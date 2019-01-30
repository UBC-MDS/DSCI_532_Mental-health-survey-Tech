# Milestone 4 - Last Improvement


### Changes made

In this final week, given the time limit we have deployed the following change to our application:

- "About" tab

We added the "About" tab to the application to show the statistics of the data. In this tab, we included bar graphs to show the total number of observations per country, gender and age group used in the application. This is inspired by the fact that we want to be transparent about the information we present in our application/app. Also, we would like users of our app to ponder whether the number of observations per variable is statistically sufficient for them to make a sound claim.


![](https://github.com/UBC-MDS/DSCI_532_Mental-health-survey-Tech/blob/master/img/about.png)

### Usability - Did the application actually deliver what we promised in our objectives?

We believe our application delivers the functionality we envisioned for our potential users. Data visulization in our application is easy to comprehend and relevant; the layout is simple to users from the feedback we gathered. This application allows users to explore the data related to mental health at Technology companies  across countries. Currently we have about 880 observations, 550 of which are collected from the United States. Whlie the observation count for U.S.A is sufficient, this derails from what we promised as "visualization of global data". However, since the United States is the major hub for technology companies, the application is still a good tool for HR professionals to use. 


### Reflection

If we were to make the app again from scratch, we would opt for using plotly instead of ggplot (for more interactive features). We would also use template instead for better user interface design.

The greatest challenges we had while developing this application is the pairwise comparison on the interview questions. The questions were designed to compare two different scenarios that we thought the comparison would be interesting to show. (i.e.how comfortable you are to discuss mental issues with your coworker versus your manager?) While we could achieve the comparison by doing a major data wrangling and then producing the responsive graphs based on filters in Shiny App, we are under a strict time limitation for us to do that.