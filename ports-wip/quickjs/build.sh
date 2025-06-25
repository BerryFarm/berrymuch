#!/usr/bin/env bash

# QuickJS port for BlackBerry 10 / QNX
# Uses pre-compiled GCC 9 optimized binaries from sw7ft
# Avoids GCC 4.6.3 limitations in berrymuch toolchain

set -e
source ../../lib.sh

DISTVER="quickjs-qnx8-arm-deploy"
DISTSUFFIX="tar.gz"
TASK=fetch

# Use sw7ft's pre-compiled GCC 9 optimized package from GitHub Releases
DISTFILES="https://github.com/sw7ft/qnx-packages/releases/download/v1.0/QuickJS_QNX8_ARM_Deploy.tar.gz"
# Fallback to berrystore during transition:
# DISTFILES="https://berrystore.sw7ft.com/QuickJS_QNX8_ARM_Deploy.tar.gz"
UNPACKCOMD="tar -xzf"

package_init "$@"

# Override package_build - no compilation needed, just repackage
package_build() {
    if [ "$TASK" == "build" ]
    then
        echo "Using pre-compiled QuickJS binaries (GCC 9 optimized)..."
        cd "$WORKROOT"
        
        # Extract sw7ft package
        if [ ! -d "quickjs_qnx8_deploy" ]; then
            echo "Error: quickjs_qnx8_deploy directory not found"
            exit 1
        fi
        
        echo "Repackaging for berrymuch compatibility..."
        TASK=install
    fi
}

# Override package_install to use existing directory structure
package_install() {
    if [ "$TASK" == "install" ]
    then
        echo "Installing pre-compiled QuickJS to $DESTDIR"
        cd "$WORKROOT/quickjs_qnx8_deploy"
        
        # Install binaries
        mkdir -p "$DESTDIR/$PREFIX/bin"
        cp -r bin/* "$DESTDIR/$PREFIX/bin/"
        
        # Install libraries  
        mkdir -p "$DESTDIR/$PREFIX/lib"
        cp -r lib/* "$DESTDIR/$PREFIX/lib/"
        
        # Install headers
        mkdir -p "$DESTDIR/$PREFIX/include"
        cp -r include/* "$DESTDIR/$PREFIX/include/"
        
        # Install documentation
        mkdir -p "$DESTDIR/$PREFIX/share/doc/quickjs"
        cp README.md DEPLOY.md "$DESTDIR/$PREFIX/share/doc/quickjs/" 2>/dev/null || true
        
        TASK=bundle
    fi
}

package_fetch
# Skip package_patch - no patches needed for pre-compiled binaries
package_build  
package_install
package_bundle 