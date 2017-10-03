# SDSC "python" roll

## Overview

This roll bundles Python 2.7.x and 3.x for side-by-side installation with the
system Python and default Rocks Python.

For more information about Python please visit the official web page:

- <a href="http://www.python.org" target="_blank">Python</a> is a programming language that lets you work more quickly and integrate your systems more effectively.

Along with Python itself, the roll installs these python modules:

- <a href="https://pypi.python.org/pypi/Cython">Cython</a>
- <a href="https://pypi.python.org/pypi/dateutils">dateutils</a>
- <a href="https://pypi.python.org/pypi/nose">nose</a>
- <a href="https://pypi.python.org/pypi/numpy">numpy</a>
- <a href="https://pypi.python.org/pypi/pip">pip</a>
- <a href="https://pypi.python.org/pypi/pyparsing">pyparsing</a>
- <a href="https://pypi.python.org/pypi/pytz">pytz</a>
- <a href="https://pypi.python.org/pypi/setuptools">setuptools</a>
- <a href="https://pypi.python.org/pypi/six">six</a>
- <a href="https://pypi.python.org/pypi/mock">mock</a>
- <a href="https://pypi.python.org/pypi/pbr">pbr</a>


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

The build process requires the MKL libraries and assumes that the mkl
modulefile provided by the SDSC intel-roll is available.  It will
build without the modulefile as long as the environment variables it provides
are otherwise defined.


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

This roll source supports building with different compilers.
The `ROLLCOMPILER` make variable can be used to
specify the names of compiler modulefiles to use for building the
software, e.g.,

```shell
% make ROLLCOMPILER=intel 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable.  The default value is "gnu".



## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll python
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the python-roll.  To avoid cluttering the cluster frontend with unused
software, the python-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the python-roll to your distro

```shell
% rocks run roll python host=NAME | bash
```

## Testing

The python-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/python.t 
```
