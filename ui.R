library(ShinyDash)


shinyUI(
   navbarPage("Height study - Galton", id="nav",                
      tabPanel("Only height of Parents",
          img(src = "pointing-finger1.gif"),br(""),
          a(href="./Tutorial.pdf", 'Click here to get the documentation', target='_blank'),
          h1("Regression "),
          sidebarPanel(
               p("View rotation"),
               sliderInput("phiAngle",
                      "Angle phi:",
                      min = 0,
                      max = 90,
                      value = 45),
               sliderInput("thetaAngle",
                           "Angle theta:",
                           min = 0,
                           max = 90,
                           value = 45)
                ),
             
          
 
          # Show a plot of the generated distribution
                  mainPanel(
                          plotOutput("distPlot"),
                          plotOutput("distResid1")
                  )
          
          
      ),
      tabPanel("Height Male",
               img(src = "pointing-finger1.gif"),br(""),
               a(href="./Tutorial.pdf", 'Click here to get the documentation', target='_blank'),
          h1("Male"),
          
          sidebarPanel(
                  p("View rotation"),
                  sliderInput("phiAngle2",
                              "Angle phi:",
                              min = 0,
                              max = 90,
                              value = 45),
                  sliderInput("thetaAngle2",
                              "Angle theta:",
                              min = 0,
                              max = 90,
                              value = 45)
          ),
          
          
          
          # Show a plot of the generated distribution
          mainPanel(
                  plotOutput("distPlot2"),
                  plotOutput("distResid2")
          )
          
          
      ),
      
      tabPanel("Height Female",
               img(src = "pointing-finger1.gif"),br(""),
               a(href="./Tutorial.pdf", 'Click here to get the documentation', target='_blank'),
               h1("Female"),
               
               sidebarPanel(
                       p("View rotation"),
                       sliderInput("phiAngle3",
                                   "Angle phi:",
                                   min = 0,
                                   max = 90,
                                   value = 45),
                       sliderInput("thetaAngle3",
                                   "Angle theta:",
                                   min = 0,
                                   max = 90,
                                   value = 45)
               ),
               
               
               
               # Show a plot of the generated distribution
               mainPanel(
                       plotOutput("distPlot3"),
                       plotOutput("distResid3")
               )
               
      ),
      
      tabPanel("Predictor",
               img(src = "pointing-finger1.gif"),br(""),
               a(href="./Tutorial.pdf", 'Click here to get the documentation', target='_blank'),
               h1("Height Predictor"),
               sidebarPanel(
                       h4("Choose the heights of your parents"),
                       sliderInput("fatherHeight",
                                   "Father height:",
                                   min = 62.1,
                                   max = 78.40,
                                   value = 65),
                       sliderInput("motherHeight",
                                   "Mother height:",
                                   min = 58,
                                   max = 70.5,
                                   value = 60),
                       radioButtons("gender", label = h4("Choose gender"),
                                    choices = list("Male" = 1, "Female" = 2),
                                    selected = 1)
               ),
               sidebarPanel(
                       p("Child height predicted: "),
                       textOutput("heightPredicted")
                      
               )
              
               
              
      ),
      tabPanel("Documentation",
               img(src = "pointing-finger1.gif"),br(""),
               a(href="./Tutorial.pdf", 'Click here to get the documentation', target='_blank')         
     
      )
   )
)