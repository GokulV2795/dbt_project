{% macro safe_divide(a,b) %}

case
    when {{ b }} = 0 then 0
    else {{ a }}/{{ b }}
end

{% endmacro %}