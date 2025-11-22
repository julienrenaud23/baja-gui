# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appdashbee_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appdashbee_autogen.dir\\ParseCache.txt"
  "appdashbee_autogen"
  )
endif()
