require 'spec_helper'

describe Fierce::ViewModel do
  let(:presenter) { Struct.new(:foo).new('bar') }

  let(:controller_presenter) { Fierce::DelegateGenerator::Controller.new(controller).generate }
  
  let(:view_model) {
    Fierce::ViewModel.new(presenter, controller_presenter)
  }

  it "responds to methods on any of the passed in presenters" do
    view_model.available.should == 'im for you!'
    view_model.foo.should == 'bar'
  end
end