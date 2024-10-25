with
    fonte_territorio_venda as (
        select 
            cast(territoryid as int) as pk_territorio
            , cast(name as string) as nome_territorio
            , cast(countryregioncode as string) as sigla_pais
            , cast("group" as string) as regiao_pais
            
        from {{ source('raw_adventure_works', 'salesterritory') }}
    )

select *
from fonte_territorio_venda


          
 