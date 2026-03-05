# 🎯 GUIA PASSO A PASSO COMPLETO - COMECE AQUI!

## 👋 Bem-vindo!

Este é o **guia definitivo** para usar o projeto Azure OpenAI PDF Translator LAB na sua **VM Windows Server 2025**.

---

## 📋 O Que Você Vai Fazer

1. ✅ Instalar Python, Git e Azure CLI
2. ✅ Rodar o projeto localmente
3. ✅ Testar com um PDF
4. ✅ Fazer deploy no Azure
5. ✅ Publicar no GitHub

**Tempo total:** ~2 horas (incluindo leitura)

---

## 🚀 ETAPA 1: Preparar o Ambiente (30 minutos)

### 1.1 - Instalar Python

1. Abra o **Edge** ou outro navegador
2. Acesse: `https://www.python.org/downloads/`
3. ⚠️ **CRÍTICO:** Baixe **Python 3.11.x ou 3.12.x** (NÃO use 3.13+ ou 3.14+)
   - Clique em **"Downloads"** no menu
   - Role até **"Looking for a specific release?"**
   - Escolha **"Python 3.12.x"** (versão estável recomendada)
4. Baixe o instalador **Windows installer (64-bit)**
5. Execute o instalador
6. ⚠️ **CRÍTICO:** Marque **"Add Python to PATH"** (checkbox na primeira tela)
7. Clique em **"Install Now"**
8. Aguarde instalação (~2 minutos)
9. Clique em **"Close"**

**Validar:**

```powershell
# Abra PowerShell (Botão Windows + X > Windows PowerShell)
python --version
# Deve mostrar: Python 3.11.x ou 3.12.x (NÃO 3.14.x)
```

**⚠️ SE VOCÊ TEM PYTHON 3.14:**
```powershell
# Desinstalar Python 3.14 (cause incompatibilidades)
# Ir em: Configurações > Aplicativos > Desinstalar Python 3.14
# Depois instalar Python 3.12 seguindo os passos acima
```

---

### 1.2 - Instalar Git

1. No navegador, acesse: `https://git-scm.com/download/win`
2. Baixe **"64-bit Git for Windows Setup"**
3. Execute o instalador
4. Deixe **tudo padrão** (apenas clique "Next" até "Install")
5. Clique em **"Finish"**

**Validar:**

```powershell
# Feche e abra um NOVO PowerShell
git --version
# Deve mostrar: git version x.x.x
```

---

### 1.3 - Instalar Azure CLI

1. No navegador, acesse: `https://aka.ms/installazurecliwindows`
2. Baixe o instalador MSI
3. Execute
4. Clique em **"Install"**
5. Aguarde (~3 minutos)
6. Clique em **"Finish"**

**Validar:**

```powershell
# Feche e abra um NOVO PowerShell
az --version
# Deve mostrar a versão do Azure CLI
```

---

## 💻 ETAPA 2: Baixar e Configurar o Projeto (10 minutos)

### 2.1 - Abrir VS Code

1. Clique no ícone **VS Code** na área de trabalho ou menu Iniciar
2. Aguarde abrir

---

### 2.2 - Abrir Terminal Integrado

1. No VS Code, pressione: `Ctrl + '` (apóstrofo)
2. Um terminal PowerShell abrirá na parte inferior

---

### 2.3 - Navegar para Pasta de Trabalho

No terminal do VS Code:

```powershell
# Ir para Documentos
cd $HOME\Documents

# Criar pasta para projetos (se não existir)
mkdir Projects -ErrorAction SilentlyContinue

# Entrar na pasta
cd Projects
```

---

### 2.4 - Clonar o Projeto

Se você já tem o projeto no GitHub:

```powershell
git clone https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git
cd lab-azureopenai-translator-app
```

OU se você está trabalhando localmente:

```powershell
# O projeto já está em:
cd "C:\Users\fabricio\Library\CloudStorage\OneDrive-Personal\VSCode\dio-me\project-01-translate-app"
```

