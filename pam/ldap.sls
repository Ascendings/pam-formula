{% from "pam/map.jinja" import pam with context %}

ldap:
  pkg.installed:
    - name: {{ pam.ldap_pkg }}

{{ pam.ldap_config }}:
  file.managed:
    - source: salt://pam/files/ldap.conf
    - template: jinja
    - user: {{ pam.config_owner }}
    - group: {{ pam.config_group }}
    - mode: 644

{% if pam.nss_ldap %}
nss_ldap_pkg:
  pkg.installed:
    - name: {{ pam.nss_ldap_pkg }}

nss_ldap_conf:
  file.symlink:
    - name: {{ pam.nss_ldap_config }}
    - target: {{ pam.ldap_config }}
    - force: True
    - require:
      - file: {{ pam.ldap_config }}
      - pkg: nss_ldap_pkg
{% endif %}

