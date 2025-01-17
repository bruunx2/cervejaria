CREATE DATABASE CERVEJARIA;

use CERVEJARIA

CREATE TABLE emprego_anterior(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    empresa VARCHAR(100) NULL, 
    cargo VARCHAR(50) NULL, 
    data_entrada DATE NULL,
    data_saida DATE NULL
)

CREATE TABLE cargo(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    funcao VARCHAR(50) NULL,
    descricao VARCHAR(100) NULL
)

CREATE TABLE endereco(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    cep VARCHAR(10) NULL,
    numero TINYINT NULL,
    complemento VARCHAR(50) NULL
)

CREATE TABLE contato(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    telefone VARCHAR (15) NULL,
    contato  VARCHAR (15) NULL,
    email VARCHAR (50) NULL
);

CREATE TABLE cliente_fornecedor(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    nome VARCHAR (100) NULL,
    cnpj_cpf VARCHAR (15) NULL,
    ie VARCHAR(10) NULL,
    tipo INTEGER NULL,
    id_endereco INTEGER FOREIGN KEY REFERENCES endereco(id) NULL,
    id_contato INTEGER FOREIGN KEY REFERENCES contato(id) NULL,
);

Alter table cliente_fornecedor alter column id_contato INTEGER  NULL

CREATE TABLE usuario (    
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    nome_usuario VARCHAR (50) NULL,
    senha VARCHAR(50) NULL,
    nivel_acesso TINYINT,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME  NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
);

CREATE TABLE info_usuario(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    nome VARCHAR(100) NULL,
    cpf VARCHAR(15) NULL,
    data_nasc DATE NULL,
    id_endereco INTEGER FOREIGN KEY REFERENCES endereco(id) NOT NULL ,
    id_contato INTEGER FOREIGN KEY REFERENCES contato(id) NOT NULL,
    id_emprego INTEGER FOREIGN KEY REFERENCES emprego_anterior(id) NOT NULL,
    id_cargo INTEGER FOREIGN KEY REFERENCES cargo(id) NOT NULL,
    id_usuario INTEGER FOREIGN KEY REFERENCES usuario(id) NOT NULL,
)

CREATE TABLE insumo(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NULL,
    data_compra  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    validade DATE NULL,
    preco_unit INTEGER NULL,
    und_medida VARCHAR NULL,
    id_cliente_fornecedor INTEGER FOREIGN KEY REFERENCES cliente_fornecedor(id) NOT NULL,
);

CREATE TABLE receita(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NULL,
    descricao VARCHAR(100)
);

CREATE TABLE receita_insumo
(
	id_receira INT NOT NULL,
	id_insumo INT NOT NULL,
	quantidade_insumo TINYINT NULL,
	CONSTRAINT [PK_RECEITAID_ID] PRIMARY KEY CLUSTERED (id_receita ASC, id_insumo ASC),
	CONSTRAINT [FK_RECEITAINSUMO_ID] FOREIGN KEY (id_receita) REFERENCES receita(id) ON DELETE NO ACTION,
	CONSTRAINT [FK_INSUMORECEITA_ID] FOREIGN KEY (id_insumo) REFERENCES insumo(id) ON DELETE NO ACTION
)

CREATE TABLE produto(
    id INTEGER IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NULL,
    descricao VARCHAR (50) NULL, 
    fabricacao  DATETIME  NULL DEFAULT CURRENT_TIMESTAMP,
    validade DATE NULL,
    quantidade INT NULL,
    und_medida VARCHAR NULL,
    id_receita INTEGER FOREIGN KEY REFERENCES receita(id) NOT NULL,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME  NULL DEFAULT CURRENT_TIMESTAMP,
);