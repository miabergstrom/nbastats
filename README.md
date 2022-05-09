# NBA Stats Descriptive Analytics
The goal of this project was to apply our knowledge of R to a real-world dataset. Descriptive analytics were performed, including calculating summary statistics, hypothesis testing, and creating visualizations. 

## Features
* Dataset merged from two sources: NBA statistical data from Kaggle and data pulled from the API known as nbastatR
* Home win percentage: Is there a relationship between the game being played at home and the home team winning the game?
* Offensive and defensive statistical relationship: Which one statistic has the greatest effect on the outcome of the game?

## Setup
1.  Loaded, cleaned, and merged data in R.
2. Formed several questions for data analysis.
3. Question 1 Process:
    - Created a new data frame that only included games that were played at home 
    - Calculated sum of number of victories among all home teams
    - Divided amount of wins by total number of games played 
4. Question 2 Process:
    - Created two summary tables:
	* Summary statistics for turnovers, steals, 3 point percentage, and field goal percentage for games that were won
	* Summary statistics for turnovers, steals, 3 point percentage, and field goal percentage for games that were lost 

## Project Status
This project is complete. 
#### Question 1 Results:
Based on our calculations, the home team has roughly 52% chance of winning the game. We concluded that if the team is playing at home, they start the game with an advantage over the other team, excluding all other factors. 
#### Question 2 Results: 
Our summary tables indicate that 3 point percentage has the greatest effect on the outcome of the game. Field goal percentage should also be considered when predicting the outcome of a game.

## Screenshots
![](      )


## What I Learned 
* Hypothesis testing using data analysis and visualization
* Subsetting data from master key
* Evaluating the significance of variables based on their summary statistics
* Apply descriptive analytics results to real-world concepts

## Acknowledgements
This was my final project for "Data Wrangling" at the University of Iowa. I worked with three teammates to achieve our desired results.


