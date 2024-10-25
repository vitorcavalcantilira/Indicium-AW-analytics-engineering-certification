with
    fonte_pessoal as (
        select 
            cast(businessentityid as int) as pk_companhia
            , cast(firstname || ' ' || lastname as string) as pessoal_nome_completo
                       
        from {{ source('raw_adventure_works', 'person') }}
    )

select *
from fonte_pessoal


          
 