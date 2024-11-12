cmake_minimum_required(VERSION 3.6)

project(tolua)

# 导入 libluajit 静态库
add_library(libluajit STATIC IMPORTED GLOBAL)
set_target_properties(libluajit PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libluajit.a" )

set(LOCAL_FORCE_STATIC_EXECUTABLE true)

set(src_files ../tolua.c
            ../int64.c
            ../uint64.c
            ../pb.c
            ../lpeg.c
            ../struct.c
            ../cjson/strbuf.c
            ../cjson/lua_cjson.c
            ../cjson/fpconv.c
            ../luasocket/auxiliar.c
            ../luasocket/buffer.c
            ../luasocket/except.c
            ../luasocket/inet.c
            ../luasocket/io.c
            ../luasocket/luasocket.c
            ../luasocket/mime.c
            ../luasocket/options.c
            ../luasocket/select.c
            ../luasocket/tcp.c
            ../luasocket/timeout.c
            ../luasocket/udp.c
            ../luasocket/usocket.c
             )

add_library(${PROJECT_NAME} SHARED ${src_files})	


target_include_directories(${PROJECT_NAME} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/../luajit-2.1/src)
target_include_directories(${PROJECT_NAME} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/../)

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -O2")
target_compile_options(${PROJECT_NAME} INTERFACE -O2 -std=gnu99)

target_link_libraries(${PROJECT_NAME} INTERFACE libluajit)
