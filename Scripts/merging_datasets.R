#Easy script.
# It takes all the df of every subject and merge it in a big df --> Dfpriming
# This is the third script to use.


setwd('C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/')
PATH = 'C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/'
files <- list.files(path=paste0(PATH,'SOA 66/'), pattern="^F", recursive=FALSE)

#2 is raw
load(file = paste0('SOA 66/',files[1]))
dfpriming = df
rm(df)

for (f in files[-1]){load(file = paste0(PATH,'SOA 66/',f))
  dfpriming = rbind(dfpriming,df)
  rm(df)}

files <- list.files(path=paste0(PATH,'SOA 150'), pattern="^F", recursive=FALSE)
for (f in files){load(file = paste0(PATH,'SOA 150/',f))
  dfpriming = rbind(dfpriming,df)
  rm(df)}


files <- list.files(path=paste0(PATH,'SOA 233'), pattern="^F", recursive=FALSE)
for (f in files){load(file = paste0(PATH,'SOA 233/',f))
  dfpriming = rbind(dfpriming,df)
  rm(df)}


files <- list.files(path=paste0(PATH,'SOA 317'), pattern="^F", recursive=FALSE)
for (f in files){load(file = paste0(PATH,'SOA 317/',f))
  dfpriming = rbind(dfpriming,df)
  rm(df)}


View(summary(as.factor(dfpriming$ID), maxsum = 200))#We have 5 ID repetead. We need to modify this. [8_34, 9_16, 8_24, 8_25, 11_25]


#SI necesito remover aplicar esto sino saltear
load(file= paste0(PATH,'SOA 150/Full8_34.rda'))
df$ID = 'new8_34'
save(df, file = paste0(PATH,'SOA 150/Full',df$ID[1],'.Rda'))

load(file= paste0(PATH,'SOA 150/Full9_16.rda'))
df$ID = 'new9_16'
save(df, file = paste0(PATH,'SOA 150/Full',df$ID[1],'.Rda'))

load(file= paste0(PATH,'SOA 150/Full8_24.rda'))
df$ID = 'new8_24'
save(df, file = paste0(PATH,'SOA 150/Full',df$ID[1],'.Rda'))

load(file= paste0(PATH,'SOA 66/Full8_25.rda'))
df$ID = 'new8_25'
save(df, file = paste0(PATH,'SOA 66/Full',df$ID[1],'.Rda'))

load(file= paste0(PATH,'SOA 317/Full11_25.rda'))
df$ID = 'new11_25'
save(df, file = paste0(PATH,'SOA 317/Full',df$ID[1],'.Rda'))



save(dfpriming,file='dfpriming_v4.Rda')

