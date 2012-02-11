$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Ssn

  autoload :ActiveRecordExtensions, 'ssn/active_record_extensions'
  autoload :SocialSecurityNumber,   'ssn/social_security_number'
  autoload :Version,                'ssn/version'

end

ActiveRecord::Base.send( :include, Ssn::ActiveRecordExtensions ) if defined?( ActiveRecord::Base )
