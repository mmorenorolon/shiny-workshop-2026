# user interface
ui <- navbarPage(
  
  # Title
  title = "LTER Animal Data Explorer",
  
  # (Page 1) Intro tab panel
  tabPanel(title = "About this App",
           
           # intro text fluidRow ----
           fluidRow(
             
             # use columns to create white space on sides
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
           ), # END intro text fluidRow
           
           hr(), # creates light gray horizontal line
           
           # footer text ----
           includeMarkdown("text/footer.md")
           
  ), # END Page 1 intro tabPanel
  
  # (Page 2) Data tabPanel
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain  tabs for data viz ----
           tabsetPanel(
             
             #trout tabPanel
             tabPanel(
               
               title = "Trout",
               
               # trout sidebarLayout ----
               sidebarLayout(
                 
                 # trout sidebarPanel ----
                 sidebarPanel(
                   
                   # Channel type picker
                   pickerInput(inputId = "channel_type_input",
                               label = "Select channel type(s):",
                               choices = unique(clean_trout$channel_type),
                               selected = c("cascade", "pool"),
                               multiple = TRUE,
                               options = pickerOptions(actionsBox = TRUE)), # END channel type pickerInput
                   
                   # section checkboxGroupButtons
                   checkboxGroupButtons(inputId = "selection_input",
                                        label = "Select a sampling section(s):",
                                        choices = c("clear cut forest", "old growth forest"),
                                        selected = c("clear cut forest", "old growth forest"),
                                        justified = TRUE,
                                        checkIcon = list(yes = icon("check", 
                                                                    lib = "font-awesome"),
                                                         no = icon("xmark", lib = "font-awesome"))) #END checkboxGroupButtons input
                 ), # END trout sidebarPanel
                 
                 # trout mainPanel ----
                 mainPanel(
                   
                   # Placeholder for trout scatterplot output
                   plotOutput(outputId = "channel_type_output") |> 
                     withSpinner(color = "blue",type = 8))
                   
                 ) # END trout mainPanel
                 
               ) # END trout sidebarLayout
               
             ), # END trout tabPanel
             
             #penguins tabPanel
             tabPanel(
               
               title = "Penguins",
               
               # penguins sidebarLayout ----
               sidebarLayout(
                 
                 # penguins sidebarPanel ----
                 sidebarPanel(
                   
                   # island pickerInput
                   pickerInput(inputId = "island_input",
                               label = "Select an island:",
                               choices = unique(penguins$island),
                               selected = c("Torgersen", "Dream", "Biscoe"),
                               multiple = TRUE,
                               options = pickerOptions(actionsBox = TRUE)), # END penguins island pickerInput
                   
                   sliderInput(inputId = "bin_number_input",
                               label = "Select the number of bins",
                               min = 1,
                               max = 100,
                               value = 25
                               ) # END penguins bins pickerInput
                   
                 ), # END penguins sidebarPanel
                 
                 # penguins mainPanel ----
                 mainPanel(
                   
                   # penguins plot output
                   plotOutput(outputId = "penguins_output"),
                   
                   
                 ) # END penguins mainPanel
                 
               ) # END penguins sidebarLayout
               
             ) # END penguins tabPanel
             
           ) # END tabsetPanel
           
  ) # END Page 2 Data tabPanel
  
) # END navbarPage