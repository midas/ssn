require 'spec_helper'

describe Ssn::SocialSecurityNumber do

  it "should agree that the UNFORMATTED_REGEX is /^[0-9]{9}$/" do
    described_class::UNFORMATTED_REGEX.should == /^[0-9]{9}$/
  end

  it "should agree that the FORMATTED_REGEX is /^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$/" do
    described_class::FORMATTED_REGEX.should == /^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$/
  end

  it "should agree that the UNFORMATTED_CAPTURE_REGEX is /^([0-9]{3})([0-9]{2})([0-9]{4})$/" do
    described_class::UNFORMATTED_CAPTURE_REGEX.should == /^([0-9]{3})([0-9]{2})([0-9]{4})$/
  end

  it "should initialize when given an unformatted SSN" do
    described_class.new( '123456789' ).raw.should == '123456789'
  end

  it "should initialize when given an unformatted SSN" do
    described_class.new( '123-45-6789' ).raw.should == '123456789'
  end

  it "should initialize the SSN to empty when given 000000000" do
    described_class.new( '000000000' ).raw.should be_nil
  end

  it "should initialize the SSN to empty when given 000-00-0000" do
    described_class.new( '000-00-0000' ).raw.should be_nil
  end

  it "should return a formatted SSN" do
    described_class.new( '123456789' ).formatted.should == '123-45-6789'
  end

  it "should return a '' when a the SSN is blank" do
    described_class.new( '' ).formatted.should be_nil
  end

  it "should return a '' when a the SSN is nil" do
    described_class.new.formatted.should be_nil
  end

  context "well formed SSNs" do

    it "should parse an SSN without formatting" do
      described_class.parse( '123456789' ).should == '123456789'
    end

    it "should parse an SSN with formatting" do
      described_class.parse( '123-45-6789' ).should == '123456789'
    end

    it "should format an SSN without formatting" do
      described_class.format( '123456789' ).should == '123-45-6789'
    end

    it "should format an SSN with formatting" do
      described_class.format( '123-45-6789' ).should == '123-45-6789'
    end

  end

end
