# frozen_string_literal: true

module Dredd
  class ClientsController < BaseController
    before_action :set_client, only: [:edit, :update, :show]

    def index
      @pagy, @clients = pagy(Client.order(created_at: :asc), items: 20)
    end

    def show; end

    def new
      @client = Client.new
    end

    def edit; end

    def create
      @client = Client.new(client_params)

      if @client.save
        flash.now[:notice] = { text: 'Client was successfully created.', icon: 'success_icon' }.stringify_keys
        render turbo_stream: [
          turbo_stream.prepend('clients', @client),
          turbo_stream.replace('form_client',
                               partial: 'form',
                               locals: { client: Client.new }),
          turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
        ]
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @client.update(client_params)
        flash.now[:notice] = { text: 'Client was successfully updated.', icon: 'success_icon' }.stringify_keys
        render turbo_stream: [
          turbo_stream.replace(@client, @client),
          turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
        ]
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name, :email, :phone_number, :nickname)
    end
  end
end
