require 'aws-sdk'
require 'pp'

ec2 = Aws::EC2::Client.new(region: 'ap-northeast-1')
puts "Amazon EC2 region(s) (and their endpoint(s)) that are currently available to you:\n\n"
describe_regions_result = ec2.describe_regions()

regions = Array.new
describe_regions_result.regions.each do |region|
  regions.push(region.region_name)
  puts region.region_name
end

pp regions.sort
