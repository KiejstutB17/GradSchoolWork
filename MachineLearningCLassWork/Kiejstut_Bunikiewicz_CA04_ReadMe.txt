## CA 04 - Ensemble Methods - Kiejstut Bunikiewicz


### Project Overview

This project is a practice implementation of the various Ensemble Methods covered in class. These methods include the Random Forest, AdaBoost Classifier, Gradient Boost Classifier,
and the Extreme Gradient Boost Classifier. This data uses the census data to try to predict whether or not an individual's income is above $50,000. This exercise first attempts to 
use accuracy to measure the optimal value for the max depth of Random Forest. Then the project tries to find the optimal number of estimators for the four ensemble methods, using 
accuracy as a metric. Finally, using a fixed number of estimators (50, the best for AdaBoost) the program compares the performance of the four models by Accuracy and AUC score.
This project is an example of how to practice hyperparameter tuning and Ensemble Model Tuning. 

### Configuration Instructions
This project was run on Google Colab, using the Windows10 operating system. 

### Installation Instructions
Google Colab uses Python 3.6.9.
The packages used on this project are as follows:

import numpy as np (NumPy)
import pandas as pd (Pandas)
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier, AdaBoostClassifier (Ensemble Methods from SkLearn)
import sklearn.metrics (Metrics for model performance, SKLearn)
from sklearn.metrics import accuracy_score (Metrics for model performance, SKLearn)
from sklearn.metrics import roc_auc_score (Metrics for model performance, SKLearn)
from sklearn import svm
import matplotlib.pyplot as plt (For Graphing Results)
import pydotplus (For Graphing Results)
from google.colab import drive (Drive mount)
!pip install xgboost (Extreme Gradient Boost installer)
import xgboost as xgb (Extreme Gradient Boost)


### Operating Instructions
For Google Colab:
Download the data files and .ipynb file. Upload both files to your Google Drive following the filepath '/content/drive/My Drive/MSBA_Colab_2020/ML_Algorithms/CA03/Data/filename'.
Because the data is the same as the data for CA03, the file path is the same.
Open the .ipynb file (Google should default to Colab for opening this file type). 
To read in the data, mount your drive in Google Drive by clicking the folder on the popout menu on the left. Then a set of three icons will appear. The rightmost
icon will allow you to mount your drive. Another way to mount the drive is to run the code in the package import cell that will mount the Google Drive.
If the folder path is the same as the folder path in the Data File Reading Section, the data will automatically read when
the cell is run. All of the code is run by clicking the play button that appears when your cursor is hovering over a code cell. The code is commented, explaining
what the lines do.


### File List
The project includes the Python Notebook and census_data.csv.
Python Notebook:
Kiejstut_Bunikiewicz_CA04_Ensemble_Models.ipynb

CSV Files:
census_data.csv (Dataset for the model)


The census dataset used is linked here:
https://github.com/ArinB/MSBA-CA-03-Decision-Trees
DataSet is also available in the GitHub.

### Contact Information
Programmer: Kiejstut Bunikiewicz
Email: kbuniki1@lion.lmu.edu

### Known Bugs
I have no bugs to note with my software.

### Troubleshooting
There should not be any issues in the code. If you are running into an issue, please check if your drive is mounted and if the data is found in a file path identical to
the path in the code. 

 