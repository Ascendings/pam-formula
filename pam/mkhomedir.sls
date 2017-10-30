{% from "pam/map.jinja" import pam with context %}

pam_mkhomedir:
  pkg.installed:
    - name: {{ pam.mkhomedir_pkg }}

{% if pam.mkhomedir_config -%}
{{ pam.mkhomedir_config }}:
  file.managed:
    - source: salt://pam/files/mkhomedir
    - user: root
    - group: root
    - require:
      - pkg: pam_mkhomedir
{%- endif %}

