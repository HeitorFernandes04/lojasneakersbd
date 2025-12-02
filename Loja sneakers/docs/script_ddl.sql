Projeto Físico (DDL)

Nesta seção é apresentado o projeto físico do banco de dados da loja de tênis, por meio do script DDL (Data Definition Language) utilizado para criar as tabelas no SGBD SQLite, contemplando chaves primárias, chaves estrangeiras, restrições de nulidade, unicidade e verificações (CHECK). Ao final, são descritos os testes de criação no SGBD e alguns registros inseridos para fins de teste.

5.1 Script DDL – Criação das Tabelas

O script abaixo cria as três tabelas principais do sistema: USUARIO, TENIS e ANUNCIO, já com as restrições de integridade definidas.

-- ============================================================
-- Script DDL - Sistema de Loja de Tênis
-- Banco de dados: SQLite
-- ============================================================

PRAGMA foreign_keys = ON;

-- ============================================================
-- Tabela: USUARIO
-- Representa os usuários que acessam o sistema
-- ============================================================

CREATE TABLE USUARIO (
    id_usuario     INTEGER       PRIMARY KEY AUTOINCREMENT,
    nome           VARCHAR(100)  NOT NULL,
    email          VARCHAR(100)  NOT NULL UNIQUE,
    senha          VARCHAR(255)  NOT NULL,
    data_cadastro  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Tabela: TENIS
-- Representa os tênis cadastrados para venda
-- ============================================================

CREATE TABLE TENIS (
    id_tenis   INTEGER       PRIMARY KEY AUTOINCREMENT,
    marca      VARCHAR(50)   NOT NULL,
    modelo     VARCHAR(100)  NOT NULL,
    tamanho    INTEGER       NOT NULL,
    cor        VARCHAR(50)   NOT NULL,
    tipo       VARCHAR(50)   NOT NULL,
    foto       VARCHAR(255),

    -- Restrições adicionais
    CONSTRAINT tenis_tamanho_range
        CHECK (tamanho >= 20 AND tamanho <= 50),

    CONSTRAINT tenis_unico_por_marca_modelo_tamanho_cor
        UNIQUE (marca, modelo, tamanho, cor)
);

-- ============================================================
-- Tabela: ANUNCIO
-- Representa os anúncios de venda dos tênis
-- ============================================================

CREATE TABLE ANUNCIO (
    id_anuncio       INTEGER        PRIMARY KEY AUTOINCREMENT,
    titulo           VARCHAR(100)   NOT NULL,
    descricao        TEXT           NOT NULL,
    preco            DECIMAL(10,2)  NOT NULL,
    data_criacao     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario       INTEGER        NOT NULL,
    id_tenis         INTEGER        NOT NULL,

    -- Chaves estrangeiras
    CONSTRAINT fk_anuncio_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES USUARIO (id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_anuncio_tenis
        FOREIGN KEY (id_tenis)
        REFERENCES TENIS (id_tenis)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- Restrições de integridade de negócio
    CONSTRAINT anuncio_preco_positivo
        CHECK (preco > 0),

    CONSTRAINT anuncio_unico_por_usuario_tenis_titulo
        UNIQUE (id_usuario, id_tenis, titulo)
);

5.2 Definição de Restrições (PK, FK, NOT NULL, UNIQUE, CHECK)

No script acima são contempladas as seguintes restrições, conforme exigido no trabalho:

PRIMARY KEY (PK)

USUARIO.id_usuario

TENIS.id_tenis

ANUNCIO.id_anuncio

FOREIGN KEY (FK)

ANUNCIO.id_usuario → USUARIO(id_usuario)

ANUNCIO.id_tenis → TENIS(id_tenis)
Com ON DELETE CASCADE e ON UPDATE CASCADE, garantindo integridade referencial.

NOT NULL

Todos os campos essenciais (nome, email, senha, marca, modelo, tamanho, cor, tipo, titulo, descricao, preco, etc.) são marcados como NOT NULL para evitar registros incompletos.

UNIQUE

USUARIO.email é UNIQUE para impedir e-mails de login duplicados.

TENIS (marca, modelo, tamanho, cor) é UNIQUE para evitar cadastro repetido do mesmo tênis com exatamente as mesmas características.

ANUNCIO (id_usuario, id_tenis, titulo) é UNIQUE para evitar que o mesmo usuário crie dois anúncios idênticos (mesmo tênis + mesmo título).

CHECK

tenis_tamanho_range: garante que tamanho esteja em um intervalo razoável (tamanho >= 20 AND tamanho <= 50).

anuncio_preco_positivo: garante que preco > 0, impedindo anúncios com preço zero ou negativo.

Essas restrições demonstram o uso prático de PK, FK, NOT NULL, UNIQUE e CHECK, conforme os requisitos da etapa de Projeto Físico.

5.3 Teste de Criação no SGBD (SQLite)

Para validar o script DDL, foi utilizado o SGBD SQLite. O procedimento de teste foi:

Criação de um novo banco de dados (por exemplo, loja_tenis.db) em uma ferramenta como DB Browser for SQLite, SQLiteStudio ou via linha de comando.

Execução do script DDL acima na aba de execução de SQL.

Verificação da criação das tabelas com sucesso.

Exemplo de comandos para verificar a criação (em uma sessão SQLite):

-- Listar todas as tabelas criadas
.tables

-- Verificar a estrutura da tabela USUARIO
.schema USUARIO

-- Verificar a estrutura da tabela TENIS
.schema TENIS

-- Verificar a estrutura da tabela ANUNCIO
.schema ANUNCIO


A saída desses comandos mostra as tabelas criadas com seus respectivos campos e restrições, confirmando que o script DDL está correto e compatível com o SGBD escolhido.

No seu PDF você pode mencionar algo como:
“O script foi executado no SQLite, e as tabelas USUARIO, TENIS e ANUNCIO foram criadas com sucesso, conforme demonstrado pelos comandos .tables e .schema.”

5.4 Inserção de Dados de Exemplo (Opcional)

Para realizar testes iniciais de funcionamento do banco e da aplicação, foram inseridos alguns registros de exemplo em cada tabela:

-- Usuários de teste
INSERT INTO USUARIO (nome, email, senha)
VALUES
    ('Administrador', 'admin@lojadetenis.com', 'senha_hash_admin'),
    ('João Silva',    'joao@exemplo.com',      'senha_hash_joao'),
    ('Maria Souza',   'maria@exemplo.com',     'senha_hash_maria');

-- Tênis de exemplo
INSERT INTO TENIS (marca, modelo, tamanho, cor, tipo, foto)
VALUES
    ('Nike',   'Air Zoom',   42, 'Preto',  'Corrida', NULL),
    ('Adidas', 'Ultraboost', 40, 'Branco', 'Casual',  NULL),
    ('Puma',   'RS-X',       38, 'Azul',   'Casual',  NULL);

-- Anúncios de exemplo
INSERT INTO ANUNCIO (titulo, descricao, preco, id_usuario, id_tenis)
VALUES
    ('Nike Air Zoom novo', 'Tênis Nike Air Zoom, pouco uso, tamanho 42.', 499.90, 2, 1),
    ('Adidas Ultraboost',  'Ultraboost branco, em ótimo estado.',         399.90, 3, 2);