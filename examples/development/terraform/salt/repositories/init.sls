/etc/zypp/repos.d/portus.repo:
  file.managed:
    - source: salt://repositories/portus.repo
    - order: 0
    - template: jinja
