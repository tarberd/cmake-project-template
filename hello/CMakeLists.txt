add_executable(hello_app main.cpp)

target_link_libraries(hello_app hello)

include(GNUInstallDirs)

install(TARGETS hello_app
    DESTINATION ${CMAKE_INSTALL_BINDIR}
)
