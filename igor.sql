CREATE DATABASE petshop;
USE petshop;

CREATE TABLE clientes (
cliente_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
endereco VARCHAR(100),
telefone VARCHAR(20)
);

CREATE TABLE animal (
animal_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
idade INT,
especie VARCHAR(50),
cliente_id INT,
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE forma_pagamento (
forma_pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50)
);

CREATE TABLE funcionario (
funcionario_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
cargo VARCHAR(50)
);

CREATE TABLE ordem_servico (
ordem_servico_id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT,
funcionario_id INT,
data_servico DATE,
forma_pagamento_id INT,
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
FOREIGN KEY (funcionario_id) REFERENCES funcionario(funcionario_id),
FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(forma_pagamento_id)
);

CREATE TABLE produto_servico (
produto_servico_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
preco DECIMAL(10, 2)
);

CREATE TABLE itens_ordem_servico (
item_id INT AUTO_INCREMENT PRIMARY KEY,
ordem_servico_id INT,
produto_servico_id INT,
quantidade INT,
FOREIGN KEY (ordem_servico_id) REFERENCES ordem_servico(ordem_servico_id),
FOREIGN KEY (produto_servico_id) REFERENCES produto_servico(produto_servico_id)
);

CREATE TABLE racas (
raca_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50)
);

CREATE TABLE recebimento (
recebimento_id INT AUTO_INCREMENT PRIMARY KEY,
ordem_servico_id INT,
valor DECIMAL(10, 2),
FOREIGN KEY (ordem_servico_id) REFERENCES ordem_servico(ordem_servico_id)
);

CREATE TABLE vacinas (
vacina_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50)
);

CREATE TABLE vacinas_aplicadas (
aplicacao_id INT AUTO_INCREMENT PRIMARY KEY,
animal_id INT,
vacina_id INT,
data_aplicacao DATE,
FOREIGN KEY (animal_id) REFERENCES animal(animal_id),
FOREIGN KEY (vacina_id) REFERENCES vacinas(vacina_id)
);

