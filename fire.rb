#!/usr/bin/env ruby
# fire.rb

# Gems
require 'optparse'	# for parsing arguments
require 'socket'	# for web stuff
require 'ipaddr'	# for IP addresses
require 'download'	# for downloading (will replace with multiconnect code later)
require 'url'

=begin
 URL Handler Class
 Can: get IP from domain name
 Can do in future: Check if server is responding
=end
class urlhandler
	attr_accessor :urlc
	# Allows you to set url at startup
	def initialize(urlc)
		@fullurl = URL.new(urlc)
		@domain = @fullurl.subdomain + "." + fullurl.domain
	end
	# Function to look up IP from Domain
	def dnslookup
		puts "Looking up IP of domain from DNS server..."
		@ipaddr = IPAddr.getaddress "#@domain"
		puts "The IP address is: " + @ipaddr
	end
end
# Setup OptionParser for arguments passed to command
options = {}

fire_parse = OptionParser.new do |opt|
	opt.banner = "Usage: fire URL [OPTIONS]
	opt.separator " "
	opt.separator "URL"
	opt.separator "	Replace URL with the URL of the file you would like to download"
	# Optional arguments for command
	opt.separator "Options"

	# Route trafic over TOR
	#opt.on("-t","--tor","route trafic through TOR network \not implemented/) do
	#	options[:tor] = true
	#end

	# Run in background
	opt.on("-b","--background","run in background and do not display progress") do
		options[:background] = true
	end

	# Show help page
	opt.on("-h","--help","display help page") do
		puts fire_parse
	end
end

=begin
 Method to extract options from ARGV
 As each argument (starting from back) is parsed,
 it is deleted. This means they must be saved by
 code in the options array when encountered.
=end
fire_parse.parse!

ifARGV[0] 
# If they neglect to provide ARGV, print the help
when ""
	puts fire_parse
else
	
