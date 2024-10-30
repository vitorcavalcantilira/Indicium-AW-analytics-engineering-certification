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
            person.pk_cliente
            , IFNULL(person.pessoal_nome_completo, 'Nao registrado') as nome_cliente
        
        from person
        left join customer on person.pk_cliente = customer.pk_cliente
    )      

select *
from cliente_enriquecida