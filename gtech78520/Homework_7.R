# Homework ----------------------------------------------------------------

# Use the covid-19 data and create 2 sets of facet (_wrap) bar charts for 
# twelve randomly chosen states in the USA.  The data are weekly cases 
# over time (group by weeks).  The second facet chart for the same 12 states is 
# the weekly cases per 100000 population in the state.  Please use the covid
# data for cases and county population.  Apply a title to each chart with
# clearly articulated x and y axis titles and labels.  Use themes() to make 
# your final charts visually appealing.  

# Libraries ---------------------------------------------------------------

library(tidyverse)
library(rstudioapi)
library(janitor)
library(lubridate)
library(tidyquant)

# Directories and data ----------------------------------------------------

# Without setting the project: Set directories 
wd <- dirname(getActiveDocumentContext()$path)
setwd(wd)

# Get the data
cases <- read_csv(file.path(wd, "covid_confirmed_usafacts.csv"))
deaths <- read_csv(file.path(wd, "covid_deaths_usafacts.csv"))
pop <- read_csv(file.path(wd, "covid_county_population_usafacts.csv"))

# Initial manipulation and joining ----------------------------------------

cases_long <- cases %>%
  filter(countyFIPS > 0) %>%
  gather(key = Date, value = Cases, `2020-01-22`:names(cases[length(cases)]))%>%
  mutate(Date = as.Date(Date))

deaths_long <- deaths %>%
  filter(countyFIPS > 0) %>%
  gather(key = Date, value = Deaths, `2020-01-22`:names(deaths[length(deaths)]))%>%
  mutate(Date = as.Date(Date))

counties_covid19 <- cases_long %>%
  left_join(deaths_long, by = c("countyFIPS", "County Name", "State",
                                "StateFIPS", "Date")) %>%
  left_join(pop, by = c("countyFIPS", "County Name", "State")) %>%
  filter(population > 0)

# Continue from here...----------

# randomly choose 12 states
states_list <- unique(cases$State)
states_list <- states_list[-9] # remove "DC" from the list because DC is not a state
random_12_states <- sample(states_list, 12, replace=FALSE)
random_12_states

# set up data to make facet wrap bar chart
facetwrap_1 <- counties_covid19 %>%
  # Filter for the states randomly chosen from previous code
  filter(is.element(State, random_12_states)) %>%
  group_by(State) %>%
  tq_transmute(select = Cases,
               mutate_fun = apply.weekly,
               FUN = sum)

# first set of facet_wrap bar chart for 12 randomly chosen USA states
# weekly cases over time (group by weeks)
ggplot(facetwrap_1, aes(x = Date, y = Cases)) + 
  geom_bar(stat = "identity") + 
  facet_wrap(~State) + 
  labs(title = "Weekly COVID-19 Cases Over Time",
       x = "Time (week of)",
       y = "Count of COVID-19 cases") + 
  theme(strip.text = element_text( size = 12, color = "white", hjust = 0.5 ),
        strip.background = element_rect( fill = "#858585", color = NA ),    
        panel.background = element_rect( fill = "#efefef", color = NA ),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_line( color = "#b2b2b2" ),
        panel.spacing.x = unit( 1, "cm" ),
        panel.spacing.y = unit( 0.5, "cm" ),
        legend.position = "none",
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, colour = 'gray50'))

# set up data to make facet wrap bar chart
facetwrap_2 <- counties_covid19 %>%
  # Filter for the states randomly chosen from previous code
  filter(is.element(State, random_12_states)) %>%
  group_by(State) %>%
  tq_transmute(select = population,
               mutate_fun = apply.weekly,
               FUN = sum) %>%
  left_join(facetwrap_1, by = c("State", "Date")) %>%
  # ungroup and then group again
  ungroup() %>%
  group_by(State) %>%
  mutate(Cases_per_100000pop = (Cases*(population/100000)))

# second set of facet_wrap bar chart for same 12 USA states
# weekly cases per 100,000 population in the state
ggplot(facetwrap_2, aes(x = Date, y = Cases * (population / 100000))) + 
  geom_bar(stat = "identity") + 
  facet_wrap(~State) + 
  labs(title = "Weekly COVID-19 Cases Over Time per 100,000 State Population",
       x = "Time (week of)",
       y = "Count of COVID-19 cases per 100,000 population in the State") + 
  theme(strip.text = element_text( size = 12, color = "white", hjust = 0.5 ),
        strip.background = element_rect( fill = "#858585", color = NA ),    
        panel.background = element_rect( fill = "#efefef", color = NA ),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_line( color = "#b2b2b2" ),
        panel.spacing.x = unit( 1, "cm" ),
        panel.spacing.y = unit( 0.5, "cm" ),
        legend.position = "none",
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, colour = 'gray50'))
