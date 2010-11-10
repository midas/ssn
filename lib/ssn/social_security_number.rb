module Ssn
  class SocialSecurityNumber
    FORMATTED_REGEX           = /^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$/
    UNFORMATTED_REGEX         = /^[0-9]{9}$/
    UNFORMATTED_CAPTURE_REGEX = /^([0-9]{3})([0-9]{2})([0-9]{4})$/

    attr_reader :raw

    def initialize( value=nil )
      return if value.nil?
      @raw = SocialSecurityNumber.parse( value )
    end

    def formatted
      return (raw.nil? || raw.empty?) ?
        '' :
        SocialSecurityNumber.format( raw )
    end

    def self.parse( value )
      value.gsub( /-/, "" )
    end

    def self.format( value )
      parse( value ).gsub( UNFORMATTED_CAPTURE_REGEX,"\\1-\\2-\\3" )
    end
  end
end