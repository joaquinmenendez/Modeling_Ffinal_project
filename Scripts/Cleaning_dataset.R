library(ggplot2)
library(lattice)
library(dplyr)
library(readtext)
library(reticulate)

setwd('C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/SOA 66')
PATH = 'C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/SOA 66'
SOA =  66
files <- list.files(path=PATH, pattern="*.csv", full.names=TRUE, recursive=FALSE)

for (fffile in files){raw1 = read.csv(file = fffile, header = F)
#Select only the 'ETAPA DE TEST' phase

raw2 = read.csv(file = fffile, skip = 30)[c(-267:-600),] 
#Rename columns to english
colnames(raw2)[colnames(raw2)=="Tiempo.Resp"] <- "RT"
colnames(raw2)[colnames(raw2)=="Calidad.respuesta..1.correcto..0.error."] <- "Answer"
colnames(raw2)[colnames(raw2)=="Tecla.presionada..vacio.si.no.se.presiono."] <- "Key_pressed"
colnames(raw2)[colnames(raw2)=="Tecla.para.responder.afirmativamente"] <- "correct_key"
colnames(raw2)[9] = 'Prime_aparition_time'
#Append columns to DF 
raw2$ID = as.character(raw1[2,2])
raw2$Age = as.character(raw1[3,2])
  raw2$Gender = as.character(raw1[4,2])
  raw2$Neuro_A = as.character(raw1[5,2])
  raw2$Medication_A = as.character(raw1[6,2])
  raw2$Works_A = as.character(raw1[7,2])
  raw2$Sleep_hours = as.character(raw1[8,2])
  #Convert  empty fields (space) in NA
  raw2$Key_pressed = replace(raw2$Key_pressed,list=raw2$Key_pressed[raw2$Key_pressed==''],values = NA) 
  
  #install.packages('reticulate')
  #devtools::install_github("rstudio/reticulate")
  
  use_condaenv(condaenv = 'C:/Users/joaqu/Anaconda3/envs/rstudio/python.exe')
  #py_discover_config()
  py_available(initialize = T)
  actual_file = as.data.frame(fffile,header = F)
  write.table(actual_file, 'C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/file.csv', sep="\n")
  source_python("C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/pre_post.py")
  pre_post()
  
  #Append LIKERT Pre-Objective and Post-Objective
  pre = read.csv("C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/pre.csv",header = F)
  post = read.csv("C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/post.csv",header = F)
  raw2$prelikert = c(pre[1,1])
  raw2$postlikert = c(post[1,1])
  
  #Creating the data frame with the similarity values
  similitud = read.csv(file = fffile, skip = 453, header = F)[c(-65:-75),]
  #similitud = read.csv(file = files[file], skip = 453, header = F)[c(-65:-75),]
  colnames(similitud) <- c('word1','word2','likert')
  
  raw2$similarity = NA
  
  for (n in seq(from = 1,to =length(similitud$word1),by = 1)){
    for (i in seq(from = 1,to =length(raw2$Prime),by = 1)){
      if(raw2$Prime[i] == similitud$word1[n] & raw2$Target[i] == similitud$word2[n]){
        raw2$similarity[i] = similitud$likert[n]}}
  }
  
  raw2$SOA = SOA
  save(raw2,file = paste0(raw2$ID[1], '.Rda'))
}
  