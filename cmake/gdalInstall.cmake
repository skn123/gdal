#============================================================================#
# Configure files with settings for use by the build.
#============================================================================#
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/Usegdal.cmake.in
               ${CMAKE_INSTALL_PREFIX}/cmake/Usegdal.cmake COPYONLY IMMEDIATE)
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/gdalConfig.cmake.in
               ${CMAKE_INSTALL_PREFIX}/cmake/gdalConfig.cmake COPYONLY IMMEDIATE)

#============================================================================#
# Location for building all libraries
#============================================================================#               
SET(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib CACHE PATH "Single output directory for building all libraries." FORCE)

#============================================================================#
#Here we install the exported libraries in a specified folder
#============================================================================#
INSTALL( TARGETS gdal
         ARCHIVE DESTINATION lib
         RUNTIME DESTINATION bin
)

#============================================================================#
#Here we install the relevant header files
#============================================================================#
INSTALL(FILES 
        ${gdal_gcore_HDRS} 
        ${gdal_port_HDRS} 
        ${gdal_alg_HDRS} 
        ${gdal_ogr_HDRS}
        ${INSTALL_HEADERS}
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include)