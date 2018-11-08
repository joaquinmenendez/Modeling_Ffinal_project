
setwd('C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/')
PATH = 'C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/'
files <- list.files(path=paste0(PATH,'SOA 66'), pattern="^F", recursive=FALSE)


load(file = files[1])
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

save(dfpriming,file='dfpriming.Rda')
