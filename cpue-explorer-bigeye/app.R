library(shiny)
library(tidyverse)
library(rsconnect)
library(sf)


# -------------------------- Load in Data ------------------------------------
# Can't use here because the paths kept breaking

bigeye_data <- readRDS("Data/Binned_Bigeye.rds")

bigeye_data <- bigeye_data %>%
  mutate(year = as.numeric(as.character(year))) # convert from factor to character to numeric

# ----------------------------- Add Hawaii overlay --------------------------

# Load Pre-calculated Hawaii overlay 

hawaii_shifted <- readRDS("Data/hawaii_overlay.rds")

# -------------------------- UI --------------------------------
ui <- fluidPage(
  titlePanel("Bigeye CPUE Explorer - Hawaiʻi Deepset Longline Fishery"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "year_selected",
        label = "Select Year:",
        choices = sort(unique(bigeye_data$year)), # auto-pulls years
        selected = max(unique(bigeye_data$year))
      ),
      br(),
      tags$img(src = "bigeye.png", height = "100px", style = "display: block; margin-top: 20px;")
    ),
    
    mainPanel(
      tags$div(
        style = "background-color: #f9f9f9; padding: 15px; border-radius: 5px;",
        plotOutput("cpue_plot"),
        br(),
        h4("Top 5 CPUE Bins for Selected Year"),
        tableOutput("cpue_table")
      )
    )
  )

)

# ----------------------------- Server --------------------------------------
server <- function(input, output, session) {

  # Reactive filtered data set based on the year
  filtered_data <- reactive({
    bigeye_data %>%
      filter(year == input$year_selected)
  })
  
  # CPUE Plot for the selected year
  output$cpue_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = lon_bin,
                                y = lat_bin,
                                fill = cpue)) +
      geom_tile(color = "white") +
      geom_sf(data = hawaii_shifted, fill = "gray50", color = NA, inherit.aes = FALSE) + # add Hawaii overlay
      scale_fill_viridis_c(option = "C", na.value = "gray90") +
      labs(
        title = paste("Bigeye Tuna CPUE in", input$year_selected),
        x = "Longitude (5° bin)",
        y = "Latitude (5° bin)",
        fill = "CPUE"
      ) +
      coord_sf(xlim = c(180, 215),
                ylim = c(5,35),
               expand = FALSE) + # fix coordinate system so map looks the same every time
      theme_minimal()
  })
  
  # Output table showing top 5 CPUE bins for that year
  output$cpue_table <- renderTable({
    filtered_data() %>%
      arrange(desc(cpue)) %>% # sort bins by highest CPUE
      select( # rename so they pretty, "presentable" names
        'Latitude Bin' = lat_bin,
        'Longitude Bin' = lon_bin,
        'CPUE' = cpue
      ) %>%
      head(5) # show top 5 rows
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


