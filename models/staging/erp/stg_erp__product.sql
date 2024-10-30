with
    fonte_produto as (
        select 
            cast(productid as int) as pk_produto
            , cast(name as string) as nome_produto
            
        from {{ source('raw_adventure_works', 'product') }}
    )

select *
from fonte_produto


 