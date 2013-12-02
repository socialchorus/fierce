require 'spec_helper'

describe HomeController do
  render_views
  
  describe 'basic rendering' do
    before do
      get :index
    end

    it "renders the layout correctly" do
      response.body.should include('<link href="/assets/application.css')
    end

    it "renders content from helpers" do
      response.body.should include('Hello from the helpers')
    end

    it "renders content from instance variables" do
      response.body.should include('Hello from the controller ivars')
    end

    it "renders content from the custom presenter" do
      response.body.should include('Hello from the presenter')
    end

    it "renders partials in the same directory" do
      response.body.should include('Hello from a local partial')
    end

    it "renders partials in another directory via name path mapping" do
      response.body.should include('Hello from a partial far, far away')
    end

    it "renders partials in other templating languages" do
      response.body.should include('Hello from haml-dom')
    end
  end

  describe 'complex context situations' do
    context 'context for mustache partials' do
      it "should have access to the parent presenter" do
        get :show, :id => 3

        response.body.should include('loop 1')
        response.body.should include('loop 2')
        response.body.should include('loop 3')
      end
    end
  end
end
