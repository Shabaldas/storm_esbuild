# frozen_string_literal: true

module Dredd
  class ClientsController < BaseController
    before_action :set_client, only: [:edit, :update, :show]

    def index
      @pagy, @clients = pagy(Client.order(created_at: :asc), items: 20)
    end

    def show; end
    def edit; end

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
      params.require(:client).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end
