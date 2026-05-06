setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(shiny)
library(lubridate)
library(DT)

# Function for saving data to a CSV file
log_line <- function(newdata, filename = 'app_data.csv'){
  (dt <- Sys.time() %>% round %>% as.character)
  (newline <- c(dt, newdata) %>% paste(collapse=',') %>% paste0('\n'))
  cat(newline, file=filename, append=TRUE)
  print('Data stored!')
}

################################################################################
################################################################################

ui <- fluidPage(
  h3("Soccer Defense Data Entry: How to Use"),
  p("    This app allows you to create data frames for defensive statistics of a soccer game. It includes defensive actions like passes allowed, takcles,
    headers, and fouls. Further, the success of these actions as well as the third of the field in which they occur can be noted. This can be a great
    tool for analyzing a soccer team's defensive quality and what areas they can improve upon."),
  titlePanel(h4("Data Entry for Defensive Statistics")),
  br(),
  fluidRow(
    column(3, selectInput('select.1',
                          label='Select the Defensive Action that Occurred',
                          choices= c('fwrd_pass_allowed','bck_pass_allowed','tackle','header','foul'),
                          width = '95%')),
    
    # Example input: selecting pre-canned options
    column(3, selectInput('select.2',
                          label='Choose the Status/Success of the Action',
                          choices = c('complete','incomplete','won','not won'),
                          width='95%')),
    # Example input: toggling between options
    column(3, radioButtons('radio',
                           label='Select the Third of the Field in which the Action Occurred',
                           choices = c('attacking third','middle third','defensive third'),
                           inline = TRUE,
                           width='95%'))),
  br(),
  br(),
  fluidRow(column(2),
           # Save button!
           column(8, actionButton('save',
                                  h2('Save!'),
                                  width='100%')),
           column(2))
)

################################################################################
################################################################################

server <- function(input, output) {
  
  # Save button ================================================================
  observeEvent(input$save, {
    newdata <- c(input$select.1, input$select.2, input$radio)
    log_line(newdata)
    showNotification("Save successful!")
  })
  #=============================================================================
  
}

################################################################################
################################################################################

shinyApp(ui, server)
