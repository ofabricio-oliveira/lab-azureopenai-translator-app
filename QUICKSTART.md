# ⚡ RESUMO RÁPIDO (5 minutos)

Para quem **já tem tudo pronto** (Python, Git, Azure OpenAI configurado).

---

## 📋 Requisitos

- Windows 10/11 ou Windows Server 2025
- Python 3.11 ou 3.12
- Recurso Azure OpenAI + deployment criado
- VS Code (opcional)

---

## 🚀 Passos

### 1. Abra a pasta do projeto

```powershell
cd C:\seu\caminho\do\projeto
```

### 2. Instale dependências

```powershell
python -m pip install --upgrade pip
pip install -r requirements.txt
```

Espere ~2 minutos.

### 3. Configure .env

```powershell
copy .env.example .env
```

Abra `.env` e preencha com suas credenciais do Azure:

```env
AZURE_OPENAI_BASE_URL=https://seu-recurso.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-12-01-preview
AZURE_OPENAI_API_KEY=sua-chave-aqui
MAX_FILE_SIZE_MB=2
```

### 4. Rode o servidor

```powershell
uvicorn app.main:app --reload
```

Saída esperada:
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
```

### 5. Teste no navegador

1. Abra: `http://localhost:8000`
2. Upload de um PDF em inglês
3. Clique em **"Traduzir"**
4. Baixe o PDF em português

✅ **Pronto!**

---

## 🆘 Precisa de ajuda?

- **Guia completo:** [COMECE AQUI (START_HERE.md)](START_HERE.md)
- **Documentação:** [README.md](README.md)
