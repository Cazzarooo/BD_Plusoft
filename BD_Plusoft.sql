SET SERVEROUTPUT ON;

--Excluir Tabelas
DROP TABLE tb_sugestao_ia CASCADE CONSTRAINTS;
DROP TABLE tb_avaliacoes CASCADE CONSTRAINTS;
DROP TABLE tb_produto CASCADE CONSTRAINTS;
DROP TABLE tb_ia CASCADE CONSTRAINTS;
DROP TABLE tb_cadastro CASCADE CONSTRAINTS;
DROP TABLE tb_cliente CASCADE CONSTRAINTS;

--Criando Tabelas
CREATE TABLE tb_avaliacoes (
    id_avaliacoes    INTEGER NOT NULL,
    id_cliente       INTEGER NOT NULL,
    id_produto       INTEGER NOT NULL,
    id_ia            INTEGER NOT NULL,
    comentario       VARCHAR2(500),
    nota_avaliacao   INTEGER,
    data_avaliacao   TIMESTAMP WITH TIME ZONE,
    status_avaliacao VARCHAR2(100)
);

ALTER TABLE tb_avaliacoes ADD CONSTRAINT tb_avaliacoes_pk PRIMARY KEY ( id_avaliacoes );

CREATE TABLE tb_cadastro (
    id_cliente       INTEGER NOT NULL,
    email_cliente    VARCHAR2(100),
    senha_cliente    VARCHAR2(50),
    endereco_cliente VARCHAR2(100),
    numero_cliente   INTEGER
);

CREATE TABLE tb_cliente (
    id_cliente              INTEGER NOT NULL,
    nome_cliente            VARCHAR2(100),
    cpf_cliente             INTEGER,
    data_nascimento_cliente TIMESTAMP WITH TIME ZONE,
    genero_cliente          VARCHAR2(50)
);

ALTER TABLE tb_cliente ADD CONSTRAINT tb_cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE tb_ia (
    id_ia             INTEGER NOT NULL,
    nome_ia           VARCHAR2(100),
    algoritmo_ia      VARCHAR2(500),
    dados_treinamento VARCHAR2(500),
    desempenho_ia     VARCHAR2(255)
);

ALTER TABLE tb_ia ADD CONSTRAINT tb_ia_pk PRIMARY KEY ( id_ia );

CREATE TABLE tb_produto (
    id_produto        INTEGER NOT NULL,
    id_cliente        INTEGER NOT NULL,
    id_ia             INTEGER NOT NULL,
    nome_produto      VARCHAR2(100),
    preco_produto     INTEGER,
    tipo_produto      VARCHAR2(100),
    descricao_produto VARCHAR2(100)
);

ALTER TABLE tb_produto ADD CONSTRAINT tb_produto_pk PRIMARY KEY ( id_produto );

CREATE TABLE tb_sugestao_ia (
    id_sugestao         INTEGER NOT NULL,
    id_ia               INTEGER NOT NULL,
    imagem_sugestao     BLOB,
    descricao_sugestao  VARCHAR2(500),
    data_sugestao       TIMESTAMP WITH TIME ZONE,
    relevancia_sugestao INTEGER
);

--Inserindo chaves estrangeiras
ALTER TABLE tb_sugestao_ia ADD CONSTRAINT tb_sugestao_ia_pk PRIMARY KEY ( id_sugestao );

ALTER TABLE tb_avaliacoes
    ADD CONSTRAINT tb_avaliacoes_tb_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES tb_cliente ( id_cliente );

ALTER TABLE tb_avaliacoes
    ADD CONSTRAINT tb_avaliacoes_tb_ia_fk FOREIGN KEY ( id_ia )
        REFERENCES tb_ia ( id_ia );

ALTER TABLE tb_avaliacoes
    ADD CONSTRAINT tb_avaliacoes_tb_produto_fk FOREIGN KEY ( id_produto )
        REFERENCES tb_produto ( id_produto );

ALTER TABLE tb_cadastro
    ADD CONSTRAINT tb_cadastro_tb_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES tb_cliente ( id_cliente );

ALTER TABLE tb_produto
    ADD CONSTRAINT tb_produto_tb_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES tb_cliente ( id_cliente );

ALTER TABLE tb_produto
    ADD CONSTRAINT tb_produto_tb_ia_fk FOREIGN KEY ( id_ia )
        REFERENCES tb_ia ( id_ia );

ALTER TABLE tb_sugestao_ia
    ADD CONSTRAINT tb_sugestao_ia_tb_ia_fk FOREIGN KEY ( id_ia )
        REFERENCES tb_ia ( id_ia );
        
