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

        
    

        message_number = 1;
        if number_of_messages.empty?
            Message.create(chat_id: chatId, message_number: message_number, payload: payLoad)
        else
            message_number = number_of_messages[chatId] + 1
            Message.create(chat_id: chatId, message_number: message_number, payload: payLoad)
        end
            

        
       
        return render json: { message: "Message created succesfully", MessageNumber: message_number}, status: :ok

    end


    def deleteMessage


        

        token = request.headers["app-token"]
        messageNumber = params[:message_number]
        chatNumber = params[:chat_number]
       
        appName = JwtService.decode(token)
        

        appId = Application.find_by(application_name: appName)&.id

        
        if !appId
            return render json: { message: "Application doesn't exist"}, status: :not_found
        end


        chatId = Chat.find_by(application_id: appId, chat_number: chatNumber)&.id

        if !chatId
            return render json: { message: "Chat doesn't exist or exist in a different application"}, status: :not_found
        end

        message = Message.where(message_number: messageNumber, chat_id: chatId)
        
        if message.blank?
            return render json: { message: "Message number is wrong"}, status: :not_found
        else
            message.delete_all
            return render json: { message: "Deleted message"}, status: :ok
        end

        
    

    end


    def searchMessage

        token = request.headers["app-token"]
        reqBody = JSON.parse(request.body.read)
        targetSearch = reqBody["targetSearch"]
        chatNumber = reqBody["chatNumber"]
        offset = reqBody["offset"]
        limit = reqBody["limit"]
       
        appName = JwtService.decode(token)


        appId = Application.find_by(application_name: appName)&.id

        
        if !appId
            return render json: { message: "Application doesn't exist"}, status: :not_found
        end



        chatId = Chat.find_by(application_id: appId, chat_number: chatNumber)&.id

        if !chatId
            return render json: { message: "Chat doesn't exist or exist in a different application"}, status: :not_found
        end


    
        
        messages = Message.search(targetSearch, where: { chat_id: chatId}, limit: limit, offset: offset ,match: :phrase)
        
        messages_array = []


        messages.each do |message|
            messages_array = messages_array << message.payload
          end

        result = {
            "application_name" => appName,
            "chat_number" => chatNumber,
            "searchResult" => messages_array
          }
        
          return render json: result, status: :ok
        

    end
end
