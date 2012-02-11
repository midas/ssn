$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'active_record'
require 'rails'
require 'bundler/setup'

require 'ssn'

RSpec.configure do |config|

  config.mock_with :rspec

end

require File.dirname(__FILE__) + '/../script/environment'
