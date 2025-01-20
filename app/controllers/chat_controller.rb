class ChatController < ApplicationController
    def createChat
        token = params[:token]
        app = Application.find_by(token: token)
        if !app
            return render json: {message: "application doesn't exist"}, status: :not_found
        else
            appId = app&.id
            ## this function is located at the chat model, it simply aggregates and count number 
            ## of chats that this application has and increment it by one and assign this value as
            ## the new chat_number PS: It's thread safe (race condition handled)
           
            chat_number = Chat.create_chat_for_application(appId, token)
            return render json: { message: "Chat created succesfully", chatNumber: chat_number }, status: :ok

        end
    end

    def deleteChat
        token = params[:token]
        chat_number = params[:chat_number]
        chat = Chat.where(token_fk: token, chat_number: chat_number)
        if !chat.blank?
          chat.delete_all
          return render json: { message: "Chat deleted"}, status: :ok
        else
          return render json: { message: "Chat doesn't exist" }, status: :not_found
        end
    
    end


    


end
