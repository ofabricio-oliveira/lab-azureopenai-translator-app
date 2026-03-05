# ========================================
# Script de Desinstalação do Python 3.14
# ========================================

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Desinstalação Automática Python 3.14" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se está rodando como Administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERRO: Este script precisa ser executado como Administrador!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Passos:" -ForegroundColor Yellow
    Write-Host "1. Feche este PowerShell" -ForegroundColor Yellow
    Write-Host "2. Clique com botão direito no ícone do PowerShell" -ForegroundColor Yellow
    Write-Host "3. Escolha 'Executar como Administrador'" -ForegroundColor Yellow
    Write-Host "4. Execute este script novamente" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host "[1/4] Verificando versão atual do Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1 | Out-String
    Write-Host "Versão encontrada: $pythonVersion" -ForegroundColor White
} catch {
    Write-Host "Python não encontrado no PATH" -ForegroundColor Gray
}

Write-Host ""
Write-Host "[2/4] Procurando instalações do Python 3.14..." -ForegroundColor Yellow

# Procurar Python 3.14 no registro (instalações por usuário e sistema)
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
        $displayName = $_.DisplayName
        $uninstallString = $_.UninstallString
        
        Write-Host "  Encontrado: $displayName" -ForegroundColor Green
        
        if ($uninstallString) {
            $uninstallStrings += $uninstallString
        }
    }
}

if (-not $python314Found) {
    Write-Host "  Nenhuma instalação do Python 3.14 encontrada no registro." -ForegroundColor Gray
    Write-Host ""
    Write-Host "[INFO] Verificando instalações manuais..." -ForegroundColor Yellow
    
    # Verificar diretórios comuns
    $commonPaths = @(
        "$env:LOCALAPPDATA\Programs\Python\Python314",
        "$env:ProgramFiles\Python314",
        "${env:ProgramFiles(x86)}\Python314",
        "$env:USERPROFILE\AppData\Local\Programs\Python\Python314"
    )
    
    foreach ($pyPath in $commonPaths) {
        if (Test-Path $pyPath) {
            Write-Host "  Encontrado diretório: $pyPath" -ForegroundColor Yellow
            Write-Host "  Removendo diretório manualmente..." -ForegroundColor Yellow
            try {
                Remove-Item -Path $pyPath -Recurse -Force -ErrorAction Stop
                Write-Host "  ✓ Diretório removido com sucesso!" -ForegroundColor Green
            } catch {
                Write-Host "  ✗ Erro ao remover: $_" -ForegroundColor Red
            }
        }
    }
}

Write-Host ""
Write-Host "[3/4] Executando desinstaladores encontrados..." -ForegroundColor Yellow

if ($uninstallStrings.Count -gt 0) {
    foreach ($uninstallCmd in $uninstallStrings) {
        Write-Host "  Executando: $uninstallCmd" -ForegroundColor White
        
        # Parse do comando de desinstalação
        if ($uninstallCmd -match 'MsiExec\.exe') {
            # Desinstalação MSI
            $productCode = ($uninstallCmd -split '/I|/X')[1].Trim()
            $args = "/X $productCode /quiet /norestart"
            Write-Host "  Desinstalando via MSI (silencioso)..." -ForegroundColor Gray
            Start-Process "msiexec.exe" -ArgumentList $args -Wait -NoNewWindow
            Write-Host "  ✓ Desinstalação MSI concluída!" -ForegroundColor Green
        } elseif ($uninstallCmd -match '\.exe') {
            # Desinstalação via EXE
            $exePath = ($uninstallCmd -replace '"', '').Trim()
            if (Test-Path $exePath) {
                Write-Host "  Desinstalando via EXE (silencioso)..." -ForegroundColor Gray
                Start-Process $exePath -ArgumentList "/uninstall /quiet" -Wait -NoNewWindow
                Write-Host "  ✓ Desinstalação EXE concluída!" -ForegroundColor Green
            }
        }
    }
} else {
    Write-Host "  Nenhum desinstalador automático encontrado." -ForegroundColor Gray
}

Write-Host ""
Write-Host "[4/4] Limpando variáveis de ambiente (PATH)..." -ForegroundColor Yellow

# Limpar Python 3.14 do PATH
$pathsToRemove = @("Python314", "Python\Python314", "python314")

# PATH do Sistema
$systemPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$systemPathItems = $systemPath -split ';' | Where-Object { 
    $item = $_
    -not ($pathsToRemove | Where-Object { $item -like "*$_*" })
}
$newSystemPath = $systemPathItems -join ';'

if ($systemPath -ne $newSystemPath) {
    [Environment]::SetEnvironmentVariable("Path", $newSystemPath, "Machine")
    Write-Host "  ✓ PATH do Sistema atualizado!" -ForegroundColor Green
} else {
    Write-Host "  PATH do Sistema já está limpo." -ForegroundColor Gray
}

# PATH do Usuário
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$userPathItems = $userPath -split ';' | Where-Object { 
    $item = $_
    -not ($pathsToRemove | Where-Object { $item -like "*$_*" })
}
$newUserPath = $userPathItems -join ';'

if ($userPath -ne $newUserPath) {
    [Environment]::SetEnvironmentVariable("Path", $newUserPath, "User")
    Write-Host "  ✓ PATH do Usuário atualizado!" -ForegroundColor Green
} else {
    Write-Host "  PATH do Usuário já está limpo." -ForegroundColor Gray
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "  Desinstalação Concluída!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "Próximo passo: Execute install-python312.ps1" -ForegroundColor Cyan
Write-Host ""
pause
