# Assignment 2 Classification
Text Classification 

Take five different samples of Gutenberg digital books (or your choice of text corpus), which are of five different authors, that you suspect are of the same genres and are semantically the same. For example, choose two of the books 1- The Brothers Karamazov and 2- Thus Spoke Zarathustra. ...5- 

Separate and set aside unbiased random partitions for training, validation and testing.

The overall objective is to produce classification predictions and compare them; analyze the pros and cons of algorithms and generate and communicate the insights.

 Gauge the bias and variability of the models to decide the champion model. Then play with the features and other factors that provide you with leverages to make it harder for the model to predict and bring the accuracy down for about 20% and then check the bias and variability.

Prepare the data: create random samples of 200 documents of each book, representative of the source input. Prepare the records of 100 words records for each document, label them as a, b and c etc. as per the book they belong to.

Preprocess the data: remove stop-words and garbage characters if needed.

Transform to BOW, and TF-IDF, n-gram, (LDA, word-embedding, optional) etc.

Train a machine that can tell which author (or genre), when asked!

Evaluation: Do ten-fold cross-validation.

Perform Error-Analysis: Identity what were the characteristics of the instance records that threw the machine off.

Document your steps, explain the results effectively, using graphs.

Verify and validate your programs; Make sure your programs run without syntax or logical errors.

Massage the data: Reduce the number of words per document if the accuracy is too high and then repeat the above steps.
