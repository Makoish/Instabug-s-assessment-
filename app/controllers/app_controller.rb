class AppController < ApplicationController

  def createApp

    app_name = JSON.parse(request.body.read)['app_name']
    token = SecureRandom.uuid
    new_app = Application.create(application_name: app_name, token: token, chats_count: 0)
    if new_app.persisted?
      render json: { message: "Application created successfully!", token: token }, status: :ok
    else
      render json: { message: "Failed to create application", errors: new_app.errors.full_messages }, status: :bad_request
    end

  end

  def updateApp

    token = params[:token]
    new_app_name = JSON.parse(request.body.read)['new_app_name']
    app = Application.find_by(token: token)
    if !app
      render json: {message: "application doesn't exist"}, status: :not_found
    else
      app.update(application_name: new_app_name)
      render json: {message: "application name updated"}, status: :ok
    end

  end

  def getCount ## get the chats cout for the specific app

    token = params[:token]
    app = Application.find_by(token: token)
    if !app
      render json: {message: "application doesn't exist"}, status: :not_found
    else
      render json: {application_name: app.application_name, count: app.chats_count}, status: :ok
    end
  end
  
end
