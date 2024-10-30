with
    fonte_pedido_motivo_venda as (
        select 
            cast(salesreasonid as int) as pk_motivo_venda
            , cast(salesorderid as int) as fk_pedido
            
        from {{ source('raw_adventure_works', 'salesorderheadersalesreason') }}
    )

select *
from fonte_pedido_motivo_venda

          
 