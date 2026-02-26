#!/bin/bash
set -e

APP_NAME="neutralino-sample"
DIST_DIR="dist"

# 不要なLinuxバイナリを削除
rm -f bin/neutralino-linux_* bin/neutralino-mac_universal

# Neutralinoビルド
neu build --embed-resources

# macOS .app バンドル作成関数
create_mac_bundle() {
  local arch=$1
  local bundle="${DIST_DIR}/${APP_NAME}-mac_${arch}.app"
  rm -rf "${bundle}"
  mkdir -p "${bundle}/Contents/MacOS"
  mkdir -p "${bundle}/Contents/Resources"

  cp "${DIST_DIR}/${APP_NAME}/${APP_NAME}-mac_${arch}" "${bundle}/Contents/MacOS/${APP_NAME}"
  chmod +x "${bundle}/Contents/MacOS/${APP_NAME}"
  xattr -cr "${bundle}"
  codesign --sign - --force "${bundle}/Contents/MacOS/${APP_NAME}"

  cat > "${bundle}/Contents/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>neutralino-sample</string>
    <key>CFBundleIdentifier</key>
    <string>js.neutralino.sample</string>
    <key>CFBundleName</key>
    <string>neutralino-sample</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.13.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF
}

create_mac_bundle "arm64"
create_mac_bundle "x64"

# Windows exe をdist直下にコピー
cp "${DIST_DIR}/${APP_NAME}/${APP_NAME}-win_x64.exe" "${DIST_DIR}/"

# neu buildの中間生成物を削除
rm -rf "${DIST_DIR}/${APP_NAME}"

echo "ビルド完了:"
echo "  macOS (ARM): ${DIST_DIR}/${APP_NAME}-mac_arm64.app"
echo "  macOS (x64): ${DIST_DIR}/${APP_NAME}-mac_x64.app"
echo "  Windows:     ${DIST_DIR}/${APP_NAME}-win_x64.exe"
