install.packages("devtools")

devtools::install_github("abresler/nbastatR")
library(nbastatR)

### Load data 
data <- read.csv("nba.games.stats.csv")
game_data <- game_logs(
  seasons = 2019,
  league = "NBA",
  result_types = "Team",
  season_types = "Regular Season",
  nest_data = F,
  assign_to_environment = TRUE,
  return_message = TRUE,
)

### Cleaning API Data so that it matches our CSV file prior to the merge 
game_data$yearSeason <- NULL
game_data$slugSeason <- NULL
game_data$slugLeague <- NULL
game_data$typeSeason <- NULL
game_data$idGame <-  NULL
game_data$numberGameTeamSeason <-  NULL
game_data$nameTeam <-  NULL
game_data$idTeam <-  NULL
game_data$isB2B <-  NULL
game_data$isB2BFirst <- NULL
game_data$isB2BSecond <-  NULL
game_data$slugMatchup <- NULL
game_data$countDaysRestTeam <- NULL
game_data$countDaysNextGameTeam <- NULL
game_data$slugTeamWinner <- NULL
game_data$slugTeamLoser <- NULL
game_data$isWin <-  NULL
game_data$hasVideo <-  NULL
game_data$minutesTeam <-  NULL
game_data$plusminusTeam <-  NULL
game_data$urlTeamSeasonLogo <-  NULL
game_data$fgmTeam<- NULL
game_data$fgaTeam <- NULL
game_data$fg3aTeam <- NULL
game_data$fg3mTeam <- NULL
game_data$fg2mTeam <- NULL
game_data$fg2aTeam <- NULL
game_data$ftmTeam <- NULL
game_data$ftaTeam <- NULL
game_data$pfTeam <- NULL
game_data$ptsTeam <- NULL
game_data$pctFG2Team <- NULL
game_data$drebTeam <- NULL

### Cleaning CSV 
data$X <- NULL 
data$Game<- NULL
data$TeamPoints<- NULL
data$OpponentPoints<- NULL
data$FieldGoals <- NULL
data$FieldGoalsAttempted <- NULL
data$X3PointShots <- NULL
data$X3PointShotsAttempted <- NULL
data$FreeThrows <- NULL
data$FreeThrowsAttempted <- NULL
data$Opp.FieldGoals <- NULL
data$Opp.FieldGoalsAttempted <- NULL
data$Opp.3PointShots <- NULL
data$Opp.3PointShotsAttempted <- NULL
data$Opp.FreeThrows <- NULL
data$Opp.FreeThrowsAttempted <- NULL
data$TotalFouls <- NULL
data$Opp.TotalFouls <- NULL
data$Opp.Assists <- NULL
data$Opp.FieldGoals. <- NULL
data$Opp.3PointShots. <- NULL
data$Opp.FreeThrows. <- NULL
data$Opp.OffRebounds <- NULL
data$Opp.Assists <- NULL
data$Opp.TotalRebounds <- NULL
data$Opp.Steals <- NULL
data$Opp.Blocks <- NULL
data$Opp.Turnovers <- NULL  

### Before the Vertical Merge we must make sure that the names match 
game_data$locationGame_Edited<-ifelse(game_data$locationGame=="A", "Away", "Home")
game_data$locationGame <- NULL


names(game_data)[which(names(game_data)=="slugTeam")]<-"Team"
names(game_data)[which(names(game_data)=="slugOpponent")]<-"Opponent"
names(game_data)[which(names(game_data)=="dateGame")]<-"Date"
names(game_data)[which(names(game_data)=="locationGame_Edited")]<-"Home"
names(game_data)[which(names(game_data)=="outcomeGame")]<-"WINorLOSS"
names(game_data)[which(names(game_data)=="pctFGTeam")]<-"FieldGoals."
names(game_data)[which(names(game_data)=="pctFG3Team")]<-"X3PointShots."
names(game_data)[which(names(game_data)=="pctFTTeam")]<-"FreeThrows."
names(game_data)[which(names(game_data)=="orebTeam")]<-"OffRebounds"
names(game_data)[which(names(game_data)=="trebTeam")]<-"TotalRebounds"
names(game_data)[which(names(game_data)=="astTeam")]<-"Assists"
names(game_data)[which(names(game_data)=="stlTeam")]<-"Steals"
names(game_data)[which(names(game_data)=="blkTeam")]<-"Blocks"
names(game_data)[which(names(game_data)=="tovTeam")]<-"Turnovers"

### Vertical Merge Below 

NBA_data_master_key <- rbind(game_data, data)

### Rename Data so that it is easier to read and more clear 


names(NBA_data_master_key)[which(names(NBA_data_master_key)=="WINorLOSS")]<-"Outcome"
names(NBA_data_master_key)[which(names(NBA_data_master_key)=="Home")]<-"Game Location"
names(NBA_data_master_key)[which(names(NBA_data_master_key)=="FreeThrows.")]<-"Free Throw Percentage"
names(NBA_data_master_key)[which(names(NBA_data_master_key)=="X3PointShots.")]<-"3 Point Percentage"
names(NBA_data_master_key)[which(names(NBA_data_master_key)=="OffRebounds")]<-"Offensive Rebounds"
names(NBA_data_master_key)[which(names(NBA_data_master_key)=="TotalRebounds")]<-"Total Rebounds"
names(NBA_data_master_key)[which(names(NBA_data_master_key)=="FieldGoals.")]<-"Field Goal Percentage"


###

View(NBA_data_master_key)


###################
###################


### Question 1 - Is there a relationship between the game being played at home and the home team winning the game?
fieldgoalperc<-lm(NBA_data_master_key$`Field Goal Percentage`~
                    NBA_data_master_key$`Offensive Rebounds`+
                    NBA_data_master_key$Assists,
                  data=NBA_data_master_key)
summary(fieldgoalperc)


histogram<-NBA_data_master_key$Assists
histogram2<-NBA_data_master_key$`Field Goal Percentage`
histogram3<-rbind(histogram, histogram2)

hist(histogram,
     main="FGA vs. Assists",
     xlab="Field Goal Percentage",
     ylab="Total Assists",
     xlim=c(0,1),
     ylim=c(0,50))

str(histogram)

qplot(NBA_data_master_key$`Field Goal Percentage`,
      NBA_data_master_key$Assists,
      data=NBA_data_master_key,
      geom="boxplot",
      scale_y_continuous(labels=count))



###################
###################


### Question 2 - Which one statistic has the greatest effect on the outcome of the game?
Q2Win<- subset(NBA_data_master_key, Outcome=="W",
               select = c("Team", "Turnovers",
                          "Steals", "3 Point Percentage","Field Goal Percentage", "Blocks"))

Q2Loss<- subset(NBA_data_master_key, Outcome=="L",
                select = c("Team", "Turnovers",
                           "Steals", "3 Point Percentage","Field Goal Percentage", "Blocks"))


Win_Summary<-subset(Q2Win,
                    avg_steals=mean(Steals),
                    avg_turnovers=mean(Turnovers),
                    avg_3PT=mean(`3 Point Percentage`),
                    avg_FGP=mean(`Field Goal Percentage`),
                    avg_Blocks=mean(Blocks))

Loss_Summary<-subset(Q2Loss,
                     avg_steals=mean(Steals),
                     avg_turnovers=mean(Turnovers),
                     avg_3PT=mean(`3 Point Percentage`),
                     avg_FGP=mean(`Field Goal Percentage`),
                     avg_Blocks=mean(Blocks))             


Final_Win<- summary(Win_Summary)
Final_Loss<- summary(Loss_Summary)


Final_Win
Final_Loss



###################
###################

