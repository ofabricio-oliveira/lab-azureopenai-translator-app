# ⚡ RESUMO RÁPIDO (5 minutos)

Para quem **já tem tudo pronto** (Python 3.11/3.12, Azure OpenAI configurado).

---

## 📋 Requisitos

- Python 3.11 ou 3.12 (NÃO 3.13+/3.14+)
- Recurso Azure OpenAI criado (endpoint + key + deployment)
- VS Code (opcional)

---

## 🚀 Passos

### 1. Abra a pasta do projeto

```powershell
cd C:\seu\caminho\lab-azureopenai-translator-app
```

### 2. Crie ambiente virtual e instale dependências

```powershell
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

```bash
# macOS/Linux
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 3. Configure .env

```powershell
copy .env.example .env
```

```bash
# macOS/Linux
cp .env.example .env
```

Abra `.env` e preencha:

```env
AZURE_OPENAI_BASE_URL=https://seu-recurso.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_API_KEY=sua-chave-aqui
```

### 4. Rode o servidor

```bash
uvicorn app.main:app --reload
```

Saída esperada:
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
```

### 5. Teste no navegador

1. Abra: `http://localhost:8000`
2. Faça upload de um PDF em inglês (texto simples, 1 página)
3. Clique em **"Translate"**
4. Aguarde 10-30 segundos
5. Baixe o PDF traduzido! 🎉

✅ **Pronto!**

---

## 🆘 Precisa de ajuda?

- **Guia completo:** [COMECE AQUI (START_HERE.md)](START_HERE.md)
- **Documentação:** [README.md](README.md)
