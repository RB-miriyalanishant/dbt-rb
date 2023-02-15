{{  config(
        materialized='incremental',
        unique_key='src_covenant_type_id',
        pre_hook = [" create or replace sequence 
        covenant_id_sequence START {{get_table_maxid('edw','dim_covenant_type','wh_covenant_type_id')}} INCREMENT 1;"]
    ) 
}}

WITH
    dim_covenant_type AS (
        SELECT
            covenant_id_sequence.nextval AS wh_covenant_type_id,
            id AS src_covenant_type_id,
            name AS name, 
            category AS category
        FROM ncino.covenant_type
    )
SELECT *
FROM dim_covenant_type
