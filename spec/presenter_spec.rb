require 'spec_helper'

describe Fierce::Presenter do
  let(:view_model) {
    double('view_model', params: {}, my_helper: 'help!')
  }
  let(:presenter) {
    class Presenter < Fierce::Presenter
      delegations :params, :my_helper
    end

    Presenter.new(view_model)
  }

  describe 'removing the boiler plate' do
    it "makes the view model available" do
      presenter.view_model.should == view_model
    end

    it "delegates down all the messages passed down via the class method" do
      presenter.params.should == {}
      presenter.my_helper.should == 'help!'
    end
  end
end