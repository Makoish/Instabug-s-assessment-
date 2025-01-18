class MessageController < ApplicationController

    def createMessage

        token = request.headers["app-token"]
        reqBody = JSON.parse(request.body.read)
        payLoad = reqBody["payLoad"]
        chatNumber = reqBody["chatNumber"]
       
        appName = JwtService.decode(token)


        appId = Application.find_by(application_name: appName)&.id

        
        if !appId
            return render json: { message: "Application doesn't exist"}, status: :not_found
        end


        
       
        chatId = Chat.find_by(application_id: appId, chat_number: chatNumber)&.id

        if !chatId
            return render json: { message: "Chat doesn't exist or exist in a different application"}, status: :not_found
        end

        number_of_messages = Message.where(chat_id: chatId).group(:chat_id).count()

        

      
        if number_of_messages.empty?
            Message.create(chat_id: chatId, message_number: 1, payload: payLoad)
        else
            Message.create(chat_id: chatId, message_number: number_of_messages[chatId] + 1, payload: payLoad)
        end
            

        
       
        return render json: { message: "Message created succesfully", MessageNumber: number_of_messages[chatId] + 1 }, status: :ok



        



        





    end


    def searchMessage

        token = request.headers["app-token"]
        reqBody = JSON.parse(request.body.read)
        payLoad = reqBody["payLoad"]
        chatNumber = reqBody["chatNumber"]
       
        appName = JwtService.decode(token)


        appId = Application.find_by(application_name: appName)&.id

        
        if !appId
            return render json: { message: "Application doesn't exist"}, status: :not_found
        end



        chatId = Chat.find_by(application_id: appId, chat_number: chatNumber)&.id

        if !chatId
            return render json: { message: "Chat doesn't exist or exist in a different application"}, status: :not_found
        end


        
       
        chatId = Chat.find_by(application_id: appId, chat_number: chatNumber)&.id

    end
end
