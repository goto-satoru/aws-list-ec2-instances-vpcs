#!/usr/bin/env ruby
#
# list all AWS VPC & EC2 instances in all regions
#
require 'aws-sdk'
require 'pp'

region_names = {
  'ap-east-1'      => 'Hong Kong',
  'ap-northeast-1' => 'Tokyo',
  'ap-northeast-2' => 'Seoul',
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
  'sa-east-1'      => 'São Paulo',
  'us-east-1'      => 'N. Virginia',
  'us-east-2'      => 'Ohio',
  'us-west-1'      => 'N. California',
  'us-west-2'      => 'Oregon'
}

ec2 = Aws::EC2::Client.new(region: 'ap-northeast-1')
describe_regions_result = ec2.describe_regions()

regions = Array.new
describe_regions_result.regions.each do |region|
  regions.push(region.region_name)
end

regions.sort.each do |region|
  ec2_client = Aws::EC2::Client.new(region: region)
  next if ec2_client.describe_vpcs.vpcs.size < 1
  puts "\nRegion: " + region + ' - ' + region_names[region]
  ec2_client.describe_vpcs.vpcs.each do |vpc|
    puts
    vpc.tags.each do |tag|
      puts "-- VPC: Tag Name = #{tag.value}" if tag.key == 'Name'
    end
    pp vpc
  end

  ec2 = Aws::EC2::Resource.new(region: region)
  puts "\n-- EC2 instances"
  ec2.instances.each do |i|
    next if i.state.name == 'terminated'
    puts "\n\tID: " + i.id + '   State: ' + i.state.name
    i.tags.each do |tag|
      puts "\tName = #{tag.value}" if tag.key == "Name"
    end
    puts "\tVPC: " + i.vpc_id
  end
end
