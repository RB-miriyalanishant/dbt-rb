{% macro get_table_maxid(schemaname, tablename, columnname) -%}

    {% call statement("get_maxid_existing", fetch_result=True) -%}

        select ifnull(max({{ columnname }}), 0) + 1 as maxid
        from {{ "RB_DEV" }}.{{ schemaname }}.{{ tablename }}

    {%- endcall %}

    {% if execute %}

        {% set max_existing_id = (load_result("get_maxid_existing").table.columns["MAXID"].values()[0]) -%} 
    
        {{ return(max_existing_id) }}

    {% else %} 
        {{ return(false) }}

    {% endif %}

{%- endmacro %}
