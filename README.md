# ffn_interview_work
Project work to interview.

#  INSTALLATION:

I.Set up a Python environment and add Scripts folder to PATH environment variable.
https://www.python.org/downloads/

II. Set python packages:
A: Open CMD, copy requirements.txt into Scripts folder of your python installation, and use the following code:
	pip install -r requirements.txt

B: Alternatively:
	1. Add Robot framework to environment.
	https://pypi.org/project/robotframework/
	2. Add SeleniumLibrary to environment.
	https://github.com/robotframework/SeleniumLibrary
	3. Add PyYAML to environment.
	https://pypi.org/project/PyYAML/
	
III. Download chrome and geckodriver that fits to your browser. Place them into Scripts folder of your python installation.



#  USAGE:

Config Settings:
In Data folder/config.yaml, you can set path to your webdrivers, and firefox binary. (You can override these settings from CMD.)
Input Data:
In Data folder/input_data.yaml, you can set input data to test cases. It has to be set at some cases to run correctly. (For example: login data)
Keywords:
It contains all the user keywords to help execute each test steps, and get object locators from object store.
Objects:
It contains saved object locators in tree hierarchy.
Tests:
It contains all the test cases.

#  Run test cases:

I. Using the installed python environment, you can run test cases by the following command in chrome:
robot --variable BROWSER:<$browser name$> --variable CHROME_EXEC:<$chromedriver path$> <$Tests folder path$>

where parameters the following:
<$browser name$> : name of the browser It can be chrome, or firefox.(in this case: chrome) 
<$chromedriver path$> : driver's path
<$Tests folder path$> : path of the Tests folder containing test cases

II. Using the installed python environment, you can run test cases by the following command in firefox:
robot --variable BROWSER:<$browser name$> --variable FIREFOX_EXEC:<$geckodriver path$>  --variable FIREFOX_BINARY:<$Firefox binary$> <$Tests folder path$>

where parameters the following:
<$browser name$> : name of the browser It can be chrome, or firefox.(in this case: firefox) 
<$geckodriver path$> : driver's path
<$Firefox binary$> : Path of firefox.exe to run
<$Tests folder path$> : path of the Tests folder containing test cases


These settings are not neccessary, if you had set config.yaml(in Data folder) previously.

Example to CMD command:
"robot --variable BROWSER:chrome --variable CHROME_EXEC:C:\\Scripts\\chromedriver.exe C:\Users\User\eclipse-workspace\FFN_interview_work\Tests"
