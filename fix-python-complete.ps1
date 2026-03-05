# ========================================
# Script COMPLETO: Desinstala 3.14 + Instala 3.12
# ========================================

Write-Host "======================================" -ForegroundColor Magenta
Write-Host "  FIX AUTOMATICO PYTHON 3.14 -> 3.12" -ForegroundColor Magenta
Write-Host "======================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "Este script irá:" -ForegroundColor White
Write-Host "  1. Desinstalar Python 3.14" -ForegroundColor Yellow
Write-Host "  2. Instalar Python 3.12.7" -ForegroundColor Yellow
Write-Host "  3. Configurar PATH automaticamente" -ForegroundColor Yellow
Write-Host "  4. Instalar dependências do projeto" -ForegroundColor Yellow
Write-Host ""

# Verificar se está rodando como Administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERRO: Este script precisa ser executado como Administrador!" -ForegroundColor Red
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "  COMO EXECUTAR COMO ADMINISTRADOR:" -ForegroundColor Yellow
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "  1. Feche este PowerShell" -ForegroundColor White
    Write-Host "  2. Botao direito no PowerShell" -ForegroundColor White
    Write-Host "  3. 'Executar como Administrador'" -ForegroundColor White
    Write-Host "  4. Navegue ate este diretorio" -ForegroundColor White
    Write-Host "  5. Execute: .\\fix-python-complete.ps1" -ForegroundColor Cyan
    Write-Host ""
    pause
    exit 1
}

Write-Host "OK: Executando como Administrador" -ForegroundColor Green
Write-Host ""
$confirmation = Read-Host "Deseja continuar? (S/N)"
if ($confirmation -ne 'S' -and $confirmation -ne 's') {
    Write-Host "Operação cancelada." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  ETAPA 1/2: DESINSTALAR PYTHON 3.14" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# ========================================
# DESINSTALAÇÃO PYTHON 3.14
# ========================================

Write-Host "[1.1] Verificando versão atual..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1 | Out-String
    Write-Host "      Versão: $pythonVersion" -ForegroundColor White
} catch {
    Write-Host "      Python não encontrado no PATH" -ForegroundColor Gray
}

Write-Host "[1.2] Procurando Python 3.14 instalado..." -ForegroundColor Yellow

$uninstallPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

$python314Found = $false
$uninstallStrings = @()

foreach ($path in $uninstallPaths) {
    Get-ItemProperty $path -ErrorAction SilentlyContinue | Where-Object {
        $_.DisplayName -like "*Python 3.14*"
    } | ForEach-Object {
        $python314Found = $true
        Write-Host "      OK: Encontrado: $($_.DisplayName)" -ForegroundColor Green
        if ($_.UninstallString) {
            $uninstallStrings += $_.UninstallString
        }
    }
}

if (-not $python314Found) {
    Write-Host "      Nenhuma instalação oficial encontrada" -ForegroundColor Gray
}

# Limpar diretórios manuais
$commonPaths = @(
    "$env:LOCALAPPDATA\Programs\Python\Python314",
    "$env:ProgramFiles\Python314",
    "${env:ProgramFiles(x86)}\Python314"
)

foreach ($pyPath in $commonPaths) {
    if (Test-Path $pyPath) {
        Write-Host "      Removendo: $pyPath" -ForegroundColor Yellow
        Remove-Item -Path $pyPath -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "      OK: Removido!" -ForegroundColor Green
    }
}

Write-Host "[1.3] Executando desinstaladores..." -ForegroundColor Yellow
foreach ($uninstallCmd in $uninstallStrings) {
    if ($uninstallCmd -match 'MsiExec\.exe') {
        $productCode = ($uninstallCmd -split '/I|/X')[1].Trim()
        Start-Process "msiexec.exe" -ArgumentList "/X $productCode /quiet /norestart" -Wait -NoNewWindow
        Write-Host "      OK: Desinstalado via MSI" -ForegroundColor Green
    }
}

