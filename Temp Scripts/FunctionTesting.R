## SCRIPT TO TEST THE PACKAGE FUNCTIONS

library(SPATFunctions)

# calcCorrMatrix() and plotCorrMatrix()
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


# transformData()

iris.transform <- transformData(iris, type="log", cols="Sepal.Length", zero.convert = NA)
head(iris)
head(iris.transform)


# shiftSeries()

# internal fn
iris[,1]
.offset.fn(iris[,1],2)
.offset.fn(iris[,1],-2)

head(iris)
iris.shifted <- shiftSeries(iris, offsets=c(0,-2,1,2,0))
head(iris.shifted)



#---------------
M <- calcCorrMatrix(SPATData_EnvCov)
plotCorrMatrix(M$cor.mat)
plotCorrMatrix(M$cor.mat,order="hclust",n.groups=4)



head(SPATData_EnvCov)
SPATData_EnvCov.shifted <- shiftSeries(SPATData_EnvCov, offsets=c(0,-2,1,2,0,3,0,0,0,0,0,0,0,0,0))
head(SPATData_EnvCov.shifted)

plotPair(SPATData_EnvCov[,c("yr","jflow","peak")])

tmp.log <- transformData(SPATData_EnvCov[,c("yr","jflow","peak")],type="log",
                     cols=c("jflow","peak"), zero.convert = NA )
plotPair(tmp.log)

tmp.z <- transformData(SPATData_EnvCov[,c("yr","jflow","peak")],type="z-score",
                         cols=c("jflow","peak"), zero.convert = NA )
plotPair(tmp.z)


plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "single",style = "print", colors = NULL)
plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "single",style = "shiny", colors = NULL)

plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2axes",style = "print", colors = NULL)
plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2axes",style = "shiny", colors = NULL)

plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2panels",style = "print", colors = NULL)
plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2panels",style = "shiny", colors = NULL)
