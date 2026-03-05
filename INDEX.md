# 📖 Índice de Navegação - Guia Completo do Projeto

Este documento orienta você sobre **QUAL ARQUIVO LER PRIMEIRO** e quando usar cada documento.

---

## 🚨 PROBLEMA URGENTE?

### ❌ "Erro: AsyncClient got unexpected keyword argument 'proxies'"

➡️ **SOLUÇÃO AUTOMÁTICA (RECOMENDADO):**

**Windows PowerShell (como Admin):**
```powershell
.\fix-python-complete.ps1
```

📖 **Documentação:** [SCRIPTS_README.md](SCRIPTS_README.md)

**OU manual:** [PYTHON_3.14_FIX.md](PYTHON_3.14_FIX.md)

**Causa:** Python 3.14 (incompatível).  
**Fix:** Script desinstala 3.14 + instala 3.12 automaticamente (5 min).

---

## 🎯 Você Está em um Destes Cenários?

### 🆕 "Acabei de abrir o projeto, por onde começo?"

➡️ **Leia:** [START_HERE.md](START_HERE.md)

Este é o **guia definitivo passo a passo** que cobre:
- Instalação de Python 3.12 (NÃO 3.14), Git, Azure CLI
- Como rodar localmente
- Como fazer deploy no Azure
- Como publicar no GitHub

**Tempo:** ~2 horas (fazendo tudo)

---

### ⚡ "Quero testar RÁPIDO, sem ler muito"

➡️ **Leia:** [QUICKSTART.md](QUICKSTART.md)

Guia super rápido (5 minutos) para rodar localmente se você já tem Python 3.12 instalado.

⚠️ **ATENÇÃO:** Se tiver Python 3.14, leia [PYTHON_3.14_FIX.md](PYTHON_3.14_FIX.md) primeiro.

---

### 📚 "Quero entender o projeto em detalhes"

➡️ **Leia nesta ordem:**

1. [README.md](README.md) - Documentação principal (bilíngue PT-BR/EN)
2. [ARCHITECTURE.md](ARCHITECTURE.md) - Arquitetura técnica detalhada
3. [SECURITY.md](SECURITY.md) - Políticas de segurança

---

### 🐙 "Quero publicar no GitHub"

➡️ **Leia:** [GITHUB_SETUP.md](GITHUB_SETUP.md)

Guia passo a passo:
- Como criar repositório
- Como fazer push
- Como configurar tokens
- Como adicionar tags/topics

---

### 🤝 "Quero contribuir para o projeto"

➡️ **Leia:** [CONTRIBUTING.md](CONTRIBUTING.md)

Aprenda:
- Como fazer fork
- Padrões de código
- Como abrir Pull Requests
- Conventional Commits

---

### 🔒 "Quero reportar um problema de segurança"

➡️ **Leia:** [SECURITY.md](SECURITY.md)

Veja como reportar vulnerabilidades de forma responsável.

---

### 📝 "Quero ver o histórico de mudanças"

➡️ **Leia:** [CHANGELOG.md](CHANGELOG.md)

Todas as versões e mudanças documentadas.

---

### 📊 "Quero uma visão geral do projeto"

➡️ **Leia:** [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)

Resumo executivo:
- Estatísticas
- Checklist
- O que está incluído
- Próximos passos

---

## 📂 Navegação por Tipo de Arquivo

### 📖 Documentação (Leitura)

| Arquivo | Quando Usar | Tempo de Leitura |
|---------|-------------|------------------|
| [START_HERE.md](START_HERE.md) | **Primeira vez** - Guia completo | 10 min (ler) |
| [README.md](README.md) | Documentação principal | 15 min |
| [QUICKSTART.md](QUICKSTART.md) | Teste rápido | 2 min |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Entender arquitetura | 10 min |
| [GITHUB_SETUP.md](GITHUB_SETUP.md) | Publicar no GitHub | 5 min |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribuir | 5 min |
| [SECURITY.md](SECURITY.md) | Segurança | 5 min |
| [CHANGELOG.md](CHANGELOG.md) | Ver versões | 2 min |
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | Visão geral | 5 min |

---

### 💻 Código (Desenvolvimento)

| Arquivo/Pasta | Descrição | Quando Mexer |
|---------------|-----------|--------------|
| `app/main.py` | Backend FastAPI principal | Adicionar endpoints |
| `app/config.py` | Configurações | Adicionar variáveis |
| `app/services/pdf_service.py` | Extração/geração PDF | Melhorar PDF |
| `app/services/translator_service.py` | Tradução Azure OpenAI | Alterar prompt |
| `app/templates/index.html` | Frontend HTML | Mudar interface |
| `app/static/styles.css` | Estilos CSS | Mudar visual |

---

### 🏗️ Infraestrutura (DevOps)

| Arquivo | Descrição | Quando Usar |
|---------|-----------|-------------|
| `infra/main.bicep` | Infraestrutura Azure | Adicionar recursos |
| `infra/parameters.json` | Parâmetros padrão | Mudar região/SKU |
| `scripts/deploy.sh` | Deploy Linux/macOS | Fazer deploy |
| `scripts/deploy.ps1` | Deploy Windows | Fazer deploy |

---

### 🧪 Testes (Qualidade)

| Arquivo | Descrição | Quando Usar |
|---------|-----------|-------------|
| `tests/test_main.py` | Testes do backend | Adicionar testes API |
| `tests/test_translator_service.py` | Testes de tradução | Testar tradutor |

---

### ⚙️ Configuração

