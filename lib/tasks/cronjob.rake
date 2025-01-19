namespace :DBCronjob do
    desc "Updating the chats' count as well as messages' count every 1 hour "
    task UpdateDataBase: :environment do
      Application.update_chats_count
      Chat.update_messages_count
      puts "test"
    end
end
