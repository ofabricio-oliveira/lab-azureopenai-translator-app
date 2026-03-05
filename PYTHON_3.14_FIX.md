# ⚠️ SOLUÇÃO URGENTE: Python 3.14 Incompatível

## 🔴 PROBLEMA

Você está vendo este erro:

```
TypeError: AsyncClient.__init__() got an unexpected keyword argument 'proxies'
```

**Causa:** Python 3.14 (muito recente) tem incompatibilidade com bibliotecas HTTP.

---

## 🚀 SOLUÇÃO AUTOMÁTICA (RECOMENDADO - 5 MIN) ⭐

```powershell
# 1. Abra PowerShell como Administrador
#    (Botão direito > Executar como Administrador)

# 2. Navegue até o projeto
cd C:\Users\adm.fa\Documents\project-01-translate-app\project-01-translate-app

# 3. Execute o script completo
.\fix-python-complete.ps1
```

**O script fará TUDO automaticamente:**
- ✓ Desinstala Python 3.14
- ✓ Baixa Python 3.12.7  
- ✓ Instala com PATH configurado
- ✓ Mostra próximos passos

📖 **Docs:** [SCRIPTS_README.md](SCRIPTS_README.md)

---

## ✅ SOLUÇÃO MANUAL (Passo a Passo)

**Prefere fazer manualmente? Siga abaixo:**

### Passo 1: Desinstalar Python 3.14

1. Pressione **Windows + I** (abre Configurações)
2. Vá em **"Aplicativos"** > **"Aplicativos instalados"**
3. Procure por **"Python 3.14"**
4. Clique nos **três pontos** > **"Desinstalar"**
5. Confirme e aguarde desinstalação

---

### Passo 2: Baixar Python 3.12 (RECOMENDADO)

1. Abra o navegador
2. Acesse: https://www.python.org/downloads/release/python-3120/
3. Role até **"Files"** no final da página
4. Clique em:
   - **Windows installer (64-bit)** → `python-3.12.x-amd64.exe`
5. Baixe e execute o instalador

---

### Passo 3: Instalar Python 3.12

1. Execute o instalador baixado
2. ⚠️ **CRÍTICO:** Marque **"Add python.exe to PATH"** (primeira tela)
3. Clique em **"Install Now"**
4. Aguarde instalação (~2 minutos)
5. Clique em **"Close"**

---

### Passo 4: Validar Instalação

Abra **PowerShell** (feche e abra um NOVO se já tinha aberto) e execute:

```powershell
python --version
```

**Esperado:** `Python 3.12.x` (NÃO 3.14.x)

**Se ainda mostrar 3.14:**
```powershell
# Ver todos os Pythons instalados
where python

# Se houver múltiplos, desinstale Python 3.14 manualmente
# Vá em: C:\Users\SEU_USUARIO\AppData\Local\Programs\Python\Python314
# Delete a pasta Python314
```

---

### Passo 5: Reinstalar Dependências

```powershell
# Navegar para o diretório do projeto
cd C:\Users\adm.fa\Documents\project-01-translate-app\project-01-translate-app

# Atualizar pip
python -m pip install --upgrade pip

# Reinstalar todas as dependências
pip install --upgrade -r requirements.txt
```

**Saída esperada:**
```
Successfully installed httpx-0.27.0 httpcore-1.0.5 openai-1.54.4 ...
```

---

### Passo 6: Reiniciar Servidor

```powershell
# Iniciar servidor (certifique-se de estar no diretório do projeto)
uvicorn app.main:app --reload
```

**Saída esperada:**
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
INFO:     Application startup complete.
```

---

### Passo 7: Testar Tradução

1. Abra navegador: http://localhost:8000
2. Faça upload do PDF: `Chocolate Cake with Chocolate Sauce.pdf`
3. Clique em **"Translate"**
4. Aguarde 10-30 segundos
5. ✅ **Download do PDF traduzido deve funcionar!**

---

## 🎯 RESUMO RÁPIDO

```powershell
# 1. Desinstalar Python 3.14 (Windows Settings > Apps)

# 2. Baixar Python 3.12
# https://www.python.org/downloads/release/python-3120/

# 3. Instalar marcando "Add to PATH"

# 4. Validar
python --version  # Deve mostrar 3.12.x

# 5. Reinstalar deps
cd C:\Users\adm.fa\Documents\project-01-translate-app\project-01-translate-app
pip install --upgrade pip
pip install --upgrade -r requirements.txt

# 6. Rodar servidor
uvicorn app.main:app --reload

# 7. Testar: http://localhost:8000
```

---

## ❓ POR QUE PYTHON 3.14 NÃO FUNCIONA?

Python 3.14 foi lançado em **outubro de 2025** e ainda é **muito recente**. Muitas bibliotecas Python (incluindo `httpx`, `httpcore`, e outras) ainda não foram totalmente atualizadas para suportar mudanças internas do Python 3.14.

**Versões recomendadas (Fev 2026):**
- ✅ **Python 3.12.x** (estável, suportado, recomendado)
- ✅ **Python 3.11.x** (estável, suportado, funciona)
- ⚠️ **Python 3.13.x** (novo, pode ter problemas)
- ❌ **Python 3.14.x** (muito novo, incompatível)

---

## 📚 DOCUMENTAÇÃO COMPLETA

Após resolver este problema, veja:

- 📖 [UPDATES_FEV_2026.md](UPDATES_FEV_2026.md) - Todas as correções de fev/2026
- 📖 [START_HERE.md](START_HERE.md) - Guia completo passo a passo
- 📖 [README.md](README.md) - Documentação principal

---

**Atualizado:** 21 de Fevereiro de 2026  
**Versão crítica:** Python 3.12.x OBRIGATÓRIO
