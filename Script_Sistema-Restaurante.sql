-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.39 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para p2
CREATE DATABASE IF NOT EXISTS `p2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `p2`;

-- Copiando estrutura para tabela p2.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.cliente: ~5 rows (aproximadamente)
INSERT IGNORE INTO `cliente` (`id_cliente`, `nome`) VALUES
	(1, 'Julio Balestrin'),
	(2, 'Miguel Alvarez'),
	(3, 'Juliana Lima'),
	(4, 'Jefferson da Silva'),
	(5, 'Gabriel Gomez');

-- Copiando estrutura para tabela p2.forma_pagamento
CREATE TABLE IF NOT EXISTS `forma_pagamento` (
  `id_forma_pagamento` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id_forma_pagamento`),
  UNIQUE KEY `descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.forma_pagamento: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela p2.funcionario
CREATE TABLE IF NOT EXISTS `funcionario` (
  `id_funcionario` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  PRIMARY KEY (`id_funcionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.funcionario: ~3 rows (aproximadamente)
INSERT IGNORE INTO `funcionario` (`id_funcionario`, `nome`) VALUES
	(1, 'Paulo Gomes'),
	(2, 'Sergio Lurat'),
	(3, 'Fernanda Manoela');

-- Copiando estrutura para tabela p2.mesa
CREATE TABLE IF NOT EXISTS `mesa` (
  `id_mesa` int NOT NULL AUTO_INCREMENT,
  `status` enum('Livre','Ocupada','Sobremesa','Ocupada-Ociosa') NOT NULL,
  `id_funcionario` int NOT NULL,
  PRIMARY KEY (`id_mesa`),
  KEY `Index 2` (`id_funcionario`),
  CONSTRAINT `Fk_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.mesa: ~5 rows (aproximadamente)
INSERT IGNORE INTO `mesa` (`id_mesa`, `status`, `id_funcionario`) VALUES
	(1, 'Ocupada', 1),
	(2, 'Sobremesa', 1),
	(3, 'Ocupada', 2),
	(4, 'Livre', 3),
	(5, 'Ocupada', 3);

-- Copiando estrutura para tabela p2.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` int NOT NULL,
  `id_mesa` int NOT NULL,
  `data_hora` datetime NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_mesa` (`id_mesa`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_mesa`) REFERENCES `mesa` (`id_mesa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.pedido: ~3 rows (aproximadamente)
INSERT IGNORE INTO `pedido` (`id_pedido`, `id_mesa`, `data_hora`) VALUES
	(1, 1, '2024-11-25 12:00:00'),
	(2, 1, '2024-11-25 13:00:00'),
	(3, 2, '2024-11-25 14:00:00');

-- Copiando estrutura para tabela p2.pedido_produto
CREATE TABLE IF NOT EXISTS `pedido_produto` (
  `id_pedido` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`id_pedido`,`id_produto`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `pedido_produto_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `pedido_produto_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.pedido_produto: ~4 rows (aproximadamente)
INSERT IGNORE INTO `pedido_produto` (`id_pedido`, `id_produto`, `quantidade`) VALUES
	(1, 1, 2),
	(1, 2, 3),
	(2, 3, 1),
	(3, 2, 2);

-- Copiando estrutura para tabela p2.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descricao` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `preco_unitario` decimal(10,2) DEFAULT '0.00',
  `quantidade_estoque` int DEFAULT '0',
  `estoque_minimo` int DEFAULT '0',
  `marca` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id_produto`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.produto: ~3 rows (aproximadamente)
INSERT IGNORE INTO `produto` (`id_produto`, `codigo`, `descricao`, `preco_unitario`, `quantidade_estoque`, `estoque_minimo`, `marca`) VALUES
	(1, '1', 'Pizza', 40.00, 59, 7, 'Pizza-Hut'),
	(2, '2', 'Refrigerante', 10.00, 101, 29, 'Coca-Cola'),
	(3, '3', 'Hambúrguer', 25.00, 34, 1, 'De siri');

-- Copiando estrutura para tabela p2.venda
CREATE TABLE IF NOT EXISTS `venda` (
  `id_venda` int NOT NULL AUTO_INCREMENT,
  `id_mesa` int NOT NULL,
  `id_cliente` int DEFAULT NULL,
  `data_hora` datetime DEFAULT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `id_forma_pagamento` int DEFAULT NULL,
  PRIMARY KEY (`id_venda`),
  KEY `id_mesa` (`id_mesa`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_forma_pagamento` (`id_forma_pagamento`),
  CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`id_mesa`) REFERENCES `mesa` (`id_mesa`),
  CONSTRAINT `venda_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `venda_ibfk_3` FOREIGN KEY (`id_forma_pagamento`) REFERENCES `forma_pagamento` (`id_forma_pagamento`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.venda: ~5 rows (aproximadamente)
INSERT IGNORE INTO `venda` (`id_venda`, `id_mesa`, `id_cliente`, `data_hora`, `valor_total`, `id_forma_pagamento`) VALUES
	(1, 1, 1, NULL, 50.00, NULL),
	(2, 1, 2, NULL, 30.00, NULL),
	(3, 2, 3, NULL, 40.00, NULL),
	(4, 3, 4, NULL, 70.00, NULL),
	(5, 5, 1, NULL, 90.00, NULL);

-- Copiando estrutura para tabela p2.venda_produto
CREATE TABLE IF NOT EXISTS `venda_produto` (
  `id_venda_produto` int NOT NULL AUTO_INCREMENT,
  `id_venda` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_venda_produto`),
  KEY `id_venda` (`id_venda`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `venda_produto_ibfk_1` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`),
  CONSTRAINT `venda_produto_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela p2.venda_produto: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
