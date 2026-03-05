# 🏗️ Arquitetura Detalhada

Este documento descreve a arquitetura técnica do Azure OpenAI PDF Translator LAB.

---

## 📐 Visão Geral da Arquitetura

```
┌─────────────────────────────────────────────────────────────────────┐
│                         USUÁRIO FINAL                               │
└────────────────────────────────┬────────────────────────────────────┘
                                 │
                                 │ HTTPS
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      AZURE WEB APP (Linux)                          │
│                      Python 3.11 + FastAPI                          │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────────────┐     ┌──────────────┐     ┌─────────────────┐    │
│  │  Frontend   │────▶│   Backend    │────▶│   Services      │    │
│  │  (HTML/CSS) │     │   (FastAPI)  │     │   (PDF/Trans)   │    │
│  └─────────────┘     └──────────────┘     └─────────────────┘    │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐  │
│  │            Managed Identity (System-Assigned)               │  │
│  └─────────────────────────────────────────────────────────────┘  │
└────────────────┬────────────────┬────────────────┬─────────────────┘
                 │                │                │
                 │ RBAC           │ API Calls      │ Logs
                 ▼                ▼                ▼
        ┌────────────────┐ ┌──────────────┐ ┌────────────────┐
        │  Key Vault     │ │ Azure OpenAI │ │ App Insights   │
        │  (Secrets)     │ │ (GPT Models) │ │ (Monitoring)   │
        └────────────────┘ └──────────────┘ └────────────────┘
```

---

## 🔄 Fluxo de Processamento

```
1. USER UPLOAD
   │
   ├─▶ Usuário acessa https://<app>.azurewebsites.net
   │   └─▶ Frontend (HTML/CSS) renderizado
   │
   ├─▶ Usuário seleciona PDF (inglês)
   │   └─▶ Clica em "Translate"
   │
   └─▶ POST /translate (multipart/form-data)

2. BACKEND PROCESSING
   │
   ├─▶ FastAPI recebe requisição
   │   └─▶ Valida tipo de arquivo (PDF)
   │   └─▶ Valida tamanho (<2MB)
   │
   ├─▶ Salva arquivo temporário
   │   └─▶ NamedTemporaryFile (OS temp dir)
   │
   └─▶ Chama PDF Service

3. PDF SERVICE
   │
   ├─▶ extract_text_from_pdf(pdf_path)
   │   └─▶ pypdf.PdfReader
   │   └─▶ Loop em páginas
   │   └─▶ Extrai texto
   │
   └─▶ Retorna texto extraído (string)

4. TRANSLATOR SERVICE
   │
   ├─▶ translate_text(text, "en", "pt-BR")
   │
   ├─▶ get_openai_api_key()
   │   ├─▶ Local dev: .env AZURE_OPENAI_API_KEY
   │   └─▶ Azure: Key Vault via Managed Identity
   │
   ├─▶ AsyncAzureOpenAI client
   │   └─▶ chat.completions.create()
   │       └─▶ model: gpt-4o
   │       └─▶ messages: [system, user]
   │       └─▶ temperature: 0.2
   │
   └─▶ Retorna texto traduzido

5. PDF GENERATION
   │
   ├─▶ create_pdf_from_text(translated_text, output_path)
   │   └─▶ reportlab.pdfgen.canvas
   │   └─▶ Escreve texto linha por linha
   │   └─▶ Salva PDF
   │
   └─▶ Retorna caminho do PDF traduzido

6. RESPONSE
   │
   ├─▶ FileResponse(pdf_path)
   │   └─▶ Content-Type: application/pdf
   │   └─▶ Content-Disposition: attachment
   │
   └─▶ BackgroundTask: deleta arquivos temporários

7. USER DOWNLOAD
   │
   └─▶ Navegador baixa PDF traduzido
```

---

## 🗂️ Estrutura de Componentes

### Frontend (Static)

```
app/templates/index.html
├─▶ HTML5 form
│   └─▶ <input type="file" accept=".pdf">
│   └─▶ <button type="submit">Translate</button>
│
app/static/styles.css
└─▶ Estilo responsivo
    └─▶ Container centralizado
    └─▶ Cores Azure Blue
```

### Backend (FastAPI)

