


ui <- dashboardPage(
  dashboardHeader(title = "HMDA Data Analysis"),
  # Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Competitor",tabName = "1",    icon = icon("dashboard")),
      menuItem("County Wise",tabName = "2",    icon = icon("dashboard")),
      menuItem("State Wise",tabName = "3",    icon = icon("dashboard"))
    )
  ),
  # Body content
  dashboardBody(
    tabItems(
      tabItem(tabName = "1",
              # Creates the controls for providing input to filter data for plots
              fluidRow(
                box(
                  # Control for Region
                  title = "Competitor",background = "black",height = 150,width = 1000,
                  selectInput("Respondent", "Respondent Name",
                              choices=c(sort(decreasing = T,unique(hmdaData$Respondent_Name_TS)))
                )
              )
              ),
              fluidRow(
                       box(title= "Distribution of applicants among different Conventional Status(Bar Chart)",background = "navy",solidHeader = TRUE, 
                    plotOutput("firstPlot"),height = 500),
                    box(title= "Distribution of applicants among different Loan Types Status(Bar Chart)",background = "navy",solidHeader = TRUE, 
                        plotOutput("secondPlot"),height = 500)),
              fluidRow(box(title= "Respondent Stats",background = "navy",solidHeader = TRUE, 
                           textOutput("text1"),tags$head(tags$style(
                                          "#text1{color: white;
                                                   font-size: 30px;
                                                  font-style: italic;
                                          }"
                         )
                           )
                           ,height = 200,width = 1500))
      ),
      tabItem(tabName = "2",
              # Creates the controls for providing input to filter data for plots
              fluidRow(
                box(
                  # Control for Region
                  title = "County",background = "black",height = 150,width = 1000,
                  selectInput("County", "County Name",
                              choices=c(sort(decreasing = T,unique(hmdaData$County_Name)))
                  )
                )
              ),
              fluidRow(
                box(title= "Distirbution of Applicants of top 10 respondents in the selected county",background = "navy",solidHeader = TRUE, 
                    plotOutput("thirdplot"),height = 500,width = 1500)),
              fluidRow(
                box(title= "County Stats",background = "navy",solidHeader = TRUE, 
                    textOutput("text2"),tags$head(tags$style(
                      "#text2{color: white;
                              font-size: 30px;
                              font-style: italic;
                      }"
                         )
                    )
                    ,height = 200,width = 1500))
              ),
      tabItem(tabName = "3",
              # Creates the controls for providing input to filter data for plots
              fluidRow(
                box(
                  # Control for Region
                  title = "State",background = "black",height = 150,width = 1000,
                  selectInput("state", "State Name",
                              choices=c(sort(decreasing = T,unique(hmdaData$State)))
                  )
                )
              ),
              fluidRow(
                box(title= "Distirbution of Applicants of top 10 respondents in the selected State",background = "navy",solidHeader = TRUE, 
                    plotOutput("fourthplot"),height = 500,width = 1500)),
              fluidRow(
                box(title= "State wise Stats",background = "navy",solidHeader = TRUE, 
                    textOutput("text3"),tags$head(tags$style(
                      "#text3{color: white;
                      font-size: 30px;
                      font-style: italic;
                      }"
                         )
                    )
                    ,height = 200,width = 1500))
                )
      )
      )
    )