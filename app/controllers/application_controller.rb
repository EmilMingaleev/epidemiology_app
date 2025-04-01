class ApplicationController < ActionController::Base
  include ActionPolicy::Controller

  rescue_from ActionPolicy::Unauthorized do |_ex|
    redirect_to root_path, alert: "Access denied"
  end
end
