# DSCI_532_Mental-Health-in-Tech-Workplace

**Team Members:**

- Sabrina Kakei Tse (github id:sabrinatkk)

- Pan Ting (githubid:panntingg)


## Section 1 - Overview

Problem: What purpose does our App serve?

Maintaining mental wellness of employees is critical to a company's success as it directly affects productivity, morale, and public perception of the company in the long run. It is the employers' responsibility to create an open and comfortable work environment for employees to express mental health concerns, as well as providing sufficient health care to address those concerns. With that in mind, we proposed a data visualisation application that aims to help human resource researchers to understand general attitudes towards mental health in the workplace from both employees and self-employers across the world. The visualization includes distributions of factors that may contribute to the likelihood of individuals seeking help and receiving treatments. With a built-in sidebar, users can explore different sub-groups within people who have had mental health treatment and those who have not by filtering variables of interest.


## Section 2 - Data Description

The dataset we use is Mental Health in Tech Survey(https://www.kaggle.com/osmi/mental-health-in-tech-survey), which is from a 2014 survey that measures the respondents' attitudes towards mental health in the tech workplace. It contains 27 variables, and we choose 11 variables according to the purpose of our App:

- Personal information (age, gender, country);
- Family history of mental illness (family_history);
- If he/she had treatment in the past ;
- Work status (self_employed, remote_work);
- If the mental health condition interferes work (work_interfere);
- Workplace resources (benefits, care_options, seek_help);
- If the anonymity of individuals with mental complications is protected (anonymity).

Note that we only use data from several countries with sufficient and meaningful observations for this app.



## Section 3 - Usage scenario & tasks

Polly is a human resource consultant who works at a leading global technology company. The result of her latest employee satisfaction survey shows that on average, employees have become unhappier and more depressed than they were three years ago. The HR data also shows that the number of both sick leaves and interpersonal complaints have increased significantly, in addition to the increasing numbers of bad online reviews on the company for being negative, stressful and having insufficient mental support in major job-hunting websites. Polly's current focus is to customize the corporate mental health support system by redesigning the current health plan and creating a positive, supportive and comfortable environment for employees from all branches around the globe. Before she can do all of that, she uses the HR data visualisation site to aid her on the designing process. Polly can control the visualisation content by manoeuvring the settings on the sidebar. By doing so, the visualisation application provides an overview of attitudes towards mental health in different countries, age groups, gender and work status and more. By understanding the differences in these sub-groups, she can create several health care options to serve different segments within the company. In addition, the application also allows Polly to understand what factors will create an open environment for employees to discuss mental health issues in the workplace. Polly understands that being able to openly talk about or admit their mental complications in workplaces without consequence but only support will alleviate work stress and its implications. The app shows how the availability of mental health support resources and benefits correlates to how likely a person seeks help or receive mental treatment. With this final piece of information, Polly can now create a cultural change strategy with improved benefits to alleviate absenteeism and improve public perception.

## Section 4 - Description of the app & sketch

Our app contains a landing page that shows the distribution of our data by age, gender, self_employed, family_history and more. 
We use two colours to indicate the groups - individuals that had sought for mental health treatment and those who never have.  From a dropdown list, users can explore data by country to learn about the difference in attitudes geographically.  Users can also segment groups by their variables of interest using the sidebar with a filtering function. The presentation of our data, which are the distribution plots, would change corresponding to their preferences.


Here is the sketch of our app:
![sketch](img/app_sketch.png)
