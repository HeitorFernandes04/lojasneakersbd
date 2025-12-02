# Sistema de Loja de Tênis
Trabalho Prático – Banco de Dados (CRUD com Django + SQLite)

## 📌 Visão Geral

Este repositório contém o código-fonte de um **sistema de gestão de loja de tênis**, desenvolvido em **Django** com **banco de dados SQLite**, adaptado para atender aos requisitos do trabalho prático de **Banco de Dados**.

O sistema permite:

- Gerenciar um catálogo de tênis (produtos);
- Criar anúncios de venda vinculados aos tênis;
- Controlar quais usuários (autenticados) podem cadastrar e gerenciar esses dados;
- Expor parte das funcionalidades via **API REST** (Django REST Framework).

> Objetivo acadêmico: demonstrar, na prática, o ciclo completo de um sistema baseado em banco de dados relacional, com modelagem, implementação e aplicação CRUD.

---

## 🎯 Contexto do Sistema (Resumo do Minimundo)

A aplicação representa o cenário de uma **loja/sistema de gerenciamento de tênis**:

- Usuários autenticados podem cadastrar diferentes modelos de tênis, informando marca, modelo, tamanho, cor, tipo e foto.
- Esses tênis podem ser usados para criar **anúncios de venda**, contendo título, descrição e preço.
- Cada anúncio pertence a um usuário (dono do anúncio) e está associado a um tênis cadastrado.
- O sistema permite listar, cadastrar, editar e excluir tanto **tênis** quanto **anúncios**, além de listar todos os anúncios disponíveis.

Esse minimundo serve de base para a **modelagem conceitual, lógica e física** do banco de dados.

---

## ✅ Requisitos do Trabalho de Banco de Dados Atendidos

Este projeto foi planejado para cobrir os seguintes pontos exigidos no trabalho de Banco de Dados:

1. **Sistema real com aplicação CRUD**
   - CRUD completo para:
     - Tênis (`Tenis`)
     - Anúncios (`Anuncio`)
   - Interface Web com formulários (Django + HTML/Bootstrap).
   - Autenticação de usuários.

2. **Banco de Dados Relacional (SQLite)**
   - SGBD: SQLite (padrão do Django).
   - Tabelas com chaves primárias e estrangeiras.
   - Relacionamentos:
     - `User (auth_user)` 1:N `Anuncio`
     - `Tenis` 1:N `Anuncio`
     - Conceitualmente, existe uma relação **N:M entre Usuário e Tênis**, mediada por `Anuncio`.

3. **Modelagem de Dados**
   - Modelo Conceitual (MER/ER) – baseado nas entidades:
     - `Usuario`
     - `Tenis`
     - `Anuncio`
   - Modelo Lógico Relacional – conversão para tabelas com chaves primárias/estrangeiras.
   - Normalização até **3FN** (evitando redundâncias e anomalias de atualização).

4. **Modelagem Orientada a Objetos**
   - Diagrama de Classes UML (sugerido):
     - Classes: `Usuario`, `Tenis`, `Anuncio`.
     - Métodos representando operações CRUD.
   - A estrutura das **classes Django (`models.py`)** reflete a modelagem do banco.

5. **Implementação Física (SQL)**
   - O banco é gerado via **migrations do Django** sobre SQLite.
   - Podem ser incluídos, neste repositório, scripts SQL com:
     - `CREATE TABLE`
     - `INSERT`, `UPDATE`, `DELETE`, `SELECT`
   - Esses scripts podem ficar, por exemplo, em `docs/sql/`.

6. **Aplicação CRUD com Interface**
   - Interface web funcional com:
     - Listagem de registros.
     - Formulários de cadastro/edição.
     - Modais de confirmação de exclusão.
   - Acesso condicionado a login.

> Observação: os artefatos teóricos como MER, DER, Diagrama de Classes e scripts SQL podem ser adicionados na pasta `docs/` do repositório para composição completa da entrega do trabalho.

---

## 🧱 Principais Funcionalidades

### 1. Autenticação

- Login e logout de usuários (baseado em `auth_user` do Django).
- Acesso às telas de Tênis e Anúncios é restrito a usuários autenticados.

### 2. Gestão de Tênis (`tenis`)

