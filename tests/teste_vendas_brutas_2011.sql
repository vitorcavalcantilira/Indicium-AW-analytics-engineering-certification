/*  Este teste garante que as vendas brutas de 2011 estão
    corretas com o valor auditado da contabilidade:
    $12.646.112,16
*/

with
    vendas_brutas_2011 as (
        select 
            sum(gross_subtotal_by_order) as total_bruto
        
        from {{ ref('fct_orders') }}
        where order_year = 2011

    )

select total_bruto
from vendas_brutas_2011
where total_bruto not between 12646112.10 and 12646112.20
