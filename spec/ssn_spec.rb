require 'spec_helper'

describe Ssn do

  let :user do
    User.new :name => 'John Smith',
             :raw_ssn => '123456789'
  end

  describe "having ActiveRecord extensions" do

    it "should respond to has_ssn" do
      ActiveRecord::Base.respond_to?( :has_ssn ).should be_true
    end

    it "should respond to has_ssns" do
      ActiveRecord::Base.respond_to?( :has_ssns ).should be_true
    end

  end

  describe "when a user provides a symbol to the has_ssn method" do

    it "should respond to a getter method with the correct name" do
      user.respond_to?( :ssn ).should be_true
    end

    it "should respond to a setter method with the correct name" do
      user.respond_to?( :ssn= ).should be_true
    end

    it "should add a length validation on the raw ssn field" do
      user.raw_ssn = '1234567890'
      user.save.should be_false
    end

    it "should not allow any formatting in the raw ssn field" do
      user.raw_ssn = '1-3456789'
      user.save.should be_false
    end

    it "should not allow a mal-formed social security number" do
      user.ssn = '1-3456789'
      user.save.should be_false
    end

  end

  describe "in general" do

    it "should return nil if the raw ssn is nil" do
      user.raw_ssn = nil
      user.save!
      user.ssn.should be_nil
    end

    it "should return nil if the raw ssn is ''" do
      user.raw_ssn = ''
      user.save!
      user.ssn.should be_nil
    end

    it "should return a formatted social security number" do
      user.ssn.should == '123-45-6789'
    end

    it "should set ssn" do
      user.ssn = '234-56-7890'
      user.ssn.should == '234-56-7890'
    end

    it "should strip formatting from a social security number" do
      user.ssn = '234-56-7890'
      user.raw_ssn.should == '234567890'
    end

  end

  context 'when the ssn is set to 000000000' do

    let :user do
      User.new :name => 'John Smith',
               :ssn => '000000000'
    end

    it "should agree that the ssn is nil" do
      user.ssn.should be_nil
    end

  end

  context 'when the ssn is set to 000-00-0000' do

    let :user do
      User.new :name => 'John Smith',
               :ssn => '000-00-0000'
    end

    it "should agree that the ssn is nil" do
      user.ssn.should be_nil
    end

  end

  context 'when the raw_ssn is set to 000000000' do

    let :user do
      User.new :name => 'John Smith',
               :raw_ssn => '000000000'
    end

    it "should agree that the raw_ssn is nil" do
      user.raw_ssn.should be_nil
    end

  end

  context 'when the ssn is set to 000-00-0000' do

    let :user do
      User.new :name => 'John Smith',
               :raw_ssn => '000-00-0000'
    end

    it "should agree that the raw_ssn is nil" do
      user.raw_ssn.should be_nil
    end

  end

end
