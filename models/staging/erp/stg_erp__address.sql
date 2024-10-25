with
    fonte_endereco as (
        select 
            cast(addressid as int) as pk_endereco
            , cast(stateprovinceid as int) as fk_endereco_provincia            
            , cast(city as string) as endereco_cidade
                       
        from {{ source('raw_adventure_works', 'address') }}
    )

select *
from fonte_endereco


          
 