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

This role requires FreeBSD, or a Debian or RHEL based Linux distribution. It
might work with other software versions, but does work with the following
specific software and versions:

* Ansible: 2.7.0
* Vault: 0.11.3
* Debian: 9
* FreeBSD 11
* Ubuntu 18.04

Sorry, there is no planned support at the moment for Windows.

## Role Variables

The role defines variables in `defaults/main.yml`:


### `vault_version`

- version to install
  - Can be overridden with `VAULT_VERSION` environment variable
  - Will include "+prem" if vault_enterprise_premium=True
  - Will include ".hsm" if vault_enterprise_premium_hsm=True

- Default value: *0.11.3*

### `vault_enterprise`

- Set this to true when installing Vault Enterprise; this is not currently
  possible as a "remote only" install method
  - Can be overridden with `VAULT_ENTERPRISE` environment variable
- Default value: *false*

### `vault_pkg`

- package filename
- Default value: `"vault_{{ vault_version }}_linux_amd64.zip"`

### `vault_enterprise_pkg`

- package filename
- Default value: `"vault-enterprise_{{ vault_version }}_{{ vault_os }}_{{ vault_architecture }}.zip"`

### `vault_zip_url`

- Package download URL
- Default value: `"https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version }}_linux_amd64.zip"`
- Override this var if you have your zip hosted internally
- Works for enterprise installs also

### `vault_checksum_file_url`

- SHA summaries URL
- Override this var if you have your sha file is hosted internally
- Default value: `"https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version}}_SHA256SUMS"`

### `vault_shasums`

- SHA summaries filename (included for convenience not for modification)
- Default value: `"vault_{{ vault_version }}_SHA256SUMS"`

### `vault_enterprise_shasums`

- SHA summaries filename (included for convenience not for modification)
- Will attempt to download from `vault_checksum_file_url` if not present in files/
- Default value: `"vault-enterprise_{{ vault_version }}_SHA256SUMS"`

### `vault_bin_path`

- Binary installation path
- Default value: `/usr/local/bin`

### `vault_config_path`

- Configuration file path
- Default value: `/etc/vault.d`

### `vault_data_path`

- Data path
- Default value: `/var/vault`

### `vault_log_path`

- Log path - (not yet implemented)
- Default value: `/var/log/vault`

### `vault_run_path`

- PID file location
- Default value: `/var/run/vault`

### `vault_manage_user`

- Should this role manage the vault user?
- Default value: *true*

### `vault_user`

- OS user name
- Default value: *vault*

### `vault_group`

- OS group name
- Default value: *bin*

### `vault_group_name`

- Inventory group name
- Default value: `vault_instances`

### `vault_cluster_name`

- Cluster name label
- Default value: *dc1*

### `vault_datacenter`

- Datacenter label
- Default value:  *dc1*

### `vault_ui`

- Enable vault web ui
- Default value:  *false*

### `vault_consul`

- host:port value for connecting to Consul HA backend
- Default value: *127.0.0.1:8500*

### `vault_consul_scheme`

- Scheme for Consul backend
- Supported values: http, https
- Default value: *http*

### `vault_consul_path`

- Name of Vault's Consul K/V root path
- Default value: *vault*

### `vault_consul_service`

- Name of the Vault service to register in Consul
- Default value: *vault*

### `vault_consul_token`

- ACL token for accessing Consul
- Default value: *none*

### `vault_log_level`

