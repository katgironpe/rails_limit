module Api::V1
  class HomeController < ApplicationController
    def index
      render plain: 'OK'
    end
  end
end
