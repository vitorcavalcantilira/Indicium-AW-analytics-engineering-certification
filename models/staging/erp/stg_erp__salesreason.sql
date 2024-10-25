with
    fonte_motivo_venda as (
        select 
            cast(salesreasonid as int) as pk_motivo_venda
            , cast(name as string) as nome_motivo
            , cast(reasontype as string) as tipo_motivo
        from {{ source('raw_adventure_works', 'salesreason') }}
    )

select *
from fonte_motivo_venda


          
 