```
app/main.py
├─▶ FastAPI app instance
├─▶ StaticFiles mount
├─▶ Jinja2Templates
│
├─▶ GET /
│   └─▶ Renderiza index.html
│
└─▶ POST /translate
    ├─▶ Validação de arquivo
    ├─▶ Extração de texto (PDF Service)
    ├─▶ Tradução (Translator Service)
    ├─▶ Geração de PDF (PDF Service)
    └─▶ Retorno de arquivo
```

### Services

```
app/services/pdf_service.py
├─▶ extract_text_from_pdf(pdf_path)
│   └─▶ pypdf.PdfReader
│   └─▶ for page in reader.pages
│   └─▶ page.extract_text()
│
└─▶ create_pdf_from_text(text, output_path)
    └─▶ reportlab.pdfgen.canvas.Canvas
    └─▶ drawString() para cada linha
    └─▶ c.save()

app/services/translator_service.py
├─▶ get_openai_api_key()
│   ├─▶ Local: os.getenv("AZURE_OPENAI_API_KEY")
│   └─▶ Azure: Key Vault + Managed Identity
│
└─▶ translate_text(text, source, target)
    └─▶ AsyncAzureOpenAI client
    └─▶ chat.completions.create()
```

### Configuration

```
app/config.py
└─▶ Settings (pydantic_settings.BaseSettings)
    ├─▶ MAX_FILE_SIZE_MB
    ├─▶ AZURE_OPENAI_BASE_URL
    ├─▶ AZURE_OPENAI_MODEL_DEPLOYMENT
    ├─▶ AZURE_OPENAI_API_VERSION
    ├─▶ KEY_VAULT_URL
    └─▶ AZURE_OPENAI_API_KEY (local only)
```

---

## 🔐 Fluxo de Autenticação

### Local Development

```
1. Desenvolvedor preenche .env
   └─▶ AZURE_OPENAI_API_KEY=sk-...

2. Settings carrega de .env
   └─▶ settings.AZURE_OPENAI_API_KEY

3. Translator Service usa diretamente
   └─▶ openai.api_key = settings.AZURE_OPENAI_API_KEY
```

### Azure (Produção)

```
1. Web App tem Managed Identity (System-Assigned)
   └─▶ Principal ID gerado automaticamente

2. RBAC: Web App → Key Vault
   └─▶ Role: "Key Vault Secrets User"

3. Translator Service busca secret
   ├─▶ DefaultAzureCredential()
   │   └─▶ Detecta Managed Identity
   │
   ├─▶ SecretClient(vault_url, credential)
   │
   └─▶ client.get_secret("AZURE-OPENAI-API-KEY")
       └─▶ Retorna valor sem expor no código
```

---

## 🏗️ Infraestrutura como Código (Bicep)

```
infra/main.bicep
├─▶ Resource Group (pré-existente)
│
├─▶ App Service Plan
│   └─▶ SKU: F1 (Free)
│   └─▶ Kind: Linux
│
├─▶ Web App
│   ├─▶ Runtime: Python 3.11
│   ├─▶ HTTPS Only: true
│   └─▶ Managed Identity: SystemAssigned
│
├─▶ Key Vault
│   ├─▶ RBAC Enabled: true
│   ├─▶ Soft Delete: true
│   └─▶ Purge Protection: false (para LAB)
│
├─▶ Application Insights
│   └─▶ Application_Type: web
│
├─▶ Azure OpenAI
│   ├─▶ Kind: OpenAI
│   ├─▶ SKU: S0
│   └─▶ Network: Public (para LAB)
│
└─▶ RBAC Assignment
    ├─▶ Principal: Web App Managed Identity
    ├─▶ Role: Key Vault Secrets User
    └─▶ Scope: Key Vault
```

---

## 📊 Matriz de Responsabilidades

| Componente | Responsabilidade | Tecnologia |
|------------|------------------|------------|
| **Frontend** | Interface usuário | HTML5, CSS3, JavaScript |
| **Backend** | API REST | FastAPI, Uvicorn |
| **PDF Service** | Extração/Geração PDF | pypdf, reportlab |
| **Translator Service** | Tradução com IA | Azure OpenAI SDK |
| **Config** | Gerenciamento configuração | pydantic-settings |
| **Key Vault** | Armazenamento segredos | Azure Key Vault |
| **Managed Identity** | Autenticação | Azure AD |
| **App Insights** | Monitoramento | Azure Monitor |
| **IaC** | Automação infraestrutura | Bicep |

