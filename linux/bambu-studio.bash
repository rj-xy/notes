# /bin/bash
# source /home/rj/bambu-studio.bash
export BAMBU_STUDIO_GH_API_URL="https://api.github.com/repos/bambulab/BambuStudio"

function bambu_studio_get_releases() {
  #  Have to use a file - getting error (too long) with `echo "$BAMBU_STUDIO_CACHE_RELEASES" | jq` 
  local tmp_filepath="/tmp/bambu-studio-releases.json"

  if [[ -z "$BAMBU_STUDIO_CACHE_RELEASES" || "$BAMBU_STUDIO_CACHE_RELEASES" != "done" ]]; then
    local url="$BAMBU_STUDIO_GH_API_URL/releases"
    >&2 echo "🟠 Getting releases from $url"
    local result=$(curl -s -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" -o $tmp_filepath $url)

    last_exit_code=$?
    if [ $last_exit_code -ne 0 ]; then
      rm -f $tmp_filepath
      echo "🔴 Error: Failed to get releases, exit code: $last_exit_code"
      exit $last_exit_code
    fi

    export BAMBU_STUDIO_CACHE_RELEASES="done"
  fi

  jq < $tmp_filepath
  return 0
}
export -f bambu_studio_get_releases

function bambu_studio_get_latest_release() {
  local releases=$(bambu_studio_get_releases)
  # sort by `id` DESC then pick first one
  local latest_release=$(echo "$releases" | jq 'sort_by(.id) | reverse | .[0]')
  echo "$latest_release" | jq
}
export -f bambu_studio_get_latest_release

function bambu_studio_get_latest_release_assets() {
  local latest_release=$(bambu_studio_get_latest_release)
  local release_tag_name=$(echo "$latest_release" | jq -r '.tag_name')
  >&2 echo "🟠 Latest release tag name: $release_tag_name"
  local assets=$(echo "$latest_release" | jq '.assets')
  echo "$assets" | jq
}
export -f bambu_studio_get_latest_release_assets

function bambu_studio_get_latest_release_asset_ubuntu_24() {
  local assets=$(bambu_studio_get_latest_release_assets)
  # filter JSON array by `.name` contains `ubuntu`
  local ubuntu_assets=$(echo "$assets" | jq 'map(select(.name | contains ("ubuntu-24")))')
  echo "$ubuntu_assets" | jq
}
export -f bambu_studio_get_latest_release_asset_ubuntu_24

function bambu_studio_get_latest_release_asset_ubuntu_24_url() {
  if [[ -z $BAMBU_STUDIO_CACHE_URL || "$BAMBU_STUDIO_CACHE_URL" == "" ]]; then
    local ubuntu_24_asset=$(bambu_studio_get_latest_release_asset_ubuntu_24)
    local url=$(echo "$ubuntu_24_asset" | jq '.[] | .browser_download_url')
    # remove quotes
    url=$(echo "$url" | sed 's/"//g')
    >&2 echo "🟠 Latest release asset Ubuntu 24 URL: $url"
    BAMBU_STUDIO_CACHE_URL="$url"
  fi

  echo $BAMBU_STUDIO_CACHE_URL
}
export -f bambu_studio_get_latest_release_asset_ubuntu_24_url

function bambu_studio_get_latest_release_asset_ubuntu_24_filename() {
  local url=$(bambu_studio_get_latest_release_asset_ubuntu_24_url)
  local filename=$(echo $url | sed -E 's/.*(Bambu.*)$/\1/')
  >&2 echo "🟠 Latest release asset Ubuntu 24 filename: $filename"
  echo $filename
}
export -f bambu_studio_get_latest_release_asset_ubuntu_24_filename

function bambu_download_latest_release_asset_ubuntu_24() {
  local url=$(bambu_studio_get_latest_release_asset_ubuntu_24_url)
  echo "======"
  if [[ -z "$url" || "$url" == "" ]]; then
    echo "🔴 Error: No URL found"
    return 1
  fi
  echo "🟢 Downloading: $url"
  # take after /Bambu_Studio....
  # e.g. https://github.com/bambulab/BambuStudio/releases/download/v02.03.00.70/Bambu_Studio_ubuntu-24.04_PR-8184.AppImage
  local filename=$(bambu_studio_get_latest_release_asset_ubuntu_24_filename)
  echo "🟢 Filename: $filename"
  local filepath="$HOME/.local/bin/$filename"
  echo "🟢 Saving to: $filepath"

  if [ -f "$filepath" ]; then
    echo "🟡 File already exists: $filepath"
    return 0 
  fi

  echo "⚡ curl --progress-bar -L -o \"$filepath\" \"$url\""
  curl --progress-bar -L -o "$filepath" "$url"
  last_exit_code=$?
  if [ $last_exit_code -ne 0 ]; then
    echo "🔴 Error: Failed to download: $url, exit code: $last_exit_code"
    return $last_exit_code
  fi
  echo "🟢 Downloaded: $filepath"
  return 0
}
export -f bambu_download_latest_release_asset_ubuntu_24

function bambu_studio_install_app_image() {
  local filename=$(bambu_studio_get_latest_release_asset_ubuntu_24_filename)
  local filepath="$HOME/.local/bin/$filename"
  echo "🟢 Installing: $filepath"
  chmod +x "$filepath"

# Override existing or create new file
cat > $HOME/.local/share/applications/bambu-studio.desktop <<- EOM
[Desktop Entry]
Name=Bambu Studio
Exec=$filepath
Icon=bambu-studio
Type=Application
Categories=Development;
EOM

  echo "🟢 Installed: $HOME/.local/share/applications/bambu-studio.desktop"
  return 0
}
export -f bambu_studio_install_app_image

function bambu_studio_uninstall() {
  rm -rf "$HOME/.local/bin/Bambu_Studio_*"
  echo "🟢 Uninstalled: $HOME/.local/bin/Bambu_Studio_*"
  rm -f "$HOME/.local/share/applications/bambu-studio.desktop"
  echo "🟢 Uninstalled: $HOME/.local/share/applications/bambu-studio.desktop"
  rm -rf "$HOME/.cache/bambu-studio"
  echo "🟢 Uninstalled: $HOME/.cache/bambu-studio"
  rm -rf "$HOME/.config/BambuStudio"
  echo "🟢 Uninstalled: $HOME/.config/BambuStudio"
  rm -rf "$HOME/.local/share/bambu-studio"
  echo "🟢 Uninstalled: $HOME/.local/share/bambu-studio"
  return 0
}
export -f bambu_studio_uninstall
