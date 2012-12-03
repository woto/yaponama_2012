#!/usr/bin/env ruby
# encoding: utf-8
#
# Данный исполняемый файл предназначен для транслитерации файла

require "rubygems"
require "bundler/setup"
require "ruby-debug"
require './common'

require File.dirname(__FILE__) + "/../../config/environment"

Common::file_check ARGV.first

f = File.new(ARGV.first, 'r:windows-1251:utf-8')


f.readlines.each do |line|
  puts (Russian::translit line).underscore
end
