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


## Configuration

The Nominal Core custom device for NI VeriStand® is intended to be configured as a single stream, but multiple instances of the custom device may be used with different channels and parameters.

### Instantiating the Custom Device
In your system definition navigate to custom devices under the appropriate target, right click, and select Nominal >> Nominal Core Streaming.
<img width="426" height="167" alt="image" src="https://github.com/user-attachments/assets/e6f68551-267d-41b9-8bbd-bee8f24f2762" />

On the CD Configuration tab you can rename the custom device instance and add a description.

### Configuring a Nominal Core Connection
After selecting the custom device, navigate to the `Nominal Configuration` tab -- if you have not entered an API key it should be selected by default. Then, fill in the following values:

 * If you are using a custom instance, edit `Nominal Base URL` from the default (https://api.gov.nominal.io/api/) to your api endpoint
 * Enter a `Nominal API key`
 * Pick an `Identifier Selection` mode
   * If selecting `Asset Identifier and Dataset Name` you will need the `Asset RID` from nominal core as well as a dataset name (ie `Default`) -- the code will take the display name or the refname of an existing dataset or create a new one with the name selected
   * If selecting `Dataset Identifier` you just need a `Dataset RID` from nominal core
 * Optional, but recommended: adjust `Channel buffer size` according to your primary control loop rate and latency needs

#### Getting your API Key
This key can be generated as described in the [nominal SDK documentation](https://docs.nominal.io/core/sdk/python-client/authentication#generating-an-api-key). Keep this key secret.

#### Getting your Asset ID
Navigate to your asset in Nominal Core. If you don't already have one, [first create an asset](https://docs.nominal.io/core/documentation/platform/data/creating-an-asset#create-an-asset). 

Then, copy the RID from this asset.

<img width="617" height="210" alt="image" src="https://github.com/user-attachments/assets/1325f1df-2457-45ec-8ea5-5aeabba8dc32" />

It should look like `ri.scout.cerulean-staging.asset.<GUID>`. This key is just an identifier, not a secret.

#### Getting your Dataset Name
The code will automatically construct a dataset with the specified name if not found and attach that dataset to your asset. 

If you wish to use a specific dataset, navigate to the asset you selected above and then navigate to the Data Sources tab. Locate the dataset you wish to use and pick its name:

<img width="1020" height="149" alt="image" src="https://github.com/user-attachments/assets/2983506f-78a6-461b-96e2-484a68d5246d" />

For ease of use, the code will accept either the displayed names ("Dataset for NI VeriStand" and "default2") or the refnames ("default" or "default2"). If more direct control is required, use the Dataset RID method.


#### Getting your Dataset RID
A dataset can be created by [first creating an asset](https://docs.nominal.io/core/documentation/platform/data/creating-an-asset#create-an-asset) and then by [creating and/or associating a dataset](https://docs.nominal.io/core/documentation/platform/data/creating-an-asset#add-a-data-source) with the asset. 

Once done you can obtain the RID from Nominal Core:
<img width="1015" height="304" alt="image" src="https://github.com/user-attachments/assets/77426668-7269-42f2-b238-dee9e1e31411" />

It should look like `ri.catalog.cerulean-staging.dataset.<GUID>`. This key is just an identifier, not a secret.

### Configuring Channels to Log
After selecting the custom device, navigate to the `Channel Configuration` -- if you have entered an API key it should be selected by default.

Select `Add Channels`, pick the channels you want to log, and select `OK`:
<img width="676" height="654" alt="image" src="https://github.com/user-attachments/assets/b3236ece-aa9f-4abd-b67a-8f0d6260b179" />

### Configuring Time
Every channel will be logged with a single timestamp which is bundled by the NI VeriStand® engine with the selected data. Because this data will always be a double-precision floating point, there are two processing options for handling the time value. 

First, map an appropriate time source to the `Time source` channel under the custom device.
<img width="846" height="639" alt="image" src="https://github.com/user-attachments/assets/879bfab2-bd71-43e3-9c11-a8261d01d355" />

The time source will determine which processing option to use. To change the processing option, navigate to the `Time source` channel under the custom device and select the mode from the drop down.

At present the following modes are supported:
 * `To Timestamp` will directly call the LabVIEW `To Time Stamp` primitive on the mapped data and use that timestamp directly. Because this is a floating point value, resolution may be lost when using this mode. This is intended to be used with the system channel `Absolute Time`.
 * `Relative Seconds` will treat the time channel as an offset from T0. At present T0 is determined internal to the custom device based on when the engine tells the custom device to begin execution. Then the custom device will calculate `data timestamp = T0 + time channel (relative)`. For most test runs, this mode will provide better resolution but the uncontrolled T0 may result in a fixed offset between the recorded and absolute time. This is intended to be used with the system channel `System Time - Microseconds` or equivalent.

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
