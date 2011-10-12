require 'spec_helper'

describe Cafe do
  
  it 'should have a working factory' do
    Factory.create(:cafe)
  end
  
end
