class SalesController < ApplicationController
  # This is our default not-logged-in controller. It will eventually house the sales page.
  
  # GET /
  def index
    render layout: false
  end
end
