## Análise exploratória retenção de clientes (churn)
## Hipótese: "O churn de novos clientes é maior do que o churn de clientes ativos”
## -- Pacotes
library(lubridate)
library(dplyr)

##########-- functions -- ##########
clientesAno <- function(dados, ano){
  x <- dados %>%
    filter(year(data_abertura_contrato) == ano) %>%
    group_by(cd_cliente) %>%
    summarise(ultimo_pedido = max(data_abertura_contrato))
  #x$cd_cliente <- as.character(x$cd_cliente)
  return(x$cd_cliente)
}

`%nin%` = Negate(`%in%`)
##########-- main -- ##########
dados <- read.csv(file = "./desafio-1/data/base_teste.csv", header = TRUE)
head(dados)
str(dados)
cat("Número de clientes:",n_distinct(dados$cd_cliente))

# 1. Transform data
dados <- rename(dados, "ID"="X")
dados$data_abertura_contrato <- lubridate::as_datetime(dados$data_abertura_contrato)
dados$data_fechamento_contrato <- lubridate::as_datetime(dados$data_fechamento_contrato)

clientes.2015 <- clientesAno(dados,2015)
clientes.2016 <- clientesAno(dados,2016)
clientes.2017 <- clientesAno(dados,2017)
clientes.2018 <- clientesAno(dados,2018)
clientes.2019 <- clientesAno(dados,2019)
clientes.2020 <- clientesAno(dados,2020)
clientes.2021 <- clientesAno(dados,2021)

# !clientes.2016$cd_cliente %in% clientes.2015$cd_cliente clientes que estão em 2016 e não em 2015 (novos)
# clientes.2016$cd_cliente %in% clientes.2015$cd_cliente clientes ativos

## Total de cliente novos e ativos em 2016
##
ano <- 2016
novosClientes.2016 <- integer()
clientesAtivos.2016 <- integer()
for(i in 1:length(clientes.2016)){
  cl <- clientes.2016[i]
  if(cl %in% clientes.2015){
    clientesAtivos.2016 <- c(clientesAtivos.2016,cl) 
  } else {
    
    novosClientes.2016 <- c(novosClientes.2016,cl)
  }
}
df <- data.frame()
df <- rbind(df,c(ano, length(novosClientes.2016), length(clientesAtivos.2016), churnAtivos = 0, churnNovos = 0))
colnames(df) <- c("ano","novosClientes","clientesAtivos","churnAtivos","churnNovos")


##########-- 2016 para 2017 -- ##########
ano <- 2017
novosClientes.2017 <- integer()
clientesAtivos.2017 <- integer()
for(i in 1:length(clientes.2017)){
  cl <- clientes.2017[i]
  if(cl %in% clientes.2016){
    clientesAtivos.2017 <- c(clientesAtivos.2017,cl) 
  } else {
    novosClientes.2017 <- c(novosClientes.2017,cl)
  }
}

churnAtivos.2016 <- integer()
for(i in 1:length(clientesAtivos.2016)){
  cl <- clientesAtivos.2016[i]
  if(cl %nin% clientes.2017){
    churnAtivos.2016 <- c(churnAtivos.2016,cl)
  }
}

churnNovos.2016 <- integer()
for(i in 1:length(novosClientes.2016)){
  cl <- novosClientes.2016[i]
  if(cl %nin% clientes.2017){
    churnNovos.2016 <- c(churnNovos.2016,cl)
  }
}

df <- rbind(df, c(ano, length(novosClientes.2017), length(clientesAtivos.2017),length(churnAtivos.2016),length(churnNovos.2016)))

##########-- 2017 para 2018 -- ##########
ano <- 2018
novosClientes.2018 <- integer()
clientesAtivos.2018 <- integer()
for(i in 1:length(clientes.2018)){
  cl <- clientes.2018[i]
  if(cl %in% clientes.2017){
    clientesAtivos.2018 <- c(clientesAtivos.2018,cl) 
  } else {
    novosClientes.2018 <- c(novosClientes.2018,cl)
  }
}

