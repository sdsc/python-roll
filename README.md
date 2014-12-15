# SDSC "python" roll

## Overview

This roll bundles Python 2.7.x and 3.x for side-by-side installation with the
system Python and default Rocks Python.

For more information about Python please visit the official web page:

- <a href="http://www.python.org" target="_blank">Python</a> is a programming language that lets you work more quickly and integrate your systems more effectively.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate python source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.


## Building

To build the python-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `python-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll python
% cd /export/rocks/install
% rocks create distro
% rocks run roll python | bash
```

In addition to the software itself, the roll installs python environment
module files in:

```shell
/opt/modulefiles/applications/python
```


## Testing

The python-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/python.t 
```
