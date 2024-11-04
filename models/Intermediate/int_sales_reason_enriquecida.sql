with
    salesreason as (
        select *
        from {{ ref('stg_erp__salesreason') }}
    )


    , salesorderheadersalesreason as (
        select *
        from {{ ref('stg_erp__salesorderheadersalesreason') }}

    )

    , salesorderheader as (
        select *
        from {{ ref('stg_erp__salesorderheader') }} 
    
    )

    , order_reason as (
        select
            salesorderheadersalesreason.fk_pedido
            , salesorderheadersalesreason.pk_motivo_venda
            , salesreason.nome_motivo
            , salesreason.tipo_motivo
        
        from salesorderheadersalesreason
        left join salesreason on salesorderheadersalesreason.pk_motivo_venda = salesreason.pk_motivo_venda
    )

    , sales_reason_enriquecida as (
        select
            salesorderheader.fk_pedido
            , IFNULL(array_to_string(array_agg(IFNULL(order_reason.nome_motivo, 'Nao registrado')), ', '), 'Nao registrado') as nome_motivo
            , IFNULL(array_to_string(array_agg(IFNULL(order_reason.tipo_motivo, 'Nao registrado')), ', '), 'Nao registrado') as tipo_motivo
            --, order_reason.pk_motivo_venda
            --, order_reason.nome_motivo
            --, order_reason.tipo_motivo

        from salesorderheader
        left join order_reason on salesorderheader.fk_pedido = order_reason.fk_pedido
        group by salesorderheader.fk_pedido
    )      

select *
from sales_reason_enriquecida


