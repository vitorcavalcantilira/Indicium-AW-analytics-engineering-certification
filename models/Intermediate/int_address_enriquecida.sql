with
    address as (
        select *
        from {{ ref('stg_erp__address') }}
    )


    , countryregion as (
        select *
        from {{ ref('stg_erp__countryregion') }}
    )


    , stateprovince as (
        select *
        from {{ ref('stg_erp__stateprovince') }}
    )


    , salesterritory as (
        select *
        from {{ ref('stg_erp__salesterritory') }} 
    )

 
    , salesorderheader as (
        select
            fk_pedido
            , pk_territorio
            , fk_endereco
        from {{ ref('stg_erp__salesorderheader') }} 
    )

    , join_salesorderheader_address as (
        select
            salesorderheader.fk_endereco
            , salesorderheader.fk_pedido
            , row_number () over (partition by salesorderheader.fk_endereco order by salesorderheader.fk_pedido) as row_address_id

            , address.endereco_cidade
            , address.fk_provincia

        from salesorderheader
        left join address on salesorderheader.fk_endereco = address.pk_endereco
    )

    , join_address_stateprovince as (
        select
            join_salesorderheader_address.fk_endereco
            , join_salesorderheader_address.row_address_id
            , join_salesorderheader_address.endereco_cidade

            , stateprovince.nome_provincia
            , stateprovince.sigla_pais
            , stateprovince.pk_territorio
        from join_salesorderheader_address
        left join stateprovince on join_salesorderheader_address.fk_provincia = stateprovince.pk_provincia
        where join_salesorderheader_address.row_address_id = 1
    )

    , address_enriquecida as (
        select
            join_address_stateprovince.fk_endereco
            , join_address_stateprovince.endereco_cidade
            , join_address_stateprovince.nome_provincia

            , countryregion.nome_pais

            , salesterritory.nome_territorio

        from join_address_stateprovince
        left join countryregion on join_address_stateprovince.sigla_pais = countryregion.sigla_pais
        left join salesterritory on join_address_stateprovince.pk_territorio = salesterritory.pk_territorio

    )        

select *
from address_enriquecida