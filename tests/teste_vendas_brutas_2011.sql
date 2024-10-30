/*  Este teste garante que as vendas brutas de 2011 estão
    corretas com o valor auditado da contabilidade:
    $12.646.112,16
*/

with
    vendas_brutas_2011 as (
        select 
            sum(valor_bruto_ordenado) as total_bruto_ordenado
            --, round(sum(valor_bruto_ordenado),2) as total_bruto_ordenado --valor arredondado com 2 casas decimais          
        
        from {{ ref('int_vendas_metricas') }}
        where order_date between '2011-01-01' and '2011-12-31'

    )

select total_bruto_ordenado
from vendas_brutas_2011
where total_bruto_ordenado not between 12646112.1600 and 12646112.1610
--where total_bruto_ordenado != 12646112,16 --valor de teste com arredondamento de 2 casas decimais
