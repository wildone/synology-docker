Param(
  [string]$FUNCTIONS_URI = "https://github.com/aem-design/aemdesign-docker/releases/latest/download/functions.ps1",
  [string]$SERVICES = "$( (Get-Content ".\start-services.conf") -join " -f ")",
  [string]$PORT = "5080"
)

$SKIP_CONFIG = $true
$PARENT_PROJECT_PATH = ".."

. ([Scriptblock]::Create((([System.Text.Encoding]::ASCII).getString((Invoke-WebRequest -Uri "${FUNCTIONS_URI}").Content))))


# get env config
$CONFIG_ENV = (Get-Content ".env" -Raw | ConvertFrom-StringData)
$PORT=$CONFIG_ENV.TRAEFIK_HTTP_PORT

$DOCKER_COMMAND="docker-compose --env-file .env -f docker-compose.yml -f ${SERVICES} up"

$OPEN_COMMAND="explorer http://localhost:${PORT}"

printSubSectionStart "Open Console at http://localhost:${PORT}"

Invoke-Expression "${OPEN_COMMAND}"


printSubSectionStart "Docker Compose Execute"

printSectionLine "${DOCKER_COMMAND}"

Invoke-Expression "${DOCKER_COMMAND}"