---

### 2.5 - Abrir Projeto no VS Code

No terminal:

```powershell
code .
```

O VS Code abrirá o projeto na pasta atual.

---

## ⚙️ ETAPA 3: Instalar Dependências (5 minutos)

No terminal do VS Code:

```powershell
# Atualizar pip
python -m pip install --upgrade pip

# Instalar dependências
pip install -r requirements.txt
```

**Aguarde ~3 minutos** enquanto as bibliotecas são instaladas.

**Saída esperada ao final:**

```
Successfully installed fastapi-0.110.0 uvicorn-0.29.0 ...
```

---

## 🔑 ETAPA 4: Configurar Azure OpenAI (20 minutos)

### 4.1 - Acessar Azure Portal

1. Abra o navegador
2. Acesse: `https://portal.azure.com`
3. Faça login com sua conta Microsoft

---

### 4.2 - Criar Recurso Azure OpenAI (se não tiver)

1. No topo, clique na **barra de busca**
2. Digite: **"Azure OpenAI"**
3. Clique em **"Azure OpenAI"** nos resultados

**Se você NÃO tem nenhum recurso:**

4. Clique em **"+ Create"**
5. Preencha:
   - **Subscription:** Selecione sua assinatura
   - **Resource group:** Clique "Create new" > Digite `openai-lab-rg`
   - **Region:** Selecione **"East US"** (tem mais quota disponível)
   - **Name:** Digite um nome único (ex: `meu-openai-2026`)
   - **Pricing tier:** **"Standard S0"**
6. Clique **"Review + create"**
7. Clique **"Create"**
8. Aguarde ~2 minutos
9. Clique **"Go to resource"**

---

### 4.3 - Obter Endpoint e Chave

1. No recurso Azure OpenAI, menu esquerdo: **"Keys and Endpoint"**
2. **Copie e anote:**
   - **Endpoint:** `https://meu-openai-2026.openai.azure.com/`
   - **KEY 1:** `abc123...` (clique no ícone de copiar)

---

### 4.4 - Criar Deployment do Modelo

1. No recurso Azure OpenAI, no menu superior, clique em **"Go to Azure AI Foundry portal"**
   - OU clique em **"Model deployments"** > **"Manage Deployments"**
2. Isso abre o **Azure AI Foundry** (portal dedicado para IA)

**⚠️ PRIMEIRA VEZ? Criação de Projeto:**

3. Se aparecer mensagem para criar um projeto:
   - Clique **"Create a project"** ou **"New project"**
   - **Project name:** Digite `pdf-translator-project` (ou qualquer nome)
   - **Resource group:** Deixe o padrão ou selecione o mesmo que criou (`openai-lab-rg`)
   - Clique **"Create"** e aguarde ~1 minuto
   - ⚠️ **Se não aparecer:** Pule para o passo 4 (projeto não é obrigatório para deployments)

**Criar o Deployment do Modelo:**

4. No Azure AI Foundry:
   - No menu esquerdo, clique em **"Deployments"** (ícone de foguete 🚀)
   - OU vá direto em **"Models + endpoints"** > **"Model deployments"**
5. Clique em **"+ Deploy model"** ou **"+ Create"**
6. Na janela de criação:
   - **Select a model:** Escolha `gpt-4o` (RECOMENDADO - gpt-4 está deprecated)
   - **Deployment name:** Digite `gpt-4o` (use o mesmo nome do modelo para facilitar)
   - **Model version:** Deixe `Default` ou `Auto-update to default`
   - **Deployment type:** Standard
   - **Tokens per minute rate limit:** Deixe padrão (10K ou 30K)
7. Clique **"Deploy"** ou **"Create"**
8. Aguarde ~1-2 minutos enquanto o deployment é criado
9. ✅ Quando aparecer status **"Succeeded"**, anote o **Deployment name** exato: `gpt-4o`

