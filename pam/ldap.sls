{% from "pam/map.jinja" import pam with context %}

ldap:
  pkg.installed:
    - name: {{ pam.ldap_pkg }}

{{ pam.ldap_config }}:
  file.managed:
    - source: salt://pam/files/ldap.conf
    - user: root
    - group: root
    - mode: 644

{% if pam.nss_ldap %}
nss_ldap_pkg:
  pkg.installed:
    - name: {{ pam.nss_ldap }}

nss_ldap_conf:
  file.symlink:
    - name: {{ pam.ldap_config }}
    - target: {{ pam.nss_ldap_config }}
    - require:
      - file: {{ pam.ldap_config }}
      - pkg: nss_ldap_pkg
{% endif %}

