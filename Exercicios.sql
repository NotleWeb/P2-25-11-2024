
/* a) Faça um código SQL que exiba as vendas por: Nome do funcionário - 
    deve exibir todas as mesas atendidas pelo funcionário
    e o valor total gasto pelo cliente (3 colunas no resultado). */

SELECT f.nome AS nome_funcionario,
    m.id_mesa,
    SUM(v.valor_total) AS total_vendido
FROM Funcionario f
JOIN Mesa m 
    ON f.id_funcionario = m.id_funcionario
JOIN Venda v 
    ON m.id_mesa = v.id_mesa
GROUP BY f.nome, m.id_mesa
ORDER BY f.nome, m.id_mesa;
    
    /* b) Faça um código SQL que exiba todos os produtos
     que uma determinada mesa pediu/consumiu. */
    
SELECT pr.descricao AS produto,
    pp.quantidade,
    (pp.quantidade * pr.preco_unitario) AS valor_total
FROM Mesa m
JOIN Pedido pd 
    ON m.id_mesa = pd.id_mesa
JOIN Pedido_Produto pp 
    ON pd.id_pedido = pp.id_pedido
JOIN Produto pr ON pp.id_produto = pr.id_produto
WHERE m.id_mesa = 1;

    /* c) Implemente uma "stored procedure" que redefina o status de uma Mesa para o Status "Livre". */

DELIMITER $$
CREATE PROCEDURE redefinir_status_livre(IN mesa_id INT)
BEGIN
    UPDATE Mesa
    SET status = 'Livre'
    WHERE id_mesa = mesa_id;
END$$
DELIMITER ;

CALL redefinir_status_livre(1);

SELECT * FROM Mesa WHERE id_mesa = 1;



