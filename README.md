# crm-dados-localiza
- Repositório para compartilhar os códigos do desafio de CRM &amp; Dados da Localiza.
- Todos os códigos foram feitos em R.
- As bibliotecas necessárias estão especifícadas no começo dos scripts.

## Desafio 1
---
O desafio consiste em validar a hipótese de que "o churn de novos clientes é maior do que o churn de clientes ativos".
O *dataset* apresentado consiste em informações sobre aluguéis de veículos entre os anos de 2015 e 2020. O intervalo de *churn* nesse exercício é de
1 ano, ou seja, se o cliente não realizar um novo pedido de locação dentro de 1 ano após seu último pedido ele entra para o status de ***churn***. Caso contrário, o status do cliente é de **ativo**.

Uma forma de se validar a hipótese é acompanhar a evolução dos novos clientes e dos clientes ativos entre os anos. Para isso é necessário definir
o que são novos clientes nesse cenário. Portanto:

> Novos Clientes: São todos os clientes que, a partir de 2015, não estão presentes no ano anterior, para cada ano.

Com isso é possível calcular o número de novos clientes naquele ano assim como quantos desses clientes permaneceram com o status de ativo. Quando o cliente é identificado como novo ou ativo verifica-se se permaneceram com o status de ativo ou são clientes com *churn*.

Abaixo está um resumo da quantidade de *chunrs* para cada tipo de cliente entre 2016 e 2020.

![image](https://user-images.githubusercontent.com/42758623/114225662-fad6ac80-9948-11eb-8299-f2d5d46d25dd.png)

É possível observar que o número absoluto de *churns* de novos cliente é superior ao de clientes ativos em todos os anos. Portanto, existem indícios que corroboram a hipótese levantada.

O script com os códigos está em `main.R`.

## Desafio 2
---
O desafio consiste em encontrar intervalos de tempos disponíveis entre duas agendas de reuniões. Nesse algoritmo é possível buscas por intervalos de *t* minutos dada as duas agendas e os horários de jornada das duas pessoas.
As funções/cálculos e execução com exemplo desse problemas estão em `function.R` e `main.R`, respectivamente.

Etapas do algoritmo:
1. Transformar os horários em minutos
2. Dividir os tempos do dia em intervalos de 1 minuto e marca-los como disponíveis
3. Marcar os horários das agendas como indisponíveis
4. Limitar a procura dos intervalos a pessoa com a menor jornada
5. Procurar todos os intervalos disponíveis nos horários ainda disponíveis
6. Verificar se nos intervalos encontrados é possível realizar a reunião de *t* minutos.


**Input**:

- agendaA = Lista com os horários da agenda da pessoa A, no formato `'%H:%M'`.
- agendaB = Lista com os horários da agenda da pessoa B, no formato `'%H:%M'`.
- jornadaA = Vetor com os horários da jornada de A
- jornadaB = Vetor com os horários da jornada de B
- t = Tempo, em minutos (inteiro), da runião desejada

**Output**:

- Lista com os intervalos de tempo em que é possível realizar uma reunião de *t* minutos.
  
Exemplo proposto:
```R
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
```
*Disponível em `main.R`*
