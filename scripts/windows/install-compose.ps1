$VERSION = '1.29.2'
$SYSTEM = 'Windows'
$ARCH = 'x86_64'
$URL = "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-${SYSTEM}-${ARCH}.exe"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $URL -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe

docker-compose --version
