# Vault with Ansible

This project provides documentation and a collection of scripts to help you automate deployment of [HashiCorp Vault](https://www.vaultproject.io/) using [Ansible](http://www.ansibleworks.com/)

These are the instructions for deploying a development or evaluation cluster on Vagrant.

The documentation and scripts are merely a starting point designed to both help familiarize you with the processes and quickly bootstrap an environment for development or evaluation. You may wish to expand on them and customize them with additional features specific to your needs later.

## Vagrant Development Server

In some situations deploying a small cluster on your local development machine can be handy. This document describes such a scenario using the following technologies:

* [Vault](https://vault.io)
* [VirtualBox](https://www.virtualbox.org/) or [Vagrant-libvirt](https://vagrant-libvirt.github.io/vagrant-libvirt)
* [Vagrant](http://www.vagrantup.com/) with Ansible provisioner and
  supporting plugin
* [Ansible](http://www.ansibleworks.com/)

The Vagrant Development Server virtual machine is configured with 2GB RAM, 2 CPU cores, and dual network interfaces. The primary interface uses NAT and has connection via the host to the outside world. The secondary interface is a private network and is used for Vault intra-cluster communication in addition to access from the host machine.

The Vagrant configuration file, `Vagrantfile` is responsible for configuring the virtual machine and a baseline OS installation.

The Ansible playbooks then further refine OS configuration, perform Vault software download and installation, and the configuration of a Vault service that is then started.

The result is a single Vault server using the [Filesystem Storage Backend](https://www.vaultproject.io/docs/configuration/storage/filesystem.html) that is ready to be initialized and unsealed from either the host system or within the virtual machine itself.

## Designed for Ansible Galaxy

This role is designed to be installed via the `ansible-galaxy` command instead of being directly run from the git repository.

You should install it like this:

```
$ ansible-galaxy role install -r roles/requirements.yml -p roles
```

## Quick Start

Begin from the top level directory of this project and use the following
steps to get up and running:

1. Install the following prerequisites:
  - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) or [Vagrant-libvirt](https://vagrant-libvirt.github.io/vagrant-libvirt/#installation)
  - [Vagrant](http://downloads.vagrantup.com/)
  - [vagrant-hosts plugin](https://docs.ansible.com/ansible/latest/installation_guide/index.html).
2. Edit `/etc/hosts` or use the included `bin/preinstall` script to add
   the following entries to your development system's `/etc/hosts` file:
  - `10.1.42.240 vault1.local vault1`
4. `export VAGRANT_DEFAULT_PROVIDER=libvirt` to use libvirt instead of VirtualBox
5. `vagrant up`
6. You can use Vault directly from the host system with the `VAULT_ADDR` environment as shown in this example:
    ```
    VAULT_ADDR=http://10.1.42.240:8200 vault operator init
    ```

You can also `vagrant ssh` into the VM and export `VAULT_ADDR=http://localhost:8200` to use Vault.

> NOTE: By default, this project will install a Debian based Vault server. If you prefer, it can also install a server based on a different Vagrant box by changing the command in step 4 to include the `BOX_NAME` environment variable specifying a different Vagrant box name as the value such as in the following example:

```
BOX_NAME="debian/bullseye64" vagrant up
```

## Vault Enterprise

The role can install Vault Enterprise based server instances.

Place the Vault Enterprise zip archive into `{{ role_path }}/files` and set `vault_enterprise: true` or use the `VAULT_ENTERPRISE="true"` environment variable.

## Notes

If you notice an error like *vm: The '' provisioner could not be found.* make sure that you have the vagrant-hosts plugin installed

## Resources

1. https://www.vaultproject.io/
2. https://www.vaultproject.io/docs/
3. https://learn.hashicorp.com/vault/
4. https://www.vaultproject.io/intro/getting-started/deploy.html
5. https://www.vaultproject.io/docs/index.html
6. http://www.ansible.com/
7. http://www.vagrantup.com/
8. https://www.virtualbox.org/
9. https://github.com/adrienthebo/vagrant-hosts
10. https://vagrant-libvirt.github.io/vagrant-libvirt
