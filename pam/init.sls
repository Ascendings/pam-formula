{% from "pam/map.jinja" import pam with context %}

{% for pam_file, pam_config in pam.files %}
pam_config_{{ pam_file }}:
  file.managed:
    - name: /etc/pam.d/{{ pam_file }}
    - source: salt://pam/files/pam_config
    - template: jinja
    - user: {{ pam.config_owner }}
    - group: {{ pam.config_group }}
    - mode: 644
    - content:
      - pam_config: pam_config
{% endfor %}

