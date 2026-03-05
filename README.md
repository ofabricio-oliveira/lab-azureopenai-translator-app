# Azure OpenAI PDF Translator LAB 🚀

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.11-3.12](https://img.shields.io/badge/python-3.11--3.12-blue.svg)](https://www.python.org/downloads/)

> **🎯 Lab educacional para portfólio, aprendizado e experimentação - NÃO é uma solução de produção**

## 📋 Índice

- [Visão Geral](#-visão-geral)
- [Arquitetura](#-arquitetura)
- [Pré-requisitos](#-pré-requisitos)
- [COMEÇE AQUI: Preparação do Ambiente](#-começe-aqui-preparação-do-ambiente)
- [Como Rodar Local (Windows)](#-como-rodar-local-windows)
- [Como Fazer Deploy no Azure](#-como-fazer-deploy-no-azure)
- [Testes](#-testes)
- [Troubleshooting](#-troubleshooting)
- [Segurança](#-segurança)
- [Limitações do LAB](#-limitações-do-lab)
- [Cleanup](#-cleanup)

---

## 🎯 Visão Geral

Este LAB demonstra como criar uma solução simples e segura para **traduzir PDFs** (texto simples, 1 página, inglês para português) usando:
- **Azure OpenAI** (tradução com GPT)
- **FastAPI** (backend Python)
- **Bicep** (infraestrutura como código)
- **Key Vault** (segredos)
- **Managed Identity** (autenticação sem senhas)

### O que você vai fazer:
1. ✅ Subir um PDF em inglês no frontend
2. ✅ Extrair texto do PDF
3. ✅ Enviar para Azure OpenAI traduzir
4. ✅ Gerar PDF traduzido em português
5. ✅ Baixar o PDF traduzido

---

## 📐 Arquitetura

```
┌─────────────┐
│   Usuário   │
└──────┬──────┘
       │ 1. Upload PDF (EN)
       ▼
┌─────────────────────────┐
│  Frontend (HTML/CSS)    │
└──────┬──────────────────┘
       │ 2. POST /translate
       ▼
┌─────────────────────────┐
│  FastAPI Backend        │
│  ├─ PDF Service         │ 3. Extrai texto
│  ├─ Translator Service  │ 4. Azure OpenAI
│  └─ PDF Generator       │ 5. Gera PDF (PT-BR)
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│  Azure Resources        │
│  ├─ Web App (Linux)     │
│  ├─ Key Vault           │
│  ├─ Azure OpenAI        │
│  └─ App Insights        │
└─────────────────────────┘
```

---

## ✅ Pré-requisitos

Antes de começar, você precisa ter:

- [ ] **Conta Microsoft Azure** (com créditos ou assinatura ativa)
- [ ] **Permissão para criar recursos Azure OpenAI** (algumas regiões têm restrição de quota)
- [ ] **VM Windows ou máquina local com Windows 10/11/Server 2025**
- [ ] **VS Code instalado** (baixe em: https://code.visualstudio.com/)
- [ ] **Git** (opcional, para clonar o repositório — [baixar aqui](https://git-scm.com/))
- [ ] **Acesso à internet**

---

## 🚀 COMEÇE AQUI: Preparação do Ambiente

**Se você tem uma VM Windows limpa com apenas VS Code instalado, siga EXATAMENTE esses passos:**

### Passo 1: Instalar Python 3.11 ou 3.12

1. Abra o navegador e acesse: https://www.python.org/downloads/
2. ⚠️ **CRÍTICO:** Baixe **Python 3.11.x ou 3.12.x** (NÃO use 3.13+/3.14+ - causa incompatibilidades)
   - Clique em "Downloads" no menu
   - Role até "Looking for a specific release?"
   - Escolha **"Python 3.12.x"** (recomendado) ou **"Python 3.11.x"**
3. Execute o instalador baixado
4. ⚠️ **IMPORTANTE**: Marque a opção **"Add Python to PATH"** antes de clicar em "Install Now"
5. Clique em **"Install Now"** e aguarde a instalação
6. Ao final, clique em **"Close"**

**Validar instalação:**
- Abra o PowerShell (clique com botão direito no menu Iniciar > PowerShell)
- Digite e pressione Enter:
  ```powershell
  python --version
  ```
- Você deve ver: `Python 3.11.x` ou `Python 3.12.x` (NÃO 3.14.x)

---

### Passo 2: Instalar Git (para clonar o repositório)

1. Abra o navegador e acesse: https://git-scm.com/download/win
2. Baixe a versão **"64-bit Git for Windows Setup"**
3. Execute o instalador
4. Nas opções, deixe **tudo padrão** (clique "Next" até "Install")
5. Ao final, clique em **"Finish"**

**Validar instalação:**
- Abra um **novo PowerShell** (feche o anterior e abra novamente)
- Digite:
  ```powershell
  git --version
  ```
- Você deve ver: `git version x.x.x`

---

### Passo 3: Instalar Azure CLI (necessário para deploy)

1. Abra o navegador e acesse: https://aka.ms/installazurecliwindows
2. Baixe o instalador MSI
3. Execute o instalador
4. Clique em **"Install"** e aguarde
5. Ao final, clique em **"Finish"**

**Validar instalação:**
- Abra um **novo PowerShell**
- Digite:
  ```powershell
  az --version
  ```
- Você deve ver a versão do Azure CLI

---

### Passo 4: Baixar o projeto

1. Abra o **VS Code**
2. Pressione `Ctrl + Shift + P` (abre a paleta de comandos)
3. Digite: **"Git: Clone"** e pressione Enter
4. Cole a URL do repositório: `https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git`
5. Escolha uma pasta local para salvar o projeto (ex: `C:\Users\SeuUsuario\Documents\`)
6. Clique em **"Open"** quando o VS Code perguntar se deseja abrir o repositório clonado

**OU use o PowerShell:**
```powershell
cd C:\Users\SeuUsuario\Documents\
git clone https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git
cd lab-azureopenai-translator-app
code .
```

---

## 💻 Como Rodar Local (Windows)

Agora que você tem tudo instalado, vamos rodar o aplicativo localmente:

### Passo 1: Abrir Terminal no VS Code

1. No VS Code, pressione `Ctrl + '` (abre o terminal integrado)
2. Certifique-se de que você está na pasta do projeto:
   ```powershell
   pwd
   ```
   Deve mostrar o caminho do projeto (ex: `C:\Users\...\project-01-translate-app`)

---

### Passo 2: Instalar Dependências Python

No terminal do VS Code, execute:

```powershell
python -m pip install --upgrade pip
pip install -r requirements.txt
```

**O que isso faz:**
- Atualiza o gerenciador de pacotes `pip`
- Instala todas as bibliotecas Python necessárias (FastAPI, pypdf, openai, etc.)

**Tempo estimado:** 2-3 minutos

---

### Passo 3: Configurar Variáveis de Ambiente

1. No VS Code, abra o arquivo `.env.example`
2. Clique em **"File" > "Save As"** e salve como `.env` (sem o `.example`)
3. Edite o arquivo `.env` com suas credenciais do Azure:

```env
AZURE_OPENAI_BASE_URL=https://SEU-RECURSO-OPENAI.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_API_KEY=SUA_CHAVE_API_AQUI
KEY_VAULT_URL=
MAX_FILE_SIZE_MB=2
```

**Onde encontrar essas informações:**

#### 3.1: Obter `AZURE_OPENAI_BASE_URL` e `AZURE_OPENAI_API_KEY`

1. Acesse o Portal Azure: https://portal.azure.com
2. No menu esquerdo, clique em **"Azure OpenAI"** (se não aparecer, use a busca no topo)
3. Se você **NÃO tem um recurso Azure OpenAI criado:**
   - Clique em **"+ Create"**
   - Preencha:
     - **Subscription:** Escolha sua assinatura
     - **Resource Group:** Clique em "Create new" e nomeie (ex: `openai-rg`)
     - **Region:** Escolha `East US` ou `Sweden Central` (regiões com quota disponível)
     - **Name:** Escolha um nome único (ex: `meu-openai-translator`)
     - **Pricing Tier:** Standard S0
   - Clique em **"Review + Create"** > **"Create"**
   - Aguarde a criação (1-2 minutos)

4. Clique no recurso criado
5. No menu esquerdo, clique em **"Keys and Endpoint"**
6. Copie:
   - **Endpoint** → Cole em `AZURE_OPENAI_BASE_URL` no `.env`
   - **KEY 1** → Cole em `AZURE_OPENAI_API_KEY` no `.env`

#### 3.2: Criar Deployment do Modelo

1. No recurso Azure OpenAI, clique em **"Go to Azure AI Foundry portal"**
2. Isso abre o **Azure AI Foundry** (portal de IA da Microsoft)
3. **Se aparecer prompt para criar projeto:** Crie um projeto com nome `pdf-translator-project` (ou pule se já tiver)
4. No menu esquerdo, clique em **"Deployments"** ou **"Model deployments"**
5. Clique em **"+ Deploy model"** ou **"+ Create"**
6. Preencha:
   - **Model:** Escolha `gpt-4o` (RECOMENDADO - gpt-4 deprecated em 2026)
   - **Deployment name:** `gpt-4o` (use o mesmo nome do modelo)
   - **Model version:** Auto-update to default
   - **Deployment type:** Standard
7. Clique em **"Deploy"**
8. Aguarde até status **"Succeeded"**
9. Copie o **"Deployment name"** exato → Cole em `AZURE_OPENAI_MODEL_DEPLOYMENT` no `.env`

**⚠️ Importante:** Se receber erro de quota, use `gpt-4o-mini` ou tente região `Sweden Central`.

---

### Passo 4: Rodar o Aplicativo

No terminal do VS Code:

```powershell
uvicorn app.main:app --reload
```

**Saída esperada:**
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
INFO:     Started server process
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

---

### Passo 5: Testar no Navegador

1. Abra o navegador
2. Acesse: http://localhost:8000
3. Você verá a página **"PDF Translator (Azure OpenAI LAB)"**
4. Clique em **"Choose File"** e selecione um PDF em inglês (texto simples, 1 página)
5. Clique em **"Translate"**
6. Aguarde o processamento (10-30 segundos)
7. O navegador baixará o PDF traduzido automaticamente!

**Não tem um PDF de teste?** Crie um:
- Abra o Word ou Google Docs
- Escreva um texto em inglês (ex: "Hello, this is a test document.")
- Salve como PDF

---

## ☁️ Como Fazer Deploy no Azure

Agora vamos publicar a aplicação na nuvem Azure:

### Passo 1: Fazer Login no Azure CLI

No terminal do VS Code:

```powershell
az login
```

**O que acontece:**
- Abre uma janela do navegador
- Faça login com sua conta Microsoft Azure
- Após o login, feche a janela do navegador
- Volte ao terminal - você verá a lista de assinaturas

---

### Passo 2: Selecionar a Subscription

Liste suas assinaturas:

```powershell
az account list --output table
```

Copie o **SubscriptionId** que você quer usar.

Defina como ativa:

```powershell
az account set --subscription SEU_SUBSCRIPTION_ID_AQUI
```

---

### Passo 3: Executar o Script de Deploy

**⚠️ Importante:** Escolha um **prefix** único (ex: sua inicial + número aleatório, como `fbs123`)

No terminal do VS Code:

```powershell
.\scripts\deploy.ps1 -subscriptionId "SEU_SUBSCRIPTION_ID" -location "eastus" -prefix "fbs123"
```

**Parâmetros:**
- `subscriptionId`: O ID da sua assinatura Azure
- `location`: Região do Azure (use `eastus`, `westeurope`, ou `brazilsouth`)
- `prefix`: Prefixo único para nomear recursos (3-10 caracteres, apenas letras e números)

**Exemplo real:**
```powershell
.\scripts\deploy.ps1 -subscriptionId "12345678-1234-1234-1234-123456789abc" -location "eastus" -prefix "meuteste01"
```

---

### Passo 4: Aguardar Deploy (processo automatizado)

O script vai executar automaticamente:

1. ✅ Criar Resource Group
2. ✅ Criar App Service Plan (Free F1)
3. ✅ Criar Web App (Linux + Python 3.11)
4. ✅ Criar Key Vault
5. ✅ Criar Application Insights
6. ✅ Criar Azure OpenAI (se disponível)
7. ✅ Configurar Managed Identity
8. ✅ Atribuir permissões RBAC
9. ✅ Fazer deploy do código

**Tempo estimado:** 5-8 minutos

**Saída esperada ao final:**
```
Deployment complete!
Web App URL: https://fbs123-web.azurewebsites.net
```

---

### Passo 5: Configurar Segredos no Key Vault (MANUAL)

**Após o deploy, você precisa armazenar a chave API no Key Vault:**

#### 5.1: Obter a API Key do Azure OpenAI

1. Acesse o Portal Azure: https://portal.azure.com
2. Vá em **"Azure OpenAI"**
3. Clique no recurso criado (nome: `<prefix>-aoai`)
4. Clique em **"Keys and Endpoint"**
5. Copie a **KEY 1**

#### 5.2: Armazenar no Key Vault

No terminal do VS Code:

```powershell
az keyvault secret set --vault-name "<prefix>kv" --name "AZURE-OPENAI-API-KEY" --value "SUA_CHAVE_AQUI"
```

**Exemplo:**
```powershell
az keyvault secret set --vault-name "fbs123kv" --name "AZURE-OPENAI-API-KEY" --value "sk-abcd1234..."
```

---

### Passo 6: Configurar o Deployment do Modelo (MANUAL)

#### 6.1: Criar Deployment do Modelo

1. Portal Azure > Azure OpenAI > Clique no recurso `<prefix>-aoai`
2. Clique em **"Go to Azure AI Foundry portal"**
3. **Se aparecer prompt para criar projeto:** Crie um (nome: `pdf-translator-project`) ou pule
4. No Azure AI Foundry, vá em **"Deployments"**
5. Clique em **"+ Deploy model"**
6. Preencha:
   - **Model:** `gpt-4o` (gpt-4 deprecado em 2026)
   - **Deployment name:** `gpt-4o` (anote!)
7. Clique em **"Deploy"****

#### 6.2: Configurar no Web App

No terminal:

```powershell
az webapp config appsettings set --name "<prefix>-web" --resource-group "<prefix>-rg" --settings AZURE_OPENAI_MODEL_DEPLOYMENT="gpt-4o"
```

**Exemplo:**
```powershell
az webapp config appsettings set --name "fbs123-web" --resource-group "fbs123-rg" --settings AZURE_OPENAI_MODEL_DEPLOYMENT="gpt-4o"
```

---

### Passo 7: Acessar o Aplicativo na Nuvem

1. Abra o navegador
2. Acesse: `https://<prefix>-web.azurewebsites.net`
3. Faça upload de um PDF em inglês
4. Clique em **"Translate"**
5. Baixe o PDF traduzido!

---

## 🧪 Testes

Para rodar os testes automatizados:

```powershell
pytest tests/
```

**Saída esperada:**
```
collected 2 items

tests/test_main.py .
tests/test_translator_service.py .

====== 2 passed in 0.50s ======
```

---

## 🔧 Troubleshooting

### ❌ ERRO CRÍTICO: "AsyncClient.__init__() got an unexpected keyword argument 'proxies'"

**Causa:** Você está usando Python 3.14+ (muito recente) que tem incompatibilidade com httpx/openai SDK.

**Solução OBRIGATÓRIA:**
```powershell
# 1. Desinstalar Python 3.14
# Ir em: Windows Settings > Apps > Uninstall Python 3.14

# 2. Baixar Python 3.12 ou 3.11
# https://www.python.org/downloads/release/python-3120/

# 3. Instalar Python 3.12 marcando "Add to PATH"

# 4. Validar versão
python --version
# Deve mostrar: Python 3.12.x ou 3.11.x

# 5. Reinstalar dependências
pip install --upgrade pip
pip install --upgrade -r requirements.txt

# 6. Reiniciar servidor
uvicorn app.main:app --reload
```

**⚠️ IMPORTANTE:** Este projeto requer Python 3.11 ou 3.12. Não use 3.13+/3.14+.

---

### Erro: "ModuleNotFoundError: No module named 'fastapi'"

**Solução:**
```powershell
pip install -r requirements.txt
```

---

### Erro: "Azure OpenAI quota exceeded"

**Causa:** Sua região não tem quota disponível para Azure OpenAI.

**Solução:**
1. Tente outra região: `westeurope`, `swedencentral`, `francecentral`
2. Use `gpt-4o-mini` em vez de `gpt-4o` (quota maior e mais rápido)
3. Solicite aumento de quota: Portal Azure > Quotas > Request increase

---

### Erro: "Key Vault access denied"

**Solução:**
```powershell
az role assignment create --assignee SEU_EMAIL --role "Key Vault Secrets Officer" --scope /subscriptions/SUB_ID/resourceGroups/<prefix>-rg/providers/Microsoft.KeyVault/vaults/<prefix>kv
```

---

### Erro: "PDF não tem texto extraível"

**Causa:** PDF é uma imagem escaneada (sem OCR).

**Solução:** Use um PDF com texto embutido (criado no Word, Google Docs, etc.).

---

### Como ver logs no Azure

1. Portal Azure > App Services > `<prefix>-web`
2. Menu esquerdo: **"Log stream"**
3. Veja logs em tempo real

---

## 🔒 Segurança

Este LAB implementa boas práticas de segurança:

- ✅ **Managed Identity:** Web App autentica no Key Vault sem senhas
- ✅ **Key Vault:** Segredos (API keys) armazenados de forma segura
- ✅ **RBAC:** Controle de acesso baseado em roles (não access policies legadas)
- ✅ **HTTPS Only:** Web App aceita apenas conexões HTTPS
- ✅ **Sem hardcode:** Sem chaves no código-fonte
- ✅ **`.env.example`:** Template sem valores reais
- ✅ **`.gitignore`:** Impede commit de arquivos sensíveis

**⚠️ Atenção:** Este é um LAB educacional. Para produção, adicione:
- Autenticação de usuário (OAuth, Azure AD)
- Rede virtual privada (VNET)
- Private Endpoints
- WAF (Web Application Firewall)
- Rate limiting

---

## ⚠️ Limitações do LAB

Este projeto é um LAB educacional com limitações conhecidas:

- ❌ Não mantém layout original do PDF (gera PDF simples com texto)
- ❌ Sem autenticação de usuário final
- ❌ Sem fila assíncrona (processamento síncrono)
- ❌ Sem banco de dados (sem histórico)
- ❌ Apenas PDF texto simples (sem OCR para PDFs escaneados)
- ❌ Limite de 2MB por arquivo
- ❌ Não otimizado para carga alta (Free tier)

---

## 🗑️ Cleanup

**IMPORTANTE:** Azure cobra por recursos ativos. Quando terminar o LAB, delete tudo:

### Deletar todos os recursos de uma vez:

```powershell
az group delete --name "<prefix>-rg" --yes --no-wait
```

**Exemplo:**
```powershell
az group delete --name "fbs123-rg" --yes --no-wait
```

**O que é deletado:**
- Web App
- App Service Plan
- Key Vault
- Azure OpenAI
- Application Insights
- Resource Group

**Tempo:** 5-10 minutos (em background)

---

### Verificar que tudo foi deletado:

```powershell
az group list --output table
```

Não deve aparecer o Resource Group `<prefix>-rg`.

---

## 📚 Recursos Adicionais

- [Documentação Azure OpenAI](https://learn.microsoft.com/azure/ai-services/openai/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure Key Vault Best Practices](https://learn.microsoft.com/azure/key-vault/general/best-practices)

---

## 🤝 Contribuindo

Este é um projeto educacional. Pull requests são bem-vindos!

1. Fork o projeto
2. Crie uma branch: `git checkout -b feature/minha-feature`
3. Commit suas mudanças: `git commit -m 'Adiciona nova feature'`
4. Push para a branch: `git push origin feature/minha-feature`
5. Abra um Pull Request

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

# ENGLISH

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Prerequisites](#-prerequisites)
- [START HERE: Environment Setup](#-start-here-environment-setup)
- [How to Run Locally (Windows)](#-how-to-run-locally-windows)
- [How to Deploy to Azure](#-how-to-deploy-to-azure)
- [Testing](#-testing)
- [Troubleshooting](#-troubleshooting-1)
- [Security](#-security-1)
- [LAB Limitations](#-lab-limitations)
- [Cleanup](#-cleanup-1)

---

## 🎯 Overview

This LAB demonstrates how to build a simple and secure solution to **translate PDFs** (plain text, 1 page, English to Portuguese) using:
- **Azure OpenAI** (GPT translation)
- **FastAPI** (Python backend)
- **Bicep** (Infrastructure as Code)
- **Key Vault** (secrets management)
- **Managed Identity** (passwordless authentication)

### What you'll do:
1. ✅ Upload an English PDF to the frontend
2. ✅ Extract text from PDF
3. ✅ Send to Azure OpenAI for translation
4. ✅ Generate translated PDF in Portuguese
5. ✅ Download the translated PDF

---

## 📐 Architecture

```
┌─────────────┐
│    User     │
└──────┬──────┘
       │ 1. Upload PDF (EN)
       ▼
┌─────────────────────────┐
│  Frontend (HTML/CSS)    │
└──────┬──────────────────┘
       │ 2. POST /translate
       ▼
┌─────────────────────────┐
│  FastAPI Backend        │
│  ├─ PDF Service         │ 3. Extract text
│  ├─ Translator Service  │ 4. Azure OpenAI
│  └─ PDF Generator       │ 5. Generate PDF (PT-BR)
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│  Azure Resources        │
│  ├─ Web App (Linux)     │
│  ├─ Key Vault           │
│  ├─ Azure OpenAI        │
│  └─ App Insights        │
└─────────────────────────┘
```

---

## ✅ Prerequisites

Before starting, you need:

- [ ] **Microsoft Azure Account** (with credits or active subscription)
- [ ] **Permission to create Azure OpenAI resources** (some regions have quota restrictions)
- [ ] **Windows VM or local machine with Windows 10/11/Server 2025**
- [ ] **VS Code installed** (download at: https://code.visualstudio.com/)
- [ ] **Git** (optional, for cloning the repository — [download here](https://git-scm.com/))
- [ ] **Internet access**

---

## 🚀 START HERE: Environment Setup

**If you have a clean Windows VM with only VS Code installed, follow these steps EXACTLY:**

### Step 1: Install Python 3.11 or 3.12

1. Open your browser and go to: https://www.python.org/downloads/
2. ⚠️ **CRITICAL:** Download **Python 3.11.x or 3.12.x** (DO NOT use 3.13+/3.14+ - causes incompatibilities)
   - Click "Downloads" in the menu
   - Scroll to "Looking for a specific release?"
   - Choose **"Python 3.12.x"** (recommended) or **"Python 3.11.x"**
3. Run the downloaded installer
4. ⚠️ **IMPORTANT**: Check **"Add Python to PATH"** before clicking "Install Now"
5. Click **"Install Now"** and wait
6. When finished, click **"Close"**

**Validate installation:**
- Open PowerShell (right-click Start menu > PowerShell)
- Type and press Enter:
  ```powershell
  python --version
  ```
- You should see: `Python 3.11.x` or `Python 3.12.x` (NOT 3.14.x)

---

### Step 2: Install Git (to clone the repository)

1. Open browser and go to: https://git-scm.com/download/win
2. Download **"64-bit Git for Windows Setup"**
3. Run the installer
4. Leave **all defaults** (click "Next" until "Install")
5. When finished, click **"Finish"**

**Validate installation:**
- Open a **new PowerShell** (close previous and reopen)
- Type:
  ```powershell
  git --version
  ```
- You should see: `git version x.x.x`

---

### Step 3: Install Azure CLI (required for deployment)

1. Open browser and go to: https://aka.ms/installazurecliwindows
2. Download the MSI installer
3. Run the installer
4. Click **"Install"** and wait
5. When finished, click **"Finish"**

**Validate installation:**
- Open a **new PowerShell**
- Type:
  ```powershell
  az --version
  ```
- You should see the Azure CLI version

---

### Step 4: Download the Project

1. Open **VS Code**
2. Press `Ctrl + Shift + P` (opens command palette)
3. Type: **"Git: Clone"** and press Enter
4. Paste the repository URL: `https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git`
5. Choose a local folder to save the project (e.g., `C:\Users\YourUser\Documents\`)
6. Click **"Open"** when VS Code asks if you want to open the cloned repository

**OR use PowerShell:**
```powershell
cd C:\Users\YourUser\Documents\
git clone https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git
cd lab-azureopenai-translator-app
code .
```

---

## 💻 How to Run Locally (Windows)

Now that you have everything installed, let's run the application locally:

### Step 1: Open Terminal in VS Code

1. In VS Code, press `Ctrl + '` (opens integrated terminal)
2. Make sure you're in the project folder:
   ```powershell
   pwd
   ```
   Should show the project path (e.g., `C:\Users\...\project-01-translate-app`)

---

### Step 2: Install Python Dependencies

In VS Code terminal, run:

```powershell
python -m pip install --upgrade pip
pip install -r requirements.txt
```

**What this does:**
- Updates the `pip` package manager
- Installs all required Python libraries (FastAPI, pypdf, openai, etc.)

**Estimated time:** 2-3 minutes

---

### Step 3: Configure Environment Variables

1. In VS Code, open the `.env.example` file
2. Click **"File" > "Save As"** and save as `.env` (without `.example`)
3. Edit the `.env` file with your Azure credentials:

```env
AZURE_OPENAI_BASE_URL=https://YOUR-OPENAI-RESOURCE.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_API_KEY=YOUR_API_KEY_HERE
KEY_VAULT_URL=
MAX_FILE_SIZE_MB=2
```

**Where to find these values:**

#### 3.1: Get `AZURE_OPENAI_BASE_URL` and `AZURE_OPENAI_API_KEY`

1. Go to Azure Portal: https://portal.azure.com
2. In the left menu, click **"Azure OpenAI"** (if not visible, use search at top)
3. If you **DO NOT have an Azure OpenAI resource created:**
   - Click **"+ Create"**
   - Fill in:
     - **Subscription:** Choose your subscription
     - **Resource Group:** Click "Create new" and name it (e.g., `openai-rg`)
     - **Region:** Choose `East US` or `Sweden Central` (regions with available quota)
     - **Name:** Choose a unique name (e.g., `my-openai-translator`)
     - **Pricing Tier:** Standard S0
   - Click **"Review + Create"** > **"Create"**
   - Wait for creation (1-2 minutes)

4. Click on the created resource
5. In the left menu, click **"Keys and Endpoint"**
6. Copy:
   - **Endpoint** → Paste in `AZURE_OPENAI_BASE_URL` in `.env`
   - **KEY 1** → Paste in `AZURE_OPENAI_API_KEY` in `.env`

#### 3.2: Create Model Deployment

1. In the Azure OpenAI resource, click **"Go to Azure AI Foundry portal"**
2. This opens Azure AI Foundry
3. **If prompted to create project:** Create one (name: `pdf-translator-project`) or skip
4. Click **"Deployments"** > **"+ Deploy model"**
5. Fill in:
   - **Model:** Choose `gpt-4o` (gpt-4 deprecated in 2026)
   - **Deployment name:** `gpt-4o` (note this name!)
   - **Model version:** Default or Auto-update to default
6. Click **"Deploy"**
7. Copy the **"Deployment name"** → Paste in `AZURE_OPENAI_MODEL_DEPLOYMENT` in `.env`

**⚠️ Important:** If you get a quota error, try another region or use `gpt-4o-mini` (higher quota, faster).

---

### Step 4: Run the Application

In VS Code terminal:

```powershell
uvicorn app.main:app --reload
```

**Expected output:**
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
INFO:     Started server process
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

---

### Step 5: Test in Browser

1. Open your browser
2. Go to: http://localhost:8000
3. You'll see the **"PDF Translator (Azure OpenAI LAB)"** page
4. Click **"Choose File"** and select an English PDF (plain text, 1 page)
5. Click **"Translate"**
6. Wait for processing (10-30 seconds)
7. The browser will automatically download the translated PDF!

**Don't have a test PDF?** Create one:
- Open Word or Google Docs
- Write some English text (e.g., "Hello, this is a test document.")
- Save as PDF

---

## ☁️ How to Deploy to Azure

Now let's publish the application to Azure cloud:

### Step 1: Login to Azure CLI

In VS Code terminal:

```powershell
az login
```

**What happens:**
- Opens a browser window
- Login with your Microsoft Azure account
- After login, close the browser window
- Return to terminal - you'll see the list of subscriptions

---

### Step 2: Select Subscription

List your subscriptions:

```powershell
az account list --output table
```

Copy the **SubscriptionId** you want to use.

Set it as active:

```powershell
az account set --subscription YOUR_SUBSCRIPTION_ID_HERE
```

---

### Step 3: Run Deployment Script

**⚠️ Important:** Choose a **unique prefix** (e.g., your initials + random number, like `abc123`)

In VS Code terminal:

```powershell
.\scripts\deploy.ps1 -subscriptionId "YOUR_SUBSCRIPTION_ID" -location "eastus" -prefix "abc123"
```

**Parameters:**
- `subscriptionId`: Your Azure subscription ID
- `location`: Azure region (use `eastus`, `westeurope`, or `brazilsouth`)
- `prefix`: Unique prefix for resource names (3-10 characters, letters and numbers only)

**Real example:**
```powershell
.\scripts\deploy.ps1 -subscriptionId "12345678-1234-1234-1234-123456789abc" -location "eastus" -prefix "mytest01"
```

---

### Step 4: Wait for Deployment (automated process)

The script will automatically:

1. ✅ Create Resource Group
2. ✅ Create App Service Plan (Free F1)
3. ✅ Create Web App (Linux + Python 3.11)
4. ✅ Create Key Vault
5. ✅ Create Application Insights
6. ✅ Create Azure OpenAI (if available)
7. ✅ Configure Managed Identity
8. ✅ Assign RBAC permissions
9. ✅ Deploy code

**Estimated time:** 5-8 minutes

**Expected output at the end:**
```
Deployment complete!
Web App URL: https://abc123-web.azurewebsites.net
```

---

### Step 5: Configure Secrets in Key Vault (MANUAL)

**After deployment, you need to store the API key in Key Vault:**

#### 5.1: Get Azure OpenAI API Key

1. Go to Azure Portal: https://portal.azure.com
2. Go to **"Azure OpenAI"**
3. Click on the created resource (name: `<prefix>-aoai`)
4. Click **"Keys and Endpoint"**
5. Copy **KEY 1**

#### 5.2: Store in Key Vault

In VS Code terminal:

```powershell
az keyvault secret set --vault-name "<prefix>kv" --name "AZURE-OPENAI-API-KEY" --value "YOUR_KEY_HERE"
```

**Example:**
```powershell
az keyvault secret set --vault-name "abc123kv" --name "AZURE-OPENAI-API-KEY" --value "sk-abcd1234..."
```

---

### Step 6: Configure Model Deployment (MANUAL)

#### 6.1: Create Model Deployment

1. Azure Portal > Azure OpenAI > Click resource `<prefix>-aoai`
2. Click **"Go to Azure AI Foundry portal"**
3. **If prompted to create project:** Create one (name: `pdf-translator-project`) or skip
4. In Azure AI Foundry, go to **"Deployments"** (left menu)
5. Click **"+ Deploy model"** or **"+ Create"**
6. Fill in:
   - **Model:** `gpt-4o` (gpt-4 deprecated in 2026)
   - **Deployment name:** `gpt-4o` (note this exact name!)
   - **Deployment type:** Standard
7. Click **"Deploy"**
8. Wait for status **"Succeeded"**

#### 6.2: Configure in Web App

In terminal:

```powershell
az webapp config appsettings set --name "<prefix>-web" --resource-group "<prefix>-rg" --settings AZURE_OPENAI_MODEL_DEPLOYMENT="gpt-4o"
```

**Example:**
```powershell
az webapp config appsettings set --name "abc123-web" --resource-group "abc123-rg" --settings AZURE_OPENAI_MODEL_DEPLOYMENT="gpt-4o"
```

---

### Step 7: Access the Application in the Cloud

1. Open your browser
2. Go to: `https://<prefix>-web.azurewebsites.net`
3. Upload an English PDF
4. Click **"Translate"**
5. Download the translated PDF!

---

## 🧪 Testing

To run automated tests:

```powershell
pytest tests/
```

**Expected output:**
```
collected 2 items

tests/test_main.py .
tests/test_translator_service.py .

====== 2 passed in 0.50s ======
```

---

## 🔧 Troubleshooting

### ❌ CRITICAL ERROR: "AsyncClient.__init__() got an unexpected keyword argument 'proxies'"

**Cause:** You are using Python 3.14+ (too recent) which has incompatibility with httpx/openai SDK.

**MANDATORY Solution:**
```powershell
# 1. Uninstall Python 3.14
# Go to: Windows Settings > Apps > Uninstall Python 3.14

# 2. Download Python 3.12 or 3.11
# https://www.python.org/downloads/release/python-3120/

# 3. Install Python 3.12 checking "Add to PATH"

# 4. Validate version
python --version
# Should show: Python 3.12.x or 3.11.x

# 5. Reinstall dependencies
pip install --upgrade pip
pip install --upgrade -r requirements.txt

# 6. Restart server
uvicorn app.main:app --reload
```

**⚠️ IMPORTANT:** This project requires Python 3.11 or 3.12. Do not use 3.13+/3.14+.

---

### Error: "ModuleNotFoundError: No module named 'fastapi'"

**Solution:**
```powershell
pip install -r requirements.txt
```

---

### Error: "Azure OpenAI quota exceeded"

**Cause:** Your region doesn't have available quota for Azure OpenAI.

**Solution:**
1. Try another region: `westeurope`, `swedencentral`, `francecentral`, `canadaeast`
2. Use `gpt-4o-mini` instead of `gpt-4o` (higher quota, faster, cheaper)
3. Request quota increase: Azure Portal > Quotas > Request increase

---

### Error: "Key Vault access denied"

**Solution:**
```powershell
az role assignment create --assignee YOUR_EMAIL --role "Key Vault Secrets Officer" --scope /subscriptions/SUB_ID/resourceGroups/<prefix>-rg/providers/Microsoft.KeyVault/vaults/<prefix>kv
```

---

### Error: "PDF has no extractable text"

**Cause:** PDF is a scanned image (no OCR).

**Solution:** Use a PDF with embedded text (created in Word, Google Docs, etc.).

---

### How to view logs in Azure

1. Azure Portal > App Services > `<prefix>-web`
2. Left menu: **"Log stream"**
3. View real-time logs

---

## 🔒 Security

This LAB implements security best practices:

- ✅ **Managed Identity:** Web App authenticates to Key Vault without passwords
- ✅ **Key Vault:** Secrets (API keys) stored securely
- ✅ **RBAC:** Role-based access control (not legacy access policies)
- ✅ **HTTPS Only:** Web App accepts only HTTPS connections
- ✅ **No hardcoded keys:** No keys in source code
- ✅ **`.env.example`:** Template without real values
- ✅ **`.gitignore`:** Prevents committing sensitive files

**⚠️ Note:** This is an educational LAB. For production, add:
- User authentication (OAuth, Azure AD)
- Private virtual network (VNET)
- Private Endpoints
- WAF (Web Application Firewall)
- Rate limiting

---

## ⚠️ LAB Limitations

This project is an educational LAB with known limitations:

- ❌ Does not preserve original PDF layout (generates simple text PDF)
- ❌ No end-user authentication
- ❌ No async queue (synchronous processing)
- ❌ No database (no history)
- ❌ Only plain text PDF (no OCR for scanned PDFs)
- ❌ 2MB file limit
- ❌ Not optimized for high load (Free tier)

---

## 🗑️ Cleanup

**IMPORTANT:** Azure charges for active resources. When you finish the LAB, delete everything:

### Delete all resources at once:

```powershell
az group delete --name "<prefix>-rg" --yes --no-wait
```

**Example:**
```powershell
az group delete --name "abc123-rg" --yes --no-wait
```

**What gets deleted:**
- Web App
- App Service Plan
- Key Vault
- Azure OpenAI
- Application Insights
- Resource Group

**Time:** 5-10 minutes (in background)

---

### Verify everything was deleted:

```powershell
az group list --output table
```

The Resource Group `<prefix>-rg` should not appear.

---

## 📚 Additional Resources

- [Azure OpenAI Documentation](https://learn.microsoft.com/azure/ai-services/openai/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure Key Vault Best Practices](https://learn.microsoft.com/azure/key-vault/general/best-practices)

---

## 🤝 Contributing

This is an educational project. Pull requests are welcome!

1. Fork the project
2. Create a branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request

---

## 📄 License

This project is under the MIT license. See the [LICENSE](LICENSE) file for more details.
