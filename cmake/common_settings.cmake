#------------------------------------------------------------------------------
# CPM init
#------------------------------------------------------------------------------
#
# Required variables:
#
# TOPLEVEL_SRC_DIR
# TOPLEVEL_BIN_DIR

set(CMAKE_SOURCE_DIR ${TOPLEVEL_SRC_DIR})
include(${CMAKE_SOURCE_DIR}/cmake/CPM_setup.cmake)


#------------------------------------------------------------------------------
# Detect Board Specific Settings
#------------------------------------------------------------------------------

# find board config
#include(${CMAKE_SOURCE_DIR}/board_config.cmake)

#if("${BOARD}" STREQUAL "BOARD_NAME")
#    set(BOARD_CFG_FILE "board_[board_name]_config.c")
#else()
#    message(FATAL_ERROR "${EXE_NAME}: board '${BOARD}' not recognised: \
#    \n Set a valid option in board_config.cmake")
#endif()
#
#list(APPEND SOURCES "${CMAKE_SOURCE_DIR}/src/board_config/${BOARD_CFG_FILE}")
#message(STATUS "${EXE_NAME}: Detected board config '${BOARD}'")
#add_definitions("-D${BOARD}")

# find debug setting
#if("${DEBUG}" STREQUAL "DEBUG_ENABLED")
#    add_definitions(-DDEBUG_ENABLED)
#endif()


#------------------------------------------------------------------------------
# Common Config
#------------------------------------------------------------------------------

set(FLASH_CFG               lpc4337_swd)

# optimize level
set(OPT 0)

# system libraries to link, separated by ';'
set(SYSTEM_LIBRARIES m c gcc)

# compile flags
set(C_FLAGS_WARN "-Wall -Wextra -Wno-unused-parameter                   \
    -Wshadow -Wpointer-arith -Winit-self -Wstrict-overflow=5")

set(C_FLAGS "${C_FLAGS_WARN} -O${OPT} -g3 -c -fmessage-length=80        \
    -fno-builtin -ffunction-sections -fdata-sections -std=gnu99 -mthumb \
    -fdiagnostics-color=auto")

# linker flags
set(L_FLAGS "${TARGET_L_FLAGS} -fmessage-length=80 -nostdlib -specs=nano.specs \
    -mthumb -Wl,--gc-sections")

set(ALL_C_FLAGS "${TARGET_C_FLAGS} ${C_FLAGS} ${C_FLAGS_WARN}")
message(STATUS "C flags: '${ALL_C_FLAGS}")
message(STATUS "L flags: '${L_FLAGS}")
#------------------------------------------------------------------------------
# Common Variables & definitions
#------------------------------------------------------------------------------

set(ELF_PATH            "${CMAKE_CURRENT_BINARY_DIR}/${EXE_NAME}")
set(EXE_PATH            "${ELF_PATH}.bin")
set(FLASH_FILE          ${TOPLEVEL_BIN_DIR}/flash.cfg)

add_definitions("${TARGET_C_FLAGS} ${C_FLAGS} ${C_FLAGS_WARN}")

#------------------------------------------------------------------------------
# Common CPM Modules
#------------------------------------------------------------------------------

CPM_AddModule("openocd_tools"
    GIT_REPOSITORY "https://github.com/JitterCompany/openocd_tools.git"
    GIT_TAG "1.2")

CPM_AddModule("c_utils"
    GIT_REPOSITORY "https://github.com/JitterCompany/c_utils.git"
    GIT_TAG "1.0")

