with
    int_sales_reason_enriquecida as (
        select *
        from {{ ref('int_sales_reason_enriquecida') }}
    )

select *
from int_sales_reason_enriquecida