with
    
    salesorderheader_data as (
        select*, 
            cast(orderdate as timestamp) as orderdate_timestamp
        from {{ source('raw_adventure_works', 'salesorderheader') }}
    )
    
    ,extracao_data as (
        select*
            , orderdate_timestamp::date as order_date
            , extract(year from orderdate_timestamp) as order_year
            , extract(month from orderdate_timestamp) as order_month
            , extract(day from orderdate_timestamp) as order_day
            
        from salesorderheader_data
    )


    ,fonte_pedido_header as (
        select 
            cast(salesorderid as int) as fk_pedido
            --, (order_day || '-' || order_month || '-'|| order_year) as data_abreviada
            , order_date
            , order_year
            , order_month
            , order_day               
            , cast(customerid as int) as pk_cliente
            , cast(salespersonid as int) as fk_vendas_pessoa
            , cast(territoryid as int) as pk_territorio
            , cast(shiptoaddressid as int) as fk_endereco
            , case when status = 5 then 'Shipped' end as status                   
            , cast(creditcardid as int) as pk_cartao_credito
            , cast(subtotal as numeric(18,2)) as sub_total
            , cast(taxamt as numeric(18,2)) as valor_taxas
            , cast(freight as numeric(18,2)) as valor_frete
            , cast(totaldue as numeric(18,2)) as total_devido

        from extracao_data     
        
    )

select *
from fonte_pedido_header

/*select
    sum(sub_total) as sub_total
from fonte_pedido_header
where order_date between '2011-01-01' and '2011-12-31'
--where order_year = 2011*/