- [Log level](https://www.consul.io/docs/agent/options.html#_log_level)
  - Supported values: trace, debug, info, warn, err
- Default value: *info*

### `vault_syslog_enable`

- Log to syslog (not yet impemented)
- Default value: *true*

### `vault_iface`

- Network interface
  - Can be overridden with `VAULT_IFACE` environment variable
- Default value: `eth1`

### `vault_address`

- Primary network interface address to use
- Default value: `"{{ hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}"`

### `vault_port`

- TCP port number to on which to listen
- Default value: *8200*

### `vault_node_name`

- Short node name
- Default value: `"{{ inventory_hostname_short }}"`

### `vault_max_lease_ttl`

- Configures the [maximum possible lease duration](https://www.vaultproject.io/docs/config/#max_lease_ttl) for tokens and secrets.
- Default value: `768h` (32 days)

### `vault_default_lease_ttl`

- Configures the [default lease duration](https://www.vaultproject.io/docs/config/#default_lease_ttl) for tokens and secrets.
- Default value: `768h` (32 days)

### `vault_main_config`

- Main configuration file name (full path)
- Default value: `"{{ vault_config_path }}/vault_main.hcl"`

### `vault_listener_template`
- Vault listener configuration template file
- Default value: *vault_listener.hcl.j2*

### `vault_backend_consul`

- Backend consul template filename
- Default value: `backend_consul.j2`

### `vault_cluster_address`

- Address to bind to for cluster server-to-server requests
- Default value: `"{{ hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}:{{ (vault_port | int) + 1}}"`

### `vault_cluster_addr`

- Address to advertise to other Vault servers in the cluster for request forwarding
- Default value: `"{{ vault_protocol }}://{{ vault_cluster_address }}"`

### `vault_api_addr`

- [HA Client Redirect address](https://www.vaultproject.io/docs/concepts/ha.html#client-redirection)
- Default value: `"{{ vault_protocol }}://{{ vault_redirect_address or hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}:{{ vault_port }}"`
  - vault_redirect_address is kept for backward compatibility but is deprecated.

### `vault_cluster_disable`

- Disable HA clustering
- Default value: *false*

### `validate_certs_during_api_reachable_check`

- Disable Certificate Validation for API reachability check
- Default value: *false*

### `vault_tls_config_path`

- Path to TLS certificate and key
- Default value `/etc/vault/tls`

### `vault_tls_disable`

- [Disable TLS](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_disable)
  - Can be overridden with `VAULT_TLS_DISABLE` environment variable
- Default value: *1*

### `vault_tls_gossip`

- Enable TLS Gossip to Consul Backend
- Default value: *0*

### `vault_tls_src_files`

- User-specified source directory for TLS files
  - Override with `VAULT_TLS_SRC_FILES` environment variable
- Default value: `{{ role_path }}/files`

### `vault_tls_config_path`

- Path to TLS certificate and key
- Default value `/etc/vault/tls`

### `vault_tls_ca_file`

- CA certificate filename
  - Override with `VAULT_TLS_CA_CRT` environment variable
- Default value: `ca.crt`

### `vault_tls_cert_file`

- Server certificate
  - Override with `VAULT_TLS_CERT_FILE` environment variable
- Default value: `server.crt`

### `vault_tls_key_file`

- Server key
  - Override with `VAULT_TLS_KEY_FILE` environment variable
- Default value: `server.key`

### `vault_tls_min_version`

- [Minimum acceptable TLS version](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_min_version)
  - Can be overridden with `VAULT_TLS_MIN_VERSION` environment variable
- Default value: *tls12*

### `vault_tls_cipher_suites`

- [Comma-separated list of supported ciphersuites](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_cipher_suites)
- Default value: "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA"

### `vault_tls_prefer_server_cipher_suites`

- [Prefer server's cipher suite over client cipher suite](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_prefer_server_cipher_suites)
  - Can be overridden with `VAULT_TLS_PREFER_SERVER_CIPHER_SUITES` environment variable
- Default value: *false*

### `vault_tls_require_and_verify_client_cert`

- [Require clients to present a valid client certificate](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_require_and_verify_client_cert)
- Default value: *false*

### `vault_tls_disable_client_certs`

- [Disable requesting for client certificates](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_disable_client_certs)
- Default value: *false*


### `vault_tls_files_remote_src`

- Copy from remote source if TLS files are already on host
- Default value: *no*

### `vault_bsdinit_template`
- BSD init template file 
- Default value: *vault_bsdinit.j2*

### `vault_sysvinit_template`
- SysV init  template file
- Default value: *vault_sysvinit.j2*

### `vault_debian_init_template`
- Debian init template file
- Default value: *vault_debian.init.j2*

### `vault_systemd_template`
- Systemd service template file
- Default value: *vault_systemd.service.j2*

## OS Distribution Variables

The `consul` binary works on most Linux platforms and is not distribution
specific. However, some distributions require installation of specific OS
packages with different naming, so this role was built with support for
popular Linux distributions and defines these variables to deal with the
differences across distributions:


### `vault_pkg`

- Vault package filename
- Default value: `{{ vault_version }}_linux_amd64.zip`

### `vault_centos_url`

- Vault package download URL
- Default value: `{{ vault_zip_url }}`

### `vault_centos_os_packages`

- List of OS packages to install
- Default value: list

### `vault_pkg`

- Vault package filename
- Default value: `"{{ vault_version }}_linux_amd64.zip"`

### `vault_debian_url`

- Vault package download URL
- Default value: `"{{ vault_zip_url }}"`

### `vault_sha256`

- Vault download SHA256 summary
- Default value: SHA256 SUM

### `vault_debian_os_packages`

- List of OS packages to install
- Default value: list

### `vault_pkg`

- Vault package filename
- Default value: `"{{ vault_version }}_linux_amd64.zip"`

### `vault_redhat_url`

- Vault package download URL
- Default value: `"{{ vault_zip_url }}"`

### `vault_sha256`

- Vault package SHA256 summary
- Default value: SHA256 SUM

### `vault_redhat_os_packages`

- List of OS packages to install
- Default value: list

### `vault_pkg`

- Vault package filename
- Default value: `"{{ vault_version }}_linux_amd64.zip"`

### `vault_ubuntu_url`

- Vault package download URL
- Default value: `"{{ vault_zip_url }}"`

### `vault_sha256`

- Vault package SHA256 summary
- Default value: SHA256 SUM

### `vault_enable_logrotate`

- Enable logrotation for systemd based systems
- Default value: *false*

### `vault_logrotate_freq`

- Determines how frequently to rotate vault logs
- Default value: *7*

### `vault_logrotate_template`

- Logrotate template file
- Default value: *vault_logrotate.j2*

### `vault_ubuntu_os_packages`

- List of OS packages to install
- Default value: list

## Dependencies

> **NOTE**: Read these before executing the role to avoid certain frequently
encountered issues which are resolved by installing the correct dependencies.

### `gtar`

Ansible requires GNU tar and this role performs some local use of the
unarchive module, so ensure that your system has `gtar` installed.

### Python netaddr

The role depends on `python-netaddr` so:

```
pip install netaddr
```

on the Ansible control host prior to executing the role.

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

## Vault Enterprise

The role can install Vault Enterprise based instances.

Place the Vault Enterprise zip archive into `{{ role_path }}/files` and set
`vault_enterprise: true` or use the `VAULT_ENTERPRISE="true"` environment
variable. Attempts to download the package from `vault_zip_url` if zip is not found in files/.

### `vault_enterprise_premium`

- Set to True if using premium binary. Basically just includes "+prem" in "vault_version" var
- Default value: *False*

## Vault Enterprise with HSM

The role can configure HSM based instances. Make sure to reference the [HSM support page](https://www.vaultproject.io/docs/configuration/seal/index.html) and take notice of the [behavior changes](https://www.vaultproject.io/docs/enterprise/hsm/behavior.html#initialization) after HSM is installed.

### `vault_enterprise_premium_hsm`

- Set to True if using premium hsm binary. Basically just includes ".hsm" in "vault_version" var
- Default value: *False*

### `vault_hsm_app`

- Set which cryptography app to use. 
- Default value: *pkcs11*

### `vault_backend_seal`

- Backend seal template filename
- Default value: *vault_backend_seal.j2*

### `vault_seal_lib`

- Set to the absolute path of the HSM library vault will call
- Default value: */lib64/hsmlibrary.so*

### `vault_seal_pin`

- The PIN for login. May also be specified by the VAULT_HSM_PIN environment variable. If set via the environment variable, Vault will obfuscate the environment variable after reading it, and it will need to be re-set if Vault is restarted.
- Default value: *12345*

### `vault_seal_key_label`

- The label of the key to use. If the key does not exist and generation is enabled, this is the label that will be given to the generated key. May also be specified by the VAULT_HSM_KEY_LABEL environment variable.
- Default value: *vault-hsm-key*

### `vault_seal_generate_key`

- If no existing key with the label specified by key_label can be found at Vault initialization time, instructs Vault to generate a key. This is a boolean expressed as a string (e.g. "true"). May also be specified by the VAULT_HSM_GENERATE_KEY environment variable. Vault may not be able to successfully generate keys in all circumstances, such as if proprietary vendor extensions are required to create keys of a suitable type.
- Default value: *false*

### `vault_seal_key_mechanism`

-  Do not change this unles you know you need to. The encryption/decryption mechanism to use, specified as a decimal or hexadecimal (prefixed by 0x) string. May also be specified by the VAULT_HSM_MECHANISM environment variable.
- Default value: *''*
- Example for RSA: *0x0009*

### `vault_seal_token_label`

- The slot token label to use. May also be specified by the VAULT_HSM_TOKEN_LABEL environment variable. This label will only be applied when `vault_softcard_enable` is true.
- Default value: *''*

### `vault_softcard_enable`

- Enable if you plan to use a softcard on your HSM.
- Default value: *false*

### `vault_seal_slot`

- The slot number to use, specified as a string (e.g. "0"). May also be specified by the VAULT_HSM_SLOT environment variable. This label will only be applied when `vault_softcard_enable` is false (default).
- Default value: *0*

## License

BSD

## Author Information

[Brian Shumate](http://brianshumate.com)

## Contributors

Special thanks to the folks listed in [CONTRIBUTORS.md](https://github.com/brianshumate/ansible-vault/blob/master/CONTRIBUTORS.md) for their
contributions to this project.
