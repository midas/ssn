module Ssn

  class SocialSecurityNumber

    FORMATTED_REGEX           = /^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$/
    UNFORMATTED_REGEX         = /^[0-9]{9}$/
    UNFORMATTED_CAPTURE_REGEX = /^([0-9]{3})([0-9]{2})([0-9]{4})$/

    attr_reader :raw

    def initialize( value=nil )
      return if value.nil? || value.empty?
      return if value == '000000000'
      return if value == '000-00-0000'
      @raw = SocialSecurityNumber.parse( value )
    end

    def formatted
      SocialSecurityNumber.format raw
    end

    def self.parse( value )
      value.nil? ?
        nil :
        value.gsub( /-/, "" )
    end

    def self.format( value )
      parsed = parse( value )

      parsed.nil? ?
        nil :
        parsed.gsub( UNFORMATTED_CAPTURE_REGEX,"\\1-\\2-\\3" )
    end

  end

end
