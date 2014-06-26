class ConfigToolsController < ApplicationController
require 'tmpdir'
require 'csv'

  def refresh_servers
    ##  refresh roles
    # get list of roles from servers.csv
    @servers_url = "http://tcysvn02.dev.sabre.com/tvly/tvl-puppet/tvl/puppet/configuration/servers/servers.csv"
    Dir.mktmpdir do |dir|
      @task = "/usr/bin/svn cat #{@servers_url} > #{dir}/servers.csv"
      `#{@task}`
      @roles_added = Array.new
      @servers_added = Array.new
      @environments_added = Array.new
    ##  refresh servers
    # get list of servers from servers.csv
      CSV.foreach("#{dir}/servers.csv", :col_sep => "|", :headers => true) do |row|
logger.info "created #{dir}/servers.csv"
        @hostname = row[0].try(:strip)
        unless @hostname == "default" || @hostname.blank?
          logger.info "got host name #{@hostname}"
          @role_name = row[1].try(:strip)
          logger.info "got role name #{@role_name}"
          unless @role.blank?
            @role = Role.find_or_initialize_by_name(@role_name)
            unless @role.persisted?
              logger.info "role added: #{@role.name}"
              @roles_added << @role_name if @role.save
              logger.info "role persisted? #{@role.persisted?}"
            end
          end
          @runtime_env = row[2].try(:strip)
          @classes = ""
          @switches = nil
          @sub_runtime_env = row[6].try(:strip)
          @batch_group = row[8].try(:strip)
          @env_name = row[3].try(:strip)
          unless @environment.blank?
            @environment = Environment.find_or_initialize_by_name(@env_name)
            unless @environment.persisted?
              logger.info "environment added: #{@environment.name}"
              @environments_added << @environment.name if @environment.save
              logger.info "environment persisted? #{@environment.persisted?}"
            end
          end
          unless @role.blank? || @environment.blank?
            @s = Server.find_or_initialize_by_name(:name => @hostname, :role_id => @role.id, :runtime_env => @runtime_env, :environment_id => @environment.id, :classes => @classes, :switches => @switches, :sub_runtime_env => @sub_runtime_env)
            unless @s.persisted?
              @servers_added << @s.name if @s.save
            end
          end
        end
      end
    end

    flash[:notice] = "Successfully refreshed servers!"
    if @roles_added.empty?
      logger.info "ConfigToolsController: finished role sync - no new roles"
      flash[:notice] << " No new roles."
    else
      logger.info "ConfigToolsController: finished role sync - adding new roles: #{@roles_added.join(',')}"
      flash[:notice] << " I loaded #{TextHelper.pluralize(@roles_added.size, "new role")}."
    end

    if @servers_added.empty?
      logger.info "ConfigToolsController: finished server sync - no new servers"
      flash[:notice] << " No new servers."
    else
      logger.info "ConfigToolsController: finished server sync - adding new servers: #{@servers_added.join(',')}"
      flash[:notice] << " I loaded #{TextHelper.pluralize(@servers_added.size, "new server")}."
    end

    if @environments_added.empty?
      logger.info "ConfigToolsController: finished environment sync - no new environments"
      flash[:notice] << " No new environments."
    else
      logger.info "ConfigToolsController: finished environment sync - adding new environments: #{@environments_added.join(',')}"
      flash[:notice] << " I loaded #{TextHelper.pluralize(@environments_added.size, "new environment")}."
    end

    redirect_to root_url
  end

end
