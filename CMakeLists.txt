# Specify the version being used
cmake_minimum_required (VERSION 3.2.2)
set(CMAKE_CXX_STANDARD 11)

# Set the options for this project
project(CitySpecificModel CXX)
set (PROJECT_SOURCE_DECLARATION_DIRECTORY ${PROJECT_SOURCE_DIR}/include)
set (PROJECT_SOURCE_DEFINITION_DIRECTORY ${PROJECT_SOURCE_DIR}/src)
set (MAIN_FILE ${PROJECT_SOURCE_DEFINITION_DIRECTORY}/model.cpp)

# Set options used by CMake
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR})

# Set options used by FindBoost.cmake
SET (BOOST_ROOT "/afs/crc.nd.edu/x86_64_linux/scilib/boost/boost_1_54_0")
#SET (BOOST_ROOT "/usr/local/Cellar/boost/1.60.0_2")
#SET (BOOST_INCLUDEDIR "/usr/local/Cellar/boost/1.60.0_2/include/boost/")
#SET (BOOST_LIBRARYDIR "/usr/local/Cellar/boost/1.60.0_2/lib")

SET (BOOST_MIN_VERSION "1.54.0")
set (Boost_NO_BOOST_CMAKE ON)
FIND_PACKAGE(Boost ${BOOST_MIN_VERSION} REQUIRED)
if (NOT Boost_FOUND)
  message(FATAL_ERROR "Fatal error: Boost (version >= 1.55) required.")
else()
  message(STATUS "Setting up BOOST")
  message(STATUS " Includes - ${Boost_INCLUDE_DIRS}")
  message(STATUS " Library  - ${Boost_LIBRARY_DIRS}")
  include_directories(${Boost_INCLUDE_DIRS})
  link_directories(${Boost_LIBRARY_DIRS})
endif (NOT Boost_FOUND)

# add an executable to the project
add_executable(simulations model.cpp)

# link given libraries
target_link_libraries (simulations ${Boost_LIBRARIES})
