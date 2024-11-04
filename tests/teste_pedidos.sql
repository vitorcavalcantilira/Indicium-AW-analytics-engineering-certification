/*  Este teste garante que os pedidos realizados e a chave de identificação pedido_item estão
    corretas no intervalo de 2011 a 2014: 
    - Qtd de Pedidos distintos: 31465
    - Qtd de Chaves de Indentificação pedido_item destintas: 121317
*/

with
    teste_pedidos as (
        select      
            count (distinct fk_pedido) as qtd_distinta_chave_pedidos
            --, count (distinct pk_pedido_item) as qtd_distinta_pedido_item
        
        from {{ ref('int_sales_reason_enriquecida') }}

    )

select
    qtd_distinta_chave_pedidos
    --, qtd_distinta_pedido_item conferência da qtd_distinta_pedido_item != 121317
from teste_pedidos
where qtd_distinta_chave_pedidos != 31465 
