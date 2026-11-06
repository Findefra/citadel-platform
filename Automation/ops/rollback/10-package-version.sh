#!/usr/bin/env bash
# 10-package-version.sh
# Rollback a package to an exact previous version (yum/dnf/apt)
# Usage: ./10-package-version.sh <package> <exact-version>

set -euo pipefail

PACKAGE=${1:?Package name required}
VERSION=${2:?Exact version required}

echo "=== Package Version Rollback ==="
echo "Package : $PACKAGE"
echo "Version : $VERSION"
echo

if command -v dnf &>/dev/null; then
  dnf install -y "${PACKAGE}-${VERSION}"
elif command -v yum &>/dev/null; then
  yum install -y "${PACKAGE}-${VERSION}"
elif command -v apt-get &>/dev/null; then
  apt-get install -y "${PACKAGE}=${VERSION}"
else
  echo "ERROR: No supported package manager found (dnf/yum/apt)"
  exit 1
fi

echo "Package rolled back."
