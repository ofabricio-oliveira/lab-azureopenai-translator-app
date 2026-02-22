# 🎯 Tradutor de PDF com Azure OpenAI

[![License: MIT](https://img.shields.io/badge/Licença-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.11-3.12](https://img.shields.io/badge/python-3.11--3.12-blue.svg)](https://www.python.org/downloads/)

**Lab prático:** Aprenda a integrar Azure OpenAI com FastAPI para traduzir PDFs de inglês para português.

---

## 📋 O que você vai fazer

1. ✅ Recebe PDF em inglês pelo navegador
2. ✅ Extrai o texto do PDF
3. ✅ Envia para Azure OpenAI traduzir
4. ✅ Gera novo PDF em português
5. ✅ Baixa o PDF traduzido

---

## 💼 Caso de Uso Real

Imagina que sua equipe recebe **documentos técnicos em inglês todos os dias** de parceiros e clientes. Você precisa compartilhá-los em português com stakeholders, mas copiar de um PDF, traduzir manualmente e formatar é lento e propenso a erros.

**Com este projeto:** Você sobe o PDF inglês no navegador, clica "Traduzir", e em 30 segundos tem um PDF completo em português pronto para download.

É isso que você vai aprender: **automação real com IA**.

---

## 🛠️ Requisitos

- **Seu computador:** Windows 10/11 ou Windows Server 2025
- **Python:** 3.11 ou 3.12 (⚠️ NÃO use 3.13+ ou 3.14+)
- **Conta Azure:** Com recurso Azure OpenAI criado
- **VS Code:** Recomendado (opcional)
- **Internet:** Conexão estável

---

## 📖 Como Começar

| Guia | Tempo | Para quem |
|------|-------|----------|
| **[COMECE AQUI (START_HERE.md)](START_HERE.md)** | ~2h | Primeira vez? Comece aqui! |
| **[RESUMO RÁPIDO (QUICKSTART.md)](QUICKSTART.md)** | ~10 min | Já tem tudo? Rode rápido |
| **[GITHUB (GITHUB_SETUP.md)](GITHUB_SETUP.md)** | ~30 min | Pronto pra publicar? |

---

## 🚀 Como Rodar (Resumo)

Para quem já tem tudo configurado:

```powershell
# Instalar dependências
pip install -r requirements.txt

# Criar arquivo .env
copy .env.example .env
# ⚠️ Edite .env e adicione suas credenciais do Azure

# Rodar o servidor
uvicorn app.main:app --reload

# Abra no navegador
# http://localhost:8000
```

---

## ⚙️ Variáveis de Ambiente

Crie um arquivo `.env` baseado em `.env.example`:

```env
AZURE_OPENAI_BASE_URL=https://seu-recurso.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-12-01-preview
AZURE_OPENAI_API_KEY=sua-chave-api-aqui
MAX_FILE_SIZE_MB=2
```

**⚠️ Pontos críticos:**

- ✅ `AZURE_OPENAI_BASE_URL` NÃO deve terminar com `/`
- ✅ `AZURE_OPENAI_MODEL_DEPLOYMENT` é **case-sensitive** (use exato do Azure AI Foundry)
- ✅ `AZURE_OPENAI_API_VERSION` deve ser `2024-12-01-preview`

---

## 🏗️ Estrutura do Código

```
app/
├── main.py                    # FastAPI - roteiros
├── config.py                  # Carrega variáveis de ambiente
├── services/
│   ├── pdf_service.py         # Extrai e gera PDFs
│   └── translator_service.py  # Chama Azure OpenAI
├── templates/
│   └── index.html             # Formulário de upload
└── static/
    └── styles.css             # Estilos
```

**Fluxo de dados:**

1. Usuário faz upload no `index.html`
2. `main.py` recebe e valida
3. `pdf_service.py` extrai texto
4. `translator_service.py` traduz com Azure OpenAI
5. `pdf_service.py` gera novo PDF
6. Navegador baixa arquivo

---

## 📚 Conceitos Aprendidos

✅ Integração com Azure OpenAI  
✅ Processamento de PDFs em Python  
✅ API Assíncrona com FastAPI  
✅ Variáveis de ambiente e configurações  
✅ Arquivos e requisitos  
✅ Publicação no GitHub para portfólio  

---

## ❌ Troubleshooting

### Erro: "404 Resource Not Found"

**Verificar:**
- ✅ `AZURE_OPENAI_BASE_URL` corresponde ao recurso Azure
- ✅ `AZURE_OPENAI_MODEL_DEPLOYMENT` é o nome EXATO do deployment (verifique em Azure AI Foundry)
- ✅ `AZURE_OPENAI_API_VERSION` é `2024-12-01-preview`
- ✅ Não há `/` no final de `AZURE_OPENAI_BASE_URL`

### Erro: "AsyncClient got unexpected keyword argument 'proxies'"

**Solução:** Você tem Python 3.14. Use Python 3.12:

```powershell
python --version
python -m pip install --upgrade pip
pip install -r requirements.txt
```

### Aviso: "CryptographyDeprecationWarning from pypdf"

**Informação:** É apenas um aviso de uma dependência. Não afeta o funcionamento.

---

## 📄 Licença

MIT. Veja [LICENSE](LICENSE).

---

## 🎯 Próxima Etapa

👉 **Leia [COMECE AQUI (START_HERE.md)](START_HERE.md)** para o guia passo a passo completo!
