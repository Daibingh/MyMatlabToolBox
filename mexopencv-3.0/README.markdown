mexopencv
=========
[![Travis](https://img.shields.io/travis/kyamagu/mexopencv.svg)](https://travis-ci.org/kyamagu/mexopencv)
[![AppVeyor](https://img.shields.io/appveyor/ci/kyamagu/mexopencv.svg)](https://ci.appveyor.com/project/kyamagu/mexopencv)
[![License](https://img.shields.io/badge/license-BSD%203--Clause-blue.svg)](LICENSE)

Collection and a development kit of MATLAB MEX functions for OpenCV library

The package provides MATLAB MEX functions that interface a hundred of
OpenCV APIs. Also the package contains C++ class that converts between
MATLAB's native data type and OpenCV data types. The package is suitable for
fast prototyping of OpenCV application in MATLAB, use of OpenCV as an external
toolbox in MATLAB, and development of a custom MEX function.

The latest version of mexopencv (master branch) is compatible with OpenCV 3.x.
For older OpenCV versions, please checkout the corresponding 2.x branches in
([v2.4](https://github.com/kyamagu/mexopencv/tree/v2.4),
[v2.3](https://github.com/kyamagu/mexopencv/tree/v2.3), and
[v2.1](https://github.com/kyamagu/mexopencv/tree/v2.1)).

- [OpenCV](https://github.com/Itseez/opencv)
- [OpenCV extra modules](https://github.com/Itseez/opencv_contrib)

Table of Contents
=================

- [Structure](#structure)
- [Build](#build)
    - [Unix](#unix)
    - [Windows](#windows)
- [Usage](#usage)
    - [Documentation](#documentation)
    - [Unit Testing](#unit-testing)
    - [Gotchas](#gotchas)
- [Developing a new MEX function](#developing-a-new-mex-function)
    - [Testing](#testing)
    - [Documenting](#documenting)
- [License](#license)

Structure
=========

The project tree is organized as follows:

    +cv/             OpenCV or custom API directory
    +mexopencv/      mexopencv utility API directory
    doc/             directory for documentation
    include/         header files
    lib/             directory for compiled C++ library files
    samples/         directory for sample application codes
    src/             directory for C++ source files
    src/+cv/         directory for MEX source files
    src/+cv/private/ directory for private MEX source files
    test/            directory for test scripts and resources
    opencv_contrib/  directory for sources/samples/tests of additional modules
    utils/           directory for utilities
    Doxyfile         config file for doxygen
    Makefile         make script
    README.markdown  this file

Build
=====

Prerequisite:

 * Unix: MATLAB, OpenCV (>= 3.0.0), g++, make, pkg-config
 * Windows: MATLAB, OpenCV (>= 3.0.0), supported compiler

We also have preliminary support for Octave (>= 4.0.0).

Currently, mexopencv targets the final 3.0.0 stable version of OpenCV. You
must built it against this exact version, rather than using the bleeding-edge
dev-version of `opencv` or `opencv_contrib`.

Unix
----

First make sure you have OpenCV installed in the system. If not, install the
package available in your package manager (e.g., `libopencv-dev` in
Debian/Ubuntu, `opencv-devel` in Fedora, `opencv` in Macports), or install the
source package from http://opencv.org/ . Make sure `pkg-config` command can
identify OpenCV path. If you have all the prerequisite, go to the mexopencv
directory and type:

    $ make

This will build and place all MEX functions inside `+cv/`.
Specify your MATLAB directory if you install MATLAB other than
`/usr/local/matlab`,

    $ make MATLABDIR=/Applications/MATLAB_R2012a.app

Optionally you can test the library functionality.

    $ make test

Developer documentation can be generated with Doxygen if installed.

    $ make doc

This will create HTML and LaTeX files under `doc/`.

### Troubleshooting: Invalid MEX file or Segmentation fault

If MATLAB says 'Library not loaded' or any other error in the test, it's
likely a compatibility issue between a system library and MATLAB's internal
library. You might be able to fix this issue by *preloading* the library file.
On Linux, set the correct library path in `LD_PRELOAD` environmental variable.
For example, if you see `GLIBCXX_3.4.15` error in MEX, use the following to
start MATLAB.

    $ LD_PRELOAD=/usr/lib/libstdc++.so.6 matlab

Note that you need to find the correct path to the shared object. For example,
`/usr/lib64/` instead of `/usr/lib/`. You can use `locate` command to find the
location of the shared libraries. On Mac OS X, this environment variable is
named `DYLD_INSERT_LIBRARIES`.

To find what library is conflicting, use `ldd` command both in the Unix shell
and within MATLAB to one of the compiled MEX-files. For example,

    $ ldd +cv/imread.mexa64    # within UNIX shell

    >> !ldd +cv/imread.mexa64  % within MATLAB

If the output of the `ldd` command gives you different line, that library is
likely to be causing the conflict. Try to preload such a library before
launching MATLAB. On Mac, you can use `otool -L` command instead.

Windows
-------

Refer to [this wiki page](https://github.com/kyamagu/mexopencv/wiki) for
detailed instructions on how to compile OpenCV 3.0 with `opencv_contrib`
modules on Windows.

### 1) Configure a C/C++ compiler for MEX-files in MATLAB

To build mexopencv MEX-files, you need a standard-compliant C++ compiler
supported by MATLAB. For an up-to-date list of supported compilers for
different versions of MATLAB, see
[this page](http://www.mathworks.com/support/sysreq/previous_releases.html).

At the time of writing, Visual Studio 2010 is the recommended version to build
mexopencv on Windows platforms. If you are building for a 64-bit target, you
have two options:
- use Visual Studio Professional edition (make sure "X64 Compilers and Tools"
  component is chosen during installation)
- use Visual C++ Express edition along with latest Windows SDK, both available
  to download for free.

To select a compiler configuration in MATLAB, type the following command, and
follow the instructions (this should be done only once):

    >> mex -setup

### 2) Install OpenCV library

1. Download the latest pre-built OpenCV binaries from
   http://opencv.org/downloads.html
2. Extract/unpack the archive into a destination of your choosing.
   For example `C:\OpenCV`
3. Add the `bin` folder containing the DLL files to the system PATH
   environment variable.
   You should choose the correct binaries depending on your platform
   and compiler. Example `C:\OpenCV\build\x86\vc10\bin`. Be careful that the
   architecture (x86 or x64) should match your MATLAB architecture but not
   your OS. Also VC version (vc10 or vc11) should match the MEX setup (and
   probably MATLAB's internal runtime). For example, if you're running MATLAB
   32-bit in Windows 7 64-bit with Visual Studio 2010 Express, you should use
   x86 and vc10. You might need to reboot for changes to take effect.

Alternatively, you can build OpenCV from the sources. Follow
[this tutorial](http://docs.opencv.org/doc/tutorials/introduction/windows_install/windows_install.html#cpptutwindowsmakeown)
in the OpenCV documentation for detailed instructions. Just make sure to
organize the output in the same directory layout described before, with a
structure similar to:

    OpenCV
    |
    +- build
        |-- $ARCH (x86, x64)
        |    |-- $COMPILER (vc10, vc11, vc12, ..)
        |          |-- bin
        |          |    |-- opencv_core300.dll
        |          |    |-- opencv_core300d.dll
        |          |    +-- ...
        |          +-- lib
        |               |-- opencv_core300.lib
        |               |-- opencv_core300d.lib
        |               +-- ...
        +-- include
             |-- opencv
             |    |-- cv.h
             |    +-- ...
             +-- opencv2
                  |-- opencv.hpp
                  +-- ...

### 3) Build mexopencv

Once you satisfy the above requirements, you can proceed to build all MEX
functions. Browse to mexopencv root folder, and type the following in the
MATLAB command window (you need to specify the path where OpenCV library is
installed):

    >> mexopencv.make('opencv_path', 'C:\OpenCV\build')

Note that if you build OpenCV from source, this path specification might not
work out of the box. Follow the directory layout described above to arrange
the OpenCV .DLL and .LIB files to correctly compile and link your MEX-files
with the library.

To remove existing mexopencv binaries, use the following command.

    >> mexopencv.make('clean', true)

### Troubleshooting: Invalid MEX-file or Segmentation fault

Check the following common issues first:

- Make sure the system PATH is set up correctly. This is different from
  `addpath()` in MATLAB. You must have the correct DLL files visible in the
  system path, depending on the MATLAB architecture and the compiler.
- A supported MEX compiler is setup correctly, In Windows 64-bit environment,
  Windows SDK compiler is needed for Visual C++ Express editions. Note that if
  you change the compiler configuration, you should clean any previously
  compiled MEX-files `mexopencv.make('clean',true)` and build again from
  scratch.

If you still see the "Invalid MEX-file" error messages, and you are using
OpenCV DLL's manually built from sources, check that a consistent value
of `_SECURE_SCL` flag was used during compilation. The current version
of `mexopencv.make` script explicitly adds `_SECURE_SCL=1` flag in the
build command for Visual Studio compilers older than 2010,
so that the built MEX-files are compatible with the OpenCV binary
distribution. If you manually built OpenCV with different `_SECURE_SCL` flag,
edit `mexopencv.make` file and change the flag to use a consistent value.

When unspecified, the default value of the
[`_SECURE_SCL` flag](http://msdn.microsoft.com/en-us/library/aa985896.aspx)
depend on the version of the Visual Studio compiler, and whether building is
in "Debug" or "Release" mode:

- VS2010 and newer: In debug mode, the default value for `_SECURE_SCL` is 1.
  In release mode, the default value for `_SECURE_SCL` is 0.
- VS2008 and older: The default value for `_SECURE_SCL` is 1.

Alternatively, you can change the default value for the `_SECURE_SCL` flag in
`mex` command.
To change the default configuration, which is created with the `mex -setup`
command in MATLAB, is located in the following path in recent versions of
Windows.

    C:\Users\(Username)\AppData\Roaming\MathWorks\MATLAB\(version)\mexopts.bat

Open this file and edit `/D_SECURE_SCL` option. Note that this is usually only
necessary for VS2008 and older.

If you see "Invalid MEX-file" error even when having matched the `_SECURE_SCL`
flag, it probably indicates some other compatibility issues. Please file a bug
report at https://github.com/kyamagu/mexopencv .
Specify your OS and compiler, MATLAB and OpenCV versions, along with any error
messages and/or crash reports.

### Troubleshooting: Visual Studio 2008 compatibility issue

Some users reported incompatibility with Visual Studio 2008. The current
recommended version to build mexopencv is VS2010. For this reason, mexopencv
on Windows platform does not work with MATLAB R2009b or earlier.

Nevertheless, if you want to try using Visual Studio 2008, obtain `stdint.h`
and use `mexopencv.make` to compile the package. Visual Studio 2008 or earlier
does not comply with C99 standard and lacks `stdint.h` header file. Luckily,
the header file is available on the Web. For example,
http://msinttypes.googlecode.com/svn/trunk/stdint.h

Place this file under `include` directory in the mexopencv package.

Usage
=====

Once MEX functions are compiled, you can add path to the project directory and
call MEX functions within MATLAB using package name `cv`.

``` matlab
addpath('/path/to/mexopencv');
result = cv.filter2D(img, kern);  % with package name 'cv'

import cv.*;
result = filter2D(img, kern);     % no need to specify 'cv' after imported
```

Note that some functions such as `cv.imread` overload MATLAB's built-in
function when imported. Use the scoped name when you need to avoid name
collision. It is also possible to import individual functions. Check
`help import` in MATLAB.

Check a list of functions available by `help` command in MATLAB.

    >> help cv; % shows list of functions in package 'cv'

    Contents of cv:

    GaussianBlur       - Smoothes an image using a Gaussian filter
    Laplacian          - Calculates the Laplacian of an image
    VideoCapture       - VideoCapture wrapper class
    ...

    >> help cv.VideoCapture; % shows documentation of VideoCapture

    VIDEOCAPTURE  VideoCapture wrapper class

     Class for video capturing from video files or cameras. The class
     provides MATLAB API for capturing video from cameras or for reading
     video files. Here is how the class can be used:
    ...

Look at the `samples/` directory for examples.

Documentation
-------------

mexopencv includes a simple documentation utility that generates HTML help
files for MATLAB. The following command creates a user documentation under
`doc/matlab/` directory.

``` matlab
addpath('utils');
MDoc;
```

On-line documentation is available at http://kyamagu.github.io/mexopencv/ .

Unit Testing
------------

You can test the functionality of compiled files by `UnitTest` class located
inside `test` directory.

``` matlab
addpath('test');
UnitTest;
```

Look at the `test/unit_tests/` directory for all unit-tests.

Gotchas
-------

- OpenCV uses 0-based indexing while MATLAB uses 1-based indexing. That is,
the top left pixel is (0,0) in OpenCV whereas MATLAB treats it as (1,1).
mexopencv does NOT convert image coordinates. Be careful when accessing a
function that deals with image coordinates.

- OpenCV often uses channels as dimensions of coordinate representation, as
seen in `cv.perspectiveTransform`. In MATLAB, you can make these channeled
array by creating 1xNxd or Nx1xd array for an N-element array of d-dimensional
vectors. Hint: use `permute` or `shiftdim` functions to convert from/to
Nxd numeric array in MATLAB.

Developing a new MEX function
=============================

All you need to do is to add your C++ source file in `src/+cv/`. If you want
to add a MEX function called `myfunc`, create `src/+cv/myfunc.cpp`.
The minimum contents of the `myfunc.cpp` would look like this:

``` cpp
#include "mexopencv.hpp"
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    // Check arguments
    nargchk (nlhs<=1 && nrhs==1);

    // Convert MxArray to cv::Mat
    cv::Mat mat = MxArray(prhs[0]).toMat();

    // Do whatever you want

    // Convert cv::Mat back to mxArray*
    plhs[0] = MxArray(mat);
}
```

This example simply copies an input to `cv::Mat` object and then copies again
to the output. Notice how the `MxArray` class provided by mexopencv converts
`mxArray` to `cv::Mat` object. Of course you would want to do something more
with the object. Once you create a file, type `mexopencv.make()` to build your
new function. The compiled MEX function will be located inside `+cv/` and
accessible through `cv.myfunc` within MATLAB.

The `mexopencv.hpp` header includes a class `MxArray` to manipulate
`mxArray` objects. Mostly this class is used to convert between OpenCV data
types and `mxArray`.

``` cpp
int i            = MxArray(prhs[0]).toInt();
double d         = MxArray(prhs[0]).toDouble();
bool b           = MxArray(prhs[0]).toBool();
std::string s    = MxArray(prhs[0]).toString();
cv::Mat mat      = MxArray(prhs[0]).toMat();   // For pixels
cv::Mat ndmat    = MxArray(prhs[0]).toMatND(); // For N-D array
cv::Point pt     = MxArray(prhs[0]).toPoint();
cv::Size siz     = MxArray(prhs[0]).toSize();
cv::Rect rct     = MxArray(prhs[0]).toRect();
cv::Scalar sc    = MxArray(prhs[0]).toScalar();
cv::SparseMat sp = MxArray(prhs[0]).toSparseMat(); // Only double to float

plhs[0] = MxArray(i);
plhs[0] = MxArray(d);
plhs[0] = MxArray(b);
plhs[0] = MxArray(s);
plhs[0] = MxArray(mat);
plhs[0] = MxArray(ndmat);
plhs[0] = MxArray(pt);
plhs[0] = MxArray(siz);
plhs[0] = MxArray(rct);
plhs[0] = MxArray(sc);
plhs[0] = MxArray(sp); // Only 2D float to double
```

Check `MxArray.hpp` for the complete list of the conversion API.

If you rather want to develop a MATLAB class that internally calls a MEX
function, make use of the `+cv/private/` directory. Any function placed under
private directory is only accessible from `+cv/` directory. So, for example,
when you want to design a MATLAB class that wraps the various behavior of the
MEX function, define your class at `+cv/MyClass.m` and develop a MEX function
dedicated for that class in `src/+cv/private/MyClass_.cpp`. Inside of
`+cv/MyClass.m`, you can call `MyClass_()` without the `cv` namespace.
In mexopencv, this is usually used to exposed C++ classes as MATLAB classes.

Testing
-------

You can optionally add a testing script for your new function. The testing
convention in mexopencv is that testing scripts are all written as a static
function in a MATLAB class. For example, `test/unit_tests/TestFilter2D.m` is
a class that describes test cases for `cv::filter2d` function. Inside of the
class, a couple of test cases are written as static functions whose name start
with 'test'.

If there is such a class inside `test/unit_tests/`, typing `make test` would
invoke all test cases and show your result. Use `test/` directory to place any
resource files necessary for testing. An example of testing class is shown
below:

``` matlab
classdef TestMyFunc
    methods (Static)
        function test_1
            src = imread(fullfile(mexopencv.root(),'test','img001.jpg'));
            ref = [1,2,3];                  % reference output
            dst = cv.myfunc(src);           % execute your function
            assert(isequal(dst, ref));      % check the output
        end

        function test_error_1
            try
                cv.myfunc('foo');           % myfunc should throw an error
                error('UnitTest:Fail','myfunc incorrectly returned');
            catch e
                assert(strcmp(e.identifier,'mexopencv:error'));
            end
        end
    end
end
```

In Windows, add the `test` directory to the MATLAB path and invoke `UnitTest`
to run all the test routines.

Documenting
-----------

You can create a MATLAB help documentation for a MEX function by having the
same file with '.m' extension. For example, a help file for `filter2D.mex*`
would be `filter2D.m`. The help file should only contain MATLAB comments. An
example is shown below:

``` matlab
%MYFUNC  brief description about myfunc
%
%    out = cv.myfunc(in)
%
% ## Input
% * __in__ input image.
%
% ## Output
% * __out__ output image.
%
% Detailed description of function continues...
%
```

License
=======

The code may be redistributed under the BSD 3-Clause license.
