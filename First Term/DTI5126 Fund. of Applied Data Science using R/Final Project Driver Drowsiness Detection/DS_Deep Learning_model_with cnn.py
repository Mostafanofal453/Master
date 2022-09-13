# -*- coding: utf-8 -*-
"""
Created on Fri Jul 22 20:30:57 2022

@author: Dell2050
"""

import dlib
import cv2
from imutils import face_utils
from scipy.spatial import distance 
import math
import pandas as pd
import numpy as np
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier 
from sklearn.base import BaseEstimator, TransformerMixin
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_curve, roc_auc_score, f1_score
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import LogisticRegression
from sklearn.neural_network import MLPClassifier
from sklearn.naive_bayes import BernoulliNB
from sklearn.tree import DecisionTreeClassifier
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.pipeline import Pipeline, FeatureUnion
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
from sklearn import metrics
import warnings
import tensorflow as tf 
############################################################################################################
IMG_SIZE = 145
def prepare(img_array):
    img_array = img_array / 255
    resized_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE))
    return resized_array.reshape(-1, IMG_SIZE, IMG_SIZE, 3)

modeldnn = tf.keras.models.load_model("drowiness_new6.h5")
############################################################################################################
def model(landmarks):

    
    prediction = modeldnn.predict(prepare(landmarks))
    Result=np.argmax(prediction)
    #0-yawn, 1-no_yawn, 2-Closed, 3-Open
    print(prediction)
    if Result ==3 or Result ==1:
        Result_String = "awake"
    elif Result ==2 or Result ==0 :
        Result_String = "sleepy"
    

    return Result_String, 0


import cv2

# Loading the cascades
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
eye_cascade = cv2.CascadeClassifier('haarcascade_eye.xml')
# Defining a function that will do the detections
def detect(gray, frame):
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)
    for (x, y, w, h) in faces:
        cropped_image = frame[x:x+w, y:y+h]

        Result_String, features = model(cropped_image)
        cv2.putText(frame,Result_String, bottomLeftCornerOfText, font, fontScale, fontColor,lineType)
           
       
    return frame
font                   = cv2.FONT_HERSHEY_SIMPLEX
bottomLeftCornerOfText = (10,400)
fontScale              = 1
fontColor              = (255,0,255)
lineType               = 2
# Doing some Face Recognition with the webcam
video_capture = cv2.VideoCapture(0)
while True:
    _, frame = video_capture.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    canvas = detect(gray, frame)
    cv2.imshow('Video', canvas)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
video_capture.release()
cv2.destroyAllWindows()

