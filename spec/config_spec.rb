require 'spec_helper'

describe Fierce, 'configuration' do
  describe '.add_path' do
    before do
      Fierce.clear_paths
    end

    it "adds a lookup path for view classes" do
      Fierce.paths.should be_empty
      Fierce.add_path "/foo"
      Fierce.paths.size.should == 1
      Fierce.paths.first.should == '/foo'
    end
  end
end