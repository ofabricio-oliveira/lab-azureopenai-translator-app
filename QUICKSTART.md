# ⚡ Guia Rápido de Início (5 minutos)

Se você quer testar o projeto **RAPIDAMENTE** na sua máquina local, siga este guia.

---

## ✅ O Que Você Precisa Ter

- [ ] Windows 10/11/Server 2025
- [ ] Python 3.11+ instalado ([baixar aqui](https://www.python.org/downloads/))
- [ ] Conta Azure com recurso Azure OpenAI criado

---

## 🚀 Passo a Passo Rápido

### 1. Clone o Projeto

```powershell
git clone https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git
cd lab-azureopenai-translator-app
```

---

### 2. Instale Dependências

```powershell
pip install -r requirements.txt
```

⏱️ **Tempo:** ~2 minutos

---

### 3. Configure Variáveis de Ambiente

**Copie o arquivo de exemplo:**

```powershell
copy .env.example .env
```

**Edite o arquivo `.env` com suas credenciais Azure:**

```env
AZURE_OPENAI_BASE_URL=https://SEU-RECURSO.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_API_KEY=SUA_CHAVE_AQUI
```

📍 **Onde encontrar:**
- Acesse [Portal Azure](https://portal.azure.com)
- Vá em **Azure OpenAI** > Seu recurso
- Clique em **"Keys and Endpoint"**
- Copie **Endpoint** e **KEY 1**

---

### 4. Rode o Aplicativo

```powershell
uvicorn app.main:app --reload
```

✅ **Pronto!** Abra: http://localhost:8000

---

### 5. Teste com um PDF

1. Crie um PDF simples em inglês (Word > Salvar como PDF)
2. Faça upload no navegador
3. Clique em **"Translate"**
4. Baixe o PDF traduzido! 🎉

---

## 🆘 Erros Comuns

### `ModuleNotFoundError: No module named 'fastapi'`
**Solução:** `pip install -r requirements.txt`

### `RuntimeError: Azure OpenAI configuration missing`
**Solução:** Verifique se preencheu corretamente o arquivo `.env`

### `RuntimeError: Azure OpenAI API key not found`
**Solução:** Copie a chave do Portal Azure e cole em `AZURE_OPENAI_API_KEY` no `.env`

---

## 📖 Quer Fazer Deploy no Azure?

Veja o guia completo em: [README.md](README.md#-como-fazer-deploy-no-azure)

---

## 🤝 Precisa de Ajuda?

- [README Completo](README.md) - Instruções detalhadas
- [Troubleshooting](README.md#-troubleshooting) - Soluções para problemas
- [Azure OpenAI Docs](https://learn.microsoft.com/azure/ai-services/openai/) - Documentação oficial
