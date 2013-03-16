class CallsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

  # POST /calls
  # POST /calls.json
  def create
    @call = Call.new(call_params)

    @call.save!

    json = render_to_string( template: 'calls/create.json.jbuilder', locals: { call: @call})
    Redis.new.publish('rails.calls.create', json)
    render :nothing => true
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def call_params
      params.require(:call).permit(:file, :phone_number)
    end
end
