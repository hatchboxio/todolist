class HotcellsController < ApplicationController
  def show
    render json: ReverseText.perform_in_hotcell([], [], text: params.fetch(:text, "Hello from the cell"))
  rescue StandardError => error
    render json: { error: error.class.name, message: error.message }, status: :service_unavailable
  end
end
