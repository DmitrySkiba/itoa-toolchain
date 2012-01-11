#!/bin/sh
#
# Copyright (C) 2011 Dmitry Skiba 
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cd `dirname $0`
THIS_PATH=`pwd`

# =========================================================
# Parse and validate arguments.

HELP=no
VERBOSE=no
NDK_ROOT=$ITOA_NDK_ROOT
for opt do
  optarg=`expr "x$opt" : 'x[^=]*=\(.*\)'`
  case "$opt" in
  --help|-h|-\?)
    HELP=yes
    ;;
  --verbose)
    VERBOSE=yes
    ;;
  --root=*)
    NDK_ROOT=$optarg
    ;;
  *)
    echo "Unknown option '$opt', use --help"
    exit 1
  esac
done

if [ $HELP = "yes" ] ; then
    echo "Rebuild the prebuilt binaries for the Itoa NDK toolchain."
    echo ""
    echo "options:"
    echo ""
    echo "  --help      print this message"
    echo "  --root      NDK root (default is $$ITOA_NDK_ROOT)"
    echo ""
    exit 0
fi

if [ -z "$NDK_ROOT" ] ; then
    echo "NDK_ROOT is not set. Either specify it with --root or set ITOA_NDK_ROOT."
    exit 1
fi

# =========================================================
# Set up variables.

# For HOST_TAG, HOST_BUILD_NUM_CPUS.
source $NDK_ROOT/build/detect-host.sh

TOOLCHAIN_NAME=arm-eabi-4.2.1
TOOLCHAIN_SRC=$THIS_PATH/src
TOOLCHAIN_OUT=$THIS_PATH/out

TOOLCHAIN_BUILD=$TOOLCHAIN_OUT/build

TOOLCHAIN_ROOT=$NDK_ROOT/toolchains/$TOOLCHAIN_NAME
TOOLCHAIN_PREFIX=$TOOLCHAIN_ROOT/$HOST_TAG

# We have to make sysroot path differ from NDK_SYSROOT.
NDK_SYSROOT=$NDK_ROOT/platform/arch-arm
TOOLCHAIN_SYSROOT=$TOOLCHAIN_OUT/sysroot

# =========================================================
# Set up logging.

TMPLOG=$TOOLCHAIN_OUT/build.log
rm -rf $TMPLOG


if [ $VERBOSE = yes ] ; then
    run ()
    {
        echo "##### NEW COMMAND"
        echo $@
        $@ 2>&1 | tee $TMPLOG
    }
else
    echo "To follow build long, please use in another terminal: tail -F $TMPLOG"
    run ()
    {
        echo "##### NEW COMMAND" >> $TMPLOG
        echo "$@" >> $TMPLOG
        $@ 1>$TMPLOG 2>&1
    }
fi

# =========================================================
# Prepare out folder.

rm -rf $TOOLCHAIN_OUT &&
mkdir -p $TOOLCHAIN_OUT &&
mkdir -p $TOOLCHAIN_SYSROOT &&
cp -r $NDK_SYSROOT/ $TOOLCHAIN_SYSROOT

if [ $? != 0 ] ; then
    echo "Failed to prepare out folder."
    exit 1
fi

# =========================================================
# Configure the toolchain

echo "Configure: toolchain build"
mkdir -p $TOOLCHAIN_BUILD &&
cd $TOOLCHAIN_BUILD &&
run $TOOLCHAIN_SRC/configure --target=arm-eabi \
    --disable-nls \
    --prefix=$TOOLCHAIN_PREFIX \
    --with-sysroot=$TOOLCHAIN_SYSROOT \

if [ $? != 0 ] ; then
    echo "Error while trying to configure toolchain build. See $TMPLOG"
    exit 1
fi

# =========================================================
# Build the toolchain

echo "Building : toolchain [this can take a long time]."
cd $TOOLCHAIN_BUILD &&
run make -j$HOST_BUILD_NUM_CPUS
if [ $? != 0 ] ; then
    echo "Error while building toolchain. See $TMPLOG"
    exit 1
fi

# =========================================================
# Install the toolchain

echo "Install  : toolchain binaries."
cd $TOOLCHAIN_BUILD &&
run make install
if [ $? != 0 ] ; then
    echo "Error while installing toolchain. See $TMPLOG"
    exit 1
fi

# Don't forget to copy the GPL and LGPL license files.
cp -f $TOOLCHAIN_SRC/COPYING $TOOLCHAIN_SRC/COPYING.LIB $TOOLCHAIN_PREFIX

# Remove some unneeded files.
rm -f $TOOLCHAIN_PREFIX/bin/*-gccbug
rm -rf $TOOLCHAIN_PREFIX/man $TOOLCHAIN_PREFIX/info

# Strip binaries to reduce final package size.
strip $TOOLCHAIN_PREFIX/bin/*
strip $TOOLCHAIN_PREFIX/arm-eabi/bin/*
strip $TOOLCHAIN_PREFIX/libexec/gcc/*/*/cc1
strip $TOOLCHAIN_PREFIX/libexec/gcc/*/*/cc1plus
strip $TOOLCHAIN_PREFIX/libexec/gcc/*/*/collect2

# Copy toolchain configs.
cp -f $THIS_PATH/config.mk $THIS_PATH/setup.mk $TOOLCHAIN_ROOT

# =========================================================
# Done.

echo "Done."
rm -f $TMPLOG

