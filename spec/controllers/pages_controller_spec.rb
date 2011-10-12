require 'spec_helper'

describe PagesController do

  describe :home do
    
    it 'should work' do
      get :home
      response.should be_success
    end
    
  end

end
