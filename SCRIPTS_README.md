# 🔧 Scripts de Correção Automática Python

Este diretório contém scripts PowerShell para corrigir problemas com Python 3.14.

---

## 🚀 Uso Rápido (RECOMENDADO)

### Opção 1: Script Completo (Tudo em 1)

```powershell
# 1. Abra PowerShell como Administrador
# 2. Navegue até o projeto
cd C:\Users\adm.fa\Documents\project-01-translate-app\project-01-translate-app

# 3. Execute o script completo
.\fix-python-complete.ps1
```

**O que faz:**
- ✅ Desinstala Python 3.14
- ✅ Instala Python 3.12.7
- ✅ Configura PATH automaticamente
- ✅ Mostra próximos passos

**Tempo:** ~5 minutos

---

## 📋 Scripts Disponíveis

### 1. `fix-python-complete.ps1` ⭐ RECOMENDADO
**Tudo em um script**: Desinstala 3.14 + Instala 3.12 + Configura tudo.

**Quando usar:** Primeira vez, ou quando quiser fazer tudo de uma vez.

```powershell
.\fix-python-complete.ps1
```

---

### 2. `uninstall-python314.ps1`
**Apenas desinstalação**: Remove Python 3.14 e limpa PATH.

**Quando usar:** Se você só quer remover Python 3.14 e instalar 3.12 manualmente depois.

```powershell
.\uninstall-python314.ps1
```

---

### 3. `install-python312.ps1`
**Apenas instalação**: Baixa e instala Python 3.12.7 com PATH configurado.

**Quando usar:** Se você já desinstalou 3.14 e só precisa instalar 3.12.

```powershell
.\install-python312.ps1
```

---

## ⚠️ IMPORTANTE: Executar como Administrador

Todos os scripts **PRECISAM** ser executados como Administrador.

### Como executar como Administrador:

#### Método 1: Via Menu Iniciar
1. Pressione **Windows + X**
2. Clique em **"Windows PowerShell (Admin)"** ou **"Terminal (Admin)"**
3. Navegue até o diretório do projeto
4. Execute o script

#### Método 2: Via Botão Direito
1. Procure **"PowerShell"** no menu Iniciar
2. Clique com **botão direito**
3. Escolha **"Executar como Administrador"**
4. Navegue até o diretório do projeto
5. Execute o script

#### Método 3: Via VS Code Terminal
1. Abra VS Code
2. `Ctrl + Shift + P`
3. Digite: **"Terminal: Create New Terminal (as Administrator)"**
4. Execute o script

---

## 🔍 O Que Cada Script Faz

### `fix-python-complete.ps1` (Recomendado)

```
┌─────────────────────────────────────┐
│ ETAPA 1: DESINSTALAR PYTHON 3.14    │
├─────────────────────────────────────┤
│ [1.1] Verificar versão atual        │
│ [1.2] Procurar Python 3.14          │
│ [1.3] Executar desinstaladores      │
│ [1.4] Limpar PATH                   │
└─────────────────────────────────────┘
         ▼
┌─────────────────────────────────────┐
│ ETAPA 2: INSTALAR PYTHON 3.12       │
├─────────────────────────────────────┤
│ [2.1] Baixar Python 3.12.7 (~25 MB) │
│ [2.2] Instalar (modo silencioso)    │
│ [2.3] Configurar PATH               │
│ [2.4] Verificar instalação          │
└─────────────────────────────────────┘
         ▼
┌─────────────────────────────────────┐
│ 🎉 CONCLUÍDO!                       │
│ Próximos passos exibidos na tela    │
└─────────────────────────────────────┘
```

---

## 🐛 Troubleshooting

### Erro: "Execution Policy"

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Erro: "Não é possível executar scripts"

```powershell
# Método alternativo: copiar e colar todo o conteúdo do script no PowerShell
Get-Content .\fix-python-complete.ps1 | Invoke-Expression
```

### Script não encontra Python 3.14

Desinstale manualmente:
1. Windows Settings (`Win + I`)
2. Apps > Installed apps
3. Procure "Python 3.14"
4. Desinstale

Depois execute o script de instalação:
```powershell
.\install-python312.ps1
```

---

## ✅ Checklist Pós-Instalação

Após executar o script, **feche e abra um NOVO PowerShell** e valide:

```powershell
# 1. Versão do Python
python --version
# Esperado: Python 3.12.7

# 2. Versão do pip
pip --version
# Esperado: pip 24.x (python 3.12)

# 3. Localização do Python
where python
# Esperado: C:\Program Files\Python312\python.exe

# 4. PATH configurado
$env:Path -split ';' | Select-String -Pattern "Python312"
# Esperado: Deve mostrar caminhos com Python312
```

---

## 📝 Após Instalação Bem-Sucedida

Execute estes comandos no diretório do projeto:

```powershell
# Navegar para o projeto
cd C:\Users\adm.fa\Documents\project-01-translate-app\project-01-translate-app

# Atualizar pip
python -m pip install --upgrade pip

# Instalar dependências do projeto
pip install --upgrade -r requirements.txt

# Verificar se openai SDK foi instalado corretamente
python -c "import openai; print(f'OpenAI SDK: {openai.__version__}')"
# Esperado: OpenAI SDK: 1.54.4

# Verificar httpx
python -c "import httpx; print(f'httpx: {httpx.__version__}')"
# Esperado: httpx: 0.27.0

# Iniciar servidor
uvicorn app.main:app --reload

# Acessar http://localhost:8000
```

---

## 🎯 Resumo Rápido

| Script | Quando Usar | Tempo |
|--------|-------------|-------|
| `fix-python-complete.ps1` | **Primeira vez / Tudo de uma vez** | 5 min |
| `uninstall-python314.ps1` | Só remover Python 3.14 | 2 min |
| `install-python312.ps1` | Só instalar Python 3.12 | 3 min |

**Recomendação:** Use `fix-python-complete.ps1` na primeira vez.

---

## 📚 Documentação Relacionada

- [PYTHON_3.14_FIX.md](PYTHON_3.14_FIX.md) - Guia manual passo a passo
- [UPDATES_FEV_2026.md](UPDATES_FEV_2026.md) - Todas as correções de fev/2026
- [START_HERE.md](START_HERE.md) - Guia completo do projeto
- [README.md](README.md) - Documentação principal

---

**Atualizado:** 21 de Fevereiro de 2026
