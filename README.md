# Ansible role to install Hashicorp Vault
[![Ansible Lint](https://github.com/ansible-community/ansible-vault/actions/workflows/ansible-lint.yml/badge.svg?branch=master)](https://github.com/ansible-community/ansible-vault/actions/workflows/ansible-lint.yml?query=branch%3Amaster)
[![Ansible Molecule](https://github.com/ansible-community/ansible-vault/actions/workflows/molecule.yml/badge.svg?branch=master)](https://github.com/ansible-community/ansible-vault/actions/workflows/molecule.yml?query=branch%3Amaster)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/ansible-community/ansible-vault.svg)](http://isitmaintained.com/project/ansible-community/ansible-vault "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/ansible-community/ansible-vault.svg)](http://isitmaintained.com/project/ansible-community/ansible-vault "Percentage of issues still open")

This Ansible role performs a basic [Vault](https://vaultproject.io/)
installation, including filesystem structure and example configuration.

It can also bootstrap a minimal development or evaluation server or HA
Consul-backed cluster in a Vagrant based environment. See
[README_VAGRANT.md](https://github.com/ansible-community/ansible-vault/blob/master/examples/README_VAGRANT.md) and the associated [Vagrantfile](https://github.com/ansible-community/ansible-vault/blob/master/examples/Vagrantfile) for more details about the developer mode setup.

## Installation
This role resides on GitHub pending the integration with Ansible Galaxy. To install this role create a `roles/requirements.yml` file in your Ansible project folder with the following contents:

```yaml
- src: https://github.com/ansible-community/ansible-vault.git
  name: ansible-community.ansible-vault
  scm: git
  version: master
```

You can use git tag in the version attribute. Also you can honor its legacy `name: brianshumate.ansible-vault`.

## Quick Start Guide

Basic installation is possible using the included [`site.yml`](examples/site.yml) playbook:

```
ansible-playbook -i hosts site.yml
```

You can also pass variables in using the `--extra-vars` option to the
`ansible-playbook` command:

```
ansible-playbook -i hosts site.yml --extra-vars "vault_datacenter=maui"
```

Specify a template file with a different backend definition
(see `templates/backend_consul.j2`):

```
ansible-playbook -i hosts site.yml --extra-vars "vault_backend_file=backend_file.j2"
```

You need to make sure that the template file `backend_file.j2` is in the
role directory for this to work.

## Requirements

This role requires Archlinux, AmazonLinux, FreeBSD, Debian or a RHEL based Linux distribution. It
might work with other software versions, but does work with the following
specific software and versions. Sorry, there is no planned support at the moment for Windows.

See the [molecule scenarios](https://github.com/ansible-community/ansible-vault/tree/master/molecule)
for currently tested distributions.

## Warning

By default, this role may restart `vault` service when played (when there's a
configuration change, OS Packages installed/updated)

When there's no auto-unseal setup on your cluster, the restart may lead to a
situation where all Vault instances will be sealed and your cluster will be
down.

To avoid this situation, the service restart by the playbook can be disabled
by using the `vault_service_restart` role variable.

Setting this `vault_service_restart` to `false` will disable the `vault`
service restart by the playbook. You may have to restart the service manually
to load any new configuration deployed.

## [Role Variables](role_variables.md)

## Misc

### [Vault Release Scheme](vault_releases.md)

## License

BSD-2-Clause

## Author Information

[Brian Shumate](http://brianshumate.com)

## Contributors

Special thanks to the folks listed in [CONTRIBUTORS.md](https://github.com/brianshumate/ansible-vault/blob/master/CONTRIBUTORS.md) for their
contributions to this project.
