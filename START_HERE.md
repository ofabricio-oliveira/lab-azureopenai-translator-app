# 🎯 GUIA PASSO A PASSO COMPLETO — COMECE AQUI!

## 👋 Bem-vindo!

Você está prestes a construir algo incrível! 🚀

Este é o guia completo para aprender como **integrar Azure OpenAI com Python**. Vamos criar um **tradutor inteligente de PDFs** que usa IA para extrair texto de um PDF em inglês e gerar uma versão traduzida em português!

Perfeito para aprender, experimentar e criar algo legal pro seu portfólio. 💻

---

## 📋 O Que Você Vai Fazer

1. ✅ Instalar Python e dependências
2. ✅ Criar recurso Azure OpenAI e fazer deploy do modelo
3. ✅ Rodar o projeto localmente
4. ✅ Testar com um PDF em inglês

**Tempo total estimado:** ~1 hora (incluindo leitura)

---

## 🚀 ETAPA 1: Preparar o Ambiente (15 minutos)

### 1.1 — Instalar Python

1. Acesse: `https://www.python.org/downloads/`
2. ⚠️ **CRÍTICO:** Baixe **Python 3.11.x ou 3.12.x** (NÃO use 3.13+/3.14+ — causa incompatibilidades com a SDK do OpenAI)
   - Clique em **"Downloads"** no menu
   - Role até **"Looking for a specific release?"**
   - Escolha **"Python 3.12.x"** (versão estável recomendada)
3. Execute o instalador
4. ⚠️ **Marque "Add Python to PATH"** na primeira tela
5. Clique em **"Install Now"**

**Validar:**

```powershell
python --version
# Deve mostrar: Python 3.11.x ou 3.12.x (NÃO 3.14.x)
```

---

### 1.2 — Instalar Git (opcional, para clonar)

1. Acesse: `https://git-scm.com/download/win`
2. Baixe e instale com opções padrão

---

## ☁️ ETAPA 2: Criar Recurso Azure OpenAI (20 minutos)

### 2.1 — Acessar Azure Portal

1. Abra: `https://portal.azure.com`
2. Faça login com sua conta Microsoft

### 2.2 — Criar recurso via Microsoft Foundry

O Azure OpenAI agora é gerenciado pelo **Microsoft Foundry**. Para criar o recurso:

1. Na barra de busca do portal, digite: **"Azure OpenAI"**
2. Clique em **"Azure OpenAI"** nos resultados — você verá a página **"Microsoft Foundry | Azure OpenAI"**
3. Clique em **"+ Create"** — aparecerão duas opções:
   - **Foundry (Recommended)** — cria um recurso Foundry completo ✅
   - **Azure OpenAI** — modo clássico (legado)
4. Selecione **"Foundry (Recommended)"**
5. Na tela **"Create a Foundry resource"**, preencha:
   - **Subscription:** Selecione sua assinatura
   - **Resource group:** Clique "Create new" → `openai-lab-rg`
   - **Name:** `meu-openai-lab-2026` (nome único)
   - **Region:** `East US` (boa disponibilidade de quota)
6. Em **"Your first project"**:
   - **Default project name:** Deixe o padrão `proj-default` ou digite um nome (ex: `pdf-translator-project`)
7. Em **"Content Review Policy"**, leia o aviso e prossiga
8. Clique **"Review + create"** → **"Create"**
9. Aguarde ~2 minutos → **"Go to resource"**

### 2.3 — Obter Endpoint e Key

1. No recurso criado, menu esquerdo: **"Keys and Endpoint"**
2. Copie:
   - **Endpoint:** `https://meu-openai-lab-2026.openai.azure.com/`
   - **KEY 1:** Clique no ícone de copiar

### 2.4 — Criar Deployment do Modelo (GPT)

1. No recurso, menu esquerdo em **"Use with Foundry"**, clique em **"Foundry"** — isso abre o **Microsoft Foundry portal** (`ai.azure.com`)
2. No Foundry portal, no menu esquerdo, clique em **"Deployments"** (ou **"Models + endpoints"**)
3. Clique em **"+ Deploy model"** → **"Deploy base model"**
4. Selecione o modelo **`gpt-4o`** e clique em **"Confirm"**
5. Preencha:
   - **Deployment name:** `gpt-4o` (use o mesmo nome do modelo para facilitar)
   - **Model version:** Deixe `Default` ou `Auto-update to default`
   - **Deployment type:** Standard
6. Clique **"Deploy"**
7. Aguarde até status **"Succeeded"**
8. ✅ Anote o **Deployment name** exato: `gpt-4o`

