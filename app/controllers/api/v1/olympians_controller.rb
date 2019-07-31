class Api::V1::OlympiansController < ApplicationController
  def index
    olympians = Olympian.params_check(params[:age])
    status = 200
    if olympians.count > 1
      data = {olympians: OlympiansSerializer.new(olympians).render_json }
    elsif olympians.count == 1
      data = OlympiansSerializer.new(olympians).render_json
    else
      data = {error: "No Olympians, Please Seed Database"}
      status = 404
    end
    render :json => data, status: status
  end
end
