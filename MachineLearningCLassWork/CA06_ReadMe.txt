## CA 06 - KNN-Based Recommender Engine- Kiejstut Bunikiewicz


### Project Overview

This project is a practice implementation of the KNN Nearest Neighbor Function. The goal is to recommend 5 movies that are most similar to the movie "The Post."
After selecting the features matrix of the movies' IMDB score and genre tags, we implement the model by inputting the scores for "The Post" to see if the recommendations are meaningful.


### Configuration Instructions
This project was run on Google Colab, using the Windows10 operating system. 

### Installation Instructions
Google Colab uses Python 3.6.9.
The packages used on this project are as follows:

import numpy as np (Numpy)
import pandas as pd (Pandas)
from sklearn.neighbors import NearestNeighbors (Sklearn's Nearest Neighbors Function)

### Operating Instructions
For Google Colab:
Download the .ipynb file. Upload the files to your Google Drive following the filepath. Open the .ipynb file (Google should default to Colab for opening this file type). 
For reading in the data, use the URL in the Data Reading cell. In Colab's Python, this dataset should read in directly.
All of the code is run by clicking the play button that appears when your cursor is hovering over a code cell. The code is commented, explaining
what the lines do.


### File List
The project includes the Python Notebook and movies_recommendation_data.csv.
Python Notebook:
Kiejstut_Bunikiewicz_CA06_KNN_Based_Recommender_Engine.ipynb

CSV Files:
movies_recommendation_data.csv (Dataset for the model)
Ideally, you should read in the data directly from the URL, rather than uploading the data to a Google Drive.

The movies dataset used is linked here:
https://github.com/ArinB/CA05-kNN/raw/master/movies_recommendation_data.csv
DataSet is also available in the GitHub.

### Acknowledgement 
Data was provided by Professor Brahma at the following GitHub link:
https://github.com/ArinB/CA05-kNN/raw/master/movies_recommendation_data.csv

### Contact Information
Programmer: Kiejstut Bunikiewicz
Email: kbuniki1@lion.lmu.edu

### Known Bugs
I have no bugs to note with my software.

### Troubleshooting
There should not be any issues in the code. 

 