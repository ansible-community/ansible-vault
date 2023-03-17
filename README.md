 # Vault
[![Build Status](https://travis-ci.org/ansible-community/ansible-vault.svg?branch=master)](https://travis-ci.org/ansible-community/ansible-vault)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/ansible-community/ansible-vault.svg)](http://isitmaintained.com/project/ansible-community/ansible-vault "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/ansible-community/ansible-vault.svg)](http://isitmaintained.com/project/ansible-community/ansible-vault "Percentage of issues still open")

This Ansible role performs a basic [Vault](https://vaultproject.io/)
installation, including filesystem structure and example configuration.

It can also bootstrap a minimal development or evaluation server or HA
Consul-backed cluster in a Vagrant and VirtualBox based environment. See
[README_VAGRANT.md](https://github.com/ansible-community/ansible-vault/blob/master/examples/README_VAGRANT.md) and the associated [Vagrantfile](https://github.com/ansible-community/ansible-vault/blob/master/examples/Vagrantfile) for more details about the developer mode setup.

## Installation
Brian Shumates transferred this role to @ansible-community/hashicorp-tools. This role resides on GitHub pending fixing the integration with Ansible Galaxy. To install this role create a `roles/requirements.yml` file in your Ansible project folder with the following contents:

```yaml
- src: https://github.com/ansible-community/ansible-vault.git
  name: ansible-community.ansible-vault
  scm: git
  version: master
```

You can use git tag in the version attribute. Also you can honor its legacy `name: brianshumate.ansible-vault`.

## Requirements

This role requires Archlinux, AmazonLinux, FreeBSD, Debian or a RHEL based Linux distribution. It
might work with other software versions, but does work with the following
specific software and versions:

* Ansible: 2.8.4
* Vault: 1.4.0 and above
* AlmaLinux
  - 8
  - 9
* AmazonLinux
  - 2
  - 2022
* ArchLinux
* CentOS
  - 7
  - 8 stream
  - 9 stream
* Debian
  - 9 (stretch)
  - 10 (buster)
  - 11 (bullseye)
* FreeBSD
  - 11
* RockyLinux
  - 8
  - 9
* Ubuntu
  - 18.04 (Bionic Beaver)
  - 20.04 (Focal Fossa)
  - 22.04 (Jammy Jellyfish)

Sorry, there is no planned support at the moment for Windows.

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


<!--ansdoc -->
<!--ansdoc -->
