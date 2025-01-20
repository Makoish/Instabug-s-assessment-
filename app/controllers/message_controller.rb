class MessageController < ApplicationController

    def createMessage
        token = params[:token]
        reqBody = JSON.parse(request.body.read)
        payLoad = reqBody["payLoad"]
        chatNumber = reqBody["chatNumber"]
        appId = Application.find_by(token: token)&.id
        if !appId
            return render json: { message: "Application doesn't exist"}, status: :not_found
        end

        chatId = Chat.find_by(chat_number: chatNumber, token_fk: token)&.id
        if !chatId
            return render json: { message: "Chat doesn't exist or exist in a different application"}, status: :not_found
        end

        message_number = Message.create_message_for_chat(chatNumber, payLoad, token)
        return render json: { message: "Message created succesfully", MessageNumber: message_number}, status: :ok
    end


    def deleteMessage
        token = params[:token]
        messageNumber = params[:message_number]
        chatNumber = params[:chat_number]
        appId = Application.find_by(token: token)&.id
        if !appId
            return render json: { message: "Application doesn't exist"}, status: :not_found
        end

        chatId = Chat.find_by(token_fk: token, chat_number: chatNumber)&.id
        if !chatId
            return render json: { message: "Chat doesn't exist or exist in a different application"}, status: :not_found
        end

        message = Message.where(message_number: messageNumber, chat_number_fk: chatNumber, token_fk: token)
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
