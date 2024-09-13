#!/usr/bin/env bash
#
# Builds the beta Bitwarden iOS app, and outputs an IPA file that can be uploaded to TestFlight.
#
# Usage:
#
#   $ ./build.sh

set -euo pipefail

bold=$(tput -T ansi bold)
normal=$(tput -T ansi sgr0)

BUILD_DIR="build"

ARCHIVE_PATH="${BUILD_DIR}/Bitwarden.xcarchive"
EXPORT_PATH="${BUILD_DIR}/Bitwarden"

echo "🧱 Building in $(pwd)"
echo ""

echo "🌱 Generating xcode project"
mint run xcodegen

mkdir -p "${BUILD_DIR}"

echo "🔨 Performing Xcode archive"
xcrun xcodebuild archive \
  CODE_CODE_SIGN_IDENTITY="iPhone Developer" \
  CODE_CODE_SIGNING_REQUIRED=NO \
  -project Bitwarden.xcodeproj \
  -scheme Bitwarden \
  -configuration Release \
  -archivePath "${ARCHIVE_PATH}" \
  | xcbeautify --renderer github-actions
#echo ""
#  CODE_CODE_SIGN_IDENTITY="iPhone Developer" \
#  CODE_CODE_SIGNING_REQUIRED=NO \
#  -project Bitwarden.xcodeproj \
#  -scheme Bitwarden \
#  -configuration Release \
#  -archivePath "${ARCHIVE_PATH}" \
#  | xcbeautify --renderer github-actions
#echo ""

ls -lah "${ARCHIVE_PATH}"

BW_APP_PATH="${ARCHIVE_PATH}/Products/Applications/Bitwarden.app"

# ldid fakesign the binaries because xcode is ass!
ldid -SBitwarden/Application/Support/Bitwarden.entitlements "${BW_APP_PATH}/Bitwarden"

ldid -SBitwardenActionExtension/Application/Support/BitwardenActionExtension.entitlements "${BW_APP_PATH}/PlugIns/BitwardenActionExtension.appex/BitwardenActionExtension"

ldid -SBitwardenAutoFillExtension/Application/Support/BitwardenAutoFill.entitlements "${BW_APP_PATH}/PlugIns/BitwardenAutoFillExtension.appex/BitwardenAutoFillExtension"

ldid -SBitwardenShareExtension/Application/Support/BitwardenShareExtension.entitlements "${BW_APP_PATH}/PlugIns/BitwardenShareExtension.appex/BitwardenShareExtension"

zip -vr "meow.zip" "${ARCHIVE_PATH}"

mkdir -p "${EXPORT_PATH}"
cp meow.zip build/Bitwarden/Bitwarden.ipa

#  -exportOptionsPlist "Configs/export_options.plist" \
echo "📦 Performing Xcode archive export"
xcrun xcodebuild -exportArchive \
  CODE_CODE_SIGN_IDENTITY="" \
  CODE_CODE_SIGNING_REQUIRED=NO \
  -archivePath "${ARCHIVE_PATH}" \
  -exportPath "${EXPORT_PATH}" \
  -exportOptionsPlist meow.plist \
  | xcbeautify --renderer github-actions || true # bleh !

echo "🎉 Build complete"
