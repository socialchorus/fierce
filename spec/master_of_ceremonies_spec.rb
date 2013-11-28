require 'spec_helper'

describe Fierce::MasterOfCeremonies do
  let(:template) { 
    <<-HTML
      <h1>Hello World</h1>
      <p>{{from_custom_presenter}}</p>
      <p>{{from_locals}}</p>
      <p>{{from_controller}}</p>
      <p>{{from_helpers}}</p>
    HTML
  }
  
  let(:path) { 'home/index' }
  let(:locals) { {from_locals: 'hello from the locals'} }
  let(:context) { Struct.new(:from_helpers).new('hello from the helpers') }

  let(:mc) {
    Fierce::MasterOfCeremonies.new(
      template, path, locals, controller, context
    )
  }

  before do
    Rails.stub(:root).and_return(File.dirname(__FILE__))
    Fierce.add_path(File.dirname(__FILE__) + "/custom_presenters")
  end

  describe '#render' do
    it 'renders the template' do
      mc.render.should include('Hello World')
    end

    it 'makes controller instance variable available in the template' do
      mc.render.should include('hello from the controller')
    end

    it 'makes local variables available' do
      mc.render.should include('hello from the locals')
    end

    it 'makes helper methods available' do
      mc.render.should include('hello from the helpers')
    end

    it 'should find and delegate to custom helpers' do
      mc.render.should include('hello from the custom presenter')
    end
  end
end