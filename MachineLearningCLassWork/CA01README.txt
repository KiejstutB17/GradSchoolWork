## CA 01 - Data Cleaning and Exploration of India Air Quality - Kiejstut Bunikiewicz

### Project Overview
This project is an attempt to clean and run some exploratory analysis on the Kaggle "India Air Quality Dataset" for the LMU BSAN 6070 Machine Learning class.
This project is a first attempt at trying to use data cleaning and machine learning techniques. It could be useful for future reference when trying to find 
work-arounds to issues.This data was released by the Ministry of Environment and Forests and Central Polution Control Board of India. 
First, the data is investigated. Then it is cleaned via column dropping, unifying formatting, and handling missing values.
Finally, exploratory analysis is conducted about the pollution levels of various substances (SO2, NO2, SPM, RSPM, PM2_5) in
each Indian state and an analysis over time for the state of Andhra Pradesh. Conclusions follow the visualizations.

### Configuration Instructions
This project was run on Google Colab, using the Windows10 operating system. 

### Installation Instructions
Google Colab uses Python 3.6.9.
The packages used on this project are as follows:
Pandas
MatPlotLib
NumPy
Datetime
SKLearn (specifically the SimpleImputer from sklearn)

### Operating Instructions
The code involves directly importing the downloaded dataset to the Google Colab Drive and then reading the file directly from Google Colab's directory.
The code and comments are run as a standard Colab notebook. The .ipynb file can also be operated on other notebooks, such as Juypter. The text cells
are instructions for the code cells. The commentary on the code should by helpful in explaining what each line of code does.

### File List
The project includes the Python Notebook and the Kaggle dataset.
The Kaggle dataset used is linked here:
https://www.kaggle.com/shrutibhargava94/india-air-quality-data


### Contact Information
Programmer: Kiejstut Bunikiewicz
Email: kbuniki1@lion.lmu.edu

### Known Bugs
I have no bugs to note with my software.

### Troubleshooting
The first issue I had was reading the dataset in. Either because of the age of the file or an issue with Colab, the utf-8 encoder (default encoder)
could not process the data. Instead, I had to use the ISO-8859-1 encoder to read the file, which may have caused some issues with data formatting later on.
The second major issue I had involved the imputing the missing values in the pollutants columns. I consistenly got an error code about the datatype being
 too large or a null value. I worked around this by creating a separate dataframe for the imputer, called "COLS". Then I fitted and transformed the "COLS"
 using NumPy's nan. This turned the output into a Nparray. Upon replacing the columns in the original dataframe, I found there were four remaining nulls 
I could not get rid of. To fix this, I simply dropped the rows because losing an additional four of the 435,000 remaining observations would not have significantly
impacted the data. I do not know if the nulls issue came from the transitioning from array to dataframe or from a mistake I made in the Imputer code. However, the
minimal loss of rows meant the end result did not change significantly from if it was transferred without the loss of those four rows. 

###Credit and Acknowledgement
The linked webpage was helpful with the Imputer work-around. 
https://scikit-learn.org/stable/modules/generated/sklearn.impute.SimpleImputer.html
 