require 'spec_helper'

describe Activity do 
  
  it { Activity.should respond_to(:by_actors) }

end