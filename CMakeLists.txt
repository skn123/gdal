#==============================================================================#
#CMakeLists file for building GDal
#==============================================================================#
PROJECT(GDal)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12)
SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
SET(CMAKE_COLOR_MAKEFILE ON)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
LIST(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

#Set the version of GDal being built
set(VERSION_MAJOR 2)
set(VERSION_MINOR 0)
set(VERSION_PATCH 0)
set(VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH})

#Include the config files
INCLUDE(GdalConfig)
#We enable the following libraries
SET(NonModularLibrary_OpenCL ON CACHE BOOL "Use OpenCL Libraries")
SET(ENABLE_HDF5 ON)
SET(NonModularLibrary_hdf5 ON CACHE BOOL "Use hdf5 Libraries")
ADD_DEFINITIONS(-DHAVE_OPENCL -DCL_USE_DEPRECATED_OPENCL_1_1_APIS)
#Set the libraries that we want to interface it with: OpenCL and hdf5
FIND_PACKAGE(ThirdPartyLibraries_VS2015 REQUIRED)

#And set a variable to hold the libraries against with gDal will be linked against
SET(EXT_LIBS ${NONMODULAR_LIBRARY_LIST} ${MODULAR_LIBRARY_LIST})
IF(WIN32)
  IF (NOT ONCE_SET_CMAKE_INSTALL_PREFIX)
    SET(ONCE_SET_CMAKE_INSTALL_PREFIX true CACHE BOOL
        "Have we set the install prefix yet?" FORCE)
    SET(CMAKE_INSTALL_PREFIX /usr/local CACHE PATH
        "Install path prefix, prepended onto install directories" FORCE)
  ENDIF()
  
  ADD_DEFINITIONS(-D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_DEPRECATE 
                  -D_CRT_SECURE_NO_WARNINGS  -D_SCL_SECURE_NO_DEPRECATE
                  -D_SCL_SECURE_NO_WARNINGS -DGDAL_COMPILATION)
  IF(MSVC)
    ADD_DEFINITIONS(-D_WIN32 -DWIN32_LEAN_AND_MEAN)
    ADD_DEFINITIONS("/wd4267 /wd4244 /wd4251 /wd4018 /wd4800 /wd4293 /wd4805 /wd4305 /wd4005 /wd4273")
    LIST(APPEND EXT_LIBS "ws2_32.lib")
  ENDIF()

ENDIF()

#==============================================================================#
#Here we list all folders that contain relevant GDal files
#==============================================================================#
SET(GDAL_Components 
    port
    ogr
    alg
	  gcore
    gnm
	  frmts
)

#==============================================================================#
#Global variables
#==============================================================================#
SET(gdal_srcs)
INCLUDE_DIRECTORIES(${PROJECT_BINARY_DIR}/port)

#==============================================================================#
#Include all files and/or build relevant libraries here
#==============================================================================#
FOREACH (COMPONENTS ${GDAL_Components})
  INCLUDE(${PROJECT_SOURCE_DIR}/cmake/gdal_${COMPONENTS}.cmake)
ENDFOREACH()

ADD_LIBRARY(gdal SHARED 
            ${gdal_srcs} 
            ${PROJECT_SOURCE_DIR}/gdal/frmts/gdalallregister.cpp)
TARGET_LINK_LIBRARIES(gdal ${EXT_LIBS})
SET_TARGET_PROPERTIES(gdal PROPERTIES DEBUG_POSTFIX "_d")

#==============================================================================#
#Check if we are building unit tests
#==============================================================================#
OPTION(ENABLE_APPS "Build GDal Apps" OFF)
IF (ENABLE_APPS)
  INCLUDE(${PROJECT_SOURCE_DIR}/cmake/gdal_apps.cmake)
ENDIF()

#==============================================================================#
#Include relevant instructions for installing GDal
#==============================================================================#
INCLUDE(${PROJECT_SOURCE_DIR}/cmake/gdalInstall.cmake)
