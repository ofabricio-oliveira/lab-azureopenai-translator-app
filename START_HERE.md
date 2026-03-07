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

1. No recurso criado, no menu esquerdo, expanda a seção **"Resource Management"**
2. Clique em **"Keys and Endpoint"**
3. Copie:
   - **Endpoint:** `https://meu-openai-lab-2026.openai.azure.com/`
   - **KEY 1:** Clique no ícone de copiar

> **💡 Guarde esses valores!** Você vai precisar deles na Etapa 3.4 para configurar o `.env`.

### 2.4 — Acessar o Microsoft Foundry Portal

Para criar o deployment do modelo, precisamos ir ao **Microsoft Foundry Portal**.

1. Ainda na página do recurso no Azure Portal, clique no botão **"Go to Foundry Portal"** (na parte superior da página)
   - Isso abre o portal em `ai.azure.com`

> **📝 O que é o Microsoft Foundry Portal?**
>
> O [Microsoft Foundry](https://ai.azure.com) é a plataforma unificada da Microsoft para IA. É onde você gerencia **modelos**, **deployments**, **agentes de IA** e **projetos**. Pense nele como o "painel de controle" dos seus recursos de IA no Azure.
>
> Neste lab, vamos usá-lo apenas para **criar o deployment do modelo GPT** — que é o passo que permite chamar o modelo via API.

### 2.5 — Criar Deployment do Modelo (GPT)

Já dentro do Microsoft Foundry Portal:

1. No menu esquerdo, clique em **"Models + endpoints"** (seção **"My assets"**)
2. Clique em **"+ Deploy model"** → **"Deploy base model"**
3. Na lista de modelos, selecione **`gpt-4o`** e clique em **"Confirm"**

> **🤖 Por que o GPT-4o?**
>
> Escolhemos o `gpt-4o` por ser um modelo com **boa qualidade de tradução**, **amplamente disponível** nas regiões do Azure e com **quota acessível** para labs. Você pode usar outro modelo disponível na sua região — o importante é anotar o nome do deployment para configurar no `.env`.

4. Preencha:
   - **Deployment name:** `gpt-4o` (use o mesmo nome do modelo para facilitar)
   - **Deployment type:** Altere para **Standard**

> **⚙️ Por que Standard e não Global-Standard?**
>
> O portal seleciona **Global-Standard** por padrão. Essa opção roteia suas chamadas por **data centers ao redor do mundo**, o que significa que seus dados podem ser processados em qualquer região. Para um lab de aprendizado, funciona — mas em cenários reais, muitas empresas exigem que os dados fiquem em uma **região específica** (ex: compliance, LGPD).
>
> Escolhemos **Standard** porque o deployment fica **fixo na região que você escolheu** (ex: East US), garantindo previsibilidade e controle sobre onde seus dados são processados.

5. Clique **"Deploy"**
6. Aguarde até status **"Succeeded"**
7. ✅ Anote o **Deployment name** exato: `gpt-4o`

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
AZURE_OPENAI_API_VERSION=2024-12-01-preview
AZURE_OPENAI_API_KEY=sua-chave-copiada-aqui
```

Após editar o arquivo, salve-o.

> **📌 Onde encontrar a `API_VERSION`?** No Microsoft Foundry Portal, vá em **"Models + endpoints"** → clique no seu deployment (`gpt-4o`) → na seção **"Get Started"**, o código de exemplo mostra o valor de `api_version`. Use esse valor.

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

### 5.1 — PDF de teste

O projeto já inclui um PDF de exemplo em inglês pronto para uso:

```
tests/sample_english.pdf
```

Você pode usar esse arquivo diretamente para testar. 🎯

> **Alternativa:** Se preferir, crie seu próprio PDF:
> 1. Abra o **Word** ou **Google Docs**
> 2. Escreva um texto em inglês (ex: "Hello World! This is a test document.")
> 3. Salve como PDF (**File > Save As > PDF**)

### 5.2 — Testar no navegador

1. Abra: `http://localhost:8000`
2. Você verá a página **"PDF Translator (Azure OpenAI LAB)"**
3. Clique em **"Choose File"** e selecione o `tests/sample_english.pdf` (ou seu próprio PDF)
4. Clique em **"Translate"**
5. Aguarde 10-30 segundos
6. O navegador **baixará automaticamente** o PDF traduzido!

### 5.3 — Verificar resultado

Abra o PDF baixado e verifique se o texto foi traduzido para português.

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
