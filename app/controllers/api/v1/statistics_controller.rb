class Api::V1::StatisticsController <ApplicationController
  def show
    olympians = Olympian.all
    status = 200
    if olympians.count > 0
      data = StatisticsSerializer.new(Olympian.all).json_output
    else
      data = { error: 'No Olympians'}
      status = 404
    end
    render :json => data, status: status
  end
end
