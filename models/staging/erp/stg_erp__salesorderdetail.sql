with
    fonte_pedido_itens as (
        select 
            cast(salesorderdetailid as int) as pk_pedido_item
            , cast(salesorderid as int) as fk_pedido
            , cast(productid as int) as fk_produto
            , cast(orderqty as int) as qtd_pedido
            , cast(unitprice as numeric(18,2)) as preco_da_unidade
            , cast(unitpricediscount as numeric(18,2)) as desconto_unidade
        from {{ source('raw_adventure_works', 'salesorderdetail') }}
    )

select *
from fonte_pedido_itens

          
 