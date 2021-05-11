# REQUIREMENTS
# Set-ExecutionPolicy Unrestricted

Function Test-CommandExists
{
	 Param ($command)
	 $oldPreference = $ErrorActionPreference
	 $ErrorActionPreference = 'stop'
	 try {if(Get-Command $command){RETURN $true}}
	 Catch {RETURN $false}
	 Finally {$ErrorActionPreference=$oldPreference}
} 


#INSTALL CHOCOLATELY
IF(Test-CommandExists choco){
	Write-Host "Chocolately is already installed"
}
ELSE{
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	choco feature enable -n allowGlobalConfirmation
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}



#INSTALL WSL2
IF(Test-CommandExists wsl -l -v) {
	Write-Host "WSL2 Engine is already installed"
}
ELSE{
	dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
	dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
	Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -Outfile "wsl_update_x64.msi"
	.\wsl_update_x64.msi /quiet
	rm .\wsl_update_x64.msi
	wsl --set-default-version 2
}

#INSTALL DOCKER-DESKTOP
IF(Test-CommandExists docker --version ) {
	Write-Host "Docker-Desktop is already installed"
}
ELSE{
	choco install docker-desktop
	choco install docker-cli
	choco install docker-compose
}


#INSTALAR VSCODE
IF(Test-CommandExists code --version ) {
	Write-Host "VSCODE is already installed"

}
ELSE{
	choco install vscode.install
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}


Restart-Computer

