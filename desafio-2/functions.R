stringToMinute <- function(time){
  hour <- strsplit(time,":")[[1]][1]
  min <- strsplit(time,":")[[1]][2]
  
  return(60*as.integer(hour)+as.integer(min))
}

minuteToString <- function(time){
  hour <- as.character(as.integer(time/60))
  min <- as.character(as.integer(time %% 60))
  
  if(nchar(hour) == 1){
    hour <- paste0('0',hour)
  }
  if(nchar(min) == 1){
    min <- paste0('0',min)
  }
  return(paste0(hour,":",min))
}

intervalRange <- function(time,step) {
  int1 <- as.integer(time[1]/step)
  int2 <- as.integer(time[2]/step)
  Range <- seq(int1,int2)
  result <- Range[-length(Range)]
  return(result)
}

calculateSlots <- function(step){
  start_time <- "00:00"
  end_time <- "23:00"
  
  
  df <- data.frame(strHora = start_time,
                   intHora = stringToMinute(start_time),
                   freeTime = TRUE,stringsAsFactors = F)
  tmp <- stringToMinute(start_time)
  while(tmp < stringToMinute(end_time)){
    tmp <- tmp + step
    hour <- minuteToString(tmp)
    flag <- TRUE
    df <- rbind(df, c(hour,tmp,flag))
  }
  df$freeTime <- as.logical(df$freeTime)
  return(df)
}

validateFreeTime <- function(freeTimes,time){
  meetDuration <- integer()
  for(i in 1:length(freeTimes)){
    meetDuration[i] <- stringToMinute(freeTimes[[i]][2]) - stringToMinute(freeTimes[[i]][1])
  }
  flag_meetDuration <- time <= meetDuration 
  result <- freeTimes[flag_meetDuration]
  if(length(result)>0){
    return(result)
  } else {
    return(-1)
  }
}

findSomeFreeTime <- function(pA,
                             pB,
                             horarioA,
                             horarioB,
                             time){
  
  max_start <- max(horarioA[1],
                   horarioB[1])
  
  min_end <- min(horarioA[2],
                 horarioB[2])
  
  meetings <- c(pA,pB)
  for(i in 1:length(meetings)){
    meetings[[i]] <- c(stringToMinute(meetings[[i]][1]),stringToMinute(meetings[[i]][2]))
  }
  
  minutesInDay <- 24*60
  k <- minutesInDay/1
  step <- as.integer(minutesInDay/k)
  allSlots <- calculateSlots(step)
  
  for(meet in meetings){
    for(i in intervalRange(meet,step)){
      #print(i+1)
      allSlots$freeTime[i+1] <- FALSE
    }
  }
  
  allSlots[which(allSlots$strHora == horarioA[2]),"freeTime"] <- FALSE
  allSlots[which(allSlots$strHora == horarioB[2]),"freeTime"] <- FALSE
  allSlots <- subset(allSlots,strHora >= max_start & strHora <= min_end)
  
  result <- list()
  openInterval <- FALSE
  start <- end <- 0
  for(i in 1:length(allSlots$freeTime)){
    flag_slot <- allSlots$freeTime[i]
    if(!openInterval & flag_slot){
      openInterval <- TRUE
      start = allSlots$strHora[i]
    }else{
      if(openInterval & !flag_slot){
        openInterval <- FALSE
        end <- allSlots$strHora[i]
        result <- rlist::list.append(result,c(start,end))
      }
    }
  }
  finalResult <- validateFreeTime(result,time)
  if(class(finalResult) == "list"){
    return(finalResult)
  } else{
    stop(paste("Não existem horários disponíveis para uma reunião de",time,"minutos.\n"))
  }
}