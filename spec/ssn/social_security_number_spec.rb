require 'spec_helper'

describe "Ssn::SocialSecurityNumber" do
  before :each do
    @klass = Ssn::SocialSecurityNumber
    @instance = @klass.new
  end

  it "should agree that the UNFORMATTED_REGEX is /^[0-9]{9}$/" do
    @klass::UNFORMATTED_REGEX.should == /^[0-9]{9}$/
  end

  it "should agree that the FORMATTED_REGEX is /^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$/" do
    @klass::FORMATTED_REGEX.should == /^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$/
  end

  it "should agree that the UNFORMATTED_CAPTURE_REGEX is /^([0-9]{3})([0-9]{2})([0-9]{4})$/" do
    @klass::UNFORMATTED_CAPTURE_REGEX.should == /^([0-9]{3})([0-9]{2})([0-9]{4})$/
  end

  it "should initialize when given an unformatted SSN" do
    @klass.new( '123456789' ).raw.should == '123456789'
  end

  it "should initialize when given an unformatted SSN" do
    @klass.new( '123-45-6789' ).raw.should == '123456789'
  end

  it "should return a formatted SSN" do
    @klass.new( '123456789' ).formatted.should == '123-45-6789'
  end

  it "should return a '' when a the SSN is blank" do
    @klass.new( '' ).formatted.should == ''
  end

  it "should return a '' when a the SSN is nil" do
    @klass.new.formatted.should == ''
  end

  context "well formed SSNs" do
    it "should parse an SSN without formatting" do
      @klass.parse( '123456789' ).should == '123456789'
    end

    it "should parse an SSN with formatting" do
      @klass.parse( '123-45-6789' ).should == '123456789'
    end

    it "should format an SSN without formatting" do
      @klass.format( '123456789' ).should == '123-45-6789'
    end

    it "should format an SSN with formatting" do
      @klass.format( '123-45-6789' ).should == '123-45-6789'
    end
  end
end
