require 'spec_helper'

describe TestsController do
  
  describe :create do
    
    it 'should work' do
      post :create
      response.should be_redirect
    end
    
  end

end
