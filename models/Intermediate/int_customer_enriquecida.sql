with
    customer as (
        select *
        from {{ ref('stg_erp__customer') }}
    )


    , person as (
        select *
        from {{ ref('stg_erp__person') }}

    )

    , cliente_enriquecida as (
        select
            customer.pk_cliente
            , IFNULL(person.pessoal_nome_completo, 'Nao registrado') as nome_cliente
        
        from customer
        left join person on customer.pk_cliente = person.pk_cliente
    )      

select *
from cliente_enriquecida
