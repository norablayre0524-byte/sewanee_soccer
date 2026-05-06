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
  h3("Soccer Attack Data Entry: How to Use"),
  p("    This app allows you to create data frames for attacking statistics of a soccer game. It includes defensive actions like foward passes, backwards passes,
    shots, and driblles. Further, the success of these actions as well as the third of the field in which they occur can be noted. This can be a great
    tool for analyzing a soccer team's attacking quality and what areas they can improve upon."),
  titlePanel(h4("Data entry app")),
  br(),
  fluidRow(
    # Example input: manual text entry
    column(3, selectInput('select.1',
                        label='Select the Type of Action',
                        choices= c('fwrd_pass','bck_pass','shot','dribble'),
                        width = '95%')),

    # Example input: selecting pre-canned options
    column(3, selectInput('select.2',
                          label='Choose the Success or Status of that Action',
                          choices = c('complete','incomplete','on target','not on target','successful','unsuccessful'),
                          width='95%')),

    column(3, selectInput('select.3)',
                          label= 'Select the Height of that Action',
                          choices= c('air','ground'),
                          width='95%')),

    # Example input: toggling between options
    column(3, radioButtons('radio',
                           label='Select the Third of the Field in Which that Action Occurred',
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
    newdata <- c(input$select.1, input$select.2, input$select.3, input$radio)
    log_line(newdata)
    showNotification("Save successful!")
  })
  #=============================================================================

}

################################################################################
################################################################################

shinyApp(ui, server)



