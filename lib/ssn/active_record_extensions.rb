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
          validates_format_of :"raw_#{args.first.to_sym}", :with => /^[0-9]{9}$/, :allow_blank => true

          validates_format_of args.first.to_sym, :with => /^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$/, :allow_blank => true
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

      def initialize_has_ssn_from_string( str )
        define_method str do
          return raw_ssn.blank? ? nil : raw_ssn.gsub( /^([0-9]{3})([0-9]{2})([0-9]{4})$/,"\\1-\\2-\\3" )
        end

        define_method "#{str}=" do |value|
          self.raw_ssn = value.gsub( /-/, "" )
        end
      end

      def initialize_has_ssn_from_hash( args )
      end
    end

    module InstanceMethods

    end
  end
end