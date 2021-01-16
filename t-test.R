df <- read.csv('latest_mid10_feature.csv') 



df$conspiracy <- factor(df$conspiracy) 


names(df[27])

for (i in 3:33) { #3:33 variables to compare are variables 1 to 4
  # boxplot(dat[, i] ~ dat$Species, # draw boxplots by group
  #         ylab = names(dat[i]), # rename y-axis with variable's name
  #         xlab = "Species"
  # )
  res <- t.test(df[, i] ~ df$conspiracy)
  print(colnames(df)[i])
  print(res)
  pdf(paste("mid10_",names(df[i]), "_boxplot.pdf",sep='') )
  boxplot(df[, i] ~ df$conspiracy, # draw boxplots by group
          ylab = names(df[i]), # rename y-axis with variable's name
          #xlab = paste("conspiracy,with p-value:",res$p.value,sep = "")
          xlab = paste("attitude"),#,res$p.value,sep = ""),
          names = c("correction","conspiracy")
  )
  dev.off() # print results of t-test
}

# t-test result: none of the mean are significant different

res <- t.test(df[, 33] ~ df$conspiracy)
res2 <- t.test(df[, 32] ~ df$conspiracy)

library(reshape2)


bilan <- aggregate(cbind(var_r)~conspiracy, data=df , mean)
rownames(bilan) <- bilan[,1]
bilan <- as.matrix(bilan[,-1])

#Plot boundaries
lim <- 100

error.bar <- function(x, y, upper, lower=upper, length=0.1,...){
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

#Then I calculate the standard deviation for each specie and condition :
stdev <- aggregate(cbind(var_r)~conspiracy , data=df , sd)
rownames(stdev) <- stdev[,1]
stdev <- as.matrix(stdev[,-1]) * 1.96 / 10

#I am ready to add the error bar on the plot using my "error bar" function !
# ze_barplot <- barplot(bilan , beside=T ,col=c("blue" , "red") , ylim=c(0,lim) , ylab="emotion count",
#                       xlab = 'emotion count:wuhan_lab   ', legend.text = c('debunk','conspiracy')
#                       ,args.legend = list( x = 'top', ncol = 2),cex.main = 2,   font.main= 4, col.main= "red",main = "Part A: Geopolitics")
# I am ready to add the error bar on the plot using my "error bar" function !
# ze_barplot <- barplot(bilan , beside=T ,col=c("blue" , "red") , ylim=c(0,lim),
#                       xlab = 'wuhan_lab',cex.main = 2,   font.main= 4, col.main= "red",main = "Part A: Geopolitics")
ze_barplot <- barplot(bilan , beside=T ,col=c("blue" , "red") , ylim=c(0,lim),
                      xlab = 'qanon coronavirus')
error.bar(ze_barplot,bilan, stdev)
 par(mfrow=c(3, 3))
