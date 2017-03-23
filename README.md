# Vault

[![Build Status](https://travis-ci.org/brianshumate/ansible-vault.svg?branch=master)](https://travis-ci.org/brianshumate/ansible-vault)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-brianshumate.vault-blue.svg)](https://galaxy.ansible.com/brianshumate/vault/)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/brianshumate/ansible-vault.svg)](http://isitmaintained.com/project/brianshumate/ansible-vault "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/brianshumate/ansible-vault.svg)](http://isitmaintained.com/project/brianshumate/ansible-vault "Percentage of issues still open")

This Ansible role performs a basic [Vault](https://vaultproject.io/)
installation, including filesystem structure and example configuration.

It can also bootstrap a minimal development or evaluation server or HA
Consul-backed cluster in a Vagrant and VirtualBox based environment. See
[README_VAGRANT.md](https://github.com/brianshumate/ansible-vault/blob/master/examples/README_VAGRANT.md) and the associated [Vagrantfile](https://github.com/brianshumate/ansible-vault/blob/master/examples/Vagrantfile) for more details about the developer mode setup.

## Requirements

This role requires a Debian or RHEL based Linux distribution. It might work
with other software versions, but does work with the following specific
software and versions:

* Ansible: 2.2.1.0
* Vault: 0.7.0
* Debian: 8

## Role Variables

The role defines variables in `defaults/main.yml`:

| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `vault_version` | *0.7.0* | Version to install - can also be specified or overridden with `VAULT_VERSION` environment variable |
| `vault_pkg` | `"vault_{{ vault_version }}_linux_amd64.zip"` | Package filename |
| `vault_zip_url` | `"https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version }}_linux_amd64.zip"` | Download URL |
| `vault_checksum_file_url` | `"https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version}}_SHA256SUMS"` | URL to SHA summaries |
| `vault_bin_path` | `/usr/local/bin` | Binary installation path |
| `vault_config_path` | `/etc/vault.d` | Configuration file path |
| `vault_data_path` | `/var/vault` | Data path |
| `vault_log_path` | `/var/log/vault` | Log path - Not impemented |
| `vault_run_path`| `/var/run/vault` | PID file location |
| `vault_user` | *vault* | OS user |
| `vault_group` | *bin* | OS group |
| `vault_group_name` | `cluster_nodes` | Inventory group name |
| `vault_cluster_name` | *sutakku* | Cluster name label |
| `vault_datacenter` | *dc1* | Datacenter label - Not impemented |
| `vault_consul` | *127.0.0.1:8500* | host:port for Consul HA backend |
 `vault_consul_path` | *vault* | Name of Vault's Consul K/V root path |
| `vault_log_level` | *info* | [Log level](https://github.com/hashicorp/vault/blob/b1ed578f3da3263ca1973d16dcb33490125486b8/command/server.go#L1003-L1005) - Supported values: [trace, debug, info, warn, err](https://github.com/hashicorp/vault/blob/b1ed578f3da3263ca1973d16dcb33490125486b8/command/server.go#L87-L103) |
| `vault_syslog_enable` | *true* | Log to syslog  - Not impemented |
| `vault_iface` | `eth1` | Network interface - Not impemented |
| `vault_address` | `"{{ hostvars[inventory_hostname]['ansible_eth1']['ipv4']['address'] }}"` | Primary interface address |
| `vault_redirect_addr` | `"{{ hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}"` | [HA Client Redirect address](https://www.vaultproject.io/docs/concepts/ha.html#client-redirection) |
| `vault_port` | *8200* | TCP port number to use |
| `vault_node_name` | `"{{ inventory_hostname_short }}"` | Short node name |
| `vault_main_config` | `"{{ vault_config_path }}/vault_main.hcl"` | Main configuration file path |
| `vault_primary_node` | `"{{hostvars[groups['primary'][0]]['ansible_fqdn']}}"` | Active node FQDN |
| `vault_backend` | `backend_consul.j2` | Backend template filename |
| `vault_cluster_address` | `"{{ hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}"` | Address for intra-cluster communication |
| `vault_cluster_disable` | *false* | Disable HA clustering |
| `vault_tls_disable` | *1* | [Disable TLS](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_disable) |
| `vault_tls_cert_file` | None | [Vault TLS certificate file path](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_cert_file) |
| `vault_tls_cert_file_dest` | `"{{ vault_config_path }}/vault.crt" # /etc/pki/tls/certs/vault.crt` | Destination path for Vault TLS certificate |
| `vault_tls_key_file` | None | [Vault TLS key file path](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_key_file) |
| `vault_tls_key_file_dest` | `"{{ vault_config_path }}/vault.key"` | Destination path for Vault TLS key |
| `vault_tls_min_version` | *tls12* | [Minimum acceptable TLS version](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_min_version) |
| `vault_tls_cipher_suites` | None | [comma-separated list of supported ciphersuites](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_cipher_suites) |
| `vault_tls_prefer_server_cipher_suites`  | false | [prefer the server's ciphersuite over the client ciphersuites](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_prefer_server_cipher_suites) |

### OS Distribution Variables

The `consul` binary works on most Linux platforms and is not distribution
specific. However, some distributions require installation of specific OS
packages with different naming, so this role was built with support for
popular Linux distributions and defines these variables to deal with the
differences acros distros:

| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `vault_pkg` | `{{ vault_version }}_linux_amd64.zip` | Vault package filename |
| `vault_centos_url` | `{{ vault_zip_url }}` | Vault package download URL |
| `vault_sha256` | SHA256 SUM | Vault download SHA256 summary |
| `vault_centos_os_packages` | list | List of OS packages to install |
| `vault_pkg` | `{{ vault_version }}_linux_amd64.zip` | Vault package filename |
| `vault_debian_url` | `{{ vault_zip_url }}` | Vault package download URL |
| `vault_sha256` | SHA256 SUM | Vault download SHA256 summary |
| `vault_debian_os_packages` | list | List of OS packages to install |
| `vault_pkg` | `{{ vault_version }}_linux_amd64.zip` | Vault package filename |
| `vault_redhat_url` | `{{ vault_zip_url }}` | Vault package download URL |
| `vault_sha256` | SHA256 SUM | Vault download SHA256 summary |
| `vault_redhat_os_packages` | list | List of OS packages to install |
| `vault_pkg` | `{{ vault_version }}_linux_amd64.zip` | Vault package filename |
| `vault_ubuntu_url` | `{{ vault_zip_url }}` | Vault package download URL |
| `vault_sha256` | SHA256 SUM | Vault download SHA256 summary |
| `vault_ubuntu_os_packages` | list | List of OS packages to install |

## Dependencies

Ansible requires GNU tar and this role performs some local use of the
unarchive module, so ensure that your system has `gtar` installed.

## Example Playbook

Basic installation is possible using the included `site.yml` playbook:

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
ansible-playbook -i hosts site.yml --extra-vars "vault_backed=backend_file.j2"
```

You need to make sure that the template file `backend_file.j2` is in the
role directory for this to work.

### Vagrant and VirtualBox

See `examples/README_VAGRANT.md` for details on quick Vagrant deployments
under VirtualBox for testing, etc.

## License

BSD

## Author Information

[Brian Shumate](http://brianshumate.com)

## Contributors

Special thanks to the folks listed in [CONTRIBUTORS.md](https://github.com/brianshumate/ansible-vault/blob/master/CONTRIBUTORS.md) for their
contributions to this project.
