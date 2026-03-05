# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [1.0.0] - 2026-02-21

### ✨ Adicionado
- Implementação inicial do Azure OpenAI PDF Translator LAB
- Backend FastAPI com endpoints de upload e tradução
- Frontend HTML/CSS simples e responsivo
- Extração de texto de PDF usando pypdf
- Geração de PDF traduzido usando reportlab
- Integração com Azure OpenAI usando SDK v1+
- Suporte a Managed Identity para acesso seguro ao Key Vault
- Infraestrutura como Código (Bicep) para deploy automatizado
- Scripts de deploy para PowerShell e Bash
- Testes unitários com pytest
- Documentação completa em PT-BR e EN
- Guia de configuração do GitHub
- Guia rápido de início (QUICKSTART.md)
- Arquivo .gitignore configurado
- Licença MIT

### 🔒 Segurança
- Managed Identity para autenticação sem senhas
- Segredos armazenados no Azure Key Vault
- RBAC (Role-Based Access Control)
- HTTPS obrigatório no Web App
- Validação de tipo e tamanho de arquivo
- Sem hardcode de credenciais
- .env.example sem valores reais

### 📚 Documentação
- README.md bilíngue (PT-BR/EN)
- QUICKSTART.md para início rápido
- GITHUB_SETUP.md para publicação no GitHub
- CONTRIBUTING.md com diretrizes
- Comentários em inglês no código
- Docstrings detalhadas

### 🏗️ Infraestrutura
- App Service Plan (Free F1)
- Web App Linux (Python 3.11)
- Azure Key Vault
- Azure OpenAI
- Application Insights
- Resource Group
- RBAC assignments

### ⚠️ Limitações Conhecidas
- Não preserva layout original do PDF
- Sem autenticação de usuário final
- Sem processamento assíncrono
- Sem banco de dados
- Apenas PDF texto simples (sem OCR)
- Limite de 2MB por arquivo
- Free tier (não otimizado para produção)

---

## [Unreleased]

### 🔮 Planejado para Futuras Versões
- Suporte a múltiplas páginas
- Suporte a múltiplos idiomas
- Processamento assíncrono com Azure Queue Storage
- Preservação de layout com pdf2image + OCR
- Autenticação com Azure AD
- Interface UI/UX melhorada
- API REST completa com documentação Swagger
- Rate limiting
- Monitoramento avançado
- Testes E2E com Playwright

---

[1.0.0]: https://github.com/ofabricio-oliveira/lab-azureopenai-translator-app/releases/tag/v1.0.0
