module Ssn

  module ActiveRecordExtensions

    def self.included( base )
      base.extend ActsMethods
    end

    module ActsMethods

      def has_ssn( *args )
        options = args.extract_options!

        unless included_modules.include? InstanceMethods
          self.class_eval { extend ClassMethods }
          include InstanceMethods
          validates_length_of :"raw_#{args.first.to_sym}", :maximum => 9, :allow_blank => true
          validates_format_of :"raw_#{args.first.to_sym}", :with => Ssn::SocialSecurityNumber::UNFORMATTED_REGEX, :allow_blank => true

          validates_format_of args.first.to_sym, :with => Ssn::SocialSecurityNumber::FORMATTED_REGEX, :allow_blank => true
        end

        initialize_has_ssn_from_args args
      end

      alias_method :has_ssns, :has_ssn

    end

    module ClassMethods

      def initialize_has_ssn_from_args( args )
        if args.first.is_a? Symbol
          initialize_has_ssn_from_string args.first.to_s
        elsif args.first.is_a? String
          initialize_has_ssn_from_string args.first
        elsif args.first.is_a? Hash
          initialize_has_ssn_from_hash args.first
        else
          raise 'has_ssn can only accept a string, symbol or hash of strings or symbols'
        end
      end
      private :initialize_has_ssn_from_args

      def initialize_has_ssn_from_string( str )
        define_method str do
          self.send( "raw_#{str}" ).blank? ?
            nil :
            self.send( "raw_#{str}" ).gsub( Ssn::SocialSecurityNumber::UNFORMATTED_CAPTURE_REGEX, "\\1-\\2-\\3" )
        end

        define_method "#{str}=" do |value|
          return if ssn_value_considered_blank?( value )
          self.send "raw_#{str}=", value.gsub( /-/, "" )
        end

        define_method "raw_#{str}=" do |value|
          return if ssn_value_considered_blank?( value )
          super
        end
      end
      private :initialize_has_ssn_from_string

    end

    module InstanceMethods

      def considered_blank_ssns
        [
          '000000000',
          '000-00-0000'
        ]
      end
      private :considered_blank_ssns

      def ssn_value_considered_blank?( value )
        considered_blank_ssns.include? value
      end
      private :ssn_value_considered_blank?

    end

  end

end
