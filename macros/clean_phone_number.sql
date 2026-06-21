{% macro clean_phone_number(column_name) %}
    case 
        when startsWith(toString({{ column_name }}), '254') then toString({{ column_name }})
        when startsWith(toString({{ column_name }}), '0') then concat('254', substring(toString({{ column_name }}), 2))
        when startsWith(toString({{ column_name }}), '+254') then substring(toString({{ column_name }}), 2)
        else concat('254', toString({{ column_name }}))
    end
{% endmacro %}