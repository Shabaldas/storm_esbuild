# frozen_string_literal: true

module Dredd
  class ClientsController < BaseController
    before_action :set_client, only: [:edit, :update, :show]

    def index
      @q = Client.left_joins(:manual_orders).group('clients.id')
             .order('COUNT(manual_orders.id) DESC')
             .ransack(params[:q]&.permit!)

      @pagy, @clients = pagy(@q.result, items: 30)
    end

    def show
      @pagy, @manual_orders = pagy(@client.manual_orders.order(status: :desc), items: 20)
    end

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

    def combine_clients
      return if params[:client1_id].blank? || params[:client2_id].blank?

      client1 = Client.find(params[:client1_id])
      client2 = Client.find(params[:client2_id])

      client2.manual_orders.each do |manual_order|
        manual_order.update(client: client1)
      end

      client2.destroy!

      redirect_to dredd_clients_path, status: :see_other, notice: { text: 'Clients successfully combined', icon: 'success_icon' }
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
