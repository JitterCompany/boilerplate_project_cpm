
# this header will be generated
set(FW_VERSION_FILE "${CMAKE_ARGV3}")

# find firmware version
execute_process(OUTPUT_VARIABLE FIRMWARE_VERSION
    COMMAND git describe --long --tags --dirty --always
    COMMAND tr -d "\n"
    )
file(WRITE "${FW_VERSION_FILE}" "#define FIRMWARE_VERSION \"${FIRMWARE_VERSION}\"\n")
message(STATUS "${EXE_NAME}: Detected firmware version '${FIRMWARE_VERSION}'")

