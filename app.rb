# frozen_string_literal: true

$:.unshift File.expand_path("./../lib", __FILE__)
require 'bundler'
Bundler.require
require 'app/scrapper.rb'
require 'views/index.rb'
require 'views/done.rb'
require 'open-uri'
require 'csv'
require 'pp'

Index.new
