with
    fonte_regiao_pais as (
        select 
            cast(countryregioncode as string) as sigla_pais
            , cast(name as string) as nome_pais   
                       
        from {{ source('raw_adventure_works', 'countryregion') }}
    )

select *
from fonte_regiao_pais


          
 