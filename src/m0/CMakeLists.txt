cmake_minimum_required(VERSION 3.5.0 FATAL_ERROR)

set(CMAKE_TOOLCHAIN_FILE
    ${TOPLEVEL_SRC_DIR}/cmake/toolchain-gcc-arm-embedded.cmake)
project(m0)

#------------------------------------------------------------------------------
# Target Specifig Build Settings
#------------------------------------------------------------------------------

# target specific
set(EXE_NAME                ${PROJECT_NAME})
set(FLASH_ADDR              0x1B000000)
set(DEBUG_BREAKPOINT_LIMIT  2)
set(DEBUG_WATCHPOINT_LIMIT  1)

set(MCU_PLATFORM            43xx_m0)

set(TARGET_C_FLAGS  "-DCORE_M0 -mcpu=cortex-m0 -DLPC43XX_CORE_M0APP \
    -DUSB_DEVICE_ONLY -D__LPC43XX__")
set(TARGET_L_FLAGS  "-mcpu=cortex-m0")

#------------------------------------------------------------------------------
# Common Settings & CPM Modules
#------------------------------------------------------------------------------

include(${TOPLEVEL_SRC_DIR}/cmake/common_settings.cmake)


#------------------------------------------------------------------------------
# Target Specific CPM Modules
#------------------------------------------------------------------------------

CPM_AddModule("43xx_m0_startup"
    GIT_REPOSITORY "https://github.com/JitterCompany/43xx_m0_startup.git"
    GIT_TAG "1.0")

CPM_AddModule("lpc_chip_43xx_m0"
    GIT_REPOSITORY "https://github.com/JitterCompany/lpc_chip_43xx_m0.git"
    GIT_TAG "1.0")

CPM_Finish()


#------------------------------------------------------------------------------
# Build Setup & Targets
#------------------------------------------------------------------------------

include_directories("${CMAKE_SOURCE_DIR}/src/m0")

file(GLOB SPECIFIC_SOURCES 
"${CMAKE_SOURCE_DIR}/src/m0/*.c"
"${CMAKE_SOURCE_DIR}/src/m0/*/*.c"
)
list(APPEND SOURCES ${SPECIFIC_SOURCES})

include(${CMAKE_SOURCE_DIR}/cmake/common_build.cmake)

