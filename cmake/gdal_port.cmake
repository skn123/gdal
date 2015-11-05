#==============================================================================#
# gdal_cpl (Common Portability Library) 
# Here, we assume that zlib will be built, natively by GDal
#==============================================================================#
SET (gdal_port_DIR ${PROJECT_SOURCE_DIR}/gdal/port)
ADD_DEFINITIONS(-DCPL_OPTIONAL_APIS -DHAVE_LIBZ)

FILE(GLOB gdal_port_SRCS ${gdal_port_DIR}/*.cpp
                         ${gdal_port_DIR}/*.c)
FILE(GLOB gdal_port_HDRS ${gdal_port_DIR}/*.h)

#Remove files that are not relevant here
IF(NOT UNIX)
  REMOVE(gdal_port_SRCS "${gdal_port_DIR}/cpl_vsil_unix_stdio_64.cpp")
  REMOVE(gdal_port_SRCS "${gdal_port_DIR}/vsipreload.cpp")
ELSEIF(NOT WIN32)
  REMOVE(gdal_port_SRCS "${gdal_port_DIR}/cpl_vsil_win32.cpp")
ENDIF()

#==============================================================================#
# Remove some files
#==============================================================================#
REMOVE(gdal_port_HDRS "${gdal_port_DIR}/cpl_win32ce_api.h"
                      "${gdal_port_DIR}/cpl_wince.h"
                      "${gdal_port_DIR}/cpl_odbc.h")
                      
REMOVE(gdal_port_SRCS "${gdal_port_DIR}/xmlreformat.cpp" 
                      "${gdal_port_DIR}/cpl_win32ce_api.cpp"
                      "${gdal_port_DIR}/cpl_odbc.cpp"
                      "${gdal_port_DIR}/cpl_vsil_simple.cpp"
                      "${gdal_port_DIR}/cpl_recode_iconv.cpp")

#==============================================================================#
#Set the include directories here
#==============================================================================#
INCLUDE_DIRECTORIES(${gdal_port_DIR})
SOURCE_GROUP("Port\\srcs" FILES ${gdal_port_SRCS})
SOURCE_GROUP("Port\\headers" FILES ${gdal_port_HDRS})

#==============================================================================#
#Finally, add the sources here
#==============================================================================#
SET(gdal_srcs ${gdal_srcs} ${gdal_port_SRCS} ${gdal_port_HDRS})
