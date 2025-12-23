-- Etapa 1: importação dos dados (extract da fonte)
with source as (
    select
        "jobTitle",
        "companyName",
        "jobType",
        "jobGeo",
        "jobLevel",
        "salaryMin",
        "salaryMax",
        "salaryCurrency"
    from SNOWFLAKE_LEARNING_DB.PUBLIC.remote_jobs
),

-- Etapa 2: Renamed -> inserir as transformações
renamed as (
    select
        "jobTitle" as nome_vaga,
        "companyName" as nome_empresa,
        "jobType" as tipo_vaga,
        "jobGeo" as localizacao,
        "jobLevel" as senioridade,
        cast("salaryMin" as float) as salario_min_anual,
        cast("salaryMax" as float) as salario_max_anual,
        "salaryCurrency" as moeda
    from source
),

-- Etapa 3: fazer o select final
final as (
    select
        nome_vaga,
        nome_empresa,
        tipo_vaga,
        localizacao,
        senioridade,
        salario_min_anual,
        round(salario_min_anual / 12, 2) as salario_min_mensal,
        salario_max_anual,
        round(salario_max_anual / 12, 2) as salario_max_mensal,
        moeda
    from renamed
    where salario_min_anual != 'NaN'
    or salario_max_anual != 'NaN'
)

select * from final