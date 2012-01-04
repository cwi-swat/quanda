#! /usr/bin/env ruby

require 'csv'

f = CSV.read(ARGV[0], :encoding => 'windows-1252')
c.foreach do |row|
  puts row.length
end
