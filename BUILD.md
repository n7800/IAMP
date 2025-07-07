# Build Instructions

## 1. Software Requirements

InstallAware for Windows Installer is built using Delphi, which makes it
difficult, if not impossible, to open source - due to the large number of
third party components which are closed source, not to mention Delphi itself
of course.

InstallAware Multi Platform has been built from the ground up in Lazarus,
the latter of which is an open source IDE built using the open source
Free Pascal compiler; which presents the possibility to open source the entire
InstallAware Multi Platform stack.

You will need Lazarus, which often contains the Free Pascal compiler, to
build this software. The current state of the distribution does not contain
any non-Pascal code, which would have required additional environments to build.

InstallAware currently uses the following Lazarus/Free Pascal versions to build
this source code. While this forms a recommendation, you may find that you are
able to transcend the suggestions below, either by changing this source code,
or by adding support for new platforms where Lazarus/Free Pascal are available
(such as Amiga).

### macOS: Lazarus 3.4 Paired With Free Pascal 3.2.2

We recommend you install this combination using [FPCUPDELUXE](https://github.com/LongDirtyAnimAlf/fpcupdeluxe/releases).

You will also need to install Xcode Command Line Tools on macOS.
Xcode itself is not required.

Versions of Xcode Command Line Tools newer than 16.2 are not currently
recommended due to compatibility issues with Lazarus/Free Pascal.

A virtualized macOS environment running macOS 12.x or 13.x is recommended.
There are problems with macOS 14.x and 15.x in supporting Dark Mode on macOS
when Lazarus compiles against the default SDKs included with those versions.

There are additional compatibility problems on Apple Silicon macOS with
the required version of Lazarus, which are resolved through the application of
a patch as described in the build instructions following this section.

### Linux: Various Versions

For aarch64 Linux on GTK2, InstallAware Software uses Lazarus 3.99 paired with
Free Pascal 3.3.1, as installed by FPCUPDELUXE. The build environment runs
Debian 11.3.

For aarch64 Linux on Qt5, InstallAware Software uses Lazarus 2.3.0 paired with
Free Pascal 3.3.1, as installed by FPCUPDELUXE. This build environment runs
Kali 2022.2.

For x86_64 Linux on GTK2, InstallAware Software uses Lazarus 3.99 paired with
Free Pascal 3.3.1, as installed by FPCUPDELUXE. This build environment runs
Mint 20.3 Xfce.

For x86_64 Linux on Qt5, InstallAware Software uses Lazarus 3.6 paired with
Free Pascal 3.2.2, as installed by the operating system application manager.
This build environment runs Manjaro (rolling release).

### Windows: Lazarus 3.99 Paired With Free Pascal 3.3.1

You may install this recommended combination using FPCUPDELUXE.

Please note that InstallAware Software only builds and maintains an
x86 version of InstallAware Multi Platform on Windows.

The scripting environment and the setup engine are already able to deploy to
AMD64 and aarch64 Windows platforms using the x86 build of the software,
through the use of setup commands such as "Set 64 Bit Mode".

You may however build native AMD64 versions of the installer should you
so desire. Please be advised this would lose compatibility with any x86
operating systems for no practical gain from either a performance, or a
functionality standpoint.

Please note that a similar level of compatibility is achievable on
Apple platforms by building the Intel version of this software.

## 2. Preparing Your Build Environment

_InstallAware Multi Platform_ is developed in [Lazarus IDE](https://www.lazarus-ide.org). It can be installed from the official website or via the [FpcUpDeluxe](https://github.com/LongDirtyAnimAlf/fpcupdeluxe/releases), which allows for very flexible installation of different versions on different OS.

Of the third-party IDE packages not included in _Lazarus_, the project only requires the following:
* `miap.lpk`: The custom script editor and file label controls.
* `GreatisRuntimeFusion/FormDes/Source/gfstd.lpk`: The form editor.
* `GreatisRuntimeFusion/ObjInsp/Source/oipkg7.lpk`: The object inspector.
* `GreatisRuntimeFusion/RunFus/Source/rfpkg.lpk`: The merged runtime designers.

## 3. Building InstallAware Multi Platform

The following build scripts perform builds on each supported platform.
You may need to enable executable attributes on the scripts in your project
folder by running the command `chmod 777 *.sh` in your favorite shell before
you are able to run the named build scripts.

### a. pubmacosfpc.sh: macOS Intel

This script assumes you have installed Lazarus and Free Pascal via FPCUPDELUXE
inside the folder `~/fpcupdeluxe/`.

### b. pubmacarm.sh: macOS Apple Silicon

This script assumes you have installed Lazarus and Free Pascal via FPCUPDELUXE
inside the folder `~/fpcupdeluxe/`.

This script additionally deletes the following files to resolve some problems
with capturing file download progress on the Apple Silicon version of
Lazarus/Free Pascal that is used to build InstallAware Multi Platform:
* `~/fpcupdeluxe/fpc/units/aarch64-darwin/openssl/*`
* `~/fpcupdeluxe/fpc/units/aarch64-darwin/fcl-net/*`

This script then replaces these files with their patched versions from:
* `patch/*`

### c. pubwindowsfpc.bat: Windows

This script assumes you have installed Lazarus and Free Pascal via FPCUPDELUXE
inside the folder `C:\fpcupdeluxe\`.

### d. publinuxarm.sh: Linux aarch64 GTK2

This script assumes you have installed Lazarus and Free Pascal via FPCUPDELUXE
inside the folder `~/fpcupdeluxe/`.

### e. publinuxarmqt5.sh: Linux aarch64 Qt5

This script assumes you have installed Lazarus and Free Pascal via FPCUPDELUXE
inside the folder `~/Downloads/fpcupdeluxe/`.

### f. publinuxfpc.sh: Linux x86_64 GTK2

This script assumes you have installed Lazarus and Free Pascal via FPCUPDELUXE
inside the folder `~/fpcupdeluxe/`.

### g. publinuxqt5.sh: Linux x86_64 Qt5

This script assumes you have installed Lazarus and Free Pascal via the
operating system application manager, and Lazarus binaries are in your path.

To first build InstallAware Multi Platform, run the build script matching the
platform you are working on. This will apply any necessary platform specific
patches as described above. You may then load and edit the following projects
inside of the Lazarus IDE:

* `miamp.lpr`:             The InstallAware Multi Platform IDE.
* `miauix.lpr`:            The InstallAware Dialog Editor.
* `miaxbuild.lpr`:         The command line build tool.
* `miaxstub.lpr`:          The InstallAware setup engine.
* `mpax.lpr`:              The Setup Capture tool.
* `trans/mtranslator.lpr`: The localization tool.

The build scripts previously mentioned in this section build some of the above
projects multiple times with different conditional defines, to realize effects
such as building the console (text mode only) setup engine from the same
sources that are used to build the GUI version of the setup engine.

Only on macOS, you must also load `miaxstub.lpr` in the Lazarus IDE, and complete
the following additional steps: Choose <ins>Main Menu > Project > Project Options</ins>.
Choose the top level "**Project Options**" parent displayed in the tree view.
Click the "**Clear Icon**" button. Choose "**OK**", and save your project normally.

Failure to complete the steps above results in the macOS Dock ignoring any
custom icon you associate with your built setups, whereby the Dock displays the
standard icon as seen in the **Project Options** window of the Lazarus IDE instead.
This is despite the correct custom icon being added to the application bundle
on macOS. This additional step is not necessary on Windows or Linux.

Feed the saved project `miaxstub.lpr` once again to the build scripts mentioned
in [3a](#a-pubmacosfpcsh-macos-intel) and [3b](#b-pubmacarmsh-macos-apple-silicon) chapters to complete your changes. This step is required on both
macOS Intel and macOS Apple Silicon.

Once all binaries have been built successfully, the following files start the
process of packaging the installers for InstallAware Multi Platform:

### h. buildmac.sh

Builds the InstallAware Multi Platform setup on macOS (platform agnostic).

### i. buildwin.sh

Builds the InstallAware Multi Platform setup in Windows.

### j. buildlinux.sh

Builds the InstallAware Multi Platform setup on Linux (platform agnostic).

## 4. Excluded Dependencies

This collection of source files does not include the following (non-exhaustive)
list of items that are be required for the build scripts above to succeed:

* 7-Zip: Used to compress/extract files. Typically named `miax.lib`. Available
in multiple platform and architecture specific instances which run natively.

* Self-Extractors: Used to package compressed and web based setups.
Typically named `dependentx` (`.exe`) for the GUI version and dependenty for the
console version. Not required for macOS, which does not make use of any
self-extractor but creates DMG files with Apple native compression instead,
while retaining single file and web build capabilities as on other platforms.

* Setup Project for InstallAware Multi Platform: Used to package the product
itself.

* Creative Assets: Setup themes, sample projects, template installations, etc.

* Code Signing Certificates: macOS Notarization and Windows Authenticode.

The Quick Start Wizard in the IDE will successfully create a fully fleshed out
setup project for you, even in the absence of (the sources of) the above
materials.

Please be advised that this document does not grant you any usage rights
over any and all material that you do not already have rights over, which rights
may all be reserved.

# Extending InstallAware Multi Platform

A good place to start is by implementing the stubbed "Check Process" command
in `mScriptExec.pas`.

Once you have implemented this command, you may explore adding new commands
to the IDE and setup engine by editing `uGui.pas` and `mScriptExec.pas`.

Native script commands to query/add/remove PKG/DEB/RPM packages on Mac/Linux
would make valuable additions to the language - especially if native
(un)installation progress can be captured live, and any error conditions
handled interactively (whilst not sacrificing silent installation capability).

If you are interested in adding plug-in support to the Multi Platform IDE and
setup engines, the current Windows-only plug-in specification is already public
on the main InstallAware for Windows Installer website and embedded
documentation.

The InstallAware Multi Platform IDE still lacks docking functionality, and the
corresponding IDE Layouts feature - although it is currently possible to perform
rudimentary docking of the current Project Manager and (Variable) Watches
windows.

While the About boxes of the IDE (`uAbout.*`) and the Dialog Editor (`About.*`)
are rendered translucently on macOS (`uMacGlass.pas`), Glass/Aero/Acrylic/Mica
support is not impemented on Windows (or macOS); and could be formally
implemented as a component corresponding to the VistaGlass component on
InstallAware for Windows Installer.

The Setup Capture tool would benefit from platform-specific, snap-shot free
methods to interrogate changes being made to a live system, just like
InstallAware for Windows Installer which can perform direct captures.

Direct importers for PKG/DEB/RPM packages - converting them into script code -
would provide upstream entry points into the InstallAware environment.

On platforms which support containers, built-in script commands which spawn
new instances, and direct all subsequent script commands to directly operate
on those instances, would facilitate efficient container orchestration.

While InstallAware Multi Platform can directy import projects from
InstallAware for Windows Installer, it cannot yet export its projects into
InstallAware for Windows Installer downstream.

The visual designer of the InstallAware Multi Platform IDE lacks views for
Application Runtimes, and multi-platform specific commands like Create Link;
both of which would make excellent starting points to extend the graphical IDE.

Just as InstallAware for Windows Installer directly exports its projects into a
variety of package formats such as MSIX, APPX, App-V, etc. - downstream support
in InstallAware Multi Platform to generate package formats such as PGK/DEB/RPM,
as well as vendor-specific Application Store exports (along with integrated
submissions), is achievable by "flattening" the conditionally executing script.

InstallAware for Windows Installer features a programmatic Automation Interface
which emits entire setup scripts and projects from your Win32 applications.
While non-trivial, a multi-platform counterpart to this functionality would
empower server and programmatic integrations for InstallAware Multi Platform.

Although planned, cross-platform builds were never actually implemented for
InstallAware Multi Platform. Building from any platform for any platform would
be convenient and trivial, considering that the build stack already accommodates
for this possibility; once the challenges of non-platform-native code signing
and notarization have been addressed. There's already several open source
projects which perform Authenticode signing on non-Windows platforms and
macOS Notarization on non-Apple platforms.

Last but not least, the best new features of InstallAware Multi Platform are
going to be those of which we have not even though of yet - that you invent!
