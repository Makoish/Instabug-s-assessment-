class AppController < ApplicationController
  def createApp

    
    
    app_name = JSON.parse(request.body.read)['app_name']

  
    existing_application = Application.find_by(application_name: app_name)
    
    if existing_application
      return render json: { message: "Application already exists" }, status: :unprocessable_entity
    end

      
    
   
    
    token = JwtService.encode(app_name)
    
    
    new_app = Application.create(application_name: app_name, token: token, chats_count: 0)
    
    if new_app.persisted?
      render json: { message: "Application created successfully!", token: token }, status: :ok
    else
      render json: { message: "Failed to create application", errors: new_app.errors.full_messages }, status: :bad_request
    end
    


  end

  def getApp

    appName = params[:name]

    app = Application.find_by(application_name: appName)

    if app
      token = app['token']
      render json: {token: token }, status: :ok
    else
      render json: {message: "application doesn't exist"}, status: :not_found
    end

  end
end
