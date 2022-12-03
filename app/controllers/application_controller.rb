class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  
  before_action :authorize 

  private 

  def authorize 
    @the_user = User.find_by(id: session[:user_id])
    render json: { errors: ['Unauthorized user']}, status: :unauthorized unless @the_user 
  end 

  def invalid_record invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity 
  end

end