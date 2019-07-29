#!/usr/bin/env ruby

require 'nokogiri'
require 'optparse'

options = {
  :warning  => 85,
  :critical => 90
}

OptionParser.new do |o|
  o.banner = "Usage: check_nvidia_smi.rb [-w warning_threshold [-c critical_threshold] -v"

  o.on('-w', '--warning threshold', Integer, 85) { |v| options[:warning] = v }
  o.on('-c', '--critical threshold', Integer, 90) { |v| options[:critical] = v }
  o.on('-v', '--verbose', 'Verbose') { |v| options[:verbose] = v }
end.parse!

verbose  = options[:verbose]
warning  = options[:warning]
critical = options[:critical]

gpu_data = `/usr/bin/nvidia-smi -q -x`
xml  = Nokogiri::XML gpu_data

gpu_util = xml.xpath("//nvidia_smi_log/gpu/utilization/gpu_util").text.gsub(' %', '')
mem_util = xml.xpath("//nvidia_smi_log/gpu/utilization/memory_util").text.gsub(' %', '')
gpu_temp = xml.xpath("//nvidia_smi_log/gpu/temperature/gpu_temp").text.gsub(' C', '')

puts "P GPU gpu_util=#{gpu_util.to_f}|mem_util=#{mem_util.to_f}|gpu_temp=#{gpu_temp.to_f} gpu_util=#{gpu_util.to_f} % mem_util=#{mem_util.to_f} % gpu_temp=#{gpu_temp.to_f} C"

status = 0
case 
when gpu_util.to_f > warning || mem_util.to_f > warning
  status = 1
when gpu_util.to_f > critical || mem_util.to_f > critical
 status = 2
end

exit status
