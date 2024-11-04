with
    product as (
        select *
        from {{ ref('stg_erp__product') }}
    )


    , salesorderdetail as (
        select *
        from {{ ref('stg_erp__salesorderdetail') }}

    )

    , order_enriquecida as (
        select
            salesorderdetail.pk_pedido_item
            ,salesorderdetail.fk_pedido
            ,salesorderdetail.fk_produto
            ,IFNULL(product.nome_produto, 'Nao registrado') as nome_produto
            ,salesorderdetail.qtd_pedido as qtd_produtos
            ,salesorderdetail.preco_da_unidade
            ,salesorderdetail.desconto_unidade
            ,cast(salesorderdetail.qtd_pedido*salesorderdetail.preco_da_unidade*(1-salesorderdetail.desconto_unidade) 
                as numeric(18,4)) as valor_liquido
        
        from salesorderdetail
        left join product on salesorderdetail.fk_produto = product.pk_produto
        order by pk_pedido_item
    )      

select *
from order_enriquecida