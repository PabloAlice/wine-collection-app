class CellarsController < ApplicationController
    before_action :set_cellar, only: [:show, :update, :destroy]
  
    # GET /cellars
    def index
      @cellars = Cellar.all
      json_response(@cellars)
    end
  
    # POST /cellars
    def create
      @cellar = Cellar.create!(cellar_params)
      json_response(@cellar, :created)
    end
  
    # GET /cellars/:id
    def show
      json_response(@cellar)
    end
  
    # PUT /cellars/:id
    def update
      @cellar.update(cellar_params)
      head :no_content
    end
  
    # DELETE /cellars/:id
    def destroy
      @cellar.destroy
      head :no_content
    end
  
    private
  
    def cellar_params
      # whitelist params
      params.permit(:name, :location)
    end
  
    def set_cellar
      @cellar = Cellar.find(params[:id])
    end
  end