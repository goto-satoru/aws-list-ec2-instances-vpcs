#!/usr/bin/env ruby
#
# list all AWS EC2 regions
#
require 'aws-sdk'

region_names = {
  'ap-east-1'      => 'Hong Kong',
  'ap-northeast-1' => 'Tokyo',
  'ap-northeast-2' => 'Seoul',
  'ap-northeast-3' => 'Osaka',
  'ap-south-1'     => 'Mumbai',
  'ap-southeast-1' => 'Singapore',
  'ap-southeast-2' => 'Sydney',
  'ca-central-1'   => 'Canada (Central)',
  'cn-north-1'     => 'Beijing',
  'cn-northwest-1' => 'China (Ningxia)',
  'eu-central-1'   => 'Frankfurt',
  'eu-north-1'     => 'Stockholm',
  'eu-west-1'      => 'Ireland',
  'eu-west-2'      => 'London',
  'eu-west-3'      => 'Paris',
  'sa-east-1'      => 'SÃ£o Paulo',
  'us-east-1'      => 'N. Virginia',
  'us-east-2'      => 'Ohio',
  'us-west-1'      => 'N. California',
  'us-west-2'      => 'Oregon'
}

ec2 = Aws::EC2::Client.new(region: 'ap-northeast-1')
puts "Amazon EC2 region(s) (and their endpoint(s)) that are currently available to you:\n"
describe_regions_result = ec2.describe_regions()

regions = Array.new
describe_regions_result.regions.each do |region|
  regions.push(region.region_name)
end

regions.sort.each do |r|
  printf "%-15s %s\n", r, region_names[r]
end
