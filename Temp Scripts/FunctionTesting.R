

# plotCorrMatrix
library(corrplot)
M <- calcCorrMatrix(mtcars)
plotCorrMatrix(M$cor.mat)
plotCorrMatrix(M$cor.mat,order="hclust",n.groups=4)


cor(mtcars)
cor(mtcars[,1], mtcars[,2])

cor(mtcars[1:31,1],mtcars[2:32,2])
cor(mtcars[1:30,1],mtcars[3:32,2])
cor(mtcars[2:31,1],mtcars[1:30,2])

ccf(mtcars[,1], mtcars[,2], lag.max = 4 , type = "correlation",
    plot = FALSE, na.action = na.omit)






head(mtcars)
shift(t(mtcars), n=c(0,0,1,2,0,3,0,0,0,0))


