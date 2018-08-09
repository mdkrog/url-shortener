class ApplicationController < ActionController::API
  def requires_application_json_content_type
    if request.headers["Content-Type"] != "application/json"      
      render json: {error: "Please ensure you have a content-type header set to application/json"}, status: 415
    end
  end
end
