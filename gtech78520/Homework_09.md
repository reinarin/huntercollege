GTECH78520_22S_11_Reina.Li326
================
Reina Li

------------------------------------------------------------------------

## R Spatial Lab Assignment # 1

For the R-Spatial Section labs, we will do some spatial data
visualization on COVID-19 in NYC. More specifically, we will explore the
distribution of confirmed cases across the city and their relationships
with some demographic variables and essential services related to retail
food stores and public health services.

The first lab is rather simple and straightforward but will be the
foundation for the next steps.

Tasks for the first lab are:

1.  [Set up a R project for the R-Spatial section.](#task-1)
2.  [Read the NYC postal areas in Shapefiles into *sf* objects. As NYC
    DOH publishes COVID-19 data by zip code, we will utilize the postal
    area data later.](#task-2)
3.  [Read and process the NYC public health services spreadsheet data.
    Create *sf* objects from geographic coordinates.](#task-3)
4.  [Read and process the NYS retail food stores data. Create *sf*
    objects from geographic coordinates for NYS.](#task-4)
5.  [Use simple mapping method, either based on `ggmap`+`ggplot` or
    *mapview*, with a basemap to verify the above datasets in terms of
    their geometry locations.](#task-5)
6.  [Save the three *sf* objects in a RData file or in a single
    GeoPackage file/database.](#task-6)

------------------------------------------------------------------------

### Task 1

Set up a R project for the R-Spatial section.

### Task 2

Read the NYC postal areas in Shapefiles into *sf* objects.

``` r
# Read the NYC postal areas in shapefiles into sf objects
postal_areas_sf <- st_read("ZIP_CODE_040114.shp")
```

### Task 3

Read and process the NYC public health services spreadsheet data. Create
*sf* objects from geographic coordinates.

``` r
# Read the NYC public health services data into a dataframe in R
public_health_services_df <- read.csv("Map_of_NYC_Health_and_Hospitals.csv")
```

The coordinates are located in the Location column. However, it is mixed
with text values. The coordinates are surrounded with parentheses. I
will use a regular expression to extract the values between a set of
parentheses. So, I will extract the coordinates (latitude and
longitude), save the coordinates into a dataframe, and then `cbind` with
the NYC public health services dataframe.

``` r
# Extract coordinates for Location column
lat_lon <- regmatches(public_health_services_df$Location.1, gregexpr( "(?<=\\().+?(?=\\))", public_health_services_df$Location.1, perl = T))

# Convert from list to matrix
lat_lon1 <- matrix(unlist(lat_lon))

# Split the comma-separated string coordinates into two columns
lat_lon2 <- data.frame(str_split_fixed(lat_lon1, ", ", 2))

# Rename the columns to Latitude and Longitude
colnames(lat_lon2) <- c("Latitude", "Longitude")

# Convert the latitude and longitude values from character into numeric values and save it in the dataframe
lat_lon2$Latitude <- as.numeric(lat_lon2$Latitude)
lat_lon2$Longitude <- as.numeric(lat_lon2$Longitude)

# Add to the NYC public health services dataframe
public_health_services_df <- cbind(public_health_services_df, lat_lon2)

# Rename columns
colnames(public_health_services_df) <- c("Facility_Type", "Borough", "Facility_Name", "Cross_Streets", "Phone", "Location", "Latitude", "Longitude") 

# Remove unused variables
rm('lat_lon', 'lat_lon1', 'lat_lon2')
```

``` r
# Create sf objects from geographic coordinates
public_health_services_sf <- st_as_sf(public_health_services_df, coords = c("Longitude", "Latitude"))

# Assign the WGS84 project, EPSG code 4326
st_crs(public_health_services_sf) <- 4326
```

### Task 4

Read and process the NYS retail food stores data. Create *sf* objects
from geographic coordinates for NYS.

``` r
# Read the NYS retail food stores data into a dataframe in R
retail_food_stores_df <- read.csv("NYS_Retail_Food_Stores.csv")
```

The coordinates are located in the Location column. However, it is mixed
with text values. The coordinates are surrounded with parentheses. I
will use a regular expression to extract the values between a set of
parentheses. So, I will extract the coordinates (latitude and
longitude), save the coordinates into a dataframe, and then `cbind` with
the NYS retail food stores dataframe.

``` r
# Extract coordinates for Location column
lat_lon <- regmatches(retail_food_stores_df$Location, gregexpr( "(?<=\\().+?(?=\\))", retail_food_stores_df$Location, perl = T))

# Split the comma-separated string coordinates into two columns
lat_lon1 <- data.frame(str_split_fixed(lat_lon, ", ", 2))

# Rename the columns to Latitude and Longitude
colnames(lat_lon1) <- c("Latitude", "Longitude")

# Convert the latitude and longitude values from character into numeric values and save it in the dataframe
lat_lon1$Latitude <- as.numeric(lat_lon1$Latitude)
lat_lon1$Longitude <- as.numeric(lat_lon1$Longitude)

# Add to the NYS retail food stores dataframe
retail_food_stores_df <- cbind(retail_food_stores_df, lat_lon1)

# There are missing coordinate values, so I will remove those rows from the data frame
retail_food_stores_df <- retail_food_stores_df %>%
  select(c(-Address.Line.2, -Address.Line.3))
retail_food_stores_df <- na.omit(retail_food_stores_df)

# Rename columns
colnames(retail_food_stores_df) <- c("County", "License_Number", "Operation_Type", "Establishment_Type", "Entity_Name", "DBA_Name", "Street_Number", "Street_Name", "City", "State", "Zip_Code", "Square_Footage", "Location", "Latitude", "Longitude")

# Remove unused variables
rm('lat_lon', 'lat_lon1')
```

``` r
# Create sf objects from geographic coordinates for NYC
retail_food_stores_sf <- st_as_sf(retail_food_stores_df, coords = c("Longitude", "Latitude"))

# Assign the WGS84 project, EPSG code 4326
st_crs(retail_food_stores_sf) <- 4326
```

### Task 5

Use simple mapping method, either based on `ggmap` + `ggplot` or
*mapview*, with a basemap to verify the above datasets in terms of their
geometry locations.

``` r
# Verify postal areas dataset
plot(postal_areas_sf['ZIPCODE'], main = "NYC Postal Codes")
```

![](Homework_09_files/figure-gfm/R-spatial-assignment-task%205a-1.png)<!-- -->

``` r
# Verify NYC public health services dataset
public_health_services_sf %>% st_bbox() %>% as.vector() %>%
  ggmap::get_stamenmap(zoom = 11, messaging = FALSE) -> baseMap

ggmap(baseMap) +
  geom_point(aes(x=X, y=Y), 
             data = public_health_services_sf %>% st_coordinates() %>% tibble::as_tibble())
```

![](Homework_09_files/figure-gfm/R-spatial-assignment-task%205a-2.png)<!-- -->

``` r
# Verify NYS retail food stores dataset
retail_food_stores_sf %>% st_bbox() %>% as.vector() %>%
  ggmap::get_stamenmap(zoom = 11, messaging = FALSE) -> baseMap1

ggmap(baseMap1) +
  geom_point(aes(x=X, y=Y), 
             data = retail_food_stores_sf %>% st_coordinates() %>% tibble::as_tibble())
```

![](Homework_09_files/figure-gfm/R-spatial-assignment-task%205a-3.png)<!-- -->

### Task 6

Save the three *sf* objects in a RData file or in a single GeoPackage
file/database.

``` r
# Save data to RData file
save(postal_areas_sf, public_health_services_sf, retail_food_stores_sf,
     file = "covid19.RData")

# To get the data back into R
# load(file = "covid19.RData")

# Save data to a GeoPackage file/database
st_write(postal_areas_sf,
         dsn = "covid19.gpkg",
         layer = "postal_areas",
         delete_layer = TRUE)

st_write(public_health_services_sf,
         dsn = "covid19.gpkg",
         layer = "public_health_services",
         delete_layer = TRUE)

st_write(retail_food_stores_sf,
         dsn = "covid19.gpkg",
         layer = "retail_food_stores",
         delete_layer = TRUE)
```
