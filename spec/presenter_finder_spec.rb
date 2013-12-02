require 'spec_helper'

describe Fierce::PresenterFinder do
  let(:fixture_presenter_path) { File.dirname(__FILE__) + "/custom_presenters" }
  
  before do
    Fierce.clear_paths
    Fierce.add_path(fixture_presenter_path)
  end

  let(:finder) { Fierce::PresenterFinder.new('home/index') }

  it "requires the file" do
    finder.perform
    defined?(CustomPresenters).should be_true
  end

  it "return the class" do
    finder.perform.should == CustomPresenters::Home::Index
  end
end