| Arquivo | Descrição | Quando Mexer |
|---------|-----------|--------------|
| `.env.example` | Template de config | **NUNCA** (é template) |
| `.env` | Config local **PRIVADO** | Sempre (local) |
| `.gitignore` | Arquivos ignorados | Adicionar exclusões |
| `requirements.txt` | Dependências Python | Adicionar libs |
| `Makefile` | Comandos úteis | Adicionar atalhos |

---

## 🗺️ Fluxo de Trabalho Sugerido

### Para Iniciantes

```
1. START_HERE.md           (Guia completo)
   ↓
2. Instalar requisitos     (Python, Git, Azure CLI)
   ↓
3. Rodar localmente        (uvicorn app.main:app)
   ↓
4. Testar com PDF          (http://localhost:8000)
   ↓
5. README.md               (Entender melhor)
   ↓
6. Deploy no Azure         (scripts/deploy.ps1)
   ↓
7. GITHUB_SETUP.md         (Publicar)
```

---

### Para Desenvolvedores

```
1. QUICKSTART.md           (Setup rápido)
   ↓
2. ARCHITECTURE.md         (Entender estrutura)
   ↓
3. Código em app/          (Desenvolver)
   ↓
4. tests/                  (Testar)
   ↓
5. CONTRIBUTING.md         (Seguir padrões)
   ↓
6. Git commit/push         (Versionamento)
```

---

### Para DevOps/SRE

```
1. README.md               (Visão geral)
   ↓
2. ARCHITECTURE.md         (Arquitetura)
   ↓
3. SECURITY.md             (Políticas)
   ↓
4. infra/main.bicep        (Infraestrutura)
   ↓
5. scripts/deploy.ps1      (Automação)
   ↓
6. Deploy no Azure         (Produção)
```

---

## 🔍 Busca Rápida

### "Como fazer X?"

| Pergunta | Resposta Está Em |
|----------|------------------|
| Como rodar local? | [START_HERE.md](START_HERE.md#-etapa-5-rodar-o-projeto-localmente-5-minutos) |
| Como fazer deploy? | [START_HERE.md](START_HERE.md#️-etapa-7-deploy-no-azure-40-minutos) |
| Como publicar no GitHub? | [GITHUB_SETUP.md](GITHUB_SETUP.md) |
| Qual a arquitetura? | [ARCHITECTURE.md](ARCHITECTURE.md) |
| Como contribuir? | [CONTRIBUTING.md](CONTRIBUTING.md) |
| Como relatar bug? | [CONTRIBUTING.md - Reportar Bugs](CONTRIBUTING.md#-reportar-bugs) |
| Quais dependências? | [requirements.txt](requirements.txt) |
| Como configurar .env? | [START_HERE.md](START_HERE.md#45---configurar-env-local) |
| Como limpar recursos Azure? | [README.md - Cleanup](README.md#-cleanup) |

---

## 📱 Atalhos por Persona

### 👨‍🎓 Estudante

**Objetivo:** Aprender e colocar no portfólio

1. [START_HERE.md](START_HERE.md) - Siga TUDO passo a passo
2. [ARCHITECTURE.md](ARCHITECTURE.md) - Entenda como funciona
3. [GITHUB_SETUP.md](GITHUB_SETUP.md) - Publique no GitHub
4. [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Use para LinkedIn

---

### 👨‍💻 Desenvolvedor

**Objetivo:** Contribuir ou usar como base

1. [QUICKSTART.md](QUICKSTART.md) - Setup rápido
2. [ARCHITECTURE.md](ARCHITECTURE.md) - Entender código
3. [CONTRIBUTING.md](CONTRIBUTING.md) - Padrões
4. `app/` - Código fonte

---

### 🔧 DevOps/SRE

**Objetivo:** Deploy e manutenção

1. [README.md](README.md) - Overview
2. [SECURITY.md](SECURITY.md) - Políticas
3. `infra/` - Bicep templates
4. `scripts/` - Automação

---

### 💼 Recrutador/Tech Lead

**Objetivo:** Avaliar qualidade

1. [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Visão geral
2. [README.md](README.md) - Documentação
3. [ARCHITECTURE.md](ARCHITECTURE.md) - Decisões técnicas
4. [SECURITY.md](SECURITY.md) - Práticas de segurança

---

## 🚀 Ações Rápidas

| Quero... | Comando |
|----------|---------|
| Rodar local | `uvicorn app.main:app --reload` |
| Rodar testes | `pytest tests/` |
| Ver logs | Veja terminal ou Azure Portal |
| Deploy Azure | `.\scripts\deploy.ps1 -subscriptionId X -location Y -prefix Z` |
| Ver versão | Veja [CHANGELOG.md](CHANGELOG.md) |

---

## 📞 Precisa de Ajuda?

1. **Primeiro:** Procure neste índice
2. **Depois:** Leia o arquivo relevante
3. **Ainda com dúvida:** Veja [README.md - Troubleshooting](README.md#-troubleshooting)
4. **Não resolveu:** Abra uma Issue no GitHub

---

## 🎯 Resumo

- **Iniciante?** → [START_HERE.md](START_HERE.md)
- **Rápido?** → [QUICKSTART.md](QUICKSTART.md)
- **Técnico?** → [ARCHITECTURE.md](ARCHITECTURE.md)
- **GitHub?** → [GITHUB_SETUP.md](GITHUB_SETUP.md)
- **Contribuir?** → [CONTRIBUTING.md](CONTRIBUTING.md)

---

**Boa sorte com o projeto! 🚀**
