with
    salesorderheader as (
        select *
        from {{ ref('stg_erp__salesorderheader') }}
    )
    ,salesorderdetail as (
        select *
        from {{ ref('stg_erp__salesorderdetail') }}
    )

    ,creditcard as (
        select *
        from {{ ref('stg_erp__creditcard') }}
    )

    
    ,detalhamento_vendas as (
        select
            salesorderheader.fk_pedido

            , row_number () over (partition by salesorderheader.fk_pedido order by salesorderdetail.fk_pedido) as row_sales_orderdetails
            
            , cast(salesorderdetail.preco_da_unidade*salesorderdetail.qtd_pedido as numeric(18,2)) as valor_bruto
            , salesorderdetail.qtd_pedido

        from salesorderheader
        left join salesorderdetail on salesorderheader.fk_pedido = salesorderdetail.fk_pedido
    )

    ,metricas as (
        select
            fk_pedido

            , count(row_sales_orderdetails) as qtd_produtos
            , sum(valor_bruto) as valor_bruto_ordenado
            , sum(qtd_pedido) as qtd_pedidos_total

        from detalhamento_vendas
        group by fk_pedido
    )

    ,final_select as (
        select
            salesorderheader.fk_pedido
            , salesorderheader.fk_endereco
            , salesorderheader.pk_cliente

            , IFNULL(creditcard.tipo_cartao, 'Nao registrado') as tipo_cartao

            , IFNULL(salesorderheader.status, 'Nao registrado') as status

            , salesorderheader.data_abreviada
            , salesorderheader.order_year
            , salesorderheader.order_month
            , salesorderheader.order_day 
            , salesorderheader.sub_total
            , salesorderheader.valor_taxas
            , salesorderheader.valor_frete
            , salesorderheader.total_devido

            , metricas.qtd_produtos
            , metricas.qtd_pedidos_total
            , metricas.valor_bruto_ordenado        

        from salesorderheader
        left join metricas on salesorderheader.FK_PEDIDO = metricas.FK_PEDIDO
        left join creditcard on salesorderheader.pk_cartao_credito = creditcard.pk_cartao_credito
        order by salesorderheader.FK_PEDIDO

    )
    select *
    from final_select