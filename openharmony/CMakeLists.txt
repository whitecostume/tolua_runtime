cmake_minimum_required(VERSION 3.6)

project(tolua)
add_library(${PROJECT_NAME} STATIC IMPORTED GLOBAL)
set_target_properties(${PROJECT_NAME} PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libluajit.a" )

set(LOCAL_FORCE_STATIC_EXECUTABLEtrue)
project(tolua)
add_library(${PROJECT_NAME} STATIC IMPORTED GLOBAL)
target_include_directories(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/../../luajit-2.1/src)
target_include_directories(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/../../)

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -O2")
target_compile_options(${PROJECT_NAME} INTERFACE -O2 -std=gnu99)
set_target_properties(${PROJECT_NAME} PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/../../tolua.c \" )
 					
target_link_libraries(${PROJECT_NAME} INTERFACE libluajit)
