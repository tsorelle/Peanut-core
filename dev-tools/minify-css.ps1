# requires: npm install -g clean-css-cli
# Exec from project root: ./dev-tools/minify.ps1
# Set project root path here:
$rootpath = "D:\dev\twoquakers\peanut2\peanut2.core"
Set-Location -Path "$rootpath\web.root\application\themes\default"
Write-Host "Current dir: $(Get-Location)"
cleancss -o extra.min.css extra.css
Set-Location -Path $rootpath