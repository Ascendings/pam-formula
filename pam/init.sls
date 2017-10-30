{% from "pam/map.jinja" import pam with context %}

{% for pam_file, file_config in pam.files.items() %}
pam_config_{{ pam_file }}:
  file.managed:
    - name: /etc/pam.d/{{ pam_file }}
    - source: salt://pam/files/pam_config
    - template: jinja
    - user: {{ pam.config_owner }}
    - group: {{ pam.config_group }}
    - mode: 644
    - defaults:
      - pam_config: {{ file_config }}
{% endfor %}

