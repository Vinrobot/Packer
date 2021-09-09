$TempDirectory = "C:\TEMP"

New-Item -ItemType Directory -Force -Path $TempDirectory

[Environment]::SetEnvironmentVariable("TEMP", $TempDirectory, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("TMP", $TempDirectory, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("TEMP", $TempDirectory, [EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("TMP", $TempDirectory, [EnvironmentVariableTarget]::User)