---

## 🔄 Ciclo de Vida da Requisição

| Etapa | Tempo Estimado | Componente |
|-------|----------------|------------|
| Upload PDF | <1s | Frontend → Backend |
| Validação | <100ms | FastAPI |
| Extração texto | 1-2s | pypdf |
| Tradução | 5-15s | Azure OpenAI |
| Geração PDF | 1-2s | reportlab |
| Download | <1s | Browser |
| **TOTAL** | **8-20s** | - |

---

## 🔒 Camadas de Segurança

```
┌────────────────────────────────────────────┐
│  Layer 7: Application Security            │
│  - Input validation                        │
│  - File type/size checks                   │
│  - Error handling                          │
└────────────────────────────────────────────┘
                    │
┌────────────────────────────────────────────┐
│  Layer 6: Authentication & Authorization   │
│  - Managed Identity                        │
│  - RBAC                                    │
│  - Key Vault                               │
└────────────────────────────────────────────┘
                    │
┌────────────────────────────────────────────┐
│  Layer 5: Transport Security               │
│  - HTTPS Only                              │
│  - TLS 1.2+                                │
└────────────────────────────────────────────┘
                    │
┌────────────────────────────────────────────┐
│  Layer 4: Platform Security                │
│  - Azure App Service                       │
│  - Azure AD                                │
└────────────────────────────────────────────┘
```

---

## 📈 Escalabilidade (Futura)

```
ATUAL (LAB):
┌────────────┐
│  1 Web App │ → Azure OpenAI
└────────────┘

PRODUÇÃO (Sugerido):
┌────────────────────────────────────┐
│       Azure Front Door (CDN)       │
└─────────────┬──────────────────────┘
              │
┌─────────────▼──────────────────────┐
│  App Gateway + WAF                 │
└─────────────┬──────────────────────┘
              │
      ┌───────┴────────┐
      │                │
┌─────▼─────┐   ┌─────▼─────┐
│ Web App 1 │   │ Web App 2 │
└─────┬─────┘   └─────┬─────┘
      │                │
      └───────┬────────┘
              │
   ┌──────────▼───────────┐
   │   Azure Queue        │
   │   (Async Processing) │
   └──────────┬───────────┘
              │
   ┌──────────▼───────────┐
   │ Function App Workers │
   └──────────────────────┘
```

---

## 🧪 Testes

```
tests/
├─▶ test_main.py
│   └─▶ TestClient(app)
│   └─▶ test_index(): GET /
│
└─▶ test_translator_service.py
    └─▶ @pytest.mark.asyncio
    └─▶ test_translate_text_mock()
        └─▶ monkeypatch
```

---

## 📚 Dependências Críticas

| Biblioteca | Versão | Propósito |
|------------|--------|-----------|
| `fastapi` | 0.110.0 | Framework web |
| `uvicorn` | 0.29.0 | ASGI server |
| `openai` | 1.13.3 | Azure OpenAI SDK |
| `pypdf` | 4.1.0 | PDF reading |
| `reportlab` | 4.1.0 | PDF generation |
| `azure-identity` | 1.15.0 | Managed Identity |
| `azure-keyvault-secrets` | 4.8.0 | Key Vault access |
| `pydantic-settings` | 2.2.1 | Configuration |

---

## 🎯 Design Decisions

### Por que FastAPI?
- Async/await nativo (bom para I/O)
- Type hints e validação automática
- Documentação auto-gerada (Swagger)
- Performance

### Por que pypdf?
- Leve e rápido
- Sem dependências externas
- Boa para PDF texto simples

### Por que reportlab?
- Geração de PDF programática
- Controle total sobre layout
- Amplamente usado

### Por que Managed Identity?
- Sem gestão de chaves
- Rotação automática
- Segurança por padrão
- Integração nativa com Azure

---

**Para mais detalhes, veja [README.md](README.md) e [SECURITY.md](SECURITY.md).**
