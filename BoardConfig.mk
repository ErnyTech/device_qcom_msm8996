# config.mk
#
# Product-specific compile-time definitions
#

#Platform
TARGET_BOARD_PLATFORM := msm8996

#Architechture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

#BOOTLOADER
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := msm8996
TARGET_NO_KERNEL := false
BOOTLOADER_GCC_VERSION := arm-eabi-4.8
BOOTLOADER_PLATFORM := msm8996 #use msm8996 LK configuration
TARGET_USES_64_BIT_BINDER := true

#Audio
BOARD_USES_GENERIC_AUDIO := true

#Bluetooth & FM
BOARD_HAVE_QCOM_FM := true
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BLUEZ := false
BOARD_USES_WIPOWER := true
QCOM_BT_USE_SIBS := false
WCNSS_FILTER_USES_SIBS := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/qcom/common

#Camera 
BOARD_QTI_CAMERA_32BIT_ONLY := true
USE_CAMERA_STUB := false
BOARD_USES_QTI_HARDWARE := true

#Display 
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_HWC2 := true
TARGET_USES_GRALLOC1 := true
TARGET_USES_QCOM_DISPLAY_BSP := true
TARGET_USES_COLOR_METADATA := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true
BOARD_EGL_CFG := device/qcom/$(TARGET_BOARD_PLATFORM)/egl.cfg
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
QTI_S3D := true # Enable S3D GPU compostion

#Encryption 
TARGET_HW_DISK_ENCRYPTION := true
TARGET_CRYPTFS_HW_PATH := device/qcom/common/cryptfs_hw

#FileSystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

#GPS
TARGET_NO_RPC := true
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := false

#GPU
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
BOARD_USES_ADRENO := true
HAVE_ADRENO_SOURCE := true
HAVE_ADRENO_SC_SOURCE := true
HAVE_ADRENO_FIRMWARE := true
TARGET_USES_ION := true
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true

#init 
TARGET_INIT_VENDOR_LIB := libinit_msm
TARGET_PLATFORM_DEVICE_BASE := /devices/soc/

#kernel 
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 cma=32M@0-0xffffffff firmware_class.path=/vendor/firmware_mnt/image loop.max_part=7 androidboot.selinux=permissive
BOARD_KERNEL_BASE        := 0x80000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x02000000
BOARD_RAMDISK_OFFSET     := 0x02200000
TARGET_KERNEL_APPEND_DTB := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
TARGET_USES_UNCOMPRESSED_KERNEL := false
TARGET_COMPILE_WITH_MSM_KERNEL := true

#Partitions 
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
TARGET_BOOTIMG_SIGNED := true
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3154116608
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 32212254720
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

ifeq ($(ENABLE_VENDOR_IMAGE), true)
    BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
    BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
    TARGET_COPY_OUT_VENDOR := vendor
    BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
endif

BOARD_SECCOMP_POLICY := device/qcom/$(TARGET_BOARD_PLATFORM)/seccomp
USES_SEC_POLICY_MULTIPLE_DEFAULT_SIGN := 1
USES_SEC_POLICY_INTEGRITY_CHECK := 1

#Dexpreopt 
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif

DEX_PREOPT_DEFAULT := nostripping

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

#healthd 
BOARD_HAL_STATIC_LIBRARIES := libhealthd.msm

#Recovery 
ifeq ($(ENABLE_VENDOR_IMAGE), true)
    TARGET_RECOVERY_FSTAB := device/qcom/msm8996/recovery_non-AB_split_variant.fstab
  else
    TARGET_RECOVERY_FSTAB := device/qcom/msm8996/recovery_non-AB_non-split_variant.fstab
endif

#Wlan
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
ifeq ($(PRODUCT_VENDOR_MOVE_ENABLED),true)
      WIFI_DRIVER_MODULE_PATH := "/$(TARGET_COPY_OUT_VENDOR)/lib/modules/wlan.ko"
else
      WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wlan.ko"
endif
WIFI_DRIVER_MODULE_NAME := "wlan"
WIFI_DRIVER_MODULE_ARG := ""
WIFI_DRIVER_BUILT := qca_cld2 qca_cld3
WIFI_DRIVER_DEFAULT := qca_cld2
WIFI_FST_DRIVER_MODULE_PATH := "/system/lib/modules/wil6210.ko"
WIFI_FST_DRIVER_MODULE_NAME := "wil6210"
WIFI_FST_DRIVER_MODULE_ARG := ""
WPA_SUPPLICANT_VERSION := VER_0_8_X
HOSTAPD_VERSION := VER_0_8_X
CONFIG_ACS := true
CONFIG_IEEE80211AC := true
BOARD_HAS_CFG80211_KERNEL3_4 := true
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)


ifneq ($(TARGET_USES_AOSP),true)
TARGET_USES_QCOM_BSP := true
endif

#Enable Peripheral Manager
TARGET_PER_MGR_ENABLED := true

#Enable early mount support for mmc/ufs
EARLY_MOUNT_SUPPORT := true

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := false

#Add support for firmare upgrade on 8996
HAVE_SYNAPTICS_DSX_FW_UPGRADE := true

#Enable DRM plugins 64 bit compilation
TARGET_ENABLE_MEDIADRM_64 := true

-include device/qcom/msm8996/BoardConfigVendor.mk
