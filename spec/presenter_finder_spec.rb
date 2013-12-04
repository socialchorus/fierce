require 'spec_helper'

describe Fierce::PresenterFinder do
  let(:fixture_presenter_path) { File.dirname(__FILE__) + "/support/custom_presenters" }
  
  before do
    Fierce.clear_paths
    Fierce.add_path(fixture_presenter_path)
  end

  let(:finder) { Fierce::PresenterFinder.new('home/index') }

  it "return the class" do
    finder.perform.should == Home::Index
  end
end
