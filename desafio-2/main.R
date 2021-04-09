if (!require("rlist", character.only = TRUE)) {
  install.packages("rlist", dependencies = TRUE)
  library("rlist", character.only = TRUE)
}

source(file = "./functions.R")

hA <- c("09:00","20:00")
pA <- list(c("09:00","10:30"),
           c("12:00","13:00"),
           c("16:00","18:00"))


hB <- c("10:00","18:30")
pB <- list(c("10:00","11:30")
           c("12:30","14:30"),
           c("14:30","15:00"),
           c("16:00","17:00"))

timeToFind <- 30

findSomeFreeTime(horarioA = hA,
                 horarioB = hB,
                 pA = pA,
                 pB = pB,
                 time = timeToFind)