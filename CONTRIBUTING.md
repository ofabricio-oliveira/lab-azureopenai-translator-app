# Contribuindo para Azure OpenAI PDF Translator LAB

Obrigado por considerar contribuir para este projeto! 🎉

Este é um projeto educacional focado em portfólio e aprendizado. Contribuições são bem-vindas!

---

## 🤝 Como Contribuir

### 1. Fork o Repositório

Clique em **"Fork"** no canto superior direito desta página.

---

### 2. Clone Seu Fork

```bash
git clone https://github.com/SEU_USUARIO/project-01-translate-app.git
cd project-01-translate-app
```

---

### 3. Crie uma Branch

```bash
git checkout -b feature/minha-nova-feature
```

**Convenção de nomes de branches:**
- `feature/` - Nova funcionalidade
- `fix/` - Correção de bug
- `docs/` - Melhorias na documentação
- `refactor/` - Refatoração de código
- `test/` - Adição de testes

**Exemplo:**
```bash
git checkout -b feature/suporte-multiplas-paginas
```

---

### 4. Faça Suas Mudanças

- Escreva código limpo e bem comentado (em inglês)
- Adicione testes para novas funcionalidades
- Atualize a documentação se necessário
- Siga o estilo de código existente

---

### 5. Commit Suas Mudanças

Use [Conventional Commits](https://www.conventionalcommits.org/):

```bash
git add .
git commit -m "feat: adiciona suporte para PDFs de múltiplas páginas"
```

**Tipos de commit:**
- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Mudanças na documentação
- `style:` - Formatação, espaços em branco
- `refactor:` - Refatoração de código
- `test:` - Adição de testes
- `chore:` - Manutenção geral

**Exemplos:**
```bash
git commit -m "feat: adiciona autenticação com Azure AD"
git commit -m "fix: corrige erro de parsing de PDF"
git commit -m "docs: atualiza README com novas instruções"
git commit -m "test: adiciona testes para pdf_service"
```

---

### 6. Push para Seu Fork

```bash
git push origin feature/minha-nova-feature
```

---

### 7. Abra um Pull Request

1. Vá para o repositório original
2. Clique em **"Pull Requests"** > **"New Pull Request"**
3. Clique em **"compare across forks"**
4. Selecione seu fork e branch
5. Preencha:
   - **Título:** Descrição clara da mudança
   - **Descrição:** 
     - O que foi mudado?
     - Por que foi mudado?
     - Como testar?
6. Clique em **"Create Pull Request"**

---

## 📝 Diretrizes de Código

### Python

- Use Python 3.11+
- Siga PEP 8
- Use type hints quando apropriado
- Docstrings em inglês (formato Google)
- Máximo 100 caracteres por linha

**Exemplo:**
```python
async def translate_text(text: str, source_lang: str, target_lang: str) -> str:
    """
    Translate text using Azure OpenAI.
    
    Args:
        text: Text to translate
        source_lang: Source language code (e.g., "en")
        target_lang: Target language code (e.g., "pt-BR")
    
    Returns:
        Translated text string
    
    Raises:
        RuntimeError: If translation fails
    """
    # Implementation...
```

---

### Commits

- Use [Conventional Commits](https://www.conventionalcommits.org/)
- Mensagens em inglês
- Seja descritivo mas conciso

---

### Testes

- Adicione testes para novas funcionalidades
- Use pytest
- Cobertura mínima de 70%

**Rodar testes:**
```bash
pytest tests/
```

---

## 🐛 Reportar Bugs

Abra uma [Issue](../../issues) com:

- **Título:** Descrição clara do bug
- **Descrição:**
  - Passos para reproduzir
  - Comportamento esperado
  - Comportamento atual
  - Screenshots (se aplicável)
  - Ambiente (OS, Python version, etc.)

---

## 💡 Sugerir Funcionalidades

Abra uma [Issue](../../issues) com:

- **Título:** `[Feature Request] Nome da funcionalidade`
- **Descrição:**
  - Por que essa funcionalidade é útil?
  - Como deveria funcionar?
  - Exemplos de uso

---

## 📋 Checklist para Pull Requests

Antes de submeter um PR, verifique:

- [ ] Código segue o estilo do projeto
- [ ] Comentários em inglês
- [ ] Testes adicionados para novas funcionalidades
- [ ] Todos os testes passam (`pytest tests/`)
- [ ] Documentação atualizada (se necessário)
- [ ] Sem arquivos desnecessários (`.env`, `app.zip`, etc.)
- [ ] Commits seguem Conventional Commits
- [ ] Branch está atualizada com `main`

---

## 🎯 Áreas Onde Contribuições São Bem-Vindas

- 🐛 Correções de bugs
- 📚 Melhorias na documentação
- 🧪 Mais testes
- ✨ Novas funcionalidades (ex.: suporte a múltiplas páginas)
- 🔒 Melhorias de segurança
- 🎨 Melhorias na UI/UX
- 🌍 Traduções para outros idiomas
- ⚡ Otimizações de performance

---

## ❓ Dúvidas?

- Abra uma [Discussion](../../discussions)
- Entre em contato via Issues

---

## 📄 Código de Conduta

Seja respeitoso e profissional. Este é um ambiente de aprendizado e colaboração.

---

**Obrigado por contribuir! 🚀**
