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
  titlePanel(h4("Data entry app")),
  br(),
  fluidRow(
    # Example input: manual text entry
    column(3, selectInput('select.1',
                        label='Type',
                        choices= c('fwrd_pass','bck_pass','shot','dribble'),
                        width = '95%')),

    # Example input: selecting pre-canned options
    column(3, selectInput('select.2',
                          label='Status',
                          choices = c('complete','incomplete','on target','not on target','successful','unsuccessful'),
                          width='95%')),

    column(3, selectInput('select.3)',
                          label= 'Height',
                          choices= c('air','ground'),
                          width='95%')),

    # Example input: toggling between options
    column(3, radioButtons('radio',
                           label='Third of the Field',
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



