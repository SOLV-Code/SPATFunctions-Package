

# plotCorrMatrix
library(corrplot)
M <- calcCorrMatrix(mtcars)
plotCorrMatrix(M$cor.mat)
plotCorrMatrix(M$cor.mat,order="hclust",n.groups=4)



