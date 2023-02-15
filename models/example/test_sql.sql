WITH dim_covenant_type AS (
    SELECT 
        id AS src_covenant_type_id,
        name AS name,
        category AS category
    FROM ncino.covenant_type
)
SELECT * FROM dim_covenant_type