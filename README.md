# ni-veristand-custom-device-nominal-core
A custom device for NI VeriStand which supports streaming to Nominal Core


## Developer Dependencies
Uses the async template which requires the below:
- https://github.com/ni/niveristand-custom-device-development-tools/releases/tag/v25.0.0
- https://github.com/ni/niveristand-custom-device-wizard/releases

However it does not depend on https://github.com/nominal-io/labview-client. It instead directly accesses dlls which must be deployed to any targets.