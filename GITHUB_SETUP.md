# 📦 Guia Completo: Como Publicar Este Projeto no GitHub

Este guia orienta você passo a passo para publicar o projeto "Azure OpenAI PDF Translator LAB" no seu GitHub.

---

## 🎯 Pré-requisitos

Antes de começar, certifique-se de ter:

- [ ] Conta no GitHub (crie em: https://github.com/signup)
- [ ] Git instalado no Windows (veja [README.md](README.md) - Passo 2)
- [ ] Projeto completo na sua máquina local

---

## 📋 Passo a Passo

### **Passo 1: Criar Repositório no GitHub**

1. Abra o navegador e acesse: https://github.com
2. Faça login na sua conta GitHub
3. No canto superior direito, clique no **ícone "+"** > **"New repository"**
4. Preencha:
   - **Repository name:** `project-01-translate-app` (ou nome de sua escolha)
   - **Description:** `Azure OpenAI PDF Translator LAB - Educational project for portfolio`
   - **Visibility:** 
     - ✅ **Public** (para portfólio, qualquer pessoa pode ver)
     - ⚠️ **Private** (apenas você e colaboradores podem ver)
   - ❌ **NÃO marque** "Add a README file" (já temos um)
   - ❌ **NÃO marque** "Add .gitignore" (já temos um)
   - ❌ **NÃO marque** "Choose a license" (já temos LICENSE)
5. Clique em **"Create repository"**

**IMPORTANTE:** Após criar, você verá uma página com instruções. **NÃO feche essa página ainda** - vamos usar as informações dela.

---

### **Passo 2: Configurar Git Localmente (Primeira Vez Apenas)**

Se é a **primeira vez** que você usa Git neste computador, configure seu nome e email:

Abra o PowerShell no VS Code (`Ctrl + '`) e execute:

```powershell
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@example.com"
```

**Exemplo:**
```powershell
git config --global user.name "Fabricio Silva"
git config --global user.email "fabricio@example.com"
```

**⚠️ Use o mesmo email da sua conta GitHub!**

---

### **Passo 3: Inicializar Repositório Local**

No terminal do VS Code (dentro da pasta do projeto):

```powershell
# Certifique-se de estar na pasta do projeto
pwd
# Deve mostrar: .../project-01-translate-app

# Inicializar repositório Git
git init
```

**Saída esperada:**
```
Initialized empty Git repository in C:/Users/.../project-01-translate-app/.git/
```

---

### **Passo 4: Adicionar Arquivos ao Git**

Agora vamos adicionar todos os arquivos do projeto ao Git:

```powershell
git add .
```

**O que isso faz:**
- Adiciona **todos os arquivos** da pasta ao "staging area" (área de preparação)
- O arquivo `.gitignore` já impede que arquivos sensíveis (`.env`, `app.zip`, etc.) sejam adicionados

---

### **Passo 5: Criar o Primeiro Commit**

```powershell
git commit -m "Initial commit: Azure OpenAI PDF Translator LAB"
```

**O que isso faz:**
- Cria um "snapshot" (foto) do estado atual do projeto
- A mensagem `-m "..."` descreve o que foi feito

**Saída esperada:**
```
[main (root-commit) abc1234] Initial commit: Azure OpenAI PDF Translator LAB
 XX files changed, XXX insertions(+)
 create mode 100644 README.md
 create mode 100644 app/main.py
 ...
```

---

### **Passo 6: Renomear Branch para `main` (Padrão GitHub)**

```powershell
git branch -M main
```

**O que isso faz:**
- Renomeia a branch atual para `main` (padrão do GitHub)
- Antes, o padrão era `master`, mas agora é `main`

---

### **Passo 7: Conectar ao Repositório Remoto (GitHub)**

Volte à página do GitHub onde você criou o repositório. Você verá comandos como:

```
…or push an existing repository from the command line

git remote add origin https://github.com/SEU_USUARIO/project-01-translate-app.git
git branch -M main
git push -u origin main
```

**Copie a URL do seu repositório** (linha com `git remote add origin ...`)

No terminal do VS Code, execute:

```powershell
git remote add origin https://github.com/SEU_USUARIO/project-01-translate-app.git
```

**⚠️ Substitua `SEU_USUARIO` pelo seu nome de usuário do GitHub!**

**Exemplo:**
```powershell
git remote add origin https://github.com/fabriciosilva/project-01-translate-app.git
```

**O que isso faz:**
- Conecta seu repositório local ao repositório remoto no GitHub
- `origin` é o nome padrão para o repositório remoto

---

### **Passo 8: Enviar Código para o GitHub (Push)**

Agora vamos enviar todo o código para o GitHub:

```powershell
git push -u origin main
```

**O que acontece:**
1. O Git pedirá autenticação:
   - **Opção 1 (recomendado):** Janela do navegador abre para você fazer login no GitHub
   - **Opção 2:** Pede username e senha (senha é um **Personal Access Token**, não a senha da conta)

2. Aguarde o upload (pode levar 1-2 minutos na primeira vez)

**Saída esperada:**
```
Enumerating objects: XX, done.
Counting objects: 100% (XX/XX), done.
Delta compression using up to 8 threads
Compressing objects: 100% (XX/XX), done.
Writing objects: 100% (XX/XX), XX.XX KiB | XX.XX MiB/s, done.
Total XX (delta X), reused 0 (delta 0), pack-reused 0
To https://github.com/SEU_USUARIO/project-01-translate-app.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

---

### **Passo 9: Verificar no GitHub**

1. Volte ao navegador
2. Atualize a página do repositório (`F5`)
3. Você deve ver:
   - ✅ Todos os arquivos do projeto
   - ✅ README.md renderizado na página inicial
   - ✅ Badge MIT License
   - ✅ Estrutura de pastas completa

---

## 🔐 Autenticação: Personal Access Token (se necessário)

Se o Git pediu **username e password** e você não conseguiu fazer push:

### Criar Personal Access Token (PAT):

1. GitHub > Clique na sua foto (canto superior direito) > **"Settings"**
2. Menu esquerdo (final da página) > **"Developer settings"**
3. **"Personal access tokens"** > **"Tokens (classic)"**
4. Clique em **"Generate new token"** > **"Generate new token (classic)"**
5. Preencha:
   - **Note:** `Git access from Windows VM` (descrição)
   - **Expiration:** `90 days` (ou `No expiration` para projetos pessoais)
   - **Select scopes:** Marque apenas:
     - ✅ `repo` (acesso completo aos repositórios)
6. Clique em **"Generate token"**
7. **⚠️ COPIE O TOKEN AGORA** (você não verá ele novamente!)

### Usar o Token:

Quando o Git pedir senha, cole o **Personal Access Token** (não a senha da conta).

**Ou configure para lembrar:**

```powershell
git config --global credential.helper wincred
```

Depois, faça `git push` novamente e cole o token. O Windows salvará a credencial.

---

## 🔄 Atualizações Futuras: Como Fazer Push de Mudanças

Quando você **modificar o código** no futuro:

```powershell
# 1. Ver o que foi modificado
git status

# 2. Adicionar mudanças
git add .

# 3. Criar commit com mensagem descritiva
git commit -m "feat: adiciona suporte para PDFs de múltiplas páginas"

# 4. Enviar para GitHub
git push
```

**Exemplos de mensagens de commit:**
- `feat: adiciona nova funcionalidade`
- `fix: corrige erro no upload de PDF`
- `docs: atualiza README com novas instruções`
- `refactor: melhora estrutura do código`
- `test: adiciona testes para translator_service`

---

## 📌 Adicionar Topics (Tags) ao Repositório

Para deixar seu repositório mais profissional:

1. GitHub > Seu repositório
2. Clique no ícone **⚙️ (Settings)** ao lado de "About"
3. Em **"Topics"**, adicione:
   - `azure`
   - `openai`
   - `fastapi`
   - `python`
   - `bicep`
   - `pdf-translator`
   - `azure-openai`
   - `key-vault`
   - `managed-identity`
4. Clique em **"Save changes"**

---

## ⭐ Deixar o README.md Ainda Melhor

### Adicionar Badge de Status

No topo do `README.md`, você pode adicionar badges:

```markdown
[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue)](https://github.com/SEU_USUARIO/project-01-translate-app)
[![Python](https://img.shields.io/badge/Python-3.11+-blue)](https://www.python.org/)
[![Azure](https://img.shields.io/badge/Azure-OpenAI-0078D4)](https://azure.microsoft.com/)
```

---

## 🎨 Adicionar Screenshot (Opcional)

Para deixar o README mais visual:

1. Tire um screenshot da aplicação rodando
2. Salve na pasta do projeto: `docs/screenshot.png`
3. No `README.md`, adicione após "Visão Geral":

```markdown
![Screenshot](docs/screenshot.png)
```

4. Faça commit:

```powershell
git add docs/screenshot.png README.md
git commit -m "docs: adiciona screenshot ao README"
git push
```

---

## ✅ Checklist Final

Antes de compartilhar seu repositório:

- [ ] README.md completo e atualizado
- [ ] `.env` **NÃO está no repositório** (apenas `.env.example`)
- [ ] `.gitignore` configurado corretamente
- [ ] LICENSE presente
- [ ] Código comentado e organizado
- [ ] Scripts de deploy funcionando
- [ ] Topics (tags) adicionadas ao repositório
- [ ] Descrição do repositório preenchida

---

## 🚀 Compartilhar no LinkedIn (Portfólio)

Para divulgar seu projeto:

1. LinkedIn > **"Criar publicação"**
2. Texto sugerido:

```
🚀 Novo projeto no GitHub: Azure OpenAI PDF Translator LAB

Desenvolvi uma solução educacional que demonstra:
✅ Tradução automática de PDFs com Azure OpenAI
✅ Backend FastAPI (Python)
✅ Infraestrutura como Código (Bicep)
✅ Segurança com Managed Identity e Key Vault
✅ Deploy automatizado no Azure

Tecnologias: #Azure #OpenAI #Python #FastAPI #Bicep

Confira o código completo (com instruções detalhadas):
https://github.com/SEU_USUARIO/project-01-translate-app

#CloudComputing #AI #DevOps #Portfolio
```

3. Adicione um screenshot da aplicação rodando
4. Publique!

---

## 🆘 Problemas Comuns

### Erro: "fatal: remote origin already exists"

**Solução:**
```powershell
git remote remove origin
git remote add origin https://github.com/SEU_USUARIO/project-01-translate-app.git
```

---

### Erro: "Updates were rejected because the remote contains work"

**Causa:** Você marcou "Add README" ao criar o repositório.

**Solução:**
```powershell
git pull origin main --allow-unrelated-histories
git push -u origin main
```

---

### Erro: "Permission denied (publickey)"

**Causa:** Tentando usar SSH sem configurar chave.

**Solução:** Use HTTPS em vez de SSH:
```powershell
git remote set-url origin https://github.com/SEU_USUARIO/project-01-translate-app.git
```

---

## 📚 Recursos Adicionais

- [GitHub Docs - Quickstart](https://docs.github.com/en/get-started/quickstart)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Conventional Commits](https://www.conventionalcommits.org/) (padrão de mensagens)

---

**🎉 Parabéns! Seu projeto está no GitHub e pronto para ser compartilhado!**
