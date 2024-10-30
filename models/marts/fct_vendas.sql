with
    int_vendas_metricas as (
        select *
        from {{ ref('int_vendas_metricas') }}
    )

    -- Apenas indicando que a dimensões a seguir tem relação com a fct_vendas a partir do Modelo Star-Schema.
    , dim_address as (
        select *
        from {{ ref('dim_address') }}
    )

    , dim_customer as (
        select *
        from {{ ref('dim_customer') }}
    )

    , dim_dates as (
        select *
        from {{ ref('dim_dates') }}
    )

    , dim_orders as (
        select *
        from {{ ref('dim_orders') }}
    )

    , dim_sales_reason as (
        select *
        from {{ ref('dim_sales_reason') }}
    )

select *
from int_vendas_metricas