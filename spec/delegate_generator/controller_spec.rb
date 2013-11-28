require 'spec_helper'

describe Fierce::DelegateGenerator::Controller do
  let(:delegate) { 
    Fierce::DelegateGenerator::Controller.new(controller).generate
  }

  it 'has readers for instance variables in the controller' do
    delegate.available.should == 'im for you!'
  end

  it 'excludes protected instance variable' do
    delegate.should_not respond_to(:protected_ivar)
  end

  it 'excludes @template' do
    delegate.should_not respond_to(:template)
  end
end