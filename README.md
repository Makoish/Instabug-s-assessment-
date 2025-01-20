
<h1>Instabug's Back-end Assessment</h1>


This is a chatting application where you can generate an application only using a name, system will automatically generate a token for this application, applications are identified by its token, each application can have many chats and chat can have only one application, chats are identified by application token as well as chat number, chat number is auto incremental for each chat, meaning that no two chat can have the same chat number for same application. Each chat can have many messages and a messagae belong to only one chat.





**Where can we find your database schema?**
you can access the schema on ./db/schema.rb, you may ask why does token_fk exist on the message table although there is a direct relationship between application and message that's because token_fk and chat_number on the table chat is a combosite key and according to normalization rules the key should be added on the N's table.

<img title="a title" alt="Alt text" src="https://i.imgur.com/QZmgrna.png" width="500" height="250"></br>



**Where can we find each API controller you implemented?</br>**
Each controller can be found on the ./app/controllers folder


**Where can we find any tasks you implemented (if any)?** </br>
It can be found on ./config/schedule.rb



**How to run the application**
<code>sudo docker compose up</code> </br>
running this command will create an image and run the container, note that I am not running postgres on docker it's running on the application so creating a container will create it's own database. Don't forget to stop elastic search at your linux system so it doesn't conflict with the one running on docker </br>
<code>sudo systemctl stop elasticsearch</code> </br>

**How to test the application?** </br>
<a href="https://documenter.getpostman.com/view/20419293/2sAYQcEVny" target="_blank">
</br>
    <img src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Postman_%28software%29.png?20211024200826" alt="Postman Logo" width="300" height="90">
</a> </br>

Please don't hesistate to contact me on mohamedmohsen96661@gmail if you have any issues running the project.





