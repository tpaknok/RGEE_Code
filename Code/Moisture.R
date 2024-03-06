library(rgee)
ee_install()

ee_Initialize()

moisture <- ee$ImageCollection("NASA_USDA/HSL/SMAP10KM_soil_moisture") %>%
  #ee$ImageCollection$filterBounds(ee$Geometry$Point(comm.data[j,c("Long")],comm.data[j,c("Lat")])) %>%
  ee$ImageCollection$filterDate("2016-01-01", "2016-12-31") %>%
  ee$ImageCollection$map(function(x) x$select("susm")) 

subMmean2016 <- moisture$reduce(ee$Reducer$mean())
subMsd2016 <- moisture$reduce(ee$Reducer$stdDev())

moisture <- ee$ImageCollection("NASA_USDA/HSL/SMAP10KM_soil_moisture") %>%
  #ee$ImageCollection$filterBounds(ee$Geometry$Point(comm.data[j,c("Long")],comm.data[j,c("Lat")])) %>%
  ee$ImageCollection$filterDate("2017-01-01", "2017-12-31") %>%
  ee$ImageCollection$map(function(x) x$select("susm")) 

subMmean2017 <- moisture$reduce(ee$Reducer$mean())
subMsd2017 <- moisture$reduce(ee$Reducer$stdDev())

moisture <- ee$ImageCollection("NASA_USDA/HSL/SMAP10KM_soil_moisture") %>%
  #ee$ImageCollection$filterBounds(ee$Geometry$Point(comm.data[j,c("Long")],comm.data[j,c("Lat")])) %>%
  ee$ImageCollection$filterDate("2018-01-01", "2018-12-31") %>%
  ee$ImageCollection$map(function(x) x$select("susm")) 

subMmean2018 <- moisture$reduce(ee$Reducer$mean())
subMsd2018 <- moisture$reduce(ee$Reducer$stdDev())

moisture <- ee$ImageCollection("NASA_USDA/HSL/SMAP10KM_soil_moisture") %>%
  #ee$ImageCollection$filterBounds(ee$Geometry$Point(comm.data[j,c("Long")],comm.data[j,c("Lat")])) %>%
  ee$ImageCollection$filterDate("2019-01-01", "2019-12-31") %>%
  ee$ImageCollection$map(function(x) x$select("susm")) 

subMmean2019 <- moisture$reduce(ee$Reducer$mean())
subMsd2019 <- moisture$reduce(ee$Reducer$stdDev())

moisture <- ee$ImageCollection("NASA_USDA/HSL/SMAP10KM_soil_moisture") %>%
  #ee$ImageCollection$filterBounds(ee$Geometry$Point(comm.data[j,c("Long")],comm.data[j,c("Lat")])) %>%
  ee$ImageCollection$filterDate("2020-01-01", "2020-12-31") %>%
  ee$ImageCollection$map(function(x) x$select("susm")) 

subMmean2020 <- moisture$reduce(ee$Reducer$mean())
subMsd2020 <- moisture$reduce(ee$Reducer$stdDev())

subMmean <- ee$ImageCollection(list(subMmean2016,subMmean2017,subMmean2018,subMmean2019,subMmean2020))
subMmean.reduced <- subMmean$mean()

subMsd <- ee$ImageCollection(list(subMsd2016,subMsd2017,subMsd2018,subMsd2019,subMsd2020))
subMsd.reduced <- subMsd$mean()

geometry <- ee$Geometry$Rectangle(
  coords = c(-180, -90, 180, 90),
  proj = "EPSG:4326",
  geodesic = FALSE
)

task <- ee_as_raster(image=subMmean.reduced,
                     region = geometry,
                  via="drive",
                  scale=10000,
                  maxPixels = 1e+10)

ee_monitoring(task)
ee_as_raster(subMsd.reduced)