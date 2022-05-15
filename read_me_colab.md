Our model can be run using several ways. This doc will run though the steps.
Please follow the steps accrodingly to train and infer using kaggle kernel, google
colab or personal gpu.
##################################################################################
				Google Colab(cloud)

##
In order to setting up the dataset yourself:


In order to run our model in google colab, at first you need to prepare the environment.

1. First download the "spcup2022_dataset" given with our submission

2. upload the file as a dataset in your google drive. 

3. After uploading the dataset, press "open notebook" option and choos suitable notebook.

4. Mount the drive using the following code in the first cell:

	a. 	from google.colab import drive
		drive.mount('/content/drive')

	b. then choose " connect to google drive "

	c. then choose your email and choose "allow" in the following steps

5. run "!pip install -r <path to requrement.txt>" to install the required libraries.

6. copy our code cell by cell to run the code.

##
For training using the dataset:

Please set up the "waveraw training pipeline.ipynb" file.

all the requirements are by default installed in colab, just running the setup will
import them. 

Now, after setting up the notebook, make the following changes:-

1. Mount google drive as mentioned before and "change the runtime type" from "Runtime"

to GPU.

2. install the requirements using "!pip install -r <path to requrement.txt>"

3. change filepaths to appropriate folders(refer to according to your drive path)
	a. CLASSWISE_DATA_PATH == classwise_dataset 
	b. ASVSPOOF_DATA_PATH == asvspoof19_1000
	c. LIBRISPEECH_DATA_PATH == librispeech_1000
	(these 2 folders are inside "external_data_sources" folder)
	d. EVAL_PATH_1 == evaluation1
	e. EVAL_PATH_2 == evaluation2
	f. all saving paths == 'Output_files/custom_training'

2. press "run all" to run and save the required csv files.

3. download the csv files for submission.

## 
For running inference:

Please set up the "waveraw inference pipeline.ipynb" file

Now, after setting up the notebook, make the following changes:-

1. change filepaths to appropriate folders(refer to according to your drive path)
	a. CLASSWISE_DATA_PATH == classwise_dataset 
	b. ASVSPOOF_DATA_PATH == asvspoof19_1000
	c. LIBRISPEECH_DATA_PATH == librispeech_1000
	(these 2 folders are inside "external_data_sources" folder)
	d. EVAL_PATH_1 == evaluation1
	e. EVAL_PATH_2 == evaluation2
	f. all saving paths == 'Output_files/inference'

2. press "run all" to run and save the required csv files.


3. download the csv files for submission.







