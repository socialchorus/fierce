class FauxController
  def initialize
    @available = 'im for you!'
    @from_controller = 'hello from the controller'
    @template = 'not here'
    @protected_ivar = 'also missing'
  end

  def protected_instance_variables
    [:@protected_ivar]
  end
end

def controller
  FauxController.new
end

class Rails
end
