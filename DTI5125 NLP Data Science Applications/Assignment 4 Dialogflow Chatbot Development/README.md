# Assignment 4 Dialogflow Chatbot Development
Book Recommendation System Chatbot using Dialogflow

Chatbot link

https://bot.dialogflow.com/8b25ae0d-f2ff-4248-a3fe-0fab03545c62

 

## Here are intents 

 First is the welcome intent 

Second is the intent to search for the books

And ask the user about his favourite genre

Then the intents which include the variety of specializations 

 

 

## For the entities 

We made 2 of them 

One is book genre which is general form of searching for the genre

And we have also specific entities for specific keywords in the genre. We will talk about its details in the next slides

Now we will take a closer look at the training and responses of the intents

 

For the default welcome intent we have the basic sentences to open the dialoge

and the chatbot will respond with the name and small description about it.

 

Then the step to search for the books

 The user can ask questions whether its suggesting, recommending or searching for books

In our scenario we made the chatbot ask the user about his favourite genre 

 

So next is books-genres intent. It include the books-genre entity which decided the field of the book the user interested in.

Here the chatbot will respond with some good responses include the same field that he chose and then ask him for the name of the last book he read

 

Now we have 2 options whether the user knows the name of the book or he doesn’t know  

For the first scenario he will recommend him books related to the the book he chose

And the second scenario is that he doesn’t know or he don’t remember so we will recommend him books directly 

 

 

Now these are the intents that we discussed before. It’s for every specific genre individually

We did the same steps for every genre and everyone has its own entity

 

Finally the intent for goodbye and thanks 



So now we reached our implementation of the demo of our chatbot 

Some intents maybe contains similar words so this confuses the chatbot



Limitations of the possible varieties

\--

Hi

Can you recommend me a book?

I want stories for children

Fiction

Industry

I am not sure about that

Thanks a lot

\--

 

1.

hi

hello

hey

lovely day isn't it

I greet you

a good day

 

diffrent languages (comment)

heya

howdy

hi there

greetings

hello again

 

 

2.

Do you know any good books?

Can you recommend me a book?

I want to search for a book

I want to read a book

 

book recommendation

recommend me a good book

let's buy a book

I hope to read a book

I would like to read a book

 

 

3.

I want stories for children

I love romance books.

I am a casual reader and love to read sci-fi and fantasy books.

I prefer historical books

 

I want something for my children

I like to read action books

Fiction 

horror

every genre (comment)

 

4.

I love The Fellowship of the Ring.

I read lord of the rings.

I read Harry Potter.

 

The last book I read was Rebecca.

The last book was Rebecca

I read The Frankenstein

I love The Westing Game

 

 

5.

I am not sure about that

I do not have that information right now

I do not remember

I really do not know, can you help me?

 

I am not 100% sure

I forgot

I have no idea

I haven’t a clue

I haven’t got the faintest idea

 

 

6.

Thanks a lot

Bye

Goodbye

see you later

 

see you soon 

have a nice day

good night

farewell

 

 

 



 

 

 

 

 
