# frozen_string_literal: true

module Dredd
  class WorkersController < BaseController
    before_action :set_worker, only: [:edit, :update, :destroy]

    def index
      @pagy, @workers = pagy(Worker.includes(:manual_orders).order(created_at: :asc), items: 20)
    end

    def new
      @worker = Worker.new
    end

    def edit; end

    def create
      @worker = Worker.new(worker_params)

      if @worker.save
        flash.now[:notice] = { text: 'Worker was successfully created.', icon: 'success_icon' }.stringify_keys
        render turbo_stream: [
          turbo_stream.prepend('workers', @worker),
          turbo_stream.replace('form_worker',
                               partial: 'form',
                               locals: { worker: Worker.new }),
          turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
        ]
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @worker.update(worker_params)
        flash.now[:notice] = { text: 'Worker was successfully updated.', icon: 'success_icon' }.stringify_keys
        render turbo_stream: [
          turbo_stream.replace(@worker, @worker),
          turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
        ]
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @worker.destroy
      lash.now[:notice] = { text: 'Worker was successfully destroyed.', icon: 'attention' }.stringify_keys
      render turbo_stream: [
        turbo_stream.remove(@worker),
        turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
      ]
    end

    private

    def set_worker
      @worker = Worker.find(params[:id])
    end

    def worker_params
      params.require(:worker).permit(:user_id, :first_name, :last_name, :nickname)
    end
  end
end
