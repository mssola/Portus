<p align="center"><a href="http://port.us.org" target="_blank" rel="noopener noreferrer"><img width="120" src="http://port.us.org/images/portus-logo.png" alt="Portus logo"></a></p>

<p align="center">
  <a href="http://port.us.org" title="Website">Website</a> |
  <a href="http://port.us.org/documentation.html" title="Documentation">Documentation</a> |
  <a href="http://port.us.org/blog/index.html" title="Blog">Blog</a> |
  <a href="https://groups.google.com/forum/#!forum/portus-dev" title="Mailing list">Mailing list</a> |
  <a href="http://port.us.org/docs/versions.html" title="Supported versions">Supported versions</a> |
  <a href="http://port.us.org/docs/deploy.html" title="How to deploy">How to deploy</a>
</p>

<p align="center">
  <a href="https://travis-ci.org/SUSE/Portus" title="Travis CI status for the master branch"><img src="https://travis-ci.org/SUSE/Portus.svg?branch=master" alt="Build Status for master branch" /></a>
  <a href="https://travis-ci.org/github/SUSE/Portus/branches" title="Travis CI status for the v2.4 branch"><img src="https://travis-ci.org/SUSE/Portus.svg?branch=v2.4" alt="Build Status for v2.4 branch" /></a>
  <a href="https://codeclimate.com/github/SUSE/Portus" title="Codeclimate"><img src="https://codeclimate.com/github/SUSE/Portus/badges/gpa.svg" alt="Codeclimate status" /></a>
  <a href="https://codeclimate.com/github/SUSE/Portus/coverage" title="Code coverage"><img src="https://codeclimate.com/github/SUSE/Portus/badges/coverage.svg" alt="Code coverage" /></a>
  <a href="https://github.com/SUSE/Portus/blob/master/LICENSE" title="License"><img src="https://raw.githubusercontent.com/SUSE/Portus/site-source/images/license.png" alt="License" /></a>
</p>

---

**Portus** is an authorization server and a user interface for the next generation
of the Docker registry. Portus targets [version
2](https://github.com/docker/distribution/blob/master/docs/spec/api.md) of the
Docker Registry API. The minimum required version of Registry is 2.1, which is
the first version supporting soft deletes of blobs.

**Current stable version**: **2.4.3** ([2.4](https://hub.docker.com/r/opensuse/portus/tags), [2.4.3](https://hub.docker.com/r/opensuse/portus/tags) and [latest](https://hub.docker.com/r/opensuse/portus/tags) Docker tags).

## Features

### Fine-grained control of permissions

Portus supports the concept of users and teams. Users have their own personal
Docker namespace where they have both read (aka `docker pull`) and write (aka
`docker push`) access. A team is a group of users that have read and write
access to a certain namespace. You can read more about this in our
[documentation page about
it](http://port.us.org/features/3_teams_namespaces_and_users.html).

Portus implements the [token based authentication
system](https://github.com/docker/distribution/blob/master/docs/spec/auth/token.md)
described by the new version of the Docker registry. This can be used to have
full control over the images served by an instance of the Docker registry.

### Web interface for Docker registry

Portus provides quick access to all the images available on your private
instance of Docker registry. User's privileges are taken into account to make
sure private images (the ones requiring special rights also for `docker pull`)
are not shown to unauthorized personnel.

### Self-hosted

Portus allows you to host everything on your servers, on your own
infrastructure. You don't have to trust a third-party service, just own
everything yourself. Take a look at our
[documentation](http://port.us.org/docs/deploy.html) to read the different
setups in which you can deploy Portus.

### And more!

Some highlights:

- [Synchronization with your private registry in order to fetch which images and tags are available](http://port.us.org/features/1_Synchronizing-the-Registry-and-Portus.html).
- [LDAP user authentication](http://port.us.org/features/2_LDAP-support.html).
- OAuth and OpenID-Connect authentication
- [Monitoring of all the activities performed onto your private registry and Portus itself](http://port.us.org/features/4_audit.html).
- [Search for repositories and tags inside of your private registry](http://port.us.org/features/5_search.html).
- [Star your favorite repositories](http://port.us.org/features/6_starring.html).
- [Disable users temporarily](http://port.us.org/features/7_disabling_users.html).
- [Optionally use Application Tokens for better security](http://port.us.org/features/application_tokens.html).

Take a tour by our [documentation](http://port.us.org/features.html) site to
read more about this.

## Contributing

Do you want to contribute with code, or to report an issue you are facing? Read
the [CONTRIBUTING.md](./CONTRIBUTING.md) file.

## [Changelog](https://pbs.twimg.com/media/DJDYCcLXcAA_eIo?format=jpg&name=small)

Read the [CHANGELOG.md](./CHANGELOG.md) file.

## Licensing

Portus is licensed under the Apache License, Version 2.0. See
[LICENSE](https://github.com/SUSE/Portus/blob/master/LICENSE) for the full
license text.
