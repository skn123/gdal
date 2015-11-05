#==============================================================================#
#Apps built using GDal
#==============================================================================#
SET(gdal_apps_DIR ${PROJECT_SOURCE_DIR}/gdal/apps)

#==============================================================================#
#Get a list of all files that are present in the list for testing
#==============================================================================#
FILE(GLOB gdal_apps_SRCS 
          ${gdal_apps_DIR}/*.cpp 
          ${gdal_apps_DIR}/*.h)

REMOVE(gdal_apps_SRCS "${gdal_apps_DIR}/commonutils.h" 
                      "${gdal_apps_DIR}/commonutils.cpp")
#In addition there are some apps that depend on OGRGeneralCmdLineProcessor
#function which is disabled
REMOVE(gdal_apps_SRCS "${gdal_apps_DIR}/test_ogrsf.cpp"
                      "${gdal_apps_DIR}/testepsg.cpp"
                      "${gdal_apps_DIR}/ogrlineref.cpp"
                      "${gdal_apps_DIR}/ogr2ogr.cpp"
                      "${gdal_apps_DIR}/ogrinfo.cpp"
                      "${gdal_apps_DIR}/ogrdissolve.cpp")
                      
FOREACH(fileName ${gdal_apps_SRCS})
  GET_FILENAME_COMPONENT(AppName "${fileName}" NAME_WE)
  ADD_EXECUTABLE(${AppName} ${fileName} ${gdal_apps_DIR}/commonutils.cpp)
  TARGET_LINK_LIBRARIES(${AppName} gdal)
ENDFOREACH()