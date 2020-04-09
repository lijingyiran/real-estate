# Mallory - STAT 550 2020###
# This is the user interface version of the shiny app

library(shinythemes)

ui <- fluidPage(theme = shinytheme("paper"),
                # header
                div(id = "headerSection",
                    h2("BC Mill Rate & Assessment Value Predictions"),
                    
                    span(
                      style = "font-size: 1em",
                      # authors
                      span("Created by "),
                      a("Gian Carlo Diluvi, Vittorio Romaniello, Sophia Li & Mallory Flynn"),
                      HTML("&bull;"),
                      # date
                      span("April 2020"),
                      HTML("&bull;"),
                      # Shiny app code link
                      span("Code"),
                      a("on GitHub", href = "insert_link"),
                    )
                ),
                
                
                # all content goes here, and is hidden initially until the page fully loads
                sidebarLayout(
                  sidebarPanel(
                                    
                    # Only show the following for assessment predictions:
                    # Use PIC?
                    checkboxInput("picInput", "Use PIC?", value = FALSE),
                    selectInput("typeInput", "Estimate Type",
                                c("Select", "Assessment Value", "Mill Rate"),
                                selected = "Select"),
                                     
                    # If using PIC:
                    conditionalPanel("input.picInput",
                                     textInput("identInput", "PIC:", placeholder = NULL)),
                                     
                    # If PIC is not available:
                    conditionalPanel("!input.picInput",
                                     # selectInput("typeInput", "Estimate Type",
                                     #             c("Select", "Assessment Value", "Mill Rate"),
                                     #             selected = "Select"),
                                     
                                     # for municipality
                                     selectInput("municipalityInput", "Municipality:", 
                                                 c("-",sort(unique(dat$municipality))),
                                                 selected = "-"),
                                                     
                                     # for Tax Class code
                                     selectInput("taxclassInput", "Tax Class Code:",
                                                 c("-",sort(unique(dat$tax.class))),
                                                 selected = "-"),
                                     
                                     #conditional input for estimate type
                                     conditionalPanel("input.typeInput == 'Assessment Value'",
                                                      numericInput("assessmentInput",
                                                                   "Current Assessment Value:",
                                                                   value = 500000, min = 0, 
                                                                   max = 6000000000))
                                     ),
                                    
                    
                    
                    # button to update the data
                    shiny::hr(),
                    actionButton("updateButton", "Update"),
                      
                    
                    # source of data as a footer
                    br(),
                    br(),
                    p("Generated using data from ",
                      a("the Altus Group Ltd.",
                        href = "https://www.altusgroup.com",
                        target = "_blank")),
                    a(img(src = "AltusGroup.svg", alt = "Altus Group"),
                      href = "https://www.altusgroup.com",
                      target = "_blank"),
                    bookmarkButton()
                    ),
                
                 
                  # main panel with Estimate tab and plot tab with mill rates
                  # or assessment values over time
                  mainPanel(h4(textOutput("resultsText")),
                            tabsetPanel(
                              tabPanel("Estimate", 
                                       br(),
                                       verbatimTextOutput("results")),
                               tabPanel("Plot", 
                                        br(),
                                        plotOutput("coolplot"))
                              )
                  )
                )
                )

                