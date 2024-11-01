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

            , row_number () over (partition by salesorderheader.fk_pedido order by salesorderdetail.pk_pedido_item) as row_sales_orderdetails
            
            , salesorderdetail.preco_da_unidade*salesorderdetail.qtd_pedido as valor_bruto
            , salesorderdetail.qtd_pedido

        from salesorderheader
        left join salesorderdetail on salesorderheader.fk_pedido = salesorderdetail.fk_pedido
    )

    ,metricas as (
        select
            fk_pedido

            , count(row_sales_orderdetails) as qtd_de_ordens
            , sum(valor_bruto) as valor_bruto_ordenado
            , sum(qtd_pedido) as qtd_produtos

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

            , salesorderheader.full_date
            , salesorderheader.order_year
            , salesorderheader.order_month
            , salesorderheader.order_day 
            , salesorderheader.sub_total
            , salesorderheader.valor_taxas
            , salesorderheader.valor_frete
            , salesorderheader.total_devido

            , metricas.qtd_de_ordens
            , metricas.qtd_produtos
            , metricas.valor_bruto_ordenado        

        from salesorderheader
        left join metricas on salesorderheader.fk_pedido = metricas.fk_pedido
        left join creditcard on salesorderheader.pk_cartao_credito = creditcard.pk_cartao_credito
        order by salesorderheader.fk_pedido

    )
    
    select *
    from final_select

    /*select
        sum(sub_total)
        , sum(valor_bruto_ordenado)
    from final_select
    where full_date between '2011-01-01' and '2011-12-31'*/
    -- Teste para valor vendas em 2011