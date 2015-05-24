library(HistData)
#library(plot3D)

data(GaltonFamilies)


gf <- GaltonFamilies
gf$aux <- paste(gf[,2],",",gf[,3])
gfMale <- gf[gf$gender=="male", ] 
gfFemale <- gf[gf$gender=="female", ] 


gf.df <- data.frame(x = gf[, 2], y = gf[, 3], z = gf[, 8])
gfMale.df <- data.frame(x = gfMale[, 2], y = gfMale[, 3], z = gfMale[, 8])
gfFemale.df <- data.frame(x = gfFemale[, 2], y = gfFemale[, 3], z = gfFemale[, 8])

gf.loess = loess(z ~ x * y, data=gf.df, degree=2, span=0.5)
gfMale.loess = loess(z ~ x * y, data = gfMale.df, degree=2, span=0.5)
gfFemale.loess = loess(z ~ x * y, data = gfFemale.df, degree=2, span=0.5)

gf.fit = expand.grid(list(x=seq(60,80,0.5), y=seq(60,80,0.5)))
z <- predict(gf.loess, newdata=gf.fit)
zMale <- predict(gfMale.loess, newdata=gf.fit)
zFemale <- predict(gfFemale.loess, newdata=gf.fit)

gf.resid <- resid(gf.loess)
gfMale.resid <- resid(gfMale.loess)
gfFemale.resid <- resid(gfFemale.loess)


jet.colors <- colorRampPalette(c("blue", "green"))
nbcol <- 100;
color <- jet.colors(nbcol)
nrz <- nrow(z)
ncz <- ncol(z)
zfacet <- z[-1,-1] + z[-1,-ncz] + z[-nrz, -ncz]
facetcol <- cut(zfacet, nbcol)



jet.colors2 <- colorRampPalette(c("darkblue", "yellow"))
nbcol2 <- 100;
color2 <- jet.colors2(nbcol2)
nrz2 <- nrow(zMale)
ncz2 <- ncol(zMale)
zfacet2 <- zMale[-1,-1] + zMale[-1,-ncz2] + zMale[-nrz2, -ncz2]
facetcol2 <- cut(zfacet2, nbcol2)


jet.colors3 <- colorRampPalette(c("darkred", "purple"))
nbcol3 <- 100;
color3 <- jet.colors3(nbcol3)
nrz3 <- nrow(zFemale)
ncz3 <- ncol(zFemale)
zfacet3 <- zFemale[-1,-1] + zFemale[-1,-ncz3] + zFemale[-nrz3, -ncz3]
facetcol3 <- cut(zfacet3, nbcol3)



shinyServer(function(input, output, session){
        
    output$distPlot <- renderPlot({
            par(bg="#E0E0E0")
            persp(seq(60,80,0.5), seq(60,80,0.5), z, phi=input$phiAngle, 
                  theta=input$thetaAngle, col = color[facetcol],
                  xlab="Father height", ylab="Mother height",zlab="Child height",
                  main="Child Height",
                  ticktype="detailed")
    })
    
    
    output$distResid1 <- renderPlot({
            plot(gf.resid)
            abline(0,0)
    })
    
    output$distPlot2 <- renderPlot({
            par(bg="#E0E0E0")
            persp(seq(60,80,0.5), seq(60,80,0.5), zMale, phi=input$phiAngle2, 
                  theta=input$thetaAngle2, col = color2[facetcol2],
                  xlab="Father height", ylab="Mother height",zlab="Male height",
                  main="Child Height",
                  ticktype="detailed" )
    })
    
    output$distResid2 <- renderPlot({
            plot(gfMale.resid)
            abline(0,0)
    })
    
    output$distPlot3 <- renderPlot({
            par(bg="#E0E0E0")
            persp(seq(60,80,0.5), seq(60,80,0.5), zFemale, phi=input$phiAngle3, 
                  theta=input$thetaAngle3,  col = color3[facetcol3],
                  xlab="Father height", ylab="Mother height",zlab="female height",
                  main="Child Height" ,
                  ticktype="detailed" )
    })
    
    output$distResid3 <- renderPlot({
            plot(gfFemale.resid)
            abline(0,0)
    })
    
    
    output$heightPredicted <- renderText({ 
            if (input$gender == 1) {
                 fit <- expand.grid(list(x=input$fatherHeight, y=input$motherHeight))
                 height <- predict(gfMale.loess, newdata=fit) 
                 paste("Height", strtrim(height,5), "\"")
            } else {
                    fit <- expand.grid(list(x=input$fatherHeight, y=input$motherHeight))
                    height <- predict(gfFemale.loess, newdata=fit) 
                    paste("Height",  strtrim(height,5), "\"")
            }
    })
    
    
        
})