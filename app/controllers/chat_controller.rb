class ChatController < ApplicationController
    def createChat


        token = request.headers["app-token"]
        appName = JwtService.decode(token)

        app = Application.find_by(application_name: appName)
        appId = app&.id


        

        number_of_chats = Chat.where(application_id: appId).group(:application_id).count()


      
        chat_number = 1
        if number_of_chats.empty?
            Chat.create(chat_number: 1, application_id: appId, messages_count: 0)
        else
            chat_number = number_of_chats[appId]
            chat_number = chat_number+1
            Chat.create(chat_number: chat_number, application: app, messages_count: 0)

        end
        
        
        
        
        return render json: { message: "Chat created succesfully", chatNumber: chat_number }, status: :ok
        
        

    end


    
end
