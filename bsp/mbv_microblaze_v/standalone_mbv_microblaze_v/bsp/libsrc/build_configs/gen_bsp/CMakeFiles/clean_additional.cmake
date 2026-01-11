# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "C:\\rustos\\bsp\\mbv_microblaze_v\\standalone_mbv_microblaze_v\\bsp\\include\\sleep.h"
  "C:\\rustos\\bsp\\mbv_microblaze_v\\standalone_mbv_microblaze_v\\bsp\\include\\xiltimer.h"
  "C:\\rustos\\bsp\\mbv_microblaze_v\\standalone_mbv_microblaze_v\\bsp\\include\\xtimer_config.h"
  "C:\\rustos\\bsp\\mbv_microblaze_v\\standalone_mbv_microblaze_v\\bsp\\lib\\libxiltimer.a"
  )
endif()
