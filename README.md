# ni-veristand-custom-device-nominal-core
A custom device for NI VeriStand® which supports streaming to Nominal Core


## Developer Dependencies
Uses the async template which requires the below:
- https://github.com/ni/niveristand-custom-device-development-tools/releases/tag/v25.0.0
- https://github.com/ni/niveristand-custom-device-wizard/releases

However it does not depend on https://github.com/nominal-io/labview-client. It instead directly accesses dlls which must be deployed to any targets.

## Install
Extract content to:
`C:\Users\Public\Documents\National Instruments\NI VeriStand <Version>\Custom Devices`
The current release only supports Version:=2026.

If you installed correctly you should be able to locate this file: 
`C:\Users\Public\Documents\National Instruments\NI VeriStand <Version>\Custom Devices\Nominal Core Streaming\Custom Device Nominal Core Streaming.xml`

## Runtime Deployment
For Windows targets, no runtime install is necessary past the base NI VeriStand® install.

For NI® Linux® Real-Time targets, users are required to manually install packages to their targets. This can be automated by building a package for NI SystemLink™ or through shell scripting. The correct procedure for manually installing to the target is:

1. Copy `C:\Users\Public\Documents\National Instruments\NI VeriStand 2026\Custom Devices\Nominal Core Streaming\Linux_x64\lib_nominal-streaming-lv_64.so` and `C:\Users\Public\Documents\National Instruments\NI VeriStand 2026\Custom Devices\Nominal Core Streaming\Linux_x64\libnominalClient_64.so` to `/usr/local/lib`. Be sure to change the NI VeriStand® version directory.
2. As `admin`, run `ldconfig`

The script below will perform these steps (save as a powershell script titled `deploy-nominal-so.ps1`)
```ps
# Deploys the Nominal Core Streaming .so files to a Linux target and refreshes the linker cache.
# Usage: .\deploy-nominal-so.ps1              (uses default IP below)
#        .\deploy-nominal-so.ps1 192.168.1.50 (override IP)

param(
    [string]$TargetIp = "192.168.1.100",
    [string]$User      = "admin"
)

$ErrorActionPreference = "Stop"

$SrcDir = "C:\Users\Public\Documents\National Instruments\NI VeriStand 2026\Custom Devices\Nominal Core Streaming\Linux_x64"
$Remote = "${User}@${TargetIp}"

# 1. Copy the .so files straight into /usr/local/lib (admin has write access).
Write-Host "Copying *.so to ${Remote}:/usr/local/lib ..."
scp "${SrcDir}\*.so" "${Remote}:/usr/local/lib/"

# 2. Refresh the linker cache as root.
Write-Host "Running ldconfig ..."
ssh $Remote "sudo ldconfig"

Write-Host "Done."
```


## Licensing and Trademark Information
The registered trademark Linux® belongs to Linus Torvalds

For more information about NI® Linux® Real-Time, refer to NI® [documentation](https://www.ni.com/en/shop/linux/introduction-to-ni-linux-real-time.html)

NI® (National Instruments®), NI VeriStand®, and NI SystemLink® are registered trademarks of NI®. All other trademarks are the property of their respective owners. For more information, refer to NI [documentation](https://www.ni.com/en/shop/electronic-test-instrumentation/application-software-for-electronic-test-and-instrumentation-category/systemlink.html)


The LICENSE file in this directory contains information about included code in this repository and the associated licenses. The identified dependencies have the following copyrights:
Copyright (c) 2026 Nominal, Inc.
Copyright (c) 2018, National Instruments Corp.
Copyright LabVIEW open source project, specifically:
-Patrick Irvin (@ciozi137)
-Francois Normandin (@francois-normandin)
-James Powell (@drjdpowell)
Contributors to https://github.com/LabVIEW-Open-Source/Epoch-Time
