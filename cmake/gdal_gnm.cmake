#==============================================================================#
# gnm
#==============================================================================#
SET (gdal_gnm_DIR ${PROJECT_SOURCE_DIR}/gdal/gnm)
FILE ( GLOB_RECURSE gdal_gnm_SRCS ${gdal_gnm_DIR}/*.cpp
                                  ${gdal_gnm_DIR}/*.c
                                  ${gdal_gnm_DIR}/*.h)
INCLUDE_DIRECTORIES(${gdal_gnm_DIR} 
                    ${gdal_gnm_DIR}/gnm_frmts
                    ${gdal_gnm_DIR}/gnm_frmts/db
                    ${gdal_gnm_DIR}/gnm_frmts/file)
FILE ( GLOB gdal_gnm_HDRS ${gdal_gnm_DIR}/*.h)  
