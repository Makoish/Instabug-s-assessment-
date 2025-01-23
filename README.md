
<h1>Instabug's Back-end Assessment</h1>


This is a chatting application where you can generate an application only using a name, system will automatically generate a token for this application, applications are identified by its token, each application can have many chats and chat can have only one application, chats are identified by application token as well as chat number, chat number is auto incremental for each chat, meaning that no two chat can have the same chat number for same application. Each chat can have many messages and a messagae belong to only one chat.





**Where can we find your database schema?**
you can access the schema on ./db/schema.rb, you may ask why does token_fk exist on the message table although there is a direct relationship between application and message that's because token_fk and chat_number on the table chat is a combosite key and according to normalization rules the key should be added on the N's table.

<img title="a title" alt="Alt text" src="https://i.imgur.com/QZmgrna.png" width="500" height="250"></br>



**Where can we find each API controller you implemented?</br>**
Each controller can be found on the ./app/controllers folder


**Where can we find any tasks you implemented (if any)?** </br>
It can be found on ./config/schedule.rb



**Where can we find workers you implemented (if any)?** </br>
You can find on it ./app/sidekiq/hard_job.rb, the query is sent to the redis message queue and consumed by the sidekiq back-ground job/worker and executed


**Where is the race condition and how did I solve it?** </br>
Every chat can have incremental value starting from 1, so I ran a "group by token" query on the chat table and selected the maximum chat_number for the given token and I simply added 1 to this value if it exists
or just put the value one for this chat if the query returned nill. the race condition is because I increment the value of the maximum chat_number exists on the table and then write it back. What if someone read the last chat number while I am still incrementing it? it will simply create a value with the old chat_number + 1 which will create a conflict on my database schema since I defined that the combination of the chat_numberr and toke should be unique. I solved this by doing transaction and locking the the table on field "token" for read and write so no other request can read or write on the same token while I am performing this operation.






**How to run the application**
<code>sudo docker compose up</code> </br>
running this command will create an image and run the container, note that I am not running sqlite on docker it's running on the application so creating a container will create it's own database. Don't forget to stop elastic search and redis at your linux system so it doesn't conflict with the one running on docker </br>
<code>sudo systemctl stop elasticsearch</code> </br>
<code>sudo systemctl stop redis-server</code> </br>



**How to test the application?** </br>
<a href="https://documenter.getpostman.com/view/20419293/2sAYQdhpLm" target="_blank">
</br>
    <img src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Postman_%28software%29.png?20211024200826" alt="Postman Logo" width="300" height="90">
</a> </br>



Please don't hesistate to contact me on mohamedmohsen96661@gmail if you have any issues running the project.





