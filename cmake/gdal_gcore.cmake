#==============================================================================#
# GCore
# Here, we assume that gtiff will be built, natively, by GDal
#==============================================================================#
SET (gdal_gcore_DIR ${PROJECT_SOURCE_DIR}/gdal/gcore)
FILE ( GLOB gdal_gcore_SRCS ${gdal_gcore_DIR}/*.cpp
                            ${gdal_gcore_DIR}/*.c
                            ${gdal_gcore_DIR}/mdreader/*.cpp
                            ${gdal_gcore_DIR}/mdreader/*.h)
FILE ( GLOB gdal_gcore_HDRS ${gdal_gcore_DIR}/*.h)  

REMOVE(gdal_gcore_SRCS ${gdal_gcore_DIR}/jp2dump.cpp)

#==============================================================================#
#Set the include directories here
#==============================================================================#
INCLUDE_DIRECTORIES(${gdal_gcore_DIR})  
SOURCE_GROUP("GCore\\srcs" FILES ${gdal_gcore_SRCS})
SOURCE_GROUP("GCore\\headers" FILES ${gdal_gcore_HDRS})

#==============================================================================#
#Finally, add the sources here
#==============================================================================#
SET(gdal_srcs ${gdal_srcs} ${gdal_gcore_SRCS} ${gdal_gcore_HDRS})         