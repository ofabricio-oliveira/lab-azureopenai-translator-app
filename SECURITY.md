# Política de Segurança

## 🔒 Versões Suportadas

Este projeto é um LAB educacional. Atualmente, apenas a versão mais recente recebe atualizações de segurança.

| Versão | Suportada          |
| ------ | ------------------ |
| 1.0.x  | :white_check_mark: |

---

## 🚨 Reportar Vulnerabilidades

Se você descobrir uma vulnerabilidade de segurança, **NÃO abra uma Issue pública**.

### Como Reportar

1. **Envie um email para:** (adicione seu email aqui)
2. **OU abra uma** [Security Advisory](../../security/advisories/new)
3. **Inclua:**
   - Descrição da vulnerabilidade
   - Passos para reproduzir
   - Impacto potencial
   - Sugestão de correção (se tiver)

### O Que Esperar

- **Confirmação:** Dentro de 48 horas
- **Análise:** Dentro de 7 dias
- **Correção:** Depende da severidade
- **Divulgação:** Após correção implementada

---

## 🛡️ Práticas de Segurança Implementadas

Este projeto implementa as seguintes práticas de segurança:

### ✅ Gerenciamento de Segredos

- **Azure Key Vault:** Segredos (API keys) armazenados de forma segura
- **Managed Identity:** Autenticação sem senhas ou chaves hardcoded
- **Environment Variables:** Configurações sensíveis via variáveis de ambiente
- **`.env.example`:** Template sem valores reais
- **`.gitignore`:** Impede commit de arquivos sensíveis

### ✅ Controle de Acesso

- **RBAC (Role-Based Access Control):** Controle granular de permissões
- **Principle of Least Privilege:** Permissões mínimas necessárias
- **HTTPS Only:** Web App aceita apenas conexões HTTPS

### ✅ Validação de Entrada

- **File Type Validation:** Aceita apenas PDFs
- **File Size Limit:** Máximo 2MB
- **MIME Type Check:** Valida Content-Type

### ✅ Proteção de Dados

- **Temporary Files:** Arquivos deletados após processamento
- **No Database:** Sem armazenamento persistente de dados do usuário
- **Background Tasks:** Limpeza automática de arquivos temporários

### ✅ Logging e Monitoramento

- **Application Insights:** Monitoramento de aplicação
- **Structured Logging:** Logs sem expor segredos
- **Error Handling:** Tratamento adequado de exceções

---

## ⚠️ Limitações de Segurança (LAB)

Este é um **LAB educacional**, não uma aplicação de produção. As seguintes limitações existem:

### ❌ Não Implementado

- **Autenticação de Usuário:** Sem login/senha
- **Rate Limiting:** Sem limite de requisições por IP
- **WAF:** Sem Web Application Firewall
- **DDoS Protection:** Sem proteção contra DDoS
- **Input Sanitization Avançada:** Validação básica apenas
- **Private Endpoints:** Recursos acessíveis publicamente
- **Network Isolation:** Sem VNET privada
- **Data Encryption at Rest:** Apenas encryption in transit (HTTPS)

### 🔧 Para Produção, Adicione

Se você for usar este código em produção, implemente:

1. **Autenticação e Autorização:**
   - Azure AD / OAuth 2.0
   - JWT tokens
   - Role-based access

2. **Rate Limiting:**
   - Azure API Management
   - Throttling policies

3. **Network Security:**
   - Azure Virtual Network (VNET)
   - Private Endpoints
   - Network Security Groups (NSG)

4. **WAF e DDoS:**
   - Azure Application Gateway + WAF
   - Azure DDoS Protection

5. **Data Protection:**
   - Azure Storage encryption at rest
   - Customer-managed keys (CMK)
   - Data masking

6. **Compliance:**
   - GDPR compliance
   - Data residency
   - Audit logging

7. **Input Validation:**
   - Advanced sanitization
   - OCR security scanning
   - Content Security Policy (CSP)

8. **Monitoring:**
   - Advanced threat detection
   - Security alerts
   - SIEM integration

---

## 📚 Recursos de Segurança

- [Azure Security Best Practices](https://learn.microsoft.com/azure/security/fundamentals/best-practices-and-patterns)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Azure Key Vault Best Practices](https://learn.microsoft.com/azure/key-vault/general/best-practices)
- [Managed Identity Overview](https://learn.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview)
- [FastAPI Security](https://fastapi.tiangolo.com/tutorial/security/)

---

## 🔍 Auditoria de Segurança

Última auditoria: 2026-02-21

**Ferramentas recomendadas para auditoria:**
- `bandit` - Python security linter
- `safety` - Python dependency checker
- `trivy` - Container security scanner
- Azure Security Center

**Executar auditoria local:**
```bash
pip install bandit safety
bandit -r app/
safety check -r requirements.txt
```

---

## 📝 Histórico de Vulnerabilidades

Nenhuma vulnerabilidade reportada até o momento.

---

**Obrigado por ajudar a manter este projeto seguro! 🛡️**
