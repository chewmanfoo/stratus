class SvnFileSwitchWorker < GenericWorker
  require 'tmpdir'

  def switch_column(file)
    @file = File.open(file)
    
    raise SwitchPrepFailedException, "can't open servers.csv file" if @file.nil?

    @line = @file.first
    @line_arr = @line.split(' | ')
    @num = @line_arr.index("tvl_switches")
    @file.close

    @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> find switch_column -> found switch_column is '#{@num}'")

    @num
  end

  def line_containing_server(file, server)
    @file = File.open(file)
    @num_col = 8
    
    raise SwitchPrepFailedException, "can't open servers.csv file" if @file.nil?
   
    @out = ""

# imperative: there is only one line in servers.csv that matches server
  
    @server_line = @file.readlines.select {|line| line[/#{server}/]}.first

    @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> DEBUG: find line_containing_server -> found line is '#{@server_line}'")
# fix the line so that it only contains one line - this is a hack!
    @server_line = @server_line.match(/(?:[^|]*\|){#{@num_col - 1}}[^|]*/).to_s

    @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> find line_containing_server -> found line is '#{@server_line}'")

    @server_line
  end

  def replace_line_in_file(old,new,file)
    @fst = File.read(file)
    @fst.gsub!(old,"#{new}\n")
 
    File.open(file,"w") {|f| f.puts @fst}
    true
  end

  def process_file(file, col, server, marker, replacement)
    @oldline = line_containing_server(file, server)

    raise SwitchPrepFailedException, "servers.csv doesn't contain server [#{server}]" if @oldline.nil?

    @a = @oldline.split('|')
    @a = @a.map { |s| s.strip }
    @switches = @a[col] 

    if @switches.blank?
      @switches = replacement
    else
      unless @switches.gsub!(marker, replacement)
        @switches << ",#{replacement}"         
#go ahead and remove old versions of switches
        sw_a = @switches.split(',')
        sw_a.sort!
        @switches = sw_a.join(',')
        @switches.gsub!(/-(\d+.tar)/,',\1')
        sw_h = @switches.split(',')
        h = Hash[*sw_h]
        @switches_a =  h.map{|k,v| "#{k}-#{v}"}
        @switches = @switches_a.join(',')
      end
    end

# remove duplicates
# use hash with name = switch name and value = version.tar 
    @switches_arr = @switches.split(',') 
    @switches_arr = @switches_arr.uniq
    @switches = @switches_arr.join(',')

    @a[col] = @switches
 
    @newline = @a.join(' | ')
 
    raise UnixFailedExitException, "can't make servers.csv line replacement" unless replace_line_in_file(@oldline,@newline,file)

    @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> process_file -> executing: replacing '#{@oldline}' with '#{@newline}' in file '#{file.to_s}'")
  end

  def servers_file_malformed(file)
    @ex = false
    @result = `awk -F"|" '{if (NF > 8) {print $0; print NF}}' #{file}`
    @ex = true if @result.size > 0
    @ex
  end

  def do_perform(event_id)
    @event = Switch.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("SvnFileSwitchWorker", @event)

    raise OutOfOrderException unless check_order("SvnFileSwitchWorker", @event, "subversion_file")

    @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> start")

    if @config.debug_mode?
      @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> debug mode")
    else
      @svn_path = @event.svn_path
      @svn_file = @event.svn_file
      @marker = "marker"

      Dir.mktmpdir do |dir|
        @task = "svn co #{@svn_path} #{dir}"

        raise UnixFailedExitException unless perform_unix("SvnFileSwitchWorker", @event, @task)

        @filename = "#{dir}/#{@svn_file}"
        @sw_col = switch_column(@filename)

        raise SwitchPrepFailedException, "servers.csv contains no switches column" if @sw_col.nil?

        raise ServersFileMalformedException if servers_file_malformed(@filename)

        if @event.deploy_to_first_server_only
          @server = @event.server_name
          @marker = @event.supercedes_package + '.tar'
          @replacement = @event.package + '.tar'
          process_file(@filename, @sw_col, @server, @marker, @replacement)

        else
          @event.servers.each do |ts|
            @server = ts.name
            @marker = @event.supercedes_package  + '.tar'
            @replacement = @event.package + '.tar'

            process_file(@filename, @sw_col, @server, @marker, @replacement)
          end
        end

        @task = "svn ci -m 'update from stratus by #{@event.starter_given_name}' #{dir}/#{@event.svn_file} --username #{@event.starter_svn_login} --password #{@event.starter_svn_password} --no-auth-cache"

        raise UnixFailedExitException unless perform_unix("SvnFileSwitchWorker", @event, @task)
      end
    end
  
    @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> end")
    @event.class.log_result(@event, "SvnFileSwitchWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed!
  end

end
