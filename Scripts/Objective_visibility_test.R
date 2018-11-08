setwd('C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/SOA 66')
PATH= 'C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/SOA 66'
#I am going to need to add this columns in the datasets
raw2$prime_type = rep('Object', length(raw2$Prime))
count = 0 
for(i in raw2$Categoria){count = count +1
    if (i == 'sra' | i == 'wra'){raw2$prime_type[count] = 'Animal'}
    else if(i == 'nr'){raw2$prime_type[count] = 'Non related'}}

#Animales = 72
#Objects = 66



# Reading the Objective Visibility Test and creating a data frame for each subject.
# After creating the DF we calculate the D' Prime and we add this measure to the Dataset of the subject
files <- list.files(path=PATH, pattern="*.csv", full.names=TRUE, recursive=FALSE)

for (fffile in files){raw1 = read.csv(file = fffile, header = F)

#Select only the ID of the subject. We will use this to join.
visibility  = read.csv(file = fffile, skip = 301)[c(-149:-600),] 
visibility$ID = as.character(raw1[2,2])

visibility$prime_type = rep('Object', length(visibility$Prime))
count = 0 
for(i in visibility$Categoria){count = count +1
if (i == 'sra' | i == 'wra'){visibility$prime_type[count] = 'Animal'}
else if(i == 'nr'){visibility$prime_type[count] = 'Non related'}}

#Lista de animales para clasificar el prime en animales o objetos
animales_prime = c('pato','gato','cabra','caballo','leon','mono','zorro','cebra','pato','tortuga','raton','arana','perro',
                 'cisne','escarabajo','gorila','oveja','ciervo','abeja','rinoceronte','elefante','zorrino','chancho','jirafa','gallina','oso','camello','conejo','canguro','sapo','ardilla','mosca','aguila','tigre','hormiga','mariposa','avestruz','burro','pinguino','gallo','cocodrilo')

objetos_prime <- c("jarra",	"taza", "serrucho",	"bowl", "sobre", "tuerca", "cama",	"puerta", "candado", "ventana", 
                   "copa",	"pincel","pava",	"lapiz", "tijera",	"escritorio","pipa",	"cuchara", "cuchillo",	"sombrero", "botella",	"hacha", "martillo", "regla", "destornillonador", "peine", "silla", "pinza","bota",	"llave", "sarten",	"media")


#df que va a contener las respuestas para cada una de las 4 posibles para la tarea de visualizacion
dfvisualizacion <- cbind(visibility$ID[1], 0, 0,0,0)
colnames(dfvisualizacion)<- c("ID", "Animales Correctas", "Animales Incorrectas", "Objetos COrrectas", "Objetos Incorrectas")
dfvisualizacion = as.data.frame(dfvisualizacion)

animales.correctas <- 0 
animales.incorrectas <- 0 
objetos.correctas <- 0 
objetos.incorrectas <- 0

for (n in seq(20, to =length(visibility[,2]), by=1)){
    if ((as.character(visibility[n,2])== as.character(1)) & (as.character(visibility[n,4]) %in% animales_prime)){
      animales.correctas = animales.correctas + 1
      #suma a la casilla de ese sujeto de animales correctas
      }
    
      #eval?a animales incorrectas
    else if ((as.numeric(as.character(visibility[n,2])) == 0) & (as.character(visibility[n,4]) %in% animales_prime)){
      animales.incorrectas = animales.incorrectas + 1
      #suma a la casilla de ese sujeto de animales correctas
     }
    
      #eval?a objetos correctas
    else if ((as.numeric(as.character(visibility[n,2])) == 1) & (as.character(visibility[n,4]) %in% objetos_prime)){
      objetos.correctas = objetos.correctas + 1
      #suma a la casilla de ese sujeto de objetos correctas
       }
    
      #eval?a objetos incorrectas
    else if ((as.numeric(as.character(visibility[n,2])) == 0) & (as.character(visibility[n,4]) %in% objetos_prime)){
      objetos.incorrectas = objetos.incorrectas + 1
      #suma a la casilla de ese sujeto de objetos correctas
      }
} 

dfvisualizacion$`Animales Correctas` = animales.correctas
dfvisualizacion$`Animales Incorrectas`= animales.incorrectas
dfvisualizacion$`Objetos COrrectas`= objetos.correctas
dfvisualizacion$`Objetos Incorrectas`= objetos.incorrectas

dfvisualizacion<-cbind(dfvisualizacion, dfvisualizacion[,2]/64,  dfvisualizacion[,5]/64, (qnorm(dfvisualizacion[,2]/64)-qnorm(dfvisualizacion[,5]/64)))
colnames(dfvisualizacion)<- c("NumSujetos", "Animales Correctas", "Animales Incorrectas", "Objetos COrrectas", "Objetos Incorrectas", "HitRate","FA rate", "dprime")

#
load(file = paste0(visibility$ID[1],'.Rda'))
df = raw2
rm(raw2)
df = cbind(df,dfvisualizacion[,2:8])
save(df, file = paste0('Full',df$ID[1],'.Rda'))
}
