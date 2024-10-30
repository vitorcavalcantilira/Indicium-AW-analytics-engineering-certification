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
            salesorderdetail.PK_PEDIDO_ITEM
            ,salesorderdetail.FK_PEDIDO
            ,salesorderdetail.FK_PRODUTO
            ,IFNULL(product.nome_produto, 'Nao registrado') as nome_produto
            ,salesorderdetail.QTD_PEDIDO
            ,salesorderdetail.PRECO_DA_UNIDADE
            ,salesorderdetail.DESCONTO_UNIDADE
            ,cast(salesorderdetail.qtd_pedido*salesorderdetail.preco_da_unidade*(1-salesorderdetail.desconto_unidade) 
                as numeric(18,2)) as VALOR_LIQUIDO
        
        from salesorderdetail
        left join product on salesorderdetail.fk_produto = product.pk_produto
    )      

select *
from order_enriquecida