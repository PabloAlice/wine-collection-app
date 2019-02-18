class WinesController < ApplicationController
    before_action :set_cellar
    before_action :set_cellar_wine, only: [:show, :update, :destroy]
  
    # GET /cellars/:cellar_id/wines
    def index
      json_response(@cellar.wines)
    end
  
    # GET /cellars/:cellar_id/wines/:id
    def show
      json_response(@wine)
    end
  
    # POST /cellars/:cellar_id/wines
    def create
      @cellar.wines.create!(wine_params)
      json_response(@cellar, :created)
    end
  
    # PUT /cellars/:cellar_id/wines/:id
    def update
      @wine.update(wine_params)
      head :no_content
    end
  
    # DELETE /cellars/:cellar_id/wines/:id
    def destroy
      @wine.destroy
      head :no_content
    end
  
    private
  
    def wine_params
      params.permit(:name, :harvest, :strain)
    end
  
    def set_cellar
      @cellar = Cellar.find(params[:cellar_id])
    end
  
    def set_cellar_wine
      @wine = @cellar.wines.find_by!(id: params[:id]) if @cellar
    end
  end