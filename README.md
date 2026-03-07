# 📄 Tradutor de PDFs com Azure OpenAI

[![License: MIT](https://img.shields.io/badge/Licença-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.11-3.12](https://img.shields.io/badge/python-3.11--3.12-blue.svg)](https://www.python.org/downloads/)

**Lab prático:** Aprenda a integrar o **Azure OpenAI (GPT)** com FastAPI — criando um **tradutor de PDFs** que extrai texto em inglês e gera uma versão traduzida em português usando IA.

---

## 📋 O que você vai fazer

1. ✅ Subir um PDF em inglês no navegador
2. ✅ Extrair o texto do PDF automaticamente
3. ✅ Enviar para Azure OpenAI traduzir (GPT)
4. ✅ Gerar um novo PDF traduzido em português
5. ✅ Baixar o PDF traduzido

---

## 🤖 O que é o Azure OpenAI?

O [Azure OpenAI Service](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview) é um serviço do Azure que fornece acesso aos modelos da OpenAI (GPT-4o, GPT-4, GPT-3.5, etc.) através de uma API segura e gerenciada pela Microsoft. Diferente da API pública da OpenAI, o Azure OpenAI oferece compliance empresarial, rede privada, controle de acesso (RBAC) e integração nativa com outros serviços Azure.

O Azure OpenAI agora faz parte do **[Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry)** — a plataforma unificada da Microsoft para IA. No portal Azure, ao criar um recurso Azure OpenAI, a opção recomendada é criar um **Foundry resource**, que organiza seus modelos, deployments e projetos em um único lugar.

Neste lab utilizamos o modelo GPT para tradução de texto:

| Feature | O que faz | Exemplo de saída |
|---------|-----------|------------------|
| **Tradução com GPT** | Traduz texto de inglês para português usando IA generativa | "Hello World!" → "Olá Mundo!" |
| **Extração de PDF** | Extrai texto de arquivos PDF (texto embutido, não OCR) | PDF → string de texto |
| **Geração de PDF** | Gera novo PDF com o texto traduzido | Texto PT-BR → PDF formatado |

> **Referências oficiais:**
> - [Azure OpenAI Service](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview)
> - [Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry)
> - [Criar recurso Foundry](https://learn.microsoft.com/en-us/azure/ai-services/multi-service-resource)
> - [Azure OpenAI Models](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models)

### Este app vs. Microsoft Foundry Portal

O Azure também oferece o [Microsoft Foundry Portal](https://ai.azure.com/), uma interface web para testar modelos, criar agentes e prototipar diretamente no navegador sem escrever código.

**A diferença é que este lab é um app Python próprio** que consome a mesma API via SDK — mostrando como integrar o Azure OpenAI em uma aplicação real. No Foundry portal você testa; aqui você aprende a construir.

---

## 💡 Exemplo de Caso de Uso

Imagine que sua empresa trabalha com **documentação técnica em inglês** — manuais, relatórios, white papers. O time precisa traduzir esse conteúdo para português de forma rápida e consistente.

Com este lab, basta fazer upload do PDF, clicar em "Translate" e ter a versão traduzida em segundos. É isso que você vai aprender: **tradução inteligente com IA do Azure**.

---

## 🛠️ Requisitos

- **Seu computador:** Windows 10/11 ou macOS
- **Python:** 3.11 ou 3.12 (⚠️ NÃO use 3.13+/3.14+ — incompatível com a SDK)
- **Git:** Opcional, para clonar o repositório ([baixar aqui](https://git-scm.com/))
- **Conta Azure:** Com recurso Azure OpenAI criado + deployment do modelo
- **VS Code:** Recomendado (opcional)
- **Internet:** Conexão estável

---

## 📖 Como Começar

| Guia | Tempo | Indicado para |
|------|-------|---------------|
| [COMECE AQUI (START_HERE.md)](START_HERE.md) | ~1h | Primeira vez? Comece aqui! |
| [RESUMO RÁPIDO (QUICKSTART.md)](QUICKSTART.md) | ~5 min | Já tem tudo configurado? Rode rápido |

---

## 🎯 Caso esteja começando do zero, vá por aqui:

👉 Leia **[COMECE AQUI (START_HERE.md)](START_HERE.md)** para o guia passo a passo completo!

---

## 🚀 Caso Já Tenha Noções do Funcionamento, Veja o Resumo

Para quem já tem tudo configurado, em resumo será:

```bash
# Clonar o repositório
git clone https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app.git
cd lab-azureopenai-translator-app

# Criar ambiente virtual
python3 -m venv venv
source venv/bin/activate   # macOS/Linux
# venv\Scripts\activate    # Windows

# Instalar dependências
pip install -r requirements.txt

# Criar arquivo .env
cp .env.example .env
# ⚠️ Edite .env e adicione suas credenciais do Azure OpenAI

# Rodar o servidor
uvicorn app.main:app --reload

# Abra no navegador
# http://localhost:8000
```

---

## 📐 Arquitetura

```
Usuário
  │
  │  1. Upload PDF (inglês)
  ▼
┌──────────────────────────┐
│  Frontend (HTML/CSS)     │
│  - Upload de arquivo PDF │
│  - Botão "Translate"     │
└──────────┬───────────────┘
           │ 2. POST /translate
           ▼
┌──────────────────────────┐
│  FastAPI Backend         │
│  ├─ PDF Service          │  3. Extrai texto do PDF
│  ├─ Translator Service   │  4. Chama Azure OpenAI (GPT)
│  └─ PDF Generator        │  5. Gera PDF traduzido (PT-BR)
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│  Azure OpenAI            │
│  (GPT Chat Completions)  │
│  - Modelo: gpt-4o        │
│  - Prompt de tradução    │
│  - EN → PT-BR            │
└──────────────────────────┘
```

---

## ⚙️ Variáveis de Ambiente

Crie um arquivo `.env` baseado em `.env.example`:

```env
AZURE_OPENAI_BASE_URL=https://seu-recurso.openai.azure.com
AZURE_OPENAI_MODEL_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2024-02-15-preview
AZURE_OPENAI_API_KEY=sua-chave-aqui
```

| Variável | Obrigatória | Descrição | Default |
|----------|-------------|-----------|---------|
| `AZURE_OPENAI_BASE_URL` | ✅ | URL do recurso Azure OpenAI | — |
| `AZURE_OPENAI_API_KEY` | ✅ | Chave de acesso (KEY 1 ou KEY 2) | — |
| `AZURE_OPENAI_MODEL_DEPLOYMENT` | ✅ | Nome do deployment do modelo (ex: `gpt-4o`) | — |
| `AZURE_OPENAI_API_VERSION` | ❌ | Versão da API | `2024-02-15-preview` |
| `KEY_VAULT_URL` | ❌ | URL do Key Vault (para uso em produção) | `""` |
| `MAX_FILE_SIZE_MB` | ❌ | Limite de tamanho do PDF em MB | `2` |

⚠️ **Pontos críticos:**
- ✅ A key e o endpoint devem ser copiados exatamente do portal Azure
- ✅ O deployment name deve corresponder ao que foi criado no Microsoft Foundry Portal
- ✅ **Não commite o `.env`!** Ele já está no `.gitignore`

---

## 🏗️ Estrutura do Código

```
lab-azureopenai-translator-app/
├── app/
│   ├── main.py                      # FastAPI — rotas e app principal
│   ├── config.py                    # Configuração via .env
│   ├── services/
│   │   ├── pdf_service.py           # Extração de texto do PDF + geração de PDF traduzido
│   │   └── translator_service.py    # Integração com Azure OpenAI (GPT)
│   ├── templates/
│   │   └── index.html               # Frontend — upload de PDF
│   └── static/
│       └── styles.css               # Estilos
├── tests/
│   ├── test_main.py                 # Testes das rotas
│   ├── test_translator_service.py   # Testes do serviço de tradução
│   └── sample_english.pdf           # PDF de exemplo em inglês (para testes)
├── .env.example                     # Exemplo de variáveis de ambiente
├── .gitignore
├── Makefile                         # Atalhos: make run, make test
├── requirements.txt
├── QUICKSTART.md                    # Resumo rápido (~5 min)
├── START_HERE.md                    # Guia passo a passo completo (~1h)
├── LICENSE                          # MIT
└── README.md                        # Este arquivo
```

**Fluxo de dados:**

1. Usuário faz upload de PDF em inglês via `index.html`
2. `main.py` recebe o arquivo e valida (tipo, tamanho)
3. `pdf_service.py` extrai o texto do PDF
4. `translator_service.py` envia o texto para Azure OpenAI e recebe a tradução
5. `pdf_service.py` gera um novo PDF com o texto traduzido
6. O navegador baixa o PDF traduzido automaticamente

---

## 🧪 Testes

```bash
# Rodar todos os testes
pytest tests/ -v

# Ou via Makefile
make test
```

São **2 testes** cobrindo:
- Rota principal (GET /)
- Serviço de tradução (mock do Azure OpenAI)

> **PDF de teste:** O arquivo `tests/sample_english.pdf` está incluído para testes manuais no navegador.

---

## 📚 Conceitos Aprendidos

✅ Integração com Azure OpenAI (GPT Chat Completions)
✅ SDK `openai` para Python com configuração Azure
✅ Extração e geração de PDF com `pypdf` e `reportlab`
✅ API com FastAPI (upload de arquivo, download de resposta)
✅ Variáveis de ambiente e configuração segura
✅ Tratamento de erros e validação de entrada

---

## ❌ Troubleshooting

### Erro: "AsyncClient.__init__() got an unexpected keyword argument 'proxies'"

**Causa:** Python 3.13+ ou 3.14+ instalado. A SDK `httpcore`/`httpx` usada pelo `openai` é incompatível.

**Solução:** Instale **Python 3.11 ou 3.12**. Desinstale versões mais recentes se necessário.

### Erro: "RuntimeError: Azure OpenAI configuration missing"

**Verificar:**
- ✅ Arquivo `.env` existe na raiz do projeto
- ✅ `AZURE_OPENAI_BASE_URL` e `AZURE_OPENAI_API_KEY` estão preenchidos
- ✅ Sem espaços extras ou aspas nos valores

### Erro: "Azure OpenAI quota exceeded"

**Verificar:**
- ✅ Tente outra região: `Sweden Central`, `France Central`, `Canada East`
- ✅ Use `gpt-4o-mini` em vez de `gpt-4o` (mais quota disponível)

### Erro: "PDF não tem texto extraível"

**Causa:** PDF é uma imagem escaneada (sem OCR).

**Solução:** Use um PDF com texto embutido (criado no Word, Google Docs, etc.).

---

## ⚠️ Aviso Importante sobre Segurança

Este projeto **NÃO possui** as seguintes proteções necessárias para produção:

- 🔓 **Sem autenticação/autorização** — qualquer pessoa com acesso à URL pode usar
- 🔑 **Chave da API em .env** — em produção, use Azure Key Vault ou Managed Identity
- 💾 **Dados em memória** — reiniciar o servidor perde tudo
- 🌐 **Sem HTTPS** — em produção, sempre use HTTPS com certificado válido
- 🛡️ **Sem rate limiting** — sem proteção contra uso excessivo

**Para uso em produção**, considere: autenticação (Azure AD / OAuth), HTTPS, Azure Key Vault para secrets, rate limiting, logging centralizado e monitoramento.

---

## ⚠️ Disclaimer

> **Esta solução foi desenvolvida com finalidade exclusivamente laboratorial e educacional.**
>
> O objetivo deste projeto é demonstrar as capacidades do **Azure OpenAI** — especificamente a tradução de texto usando GPT — e não ensinar boas práticas de desenvolvimento Python ou engenharia de software.
>
> O uso em ambientes de produção deve considerar critérios adicionais de segurança, desempenho, conformidade e manutenção, que **não estão contemplados** neste projeto.

---

## 📄 Licença

MIT. Veja LICENSE.

---

**Desenvolvido com ❤️ para aprendizado — 2026**
