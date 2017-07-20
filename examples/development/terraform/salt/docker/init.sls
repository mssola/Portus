# TODO: insecure registry
docker:
  pkg.installed:
    - install_recommends: False
  service.running:
    - enable: True

docker-compose:
  pkg.installed:
    - install_recommends: False

{% if "portus" in salt["grains.get"]("roles", []) -%}
# TODO: certificates
# TODO: hostname
docker-distribution-registry:
  pkg.installed:
    - install_recommends: False
  service.running:
    - enable: True
    - watch:
      - file: /etc/registry/config.yml

/etc/registry/config.yml:
  file.managed:
    - source: salt://docker/registry.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: docker-distribution-registry
{% endif %}