**⚠️ Problemas comuns:**
- **❌ gpt-4 deprecated:** Use `gpt-4o` (versão mais recente e estável em 2026)
- **Erro de quota:** Use `gpt-4o-mini` ou `gpt-35-turbo` (tem mais quota disponível)
- **Região sem quota:** Tente criar novo recurso em `Sweden Central`, `France Central` ou `Canada East`
- **Modelo não disponível:** Verifique se sua subscription tem acesso (alguns modelos precisam de request de acesso)

**💡 Dica:** O deployment name que você criar aqui é o que vai usar no `.env` como `AZURE_OPENAI_MODEL_DEPLOYMENT`

---

### 4.5 - Configurar .env Local

1. No VS Code, abra o arquivo **`.env.example`**
2. Clique em **"File" > "Save As..."**
3. Salve como: **`.env`** (SEM o `.example`)
4. Edite o arquivo `.env` com os valores copiados:

```env
AZURE_OPENAI_BASE_URL=https://meu-openai-2026.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_API_KEY=abc123suachaveaqui456
KEY_VAULT_URL=
MAX_FILE_SIZE_MB=2
```

5. Salve o arquivo (`Ctrl + S`)

---

## 🎮 ETAPA 5: Rodar o Projeto Localmente (5 minutos)

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

✅ **Sucesso!** O servidor está rodando!

---

## 🧪 ETAPA 6: Testar com um PDF (5 minutos)

### 6.1 - Criar PDF de Teste

1. Abra **Word** ou **Bloco de Notas**
2. Escreva um texto simples em inglês:

```
Hello World!

This is a simple test document for the Azure OpenAI PDF Translator.
The translator will convert this English text to Portuguese using AI.

Thank you for testing this project!
```

3. Salve como **"test.pdf"** (se no Bloco de Notas, salve como .txt e depois renomeie)
   - No Word: **File > Save As > PDF**

---

### 6.2 - Testar no Navegador

1. Abra o navegador
2. Acesse: `http://localhost:8000`
3. Você verá a página **"PDF Translator (Azure OpenAI LAB)"**
4. Clique em **"Choose File"**
5. Selecione o **test.pdf** que você criou
6. Clique em **"Translate"**
7. Aguarde 10-30 segundos (barra de status mostra progresso)
8. O navegador **baixará automaticamente** o PDF traduzido!

---

### 6.3 - Verificar Resultado

1. Abra o PDF baixado (geralmente em `Downloads`)
2. Verifique se o texto está em **português**!

**Exemplo esperado:**

```
Olá Mundo!

Este é um documento de teste simples para o Tradutor de PDF Azure OpenAI.
O tradutor converterá este texto em inglês para português usando IA.

Obrigado por testar este projeto!
```

✅ **Funcionou?** Parabéns! Seu projeto está funcionando localmente!

---

## ☁️ ETAPA 7: Deploy no Azure (40 minutos)

### 7.1 - Login no Azure CLI

No terminal do VS Code (pressione `Ctrl+C` para parar o servidor primeiro):

```powershell
az login
```

Uma janela do navegador abrirá. Faça login e feche a janela. Volte ao terminal.

---

### 7.2 - Selecionar Subscription

Liste suas assinaturas:

```powershell
az account list --output table
```

Copie o **SubscriptionId** que você quer usar.

Defina como ativa:

```powershell
az account set --subscription "SEU_SUBSCRIPTION_ID_AQUI"
```

---

### 7.3 - Executar Script de Deploy

**Escolha um prefix único** (ex: suas iniciais + número: `fbs2026`):

```powershell
.\scripts\deploy.ps1 -subscriptionId "SEU_SUBSCRIPTION_ID" -location "eastus" -prefix "fbs2026"
```

**Substitua:**
- `SEU_SUBSCRIPTION_ID`: O ID copiado no passo anterior
- `fbs2026`: Suas iniciais + ano/número único

