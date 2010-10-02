$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'ssn/active_record_extensions'
require 'ssn/social_security_number'

module Ssn
  VERSION = '0.1.0'
end

ActiveRecord::Base.send( :include, Ssn::ActiveRecordExtensions ) if defined?( ActiveRecord::Base )