--Inserindo valores nas tabelas
-- Inserindo valores na tb_cliente
INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente) 
VALUES (1, 'Ana Silva', 12345678901, TO_DATE('1990-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente) 
VALUES (2, 'Carlos Souza', 23456789012, TO_DATE('1985-05-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Masculino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente) 
VALUES (3, 'Mariana Santos', 34567890123, TO_DATE('1988-10-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente) 
VALUES (4, 'Rafael Oliveira', 45678901234, TO_DATE('1995-03-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Masculino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente) 
VALUES (5, 'Juliana Martins', 56789012345, TO_DATE('1980-12-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');

-- Inserindo valores na tb_cadastro
INSERT INTO tb_cadastro (id_cliente, email_cliente, senha_cliente, endereco_cliente, numero_cliente) 
VALUES (1, 'anasilva@example.com', 'senha123', 'Rua A, 123', '+5511912345678');

INSERT INTO tb_cadastro (id_cliente, email_cliente, senha_cliente, endereco_cliente, numero_cliente) 
VALUES (2, 'carlossouza@example.com', 'senha456', 'Rua B, 456', '+5511912345679');

INSERT INTO tb_cadastro (id_cliente, email_cliente, senha_cliente, endereco_cliente, numero_cliente) 
VALUES (3, 'marianasantos@example.com', 'senha789', 'Rua C, 789', '+5511912345680');

INSERT INTO tb_cadastro (id_cliente, email_cliente, senha_cliente, endereco_cliente, numero_cliente) 
VALUES (4, 'rafaeloliveira@example.com', 'senhaabc', 'Rua D, 1011', '+5511912345681');

INSERT INTO tb_cadastro (id_cliente, email_cliente, senha_cliente, endereco_cliente, numero_cliente) 
VALUES (5, 'julianamartins@example.com', 'senhaxyz', 'Rua E, 1213', '+5511912345682');

-- Inserindo valores na tb_ia
INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia) 
VALUES (1, 'IA de Recomendação', 'Redes Neurais', 'dados_recomendacao.csv', '85% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia) 
VALUES (2, 'IA de Análise de Sentimentos', 'Árvores de Decisão', 'dados_sentimentos.csv', '78% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia) 
VALUES (3, 'IA de Reconhecimento de Imagens', 'Máquinas de Vetores de Suporte', 'dados_imagens.csv', '91% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia) 
VALUES (4, 'IA de Previsão de Vendas', 'Regressão Linear', 'dados_vendas.csv', '67% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia) 
VALUES (5, 'IA de Classificação de Textos', 'Redes Bayesianas', 'dados_textos.csv', '82% de precisão');

-- Inserindo valores na tb_produto
INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto) 
VALUES (1, 1, 1, 'Notebook Dell', 2500, 'Eletrônico', 'Notebook com processador Intel Core i7 e 8GB de RAM.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto) 
VALUES (2, 2, 2, 'Camisa Polo', 80, 'Vestuário', 'Camisa Polo de algodão, várias cores disponíveis.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto) 
VALUES (3, 3, 3, 'Chocolate Amargo', 10, 'Alimentício', 'Barra de chocolate amargo, 70% de cacau.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto) 
VALUES (4, 4, 4, 'Vaso Decorativo', 150, 'Decoração', 'Vaso de cerâmica decorado com padrão floral.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto) 
VALUES (5, 5, 5, 'Tênis de Corrida', 300, 'Esportivo', 'Tênis de corrida com amortecimento e tecnologia respirável.');

-- Inserindo valores na tb_avaliacoes
INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao) 
VALUES (1, 1, 1, 1, 'Ótimo produto, estou muito satisfeito!', 5, TO_DATE('2024-04-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao) 
VALUES (2, 2, 2, 2, 'A qualidade da camisa é excelente!', 4, TO_DATE('2024-04-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao) 
VALUES (3, 3, 3, 3, 'Adorei a variedade de cores disponíveis!', 5, TO_DATE('2024-04-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao) 
VALUES (4, 4, 4, 4, 'O vaso combinou perfeitamente com a decoração da minha casa.', 4, TO_DATE('2024-04-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao) 
VALUES (5, 5, 5, 5, 'O tênis é muito confortável para correr!', 5, TO_DATE('2024-04-11 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

-- Inserindo valores na tb_sugestao_ia
INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao) 
VALUES (1, 1, 'Sugestão de Produto: Mochila para Notebook', TO_DATE('2024-04-11 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao) 
VALUES (2, 2, 'Sugestão de Produto: Calça Jeans Masculina', TO_DATE('2024-04-11 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao) 
VALUES (3, 3, 'Sugestão de Produto: Kit de Pintura', TO_DATE('2024-04-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao) 
VALUES (4, 4, 'Sugestão de Produto: Monitor Ultrawide', TO_DATE('2024-04-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao) 
VALUES (5, 5, 'Sugestão de Produto: Livro de Ficção Científica', TO_DATE('2024-04-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);

--Cursor que demonstra o nome do cliente, o total de avaliações feitas por ele e a média das avaliações.
DECLARE
  CURSOR c_avaliacoes IS
  SELECT 
    cl.nome_cliente AS cliente, 
    COUNT(*) AS total_avaliacoes,
    AVG(av.nota_avaliacao) AS media_avaliacao
  FROM tb_cliente cl
  INNER JOIN tb_avaliacoes av ON cl.id_cliente = av.id_cliente
  INNER JOIN tb_produto pr ON av.id_produto = pr.id_produto
  INNER JOIN tb_ia ia ON av.id_ia = ia.id_ia
  INNER JOIN tb_cadastro cd ON cl.id_cliente = cd.id_cliente
  INNER JOIN tb_sugestao_ia si ON av.id_ia = si.id_ia -- Novo join com a tabela tb_sugestao_ia
  GROUP BY cl.nome_cliente
  ORDER BY media_avaliacao DESC;

  av_row c_avaliacoes%ROWTYPE;
BEGIN
  OPEN c_avaliacoes;
  LOOP
    FETCH c_avaliacoes INTO av_row;
    EXIT WHEN c_avaliacoes%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('Cliente: ' || av_row.cliente);
    DBMS_OUTPUT.PUT_LINE('Total de Avaliações: ' || av_row.total_avaliacoes);
    DBMS_OUTPUT.PUT_LINE('Média de Avaliação: ' || av_row.media_avaliacao);
    DBMS_OUTPUT.PUT_LINE('-----------------------');
  END LOOP;
  CLOSE c_avaliacoes;
END;