**Aguarde ~8 minutos** enquanto o Azure cria os recursos.

**Ao final, você verá:**

```
Deployment complete!
Web App URL: https://fbs2026-web.azurewebsites.net
```

---

### 7.4 - Configurar Segredos no Key Vault

**Armazenar a chave API no Key Vault:**

```powershell
az keyvault secret set --vault-name "fbs2026kv" --name "AZURE-OPENAI-API-KEY" --value "SUA_CHAVE_AQUI"
```

**Substitua:**
- `fbs2026kv`: Seu prefix + `kv`
- `SUA_CHAVE_AQUI`: A mesma KEY 1 do passo 4.3

---

### 7.5 - Configurar Deployment do Modelo no Web App

```powershell
az webapp config appsettings set --name "fbs2026-web" --resource-group "fbs2026-rg" --settings AZURE_OPENAI_MODEL_DEPLOYMENT="gpt-4o"
```

**Substitua:**
- `fbs2026-web`: Seu prefix + `-web`
- `fbs2026-rg`: Seu prefix + `-rg`
- `gpt-4o`: O **deployment name exato** que você criou no Azure AI Foundry (passo 4.4)

**⚠️ Importante:** Use o mesmo nome que aparece na coluna "Deployment name" no Azure AI Foundry (deve ser `gpt-4o`)

---

### 7.6 - Testar no Azure

1. Abra o navegador
2. Acesse: `https://fbs2026-web.azurewebsites.net` (substitua pelo seu)
3. Faça upload do **test.pdf**
4. Clique em **"Translate"**
5. Baixe o PDF traduzido!

✅ **Funcionou?** Seu projeto está na nuvem!

---

## 🐙 ETAPA 8: Publicar no GitHub (20 minutos)

Siga o guia completo em: **[GITHUB_SETUP.md](GITHUB_SETUP.md)**

**Resumo rápido:**

```powershell
# 1. Inicializar Git
git init

# 2. Adicionar arquivos
git add .

# 3. Primeiro commit
git commit -m "Initial commit: Azure OpenAI PDF Translator LAB"

# 4. Renomear branch
git branch -M main

# 5. Conectar ao GitHub (crie o repo no GitHub primeiro!)
git remote add origin https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git

# 6. Push
git push -u origin main
```

---

## ✅ CHECKLIST FINAL

- [ ] Python instalado e funcionando
- [ ] Git instalado e funcionando
- [ ] Azure CLI instalado e funcionando
- [ ] Projeto rodando local (http://localhost:8000)
- [ ] Teste local com PDF funcionou
- [ ] Deploy no Azure concluído
- [ ] Teste no Azure funcionou
- [ ] Projeto publicado no GitHub

---

## 🎉 PARABÉNS!

Você completou com sucesso:

✅ Desenvolveu um projeto Python com FastAPI  
✅ Integrou com Azure OpenAI  
✅ Fez deploy na nuvem Azure  
✅ Publicou no GitHub  
✅ Criou um projeto de portfólio profissional!  

---

## 📚 Próximos Passos

1. **Compartilhe no LinkedIn:**
   - Veja modelo de post em [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)

2. **Adicione ao portfólio:**
   - Link do GitHub no seu currículo
   - Screenshot do projeto rodando

3. **Continue aprendendo:**
   - Leia [ARCHITECTURE.md](ARCHITECTURE.md) para entender a arquitetura
   - Veja [CONTRIBUTING.md](CONTRIBUTING.md) para melhorar o projeto

---

## 🆘 Precisa de Ajuda?

- **Documentação:** [README.md](README.md)
- **Troubleshooting:** [README.md - Troubleshooting](README.md#-troubleshooting)
- **Guia rápido:** [QUICKSTART.md](QUICKSTART.md)
- **Arquitetura:** [ARCHITECTURE.md](ARCHITECTURE.md)

---

**Desenvolvido com ❤️ para aprendizado - 2026**
