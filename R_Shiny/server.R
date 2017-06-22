
server <- function(input, output) 
  {
  
  # filter for to filter the data for respondent 
  filter_repondent = reactive({
    hmdaData%>%
      filter(
        Respondent_Name_TS == input$Respondent
      ) 
  })
  
  # filter for to filter the data for County
  filter_county = reactive({
    hmdaData%>%
      filter(
        County_Name == input$County
      ) 
  })
  
  # filter for to filter the data for State
  filter_state = reactive({
    hmdaData%>%
      filter(
        State == input$state
      ) 
  })
  
  

  output$filterControls <- renderUI({
      selectInput("yearInput", "County", 
                  choices=c(unique(filter_repondent()$County_Name)))
  })
  
  output$firstPlot <- renderPlot({
    ggplot( filter_repondent(), aes( x= Conventional_Status))+
      geom_bar(stat= "Count", aes(fill = Conventional_Status))
  })

  output$secondPlot <- renderPlot({
    ggplot( filter_repondent(), aes( x= Loan_Type_Description))+
      geom_bar(stat= "Count", aes(fill = Loan_Type_Description))
  })
  
  output$linegraph <- renderPlot({
    ggplot(filter_repondent(),aes(x = As_of_Year,y=Loan_Amount_000,group = State ))+
      geom_line(aes(col = State),size = 1.5)
  })
  
  
  output$text1 <- renderText({ 
    paste(input$Respondent,
          " Respondent has an average of ",
          round(nrow(filter_repondent())/3,0),
          " number of loans applicants with an average of about ",
          round(mean(filter_repondent()$Loan_Amount_000,na.rm = T),2),
          " thousand $ per loan applicant")
  })
  
  output$thirdplot <- renderPlot({
    
    d <- filter_county()%>%
      group_by(Respondent_Name_TS)%>%
      summarise(n = n())%>%
      arrange(desc(n))
    
    ggplot( d[1:10,], aes( x= reorder(Respondent_Name_TS,n),y=n))+
      coord_flip() +
      geom_bar(stat = "identity", aes(fill = Respondent_Name_TS))
  })
  
  output$text2 <- renderText({
    str1 <- paste("Average loan applications for Year = ",
                  round(nrow(filter_state())/3, 0))
    
    str2 <- paste("Percentage of the total loan amount of all three years = ",
            round(sum(filter_county()$Loan_Amount_000,na.rm = T)*100/sum(hmdaData$Loan_Amount_000,na.rm = T),8))
    
    str3 <- paste("Total Amount = ",
          sum(filter_county()$Loan_Amount_000,na.rm = T),
                  "000 $")
    
    
    paste(str1,str2,str3, sep = "\n")
  })
  
### State filtering elemnets
  
  output$fourthplot <- renderPlot({
    
    d <- filter_state()%>%
      group_by(Respondent_Name_TS)%>%
      summarise(n = n())%>%
      arrange(desc(n))
    
    ggplot( d[1:10,], aes(x= reorder(Respondent_Name_TS, n),y=n))+
      coord_flip() +
      geom_bar(stat = "identity", aes(fill = Respondent_Name_TS))
  })
  
  output$text3 <- renderText({
    paste(
          "Average loan applications for Year = ", 
          round(nrow(filter_state())/3, 0),
          "Percentage of the total loan amount of all three years = ",
          round(sum(filter_state()$Loan_Amount_000,na.rm = T)*100/sum(hmdaData$Loan_Amount_000,na.rm = T),8),
          "Total Amount = ",
          sum(filter_state()$Loan_Amount_000,na.rm = T),
          "000 $")
  })
}