- Cadastro de tênis com os campos:
  - Marca (choices)
  - Modelo
  - Tamanho
  - Cor (choices)
  - Tipo (choices)
  - Foto (opcional)
- Listagem de todos os tênis cadastrados.
- Edição de dados de um tênis.
- Exclusão de tênis.
- Exibição de foto cadastrada.

### 3. Gestão de Anúncios (`anuncio`)

- Cada anúncio pertence a um **usuário autenticado** e a um **tênis**.
- Campos:
  - Tênis
  - Título
  - Descrição
  - Preço
  - Datas de criação e atualização
- Funcionalidades:
  - Listar **meus anúncios**.
  - Listar **todos os anúncios** do sistema.
  - Cadastrar, editar e excluir anúncios.
  - Visualizar detalhes de um anúncio.

### 4. API REST (opcional para o trabalho, mas implementada)

- Endpoints para Tênis usando Django REST Framework e Autenticação por Token:
  - `POST /api/login/` → autenticação e geração de token.
  - `GET /tenis/api/listar/` → lista todos os tênis.
  - `POST /tenis/api/criar/` → cria um novo tênis.
  - `GET/PUT/PATCH /tenis/api/editar/<id>/` → consulta/edita um tênis.
  - `DELETE /tenis/api/deletar/<id>/` → exclui um tênis.

---

## 🏗️ Arquitetura e Tecnologias

- **Linguagem:** Python
- **Framework Web:** Django
- **Banco de Dados:** SQLite
- **API REST:** Django REST Framework
- **Template Engine:** Django Templates + HTML + Bootstrap
- **Autenticação Web:** `django.contrib.auth` (sessão)
- **Autenticação API:** Token (DRF Authtoken)

---

## 📂 Estrutura de Pastas (principal)

```bash
.
├── manage.py
├── db.sqlite3
├── sistema/              # Configurações principais do projeto Django
│   ├── settings.py
│   ├── urls.py
│   ├── views.py          # Login, Logout, LoginAPI
│   ├── static/           # Arquivos estáticos (CSS, JS, imagens)
│   └── ...
├── tenis/                # App responsável pelo cadastro de tênis
│   ├── models.py
│   ├── views.py
│   ├── forms.py
│   ├── urls.py
│   ├── serializers.py
│   └── templates/tenis/
└── anuncio/              # App responsável pelos anúncios
    ├── models.py
    ├── views.py
    ├── forms.py
    ├── urls.py
    └── templates/anuncio/
Caso o repositório também contenha uma pasta sistema-mobile/, ela corresponde a um aplicativo mobile (Ionic/Angular) que consome a API REST. Para o trabalho de Banco de Dados, o foco é o backend em Django + SQLite.

⚙️ Como Executar o Projeto Localmente
1. Pré-requisitos
Python 3.10+ (ou compatível com o projeto)

pip instalado

(Opcional, mas recomendado) virtualenv

2. Clonar o repositório
bash
Copiar código
git clone https://github.com/SEU-USUARIO/SEU-REPO.git
cd SEU-REPO
3. Criar e ativar o ambiente virtual
bash
Copiar código
python -m venv venv
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate
4. Instalar dependências
bash
Copiar código
pip install -r requirements.txt
(se ainda não houver requirements.txt, você pode gerar com pip freeze > requirements.txt após instalar Django, DRF, etc.)

5. Aplicar migrações
Se ainda não existir o banco:

bash
Copiar código
python manage.py migrate
6. Criar um superusuário
bash
Copiar código
python manage.py createsuperuser
Siga as instruções no terminal (usuário, e-mail, senha).

7. Rodar o servidor
bash
Copiar código
python manage.py runserver
Acesse em:
➡ http://127.0.0.1:8000/

🧭 Fluxo de Uso do Sistema
Acesse http://127.0.0.1:8000/

Faça login com o usuário criado (createsuperuser) ou outro usuário cadastrado.

Após o login:

Vá para /tenis/ para gerenciar o catálogo de tênis;

Vá para /anuncio/ para gerenciar meus anúncios;

Vá para /anuncio/todos/ para ver todos os anúncios cadastrados no sistema.

Curso: Ciência da Computação - UFT Palmas

Matéria: Banco de dados 2025/02

Professor: Paulo Augusto Barros

Alunos: Heitor Fernandes, Arthur Bispo e Mauricio Monteiro
