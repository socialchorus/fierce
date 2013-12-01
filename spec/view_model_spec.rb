require 'spec_helper'

describe Fierce::ViewModel do
  let(:presenter) { Struct.new(:foo).new('bar') }
  let(:context)   { double('template context', content_for: '<h1>layout here</h1>') }
  let(:controller_presenter) { Fierce::DelegateGenerator::Controller.new(controller).generate }
  
  let(:view_model) {
    Fierce::ViewModel.new(presenter, controller_presenter, context)
  }

  it "responds to methods on any of the passed in presenters" do
    view_model.available.should == 'im for you!'
    view_model.foo.should == 'bar'
  end

  it "resonds to yield in a traditional erb layout type of a way" do
    view_model.yield.should ==  '<h1>layout here</h1>'
  end
end