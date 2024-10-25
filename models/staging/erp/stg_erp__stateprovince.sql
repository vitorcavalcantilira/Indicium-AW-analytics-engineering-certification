with
    fonte_pais_provincia as (
        select 
            cast(stateprovinceid as int) as pk_provincia
            , cast(territoryid as int) as pk_territorio   
            , cast(countryregioncode as string) as sigla_pais
            , cast(stateprovincecode as string) as sigla_provincia    
            , cast(name as string) as nome_provincia
                       
        from {{ source('raw_adventure_works', 'stateprovince') }}
    )

select *
from fonte_pais_provincia


          
 