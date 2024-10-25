with
    fonte_clientes as (
        select 
            cast(customerid as int) as pk_cliente
            , cast(territoryid as int) as pk_territorio
            , cast(personid as int) as fk_pessoal            
            
        from {{ source('raw_adventure_works', 'customer') }}
    )

select *
from fonte_clientes


          
 