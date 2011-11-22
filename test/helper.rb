require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'mocha'
require "ruby-debug"
require 'timecop'
require 'backgrounded'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'destroy_backgrounded'
require 'matchers/destroy_matcher'
require 'matchers/callback_matcher'
require 'database_setup'

class Test::Unit::TestCase
  extend DestroyMatcher::MatcherMethods
  extend CallbackMatcher::MatcherMethods
end

module Backgrounded
  module Handler
    class NoOpHandler
      def request(object, method, *args)
      end
    end
  end
end
Backgrounded.handler = Backgrounded::Handler::NoOpHandler.new

# configure default logger to standard out with info log level
Backgrounded.logger = Logger.new STDOUT
Backgrounded.logger.level = Logger::DEBUG
ActiveRecord::Base.logger=Logger.new(STDOUT)
ActiveRecord::Base.logger.level=0
