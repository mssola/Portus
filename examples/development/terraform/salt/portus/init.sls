# Needed for bundling Portus

portus-deps:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - libmysqld-devel
      - postgresql-devel
      - libxml2-devel

# Utils for Portus' development

yarn:
  pkg.installed:
    - install_recommends: False