CREATE TABLE agendamento (
agendamento_id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT,
data_hora DATETIME,
descricao VARCHAR(100),
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE ranking (
ranking_id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT,
pontuacao INT,
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE Animal_Historico (
historico_id INT AUTO_INCREMENT PRIMARY KEY,
animal_id INT,
data DATE,
descricao VARCHAR(100),
FOREIGN KEY (animal_id) REFERENCES animal(animal_id)
);

CREATE TABLE log_banco (
log_id INT AUTO_INCREMENT PRIMARY KEY,
data_hora DATETIME,
descricao VARCHAR(100)
);


INSERT INTO clientes (nome, endereco, telefone) VALUES
    ('lula', 'Rua da cloroquina', '75988911191'),
    ('laro', 'Miami', '75987933199'),
    ('Neymar', 'alguma rua da arabia', '75982521497');

INSERT INTO funcionario (nome, cargo) VALUES
    ('Ana Santos', 'Atendente'),
    ('Pedro Rodrigues', 'Veterinário'),
    ('Lucia Oliveira', 'Gerente');

INSERT INTO produto_servico (nome, preco) VALUES
    ('Banho e Tosa', 50.00),
    ('Consulta Veterinária', 80.00),
    ('Vacinação', 30.00);

INSERT INTO racas (nome) VALUES
    ('Golden Retriever'),
    ('Siamese'),
    ('Bulldog');

INSERT INTO vacinas (nome) VALUES
    ('Vacina contra a Raiva'),
    ('Vacina contra a Parvovirose'),
    ('Vacina contra a Cinomose');

INSERT INTO animal (nome, idade, especie, cliente_id) VALUES
    ('Principe', 3, 'Cachorro', 1),
    ('princesa', 2, 'Gato', 2),
    ('Sansão', 5, 'Cachorro', 1);
   
INSERT INTO forma_pagamento (nome) VALUES
    ('Dinheiro'),
    ('Cartão de Crédito'),
    ('Cartão de Débito');

INSERT INTO ordem_servico (cliente_id, funcionario_id, data_servico, forma_pagamento_id) VALUES
    (1, 2, '2023-09-20', 1),
    (2, 2, '2023-09-21', 2),
    (1, 3, '2023-09-22', 3);

INSERT INTO itens_ordem_servico (ordem_servico_id, produto_servico_id, quantidade) VALUES
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 2);
   
INSERT INTO recebimento (ordem_servico_id, valor) VALUES
    (1, 50.00),
    (2, 80.00),
    (3, 60.00);

INSERT INTO vacinas_aplicadas (animal_id, vacina_id, data_aplicacao) VALUES
    (1, 1, '2023-08-15'),
    (2, 2, '2023-07-20'),
    (1, 3, '2023-09-10');

INSERT INTO agendamento (cliente_id, data_hora, descricao) VALUES
    (1, '2023-09-25 10:00:00', 'Banho e Tosa'),
    (2, '2023-09-26 14:30:00', 'Consulta Veterinária'),
    (3, '2023-09-27 11:15:00', 'Vacinação');

INSERT INTO ranking (cliente_id, pontuacao) VALUES
    (1, 100),
    (2, 85),
    (3, 95);

INSERT INTO Animal_Historico (animal_id, data, descricao) VALUES
    (1, '2023-08-01', 'Exame de rotina'),
    (2, '2023-07-10', 'Vacinação anual'),
    (1, '2023-09-05', 'Tratamento para alergia');
   
INSERT INTO agendamento (cliente_id, data_hora, descricao)
VALUES
    (1, NOW(), 'Banho e Tosa'),
    (2, NOW() - INTERVAL 2 DAY, 'Consulta Veterinária'),
    (3, NOW() - INTERVAL 3 DAY, 'Vacinação'),
    (1, NOW() + INTERVAL 2 DAY, 'Consulta de Rotina'),
    (2, NOW() + INTERVAL 4 DAY, 'Banho e Tosa');


SELECT a.animal_id, a.nome AS nome_animal, a.especie, c.nome AS nome_cliente, ag.data_hora AS data_agendamento
FROM agendamento ag
INNER JOIN animal a ON ag.cliente_id = a.cliente_id
INNER JOIN clientes c ON a.cliente_id = c.cliente_id
WHERE WEEK(ag.data_hora) = WEEK(CURRENT_DATE());



INSERT INTO log_banco (data_hora, descricao)
VALUES ('2023-09-20 10:30:00', 'Log de teste 1'),
       ('2023-09-20 11:45:00', 'Log de teste 2'),
       ('2023-09-20 14:15:00', 'Log de teste 3');
   

CREATE VIEW animais_agendados_semana AS
SELECT a.animal_id, a.nome AS nome_animal, a.especie, c.nome AS nome_cliente, ag.data_hora AS data_agendamento
FROM agendamento ag
INNER JOIN animal a ON ag.cliente_id = a.cliente_id
INNER JOIN clientes c ON a.cliente_id = c.cliente_id
WHERE WEEK(ag.data_hora) = WEEK(CURRENT_DATE());

CREATE VIEW ranking_consumo_mensal AS
SELECT a.animal_id, a.nome AS nome_animal, a.especie, SUM(p.preco * io.quantidade) AS total_consumido
FROM animal a
INNER JOIN ordem_servico os ON a.cliente_id = os.cliente_id
INNER JOIN itens_ordem_servico io ON os.ordem_servico_id = io.ordem_servico_id
INNER JOIN produto_servico p ON io.produto_servico_id = p.produto_servico_id
WHERE YEAR(os.data_servico) = YEAR(CURRENT_DATE()) AND MONTH(os.data_servico) = MONTH(CURRENT_DATE())
GROUP BY a.animal_id, a.nome, a.especie
ORDER BY total_consumido DESC;

CREATE VIEW logs AS
SELECT log_id, data_hora, descricao
FROM log_banco;

DELIMITER //
CREATE TRIGGER log_produto_servico_insert
AFTER INSERT ON produto_servico FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação INSERT na tabela produto_servico');
END;
//

DELIMITER ;

DELIMITER //
CREATE TRIGGER log_produto_servico_update
AFTER UPDATE ON produto_servico FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação UPDATE na tabela produto_servico');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER log_produto_servico_delete
AFTER DELETE ON produto_servico FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação DELETE na tabela produto_servico');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER log_ordem_servico_insert
AFTER INSERT ON ordem_servico FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação INSERT na tabela ordem_servico');
END;
//

DELIMITER ;

DELIMITER //
CREATE TRIGGER log_ordem_servico_update
AFTER UPDATE ON ordem_servico FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação UPDATE na tabela ordem_servico');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER log_ordem_servico_delete
AFTER DELETE ON ordem_servico FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação DELETE na tabela ordem_servico');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER log_vacinas_aplicadas_insert
AFTER INSERT ON vacinas_aplicadas FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação INSERT na tabela vacinas_aplicadas');
END;
//

DELIMITER ;

DELIMITER //
CREATE TRIGGER log_vacinas_aplicadas_update
AFTER UPDATE ON vacinas_aplicadas FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação UPDATE na tabela vacinas_aplicadas');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER log_vacinas_aplicadas_delete
AFTER DELETE ON vacinas_aplicadas FOR EACH ROW
BEGIN
    INSERT INTO log_banco (data_hora, descricao)
    VALUES (NOW(), 'Ação DELETE na tabela vacinas_aplicadas');
END;
//
DELIMITER ;
