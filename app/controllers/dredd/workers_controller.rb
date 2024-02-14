# frozen_string_literal: true

module Dredd
  class WorkersController < BaseController
    before_action :set_worker, only: [:edit, :update, :destroy]

    def index
      @pagy, @workers = pagy(Worker.all, items: 20)
    end

    def new
      @worker = Worker.new
    end

    def create
      @worker = Worker.new(worker_params)

      if @worker.save
        respond_to do |format|
          format.html { redirect_to dredd_workers_path, notice: "Worker was successfully created." }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit;end

    def update
      if @worker.update(worker_params)
        redirect_to dredd_workers_path, notice: "Worker was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @worker.destroy
      respond_to do |format|
        format.html { redirect_to dredd_workers_path, notice: "Worker was successfully destroyed." }
        format.turbo_stream
      end
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
