
library(shiny)
library(coronavirus)
library(tidyverse)
library(kableExtra)
library(lubridate)
library(plotly)
library(leaflet)
library(shinythemes)


# province data -----------------------------------------------------------
coronavirus %>%
  filter(country %in% c("Australia","United Kingdom","China"), date >= "2020-01-27")%>%
  mutate(Month=month(date))%>%
  group_by(type,province,Month,country,long,lat) %>%
  summarise(Cases = sum(cases),.groups = 'drop')%>%
  rename(Type=type)->data
data<-data[-c(1:9),]

region<-coronavirus %>%
  filter(country %in% c("Australia","United Kingdom","China"))%>%
  mutate(Month=month(date))%>%
  group_by(type,country,province,long,lat) %>%
  summarise(Cases = sum(cases),.groups = 'drop')%>%
  filter(type=="confirmed")
region <- region[-c(42),]

country<-tibble(country=c("China","United Kingdom","Australia"),
                long=c(104.1954,-3.4360,133.7751),
                lat=c(35.8617,55.3781,-25.2744))

data%>%
  select(Type,Month,country,Cases)%>%
  group_by(Type,Month,country) %>%
  summarise(Cases = sum(Cases))%>%
  pivot_wider(names_from = Type,
              values_from = Cases)->new_data
data %>%
  select(Type,Month,country,province,Cases)%>%
  group_by(Type,Month,country,province) %>%
  summarise(Cases = sum(Cases))%>%
  drop_na()%>%
  mutate(Level=ifelse(Type=="confirmed",0,ifelse(Type=="death",1,ifelse(Type=="recovered",2))))->area


# Define UI for application that draws a histogram
ui <- fluidPage(
  br(),
  
  # Application title
  #titlePanel("Covid 19 Case situation acorss each country"),
  navbarPage(theme = shinytheme("flatly"), collapsible = TRUE,
             "COVID-19 tracker", id="nav",
             
             tabPanel("Country/Region plots",
                      # Sidebar with a slider input for number of bins
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("country", "Which country do you want to examine?", choices = unique(data$country),
                                      selected = "China"),
                          selectInput("province", "Which province?", choices = ""),
                          leafletOutput("leaflet")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h4("Case distribution plot"),
                                  plotlyOutput("lineplot"),
                                  br(),
                                  br(),
                                  br(),
                                  plotlyOutput("click")
                                  
                        )
                      )
             ),             tabPanel("Covid-19 Case Summary",
                                     sidebarLayout(
                                       sidebarPanel(
                                         radioButtons("comparison_summary", h3("Select country:"),
                                                      choices =unique(new_data$country)),
                                       ),
                                       mainPanel(htmlOutput("table1")))),
             tabPanel("About",
                      fluidRow(
                        column(8,
                               includeMarkdown('./about/about.Rmd')
                        )
                      )
             )
  ))



# Define server logic required to draw a histogram
server <- function(input, output,session) {
  
  observeEvent(input$country, {
    updateSelectInput(session, "province",
                      choices = filter(region, country==input$country)$province)
  })
  
  output$leaflet <- renderLeaflet({
    country_df <- filter(country, country==input$country)
    leaflet() %>%
      setView(lat = country_df$lat, lng = country_df$long,  zoom = 3) %>%
      addTiles() %>%
      #addCircleMarkers(
      addMarkers(
        data = filter(region, country==input$country),
        layerId = ~province,
        lng = ~long,
        lat = ~lat,
        #radius = ~(Cases/2000),
        label = ~paste("Region: ",province,"; Confirmed case:",Cases)
        #weight = 2,
        #color = "#EF0F21"
      )
  })
  clicked_leaflet <- reactiveValues(clickedMarker=NULL)
  observeEvent(input$leaflet_marker_click,{
    clicked_leaflet$clickedMarker <- input$leaflet_marker_click
    
  })
  observeEvent(input$leaflet_marker_click, { # update the location selectInput on map clicks
    p <- input$leaflet_marker_click
    if(!is.null(p$id)){
      if(is.null(input$province) || input$province!=p$id)
        updateSelectInput(session, "province", selected=p$id)
    }
  })
  
  
  selected_coordinates= reactive(({
    c(clicked_leaflet$clickedMarker$lng,clicked_leaflet$clickedMarker$lat)
  }))
  
  output$fish=renderTable({
    selected_data()
  })
  
  selected_data= reactive(({
    if(is.null(clicked_leaflet$clickedMarker))
      return(NULL)
    
    filter(data, long == as.numeric(as.character(selected_coordinates()[1])),lat==as.numeric(as.character(selected_coordinates()[2])))
  }))
  output$lineplot <- renderPlotly({
    
    temp=selected_data()
    if(is.null(temp))
      return(NULL)
    plot_country<-ggplot(data=temp,#filter(data,province==input$province,country==input$country),
                         aes(x=Month,y=Cases,col=Type))+
      #geom_sf(data=filter(data,country==input$country))+
      geom_line()+
      geom_point()+
      labs(x = "Month", y = "Cases count", title = temp$province)+
      theme_bw()+
      theme(legend.position="bottom",
            legend.direction="horizontal",
            legend.box.background = element_rect(fill = "transparent"),
            legend.background = element_rect(fill = "transparent",linetype="solid",color = "#BDD9EC"),
            axis.text = element_text(size = 10),
            legend.text = element_text(size = 10),
            legend.title = element_blank(),
            axis.title = element_text(size = 12),
            axis.line = element_line(size = 0.4, colour = "white"),
            plot.background = element_rect(fill = "#e3f0fc"),
            panel.background = element_rect(fill="transparent"),
            panel.border = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.ticks.x.bottom = element_line(colour = "white",size = 0),
            plot.margin = margin(10,20,10,20))+
      scale_x_continuous(breaks = seq(1, 9,1))
    ggplotly(plot_country)
  })
  
  output$click <- renderPlotly({
    d <- event_data("plotly_click")
    area %>%
      filter(country==input$country,province==input$province)%>%
      filter(Level %in% d$curveNumber)%>%
      plot_ly(labels = ~Month, values = ~Cases,
              textposition = 'inside',
              textinfo="label+percent",
              insidetextfont = list(color = '#FFFFFF'),
              hoverinfo = 'text',
              text = ~paste("Month: ",Month,"; Type: ",Type,"; Cases:",Cases),
              marker = list(colors = colors,
                            line = list(color = '#FFFFFF', width = 1)),
              type = 'pie') %>%
      layout(title=" The proportion of cases in different months ",
             legend = list(title = list(text = "Month")),
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
  })
  
  
  output$table1 <- renderText({
    filter(new_data,country==input$comparison_summary)%>%
      kable(col.names = c("Month", "Country", "Confirmed", "Death", "Recovered"),
            align = "llrrr",
            booktabs=TRUE,
            caption = "summary statistic")%>%
      kable_styling(bootstrap_options = c("striped", "hover", "border"))%>%
      row_spec( 1:9,bold = T,color = "white",background = "#2875a1")
    
  })
}

# Run the application
shinyApp(ui = ui, server = server)
