class Api::V1::AuthenticationController < ApplicationController

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     email: @user.email },
                     status: :ok
      activity_log("logged in")
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def activity_log(activity)
    @activity = ActivityLog.new
    @activity.user_id = @user.id
    @activity.activity = activity
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.ip_address = request.env['REMOTE_ADDR']
    @activity.save
  end

  def login_params
    params.permit( :email, :password )
  end
end