churnAtivos.2017 <- integer()
for(i in 1:length(clientesAtivos.2017)){
  cl <- clientesAtivos.2017[i]
  if(cl %nin% clientes.2018){
    churnAtivos.2017 <- c(churnAtivos.2017,cl)
  }
}

churnNovos.2017 <- integer()
for(i in 1:length(novosClientes.2017)){
  cl <- novosClientes.2017[i]
  if(cl %nin% clientes.2018){
    churnNovos.2017 <- c(churnNovos.2017,cl)
  }
}

df <- rbind(df, c(ano, length(novosClientes.2018), length(clientesAtivos.2018),length(churnAtivos.2017),length(churnNovos.2017)))
##########-- 2018 para 2019 -- ##########
ano <- 2019
novosClientes.2019 <- integer()
clientesAtivos.2019 <- integer()
for(i in 1:length(clientes.2019)){
  cl <- clientes.2019[i]
  if(cl %in% clientes.2018){
    clientesAtivos.2019 <- c(clientesAtivos.2019,cl) 
  } else {
    novosClientes.2019 <- c(novosClientes.2019,cl)
  }
}

churnAtivos.2018 <- integer()
for(i in 1:length(clientesAtivos.2018)){
  cl <- clientesAtivos.2018[i]
  if(cl %nin% clientes.2019){
    churnAtivos.2018 <- c(churnAtivos.2018,cl)
  }
}

churnNovos.2018 <- integer()
for(i in 1:length(novosClientes.2018)){
  cl <- novosClientes.2018[i]
  if(cl %nin% clientes.2019){
    churnNovos.2018 <- c(churnNovos.2018,cl)
  }
}

df <- rbind(df, c(ano, length(novosClientes.2019), length(clientesAtivos.2019),length(churnAtivos.2018),length(churnNovos.2018)))
##########-- 2019 para 2020 -- ##########
ano <- 2020
novosClientes.2020 <- integer()
clientesAtivos.2020 <- integer()
for(i in 1:length(clientes.2020)){
  cl <- clientes.2020[i]
  if(cl %in% clientes.2019){
    clientesAtivos.2020 <- c(clientesAtivos.2020,cl) 
  } else {
    novosClientes.2020 <- c(novosClientes.2020,cl)
  }
}

churnAtivos.2019 <- integer()
for(i in 1:length(clientesAtivos.2019)){
  cl <- clientesAtivos.2019[i]
  if(cl %nin% clientes.2020){
    churnAtivos.2019 <- c(churnAtivos.2019,cl)
  }
}

churnNovos.2019 <- integer()
for(i in 1:length(novosClientes.2019)){
  cl <- novosClientes.2019[i]
  if(cl %nin% clientes.2020){
    churnNovos.2019 <- c(churnNovos.2019,cl)
  }
}

df <- rbind(df, c(ano, length(novosClientes.2020), length(clientesAtivos.2020),length(churnAtivos.2019),length(churnNovos.2019)))

##########-- Plot -- ##########
churnAtivos.plot <- df %>% filter(ano > 2016) %>% select(ano,churnAtivos)
churnAtivos.plot$type <- "churnAtivos"
colnames(churnAtivos.plot)<-c("ano","variable","type")

churnNovos.plot <- df %>% filter(ano > 2016) %>% select(ano,churnNovos)
churnNovos.plot$type <- "churnNovos"
colnames(churnNovos.plot)<-c("ano","variable","type")
df.plot <- rbind(churnAtivos.plot,churnNovos.plot)

ggplot(data = df.plot, aes(x = ano, y = variable, fill = type)) + 
  geom_bar(stat="identity",position=position_dodge()) +
  geom_text(aes(label=variable), vjust=1.6, color="white",
            position = position_dodge(0.9), size=3.5)+
  labs(x = "Ano", y="Número de clientes") +
  scale_fill_brewer(palette="Paired",name="Legenda", labels=c("Churns de clientes ativos","Churns de novos clientes"))+
  theme_minimal()
  
