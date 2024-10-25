with
    fonte_cartao_credito as (
        select 
            cast(creditcardid as int) as pk_cartao_credito
            , cast(cardtype as string) as tipo_cartao
            
        from {{ source('raw_adventure_works', 'creditcard') }}
    )

select *
from fonte_cartao_credito


          
 