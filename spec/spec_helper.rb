require 'rubygems'
require 'rack/test'

ENV["RACK_ENV"] ||= 'test'
require_relative '../app/server'
