with 
    date_spine as (
        {{ dbt_utils.date_spine(datepart="day", start_date="cast('1970-01-01' as date)",end_date="cast('2014-12-31' as date)"
        )}}
    )

    ,date_casted as (
        select
            cast(date_day as timestamp) as date_time
        from date_spine
    )


    ,date_final as (
        select
            date_time::date as full_date  -- Converte timestamp para date
        from date_casted
    )


    ,calendar as (
        select
        full_date
        ,extract(year from full_date) as year
        ,extract(month from full_date) as month
        ,extract(day from full_date) as day
        -- Nome do mês
        ,case 
            when extract(month from full_date) = 1 then 'Janeiro'
            when extract(month from full_date) = 2 then 'Fevereiro'
            when extract(month from full_date) = 3 then 'Março'
            when extract(month from full_date) = 4 then 'Abril'
            when extract(month from full_date) = 5 then 'Maio'
            when extract(month from full_date) = 6 then 'Junho'
            when extract(month from full_date) = 7 then 'Julho'
            when extract(month from full_date) = 8 then 'Agosto'
            when extract(month from full_date) = 9 then 'Setembro'
            when extract(month from full_date) = 10 then 'Outubro'
            when extract(month from full_date) = 11 then 'Novembro'
            when extract(month from full_date) = 12 then 'Dezembro'
        end as month_name
        -- Concatenação de mês/ano
        ,concat(
            case 
                when extract(month from full_date) = 1 then 'Janeiro'
                when extract(month from full_date) = 2 then 'Fevereiro'
                when extract(month from full_date) = 3 then 'Março'
                when extract(month from full_date) = 4 then 'Abril'
                when extract(month from full_date) = 5 then 'Maio'
                when extract(month from full_date) = 6 then 'Junho'
                when extract(month from full_date) = 7 then 'Julho'
                when extract(month from full_date) = 8 then 'Agosto'
                when extract(month from full_date) = 9 then 'Setembro'
                when extract(month from full_date) = 10 then 'Outubro'
                when extract(month from full_date) = 11 then 'Novembro'
                when extract(month from full_date) = 12 then 'Dezembro'
            end, '/', extract(year from full_date)
        ) as month_and_year
    from date_final
    )

select *
from calendar
order by full_date desc