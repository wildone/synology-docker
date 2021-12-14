Param(
  [string]$LOG_PATH = ".\logs",
  [string]$LOG_PEFIX = "clean",
  [string]$LOG_SUFFIX = ".log",
  [string]$FUNCTIONS_URI = "https://github.com/aem-design/aemdesign-docker/releases/latest/download/functions.ps1",
  [array]$CLEAN_PATHS = (Get-Content ".\clean-paths.conf")
)

$SKIP_CONFIG = $true
$PARENT_PROJECT_PATH = "."

. ([Scriptblock]::Create((([System.Text.Encoding]::ASCII).getString((Invoke-WebRequest -Uri "${FUNCTIONS_URI}").Content))))

printSubSectionStart "Remove data paths"

Foreach ($REMOVE_PATH in $CLEAN_PATHS) {
  printSectionLine "Removing ${REMOVE_PATH}"
  Remove-Item –path $REMOVE_PATH –recurse -ErrorAction SilentlyContinue
}

