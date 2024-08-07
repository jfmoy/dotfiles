#!/bin/zsh

# PHP Version Switcher
switch_php_version() {
   local version="$1"

   # Check if version is provided
   if [ -z "$version" ]; then
      echo "Please provide a PHP version (e.g., 7.2)"
      return 1
   fi

   # Unlink current PHP versions
   brew unlink php
   # Link the new PHP version
   brew link --overwrite php@"$version"

   # Remove any existing PHP paths from .zshrc
   sed -i '' '/\/opt\/homebrew\/opt\/php@/d' ~/.zshrc
 
   {{ if eq .chezmoi.arch "arm64" }}
   echo "export PATH=\"/opt/homebrew/opt/php@$version/bin:\$PATH\"" >>~/.zshrc
   echo "export PATH=\"/opt/homebrew/opt/php@$version/sbin:\$PATH\"" >>~/.zshrc
   {{ else }}
   echo "export PATH=\"/usr/local/opt/php@$version/bin:\$PATH\"" >>~/.zshrc
   echo "export PATH=\"/usr/local/opt/php@$version/sbin:\$PATH\"" >>~/.zshrc
   {{ end }}

   # Reload .zshrc to apply changes immediately
   source ~/.zshrc

   echo "Switched to PHP $version"
}
