class ProvidersController < ApplicationController
    before_action :set_provider, only: [:show, :edit, :update, :destroy]
    helper ProvidersHelper

    def index
        @q = Provider.ransack(params[:q])
        @providers = @q.result.paginate(page: params[:page]).order(:name)
    end

    def show
    end

    def new
        @provider = Provider.new
    end

    def edit
    end

    def create
        @provider = Provider.new(provider_params)
        if @provider.save
            flash[:success] = 'El proveedor se ha creado correctamente.'
            redirect_to @provider
        else
            render :edit
        end
    end

    def update
        if @provider.update(provider_params)
            flash[:success] = 'El proveedor se ha actualizado correctamente.'
            redirect_to return_to_previous_url
        else
            render :edit
        end
    end

    def destroy
        if @provider.destroy
            flash[:success] = "El proveedor se ha eliminado correctamente."
        else
            flash[:alert] = "No se puede eliminar el proveedor porque tiene artículos asociados."
        end
        redirect_to providers_url
    end

    private
        def set_provider
            @provider = Provider.find(params[:id])
        end

        def provider_params
            params.require(:provider).permit(:name, :contact)
        end
end
