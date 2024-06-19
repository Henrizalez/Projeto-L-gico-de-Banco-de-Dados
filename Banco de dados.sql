-- Criação do esquema do banco de dados E-commerce
CREATE TABLE Categoria (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255)
);

CREATE TABLE Produto (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Descrição TEXT,
    Preço DECIMAL(10,2),
    Estoque INT,
    Imagem VARCHAR(255),
    Categoria INT,
    FOREIGN KEY (Categoria) REFERENCES Categoria(ID)
);

CREATE TABLE Cliente (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Email VARCHAR(255),
    Senha VARCHAR(255),
    Endereço TEXT,
    Telefone VARCHAR(20)
);

CREATE TABLE Pedido (
    ID INT PRIMARY KEY,
    Data_do_Pedido DATE,
    Cliente INT,
    Status VARCHAR(20),
    FOREIGN KEY (Cliente) REFERENCES Cliente(ID)
);

CREATE TABLE Item_do_Pedido (
    ID INT PRIMARY KEY,
    Pedido INT,
    Produto INT,
    Quantidade INT,
    Preço_Unitario DECIMAL(10,2),
    FOREIGN KEY (Pedido) REFERENCES Pedido(ID),
    FOREIGN KEY (Produto) REFERENCES Produto(ID)
);

-- Inserção de dados para testes
-- Inserindo categorias
INSERT INTO Categoria (ID, Nome) VALUES
    (1, 'Eletrônicos'),
    (2, 'Livros'),
    (3, 'Roupas');

-- Inserindo produtos
INSERT INTO Produto (ID, Nome, Descrição, Preço, Estoque, Imagem, Categoria) VALUES
    (1, 'Smartphone X', 'Smartphone de última geração', 1000.00, 50, 'smartphone_x.jpg', 1),
    (2, 'Livro Y', 'Romance emocionante', 25.00, 100, 'livro_y.jpg', 2),
    (3, 'Camiseta Z', 'Camiseta estilosa', 30.00, 200, 'camiseta_z.jpg', 3);

-- Inserindo clientes
INSERT INTO Cliente (ID, Nome, Email, Senha, Endereço, Telefone) VALUES
    (1, 'João Silva', 'joao@email.com', 'senha123', 'Rua A, 123', '(11) 98765-4321'),
    (2, 'Maria Santos', 'maria@email.com', 'senha456', 'Rua B, 456', '(21) 12345-6789');

-- Inserindo pedidos
INSERT INTO Pedido (ID, Data_do_Pedido, Cliente, Status) VALUES
    (1, '2023-10-27', 1, 'Pendente'),
    (2, '2023-10-28', 2, 'Pago');

-- Inserindo itens do pedido
INSERT INTO Item_do_Pedido (ID, Pedido, Produto, Quantidade, Preço_Unitario) VALUES
    (1, 1, 1, 2, 1000.00),
    (2, 2, 2, 1, 25.00),
    (3, 2, 3, 3, 30.00);


-- Queries SQL com diferentes clausulas

-- Recuperação simples com SELECT Statement
-- Listar todos os produtos:
SELECT * FROM Produto;

-- Listar o nome e preço de todos os produtos:
SELECT Nome, Preço FROM Produto;

-- Filtros com WHERE Statement
-- Listar produtos com preço maior que R$50:
SELECT * FROM Produto WHERE Preço > 50;

-- Listar clientes com email contendo "@gmail.com":
SELECT * FROM Cliente WHERE Email LIKE '%@gmail.com%';

-- Expressões para gerar atributos derivados
-- Calcular o valor total de um pedido:
SELECT P.ID, P.Data_do_Pedido, SUM(IP.Quantidade * IP.Preço_Unitario) AS ValorTotal
FROM Pedido AS P
JOIN Item_do_Pedido AS IP ON P.ID = IP.Pedido
GROUP BY P.ID, P.Data_do_Pedido;

-- Junções entre tabelas
-- Listar os produtos de cada pedido:
SELECT P.Nome, IP.Quantidade, IP.Preço_Unitario
FROM Produto AS P
JOIN Item_do_Pedido AS IP ON P.ID = IP.Produto
JOIN Pedido AS Pe ON IP.Pedido = Pe.ID;

-- Listar os pedidos de cada cliente:
SELECT C.Nome AS NomeCliente, Pe.ID AS IDPedido, Pe.Data_do_Pedido
FROM Cliente AS C
JOIN Pedido AS Pe ON C.ID = Pe.Cliente;