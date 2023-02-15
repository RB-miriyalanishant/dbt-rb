{{  config(
        materialized='incremental',
        unique_key='src_covenant_id',
        pre_hook = [" create or replace sequence 
        covenant_id_sequence START {{get_table_maxid('edw','dim_covenant','wh_covenant_id')}} INCREMENT 1;"]
    ) 
}}

WITH dim_covenant_type as (
    SELECT * FROM {{ref('dim_covenant_type')}}
),
dim_covenant AS(
    SELECT 
        covenant_id_sequence.nextval as wh_covenant_id,
        a.id as src_covenant_id,
        a.active as is_active,
        b.wh_covenant_type_id,
        a.last_evaluation_date,
        a.last_evaluation_status,
        a.next_evaluation_date,
        a.detail,
        a.frequency_months as frequency_month,
        a.frequency,
        a.required as is_required,
        a.comments,
        a.covenantwording as covenant_wordings,
        a.istest as is_test,
        a.due_date
    FROM ncino.covenant_management a
    join dim_covenant_type b on a.covenant_type=b.src_covenant_type_id
)
SELECT * FROM dim_covenant