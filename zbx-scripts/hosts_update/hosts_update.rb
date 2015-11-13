#!/usr/bin/env ruby

=begin
Script: discovery_update
Author: Jean-Jacques Martrès (jjmartres |at| gmail |dot| com)
Description: Discovery update extend the discovery capabilities of Zabbix
License: GPL2

This script is intended for use with Zabbix > 2.0

USAGE:

  as a script:    discovery_update [options]

  OPTIONS
     -h, --help                            Display this help message
     -c, --config CONFIG_FILE              Configuration file

  CONFIG FILE FORMAT

     url:                "zabbix api url"
     login:              "zabbix username"
     password:           "zabbix password"
     folders:            "[['host group name 1','snmp_community_1'],['host group name 2','snmp_community_2']]"
     rules:              "[['TEMPLATE_NAME_1','regex1','class1'],['TEMPLATE_NAME_2','regex2','class2']]"
=end
require 'rubygems'
require 'optparse'
require 'rubix'
require 'snmp'
require 'logger'
#require 'YAML'
require 'net/ping/external'

# Howto use it ... quiet simple
OPTIONS = {}
mandatory_options=[:config]
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"
  opts.separator ""
  opts.separator "Options"
  opts.on("-h", "--help", "Display this help message") do
    puts opts
    exit(-1)
  end
  opts.on('-c', '--config CONFIG_FILE',String,  'Configuration file') { |v| OPTIONS[:config] = v }
  opts.separator ""
end


# Show usage when no args pass
if ARGV.empty?
  puts optparse
  exit(-1)
end

# Validate that mandatory parameters are specified
begin
  optparse.parse!(ARGV)
  missing = mandatory_options.select{|p| OPTIONS[p].nil? }
  if not missing.empty?
    puts "Missing options: #{missing.join(', ')}"
    puts optparse
    exit(-1)
  end
  rescue OptionParser::ParseError,OptionParser::InvalidArgument,OptionParser::InvalidOption
       puts $!.to_s
       exit(-1)
end

# Log each events
log = Logger.new(STDOUT)

# Start logger
log.level = Logger::DEBUG
log.debug ""
log.debug "Starting configuring OXIDIZED from NMS"
log.debug ""

# Read file config
if File.exist?(OPTIONS[:config])
 cnf = YAML::load(File.open(OPTIONS[:config]))
else
 log.error "File #{OPTIONS[:config]} doesn't exist !"
 exit(-1)
end

# Read router.db file
if File.exist?(File.expand_path(cnf["devices"]))
  DevicesList = File.readlines(File.expand_path(cnf["devices"]))
else
  log.warn "File #{cnf["devices"]} doesn't exist"
  DevicesList = []
end

# Read hosts file
if File.exist?(File.expand_path(cnf["hosts"]))
  HostsList = File.readlines(File.expand_path(cnf["hosts"]))
else
  log.warn "File #{cnf["hosts"]} doesn't exist"
  HostsList = []
  HostsList.insert(-1,cnf["headers"])
end

# Connect to the Zabbix API
Rubix.connect(cnf["node"]["url"],cnf["node"]["username"],cnf["node"]["password"])

# Define FOLDERS
FOLDERS = cnf["folders"]

# Define RULES
RULES = cnf["rules"]

FOLDERS.each do |folder|

    # We need to ensure that provided group exist
    group = Rubix.connection.request('hostgroup.get', 'filter' => { 'name' => folder })
    if group.has_data?
      group = group.result.reduce Hash.new, :merge
    else
      log.error "Host group #{folder} doesn't exist !"
      exit(-1)
    end

    RULES.each do |rule|

        log.info "Working on #{folder} on template #{rule["name"]}"

        # Get template list
        template = Rubix.connection.request('template.get', 'filter' => {'name' => rule["name"] })
        if template.has_data?
            template = template.result.reduce Hash.new, :merge

            # Get hosts list
            hosts = Rubix.connection.request('host.get', 'groupids' => group["groupid"], 'templateids' => template["templateid"] )
            hosts = hosts.result
            if hosts.count.to_i.zero?
                log.error "No hosts to update on this group"
            else
                log.info "We need to update #{hosts.count} hosts"
            end

            count = 0

            while count < hosts.count do
                host_id = hosts.fetch(count)["hostid"]
                host = Rubix.connection.request('host.getobjects', 'hostid'=> host_id )
                host = host.result.reduce Hash.new, :merge

                # append router.db
                DevicesList.insert(-1, "#{host["name"].downcase}:#{rule["type"].downcase}:#{folder.upcase}:#{rule["username"]}:#{rule["password"]}\n")

                # append hosts
                HostsList.insert(-1, "#{host["host"]}\t\t\t#{host["name"].downcase}\n")

                count = count + 1

            end

        else
            log.error "Template #{template} doesn't exist !"
        end
    end
end

# Write router.db
begin
   file =  File.open(File.expand_path(cnf["devices"]),"w")
   file.puts(DevicesList.uniq)
rescue IOError => e
ensure
   file.close unless file == nil
end

# Write hosts
begin
  file = File.open(File.expand_path(cnf["hosts"]),"w")
  file.puts(HostsList.uniq)
rescue IOError => e
ensure
  file.close unless file == nil
end


