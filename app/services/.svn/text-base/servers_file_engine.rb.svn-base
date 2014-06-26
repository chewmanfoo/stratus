require 'tmpdir'
require 'csv'
require 'forwardable'

class ServersFileEngineDynamicFinderMatch
  attr_accessor :attribute
  def initialize(method_sym)
    if method_sym.to_s =~ /^find_by_(.*)$/
      @attribute = $1.to_sym
    end
  end
  
  def match?
    @attribute != nil
  end
end

class ServersFileEngine
  include Enumerable
  extend Forwardable

  def_delegators :@servers, :each, :size, :map, :<<

  def initialize
    @servers = {}
    Dir.mktmpdir do |dir|
      @task = "/usr/bin/svn cat #{SERVERS_URL} > #{dir}/servers.csv"
      `#{@task}`

      CSV.foreach("#{dir}/servers.csv", :col_sep => "|", :headers => true, :header_converters => lambda {|f| f.strip.to_sym}, :converters => lambda {|f| f ? f.strip : nil}) do |row|
        @servers[row.fields[0].try(:strip)] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
      end
    end
  end

  def find(header, value)
    e = ServersFileEngine.new
    e.set_servers(@servers.select{|k,v| v[header]==value})
    e
  end

  def self.method_missing(method_sym, *arguments, &block)
    match = ServersFileEngineDynamicFinderMatch.new(method_sym)
    if match.match?
     @servers.find(match.attribute => arguments.first)
    else
      super
    end
  end

  def self.respond_to?(method_sym, include_private = false)
    if ServersFileEngineDynamicFinderMatch.new(method_sym).match?
      true
    else
      super
    end
  end

protected

  def set_servers(_servers)
    @servers = _servers
  end

end
