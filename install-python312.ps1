# ========================================
# Script de Instalação Automática do Python 3.12
# ========================================

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Instalação Automática Python 3.12" -ForegroundColor Cyan
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

# Configurações
$pythonVersion = "3.12.7"
$pythonUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-amd64.exe"
$installerPath = "$env:TEMP\python-$pythonVersion-installer.exe"

Write-Host "[1/5] Baixando Python $pythonVersion..." -ForegroundColor Yellow
Write-Host "  URL: $pythonUrl" -ForegroundColor Gray

try {
    # Download com barra de progresso
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath -ErrorAction Stop
    $ProgressPreference = 'Continue'
    
    $fileSize = (Get-Item $installerPath).Length / 1MB
    Write-Host "  ✓ Download concluído! ($([math]::Round($fileSize, 2)) MB)" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Erro ao baixar: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Tente baixar manualmente:" -ForegroundColor Yellow
    Write-Host "  $pythonUrl" -ForegroundColor White
    pause
    exit 1
}

Write-Host ""
Write-Host "[2/5] Verificando integridade do arquivo..." -ForegroundColor Yellow
if (Test-Path $installerPath) {
    Write-Host "  ✓ Arquivo encontrado: $installerPath" -ForegroundColor Green
} else {
    Write-Host "  ✗ Arquivo não encontrado!" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "[3/5] Instalando Python $pythonVersion (modo silencioso)..." -ForegroundColor Yellow
Write-Host "  Isso pode levar 2-3 minutos..." -ForegroundColor Gray
Write-Host ""

# Argumentos para instalação silenciosa
# /quiet = sem interface gráfica
# InstallAllUsers=1 = instalar para todos os usuários
# PrependPath=1 = adicionar ao PATH automaticamente
# Include_test=0 = não instalar módulo de testes
# Include_pip=1 = instalar pip
# Include_launcher=1 = instalar launcher py.exe
$installArgs = @(
    "/quiet",
    "InstallAllUsers=1",
    "PrependPath=1",
    "Include_test=0",
    "Include_pip=1",
    "Include_tcltk=1",
    "Include_doc=0",
    "Include_launcher=1",
    "InstallLauncherAllUsers=1"
)

try {
    $process = Start-Process -FilePath $installerPath -ArgumentList $installArgs -Wait -PassThru -NoNewWindow
    
    if ($process.ExitCode -eq 0) {
        Write-Host "  ✓ Instalação concluída com sucesso!" -ForegroundColor Green
    } elseif ($process.ExitCode -eq 1602) {
        Write-Host "  ⚠ Instalação cancelada pelo usuário." -ForegroundColor Yellow
        pause
        exit 1
    } else {
        Write-Host "  ⚠ Instalação finalizada com código: $($process.ExitCode)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ✗ Erro durante instalação: $_" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "[4/5] Limpando arquivo temporário..." -ForegroundColor Yellow
try {
    Remove-Item -Path $installerPath -Force -ErrorAction SilentlyContinue
    Write-Host "  ✓ Arquivo removido!" -ForegroundColor Green
} catch {
    Write-Host "  ⚠ Não foi possível remover: $installerPath" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[5/5] Verificando instalação..." -ForegroundColor Yellow

# Atualizar variáveis de ambiente da sessão atual
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

Start-Sleep -Seconds 2

try {
    # Tentar executar python
    $pythonVersionOutput = & python --version 2>&1
    
    if ($pythonVersionOutput -match "Python 3\.12") {
        Write-Host "  ✓ Python instalado corretamente!" -ForegroundColor Green
        Write-Host "    Versão: $pythonVersionOutput" -ForegroundColor White
    } elseif ($pythonVersionOutput -match "Python") {
        Write-Host "  ⚠ Python encontrado, mas versão diferente: $pythonVersionOutput" -ForegroundColor Yellow
        Write-Host "    Pode ser necessário reiniciar o terminal ou PC" -ForegroundColor Yellow
    } else {
        Write-Host "  ⚠ Python não encontrado no PATH ainda" -ForegroundColor Yellow
        Write-Host "    Reinicie o PowerShell ou PC" -ForegroundColor Yellow
    }
    
    # Verificar pip
    $pipVersionOutput = & pip --version 2>&1
    if ($pipVersionOutput -match "pip") {
        Write-Host "  ✓ pip instalado corretamente!" -ForegroundColor Green
        Write-Host "    Versão: $pipVersionOutput" -ForegroundColor White
    }
} catch {
    Write-Host "  ⚠ Não foi possível verificar (pode precisar reiniciar terminal)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "  Instalação Concluída!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "PRÓXIMOS PASSOS:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. FECHE e ABRA um NOVO PowerShell" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Valide a versão:" -ForegroundColor Yellow
Write-Host "   python --version" -ForegroundColor White
Write-Host "   (deve mostrar: Python 3.12.x)" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Navegue até o projeto:" -ForegroundColor Yellow
Write-Host "   cd C:\Users\adm.fa\Documents\project-01-translate-app\project-01-translate-app" -ForegroundColor White
Write-Host ""
Write-Host "4. Atualize pip:" -ForegroundColor Yellow
Write-Host "   python -m pip install --upgrade pip" -ForegroundColor White
Write-Host ""
Write-Host "5. Instale dependências:" -ForegroundColor Yellow
Write-Host "   pip install --upgrade -r requirements.txt" -ForegroundColor White
Write-Host ""
Write-Host "6. Inicie o servidor:" -ForegroundColor Yellow
Write-Host "   uvicorn app.main:app --reload" -ForegroundColor White
Write-Host ""
Write-Host "7. Acesse: http://localhost:8000" -ForegroundColor Yellow
Write-Host ""
pause