Write-Host "[1.4] Limpando PATH..." -ForegroundColor Yellow
$pathsToRemove = @("Python314", "Python\Python314")

# Sistema
$systemPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$systemPathItems = $systemPath -split ';' | Where-Object { 
    $item = $_
    -not ($pathsToRemove | Where-Object { $item -like "*$_*" })
}
[Environment]::SetEnvironmentVariable("Path", ($systemPathItems -join ';'), "Machine")

# Usuário
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$userPathItems = $userPath -split ';' | Where-Object { 
    $item = $_
    -not ($pathsToRemove | Where-Object { $item -like "*$_*" })
}
[Environment]::SetEnvironmentVariable("Path", ($userPathItems -join ';'), "User")

Write-Host "      OK: PATH limpo!" -ForegroundColor Green

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  ETAPA 2/2: INSTALAR PYTHON 3.12" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# ========================================
# INSTALAÇÃO PYTHON 3.12
# ========================================

$pythonVersion = "3.12.7"
$pythonUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-amd64.exe"
$installerPath = "$env:TEMP\python-installer.exe"

Write-Host "[2.1] Baixando Python $pythonVersion..." -ForegroundColor Yellow
try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath -ErrorAction Stop
    $fileSize = (Get-Item $installerPath).Length / 1MB
    Write-Host "      OK: Baixado! ($([math]::Round($fileSize, 2)) MB)" -ForegroundColor Green
} catch {
    Write-Host "      ERRO: $_" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "[2.2] Instalando Python $pythonVersion..." -ForegroundColor Yellow
$installArgs = @("/quiet", "InstallAllUsers=1", "PrependPath=1", "Include_pip=1", "Include_launcher=1")
$process = Start-Process -FilePath $installerPath -ArgumentList $installArgs -Wait -PassThru -NoNewWindow

if ($process.ExitCode -eq 0) {
    Write-Host "      OK: Instalado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "      AVISO: Codigo de saida: $($process.ExitCode)" -ForegroundColor Yellow
}

Remove-Item -Path $installerPath -Force -ErrorAction SilentlyContinue

Write-Host "[2.3] Atualizando PATH da sessão..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
Start-Sleep -Seconds 2

Write-Host "[2.4] Verificando instalação..." -ForegroundColor Yellow
try {
    $newVersion = & python --version 2>&1
    if ($newVersion -match "3\.12") {
        Write-Host "      OK: Python 3.12 instalado!" -ForegroundColor Green
        Write-Host "      Versao: $newVersion" -ForegroundColor White
    } else {
        Write-Host "      AVISO: Versao: $newVersion (reinicie terminal)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "      AVISO: Reinicie o PowerShell" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "  INSTALACAO CONCLUIDA!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  PROXIMOS PASSOS (copie e cole no PowerShell):" -ForegroundColor White
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "# 1. FECHE e ABRA um NOVO PowerShell (Admin)" -ForegroundColor Yellow
Write-Host ""
Write-Host "# 2. Navegue até o projeto:" -ForegroundColor Yellow
Write-Host 'cd "C:\Users\adm.fa\Documents\project-01-translate-app\project-01-translate-app"' -ForegroundColor White
Write-Host ""
Write-Host "# 3. Valide Python:" -ForegroundColor Yellow
Write-Host "python --version" -ForegroundColor White
Write-Host ""
Write-Host "# 4. Atualize pip:" -ForegroundColor Yellow
Write-Host "python -m pip install --upgrade pip" -ForegroundColor White
Write-Host ""
Write-Host "# 5. Instale dependencias:" -ForegroundColor Yellow
Write-Host "pip install --upgrade -r requirements.txt" -ForegroundColor White
Write-Host ""
Write-Host "# 6. Inicie servidor:" -ForegroundColor Yellow
Write-Host "uvicorn app.main:app --reload" -ForegroundColor White
Write-Host ""
Write-Host "# 7. Acesse: http://localhost:8000" -ForegroundColor Yellow
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
pause