**⚠️ Problemas comuns:**
- **Erro de quota:** Use `gpt-4o-mini` (tem mais quota disponível)
- **Região sem quota:** Tente `Sweden Central`, `France Central` ou `Canada East`

**💡 Dica:** O deployment name que você criar aqui é o que vai usar no `.env` como `AZURE_OPENAI_MODEL_DEPLOYMENT`

---

## 💻 ETAPA 3: Baixar e Configurar o Projeto (10 minutos)

### 3.1 — Obter o projeto

```powershell
# Se tem Git:
git clone https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git
cd lab-azureopenai-translator-app

# OU: baixe o ZIP e extraia
```

### 3.2 — Criar ambiente virtual

```powershell
# Windows
python -m venv venv
venv\Scripts\activate
```

```bash
# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

### 3.3 — Instalar dependências

```bash
pip install -r requirements.txt
```

Aguarde ~2 minutos.

### 3.4 — Configurar .env

Aqui precisaremos ter um arquivo chamado `.env`, então copie o arquivo `.env.example` e renomeie para `.env`.

```powershell
copy .env.example .env
```

```bash
# macOS/Linux
cp .env.example .env
```

Edite o `.env` com os valores copiados na Etapa 2:

```env
AZURE_OPENAI_BASE_URL=https://meu-openai-lab-2026.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_API_KEY=sua-chave-copiada-aqui
```

Após editar o arquivo, salve-o.

> **💡 Nota:** As variáveis `KEY_VAULT_URL` e `MAX_FILE_SIZE_MB` são opcionais. Deixe `KEY_VAULT_URL` vazio para uso local.

---

## 🎮 ETAPA 4: Rodar o Projeto (5 minutos)

```bash
uvicorn app.main:app --reload
```

Saída esperada:

```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
INFO:     Application startup complete.
```

✅ O servidor está rodando!

---

## 🧪 ETAPA 5: Testar com um PDF (10 minutos)

### 5.1 — Criar um PDF de teste

Se você não tem um PDF em inglês, crie um:

1. Abra o **Word** ou **Google Docs**
2. Escreva um texto em inglês:

```
Hello World!

This is a simple test document for the Azure OpenAI PDF Translator.
The translator will convert this English text to Portuguese using AI.

Thank you for testing this project!
```

3. Salve como PDF (**File > Save As > PDF**)

### 5.2 — Testar no navegador

1. Abra: `http://localhost:8000`
2. Você verá a página **"PDF Translator (Azure OpenAI LAB)"**
3. Clique em **"Choose File"** e selecione o PDF em inglês
4. Clique em **"Translate"**
5. Aguarde 10-30 segundos
6. O navegador **baixará automaticamente** o PDF traduzido!

### 5.3 — Verificar resultado

Abra o PDF baixado e verifique se o texto está em português:

```
Olá Mundo!

Este é um documento de teste simples para o Tradutor de PDF Azure OpenAI.
O tradutor converterá este texto em inglês para português usando IA.

Obrigado por testar este projeto!
```

✅ **Funcionou? Parabéns!**

---

## ✅ CHECKLIST FINAL

- [ ] Python 3.11 ou 3.12 instalado e funcionando
- [ ] Recurso Azure OpenAI criado
- [ ] Deployment do modelo (`gpt-4o`) criado
- [ ] Endpoint e key configurados no `.env`
- [ ] Servidor rodando (`http://localhost:8000`)
- [ ] Teste com PDF funcionou (tradução EN → PT)

---

## 🎉 PARABÉNS!

Você completou o lab com sucesso:

✅ Integrou com Azure OpenAI (GPT)
✅ Extraiu texto de PDF com Python
✅ Traduziu conteúdo usando IA
✅ Gerou PDF traduzido automaticamente
✅ Criou um projeto de portfólio!

---

## 📚 Próximos Passos

1. **Experimente:** Teste com PDFs diferentes (artigos, documentação técnica, etc.)
2. **Modelos:** Teste com `gpt-4o-mini` (mais rápido e barato) ou outros modelos
3. **Compartilhe:** Adicione ao seu GitHub e portfólio

---

## 🆘 Precisa de Ajuda?

- **Documentação completa:** [README.md](README.md)
- **Resumo rápido:** [QUICKSTART.md](QUICKSTART.md)
- **Mais conteúdo:** [fabricio.tech](https://fabricio.tech)

---

**Desenvolvido com ❤️ para aprendizado — 2026**

📌 Mais conteúdo em [fabricio.tech](https://fabricio.tech)
