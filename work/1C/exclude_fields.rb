#!/usr/bin/env ruby
# encoding: utf-8
#
# Данный исполняемый файл предназначен для вырезки полей второго файла из первого

require "rubygems"
require "bundler/setup"
require "ruby-debug"
require './common'

require File.dirname(__FILE__) + "/../../config/environment"


Common::file_check ARGV.first
Common::file_check ARGV.second
  
f1 = File.new(ARGV.first, 'r:windows-1251:utf-8')

f2_keys = []

File.open(ARGV.second, 'r:windows-1251:utf-8') do |f2|
  f2.readlines.each do |line|
    f2_keys << line.strip
  end
end

f1.readlines.each do |f1_line|

  begin
    f2_keys.each do |f2_key|
      if f1_line.strip.include? f2_key
        raise StopIteration
      end
    end
  rescue StopIteration
    next
  end

  puts (Russian::translit f1_line).underscore

end
