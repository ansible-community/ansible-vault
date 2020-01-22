 # Vault

[![Build Status](https://travis-ci.org/brianshumate/ansible-vault.svg?branch=master)](https://travis-ci.org/brianshumate/ansible-vault)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-brianshumate.vault-blue.svg)](https://galaxy.ansible.com/brianshumate/vault/)
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

* Ansible: 2.8.4
* Vault: 1.3.2
* Debian
  - Debian 10 (buster)
  - Debian 9 (stretch)
  - Debian 8 (jessie)
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

- Default value: 1.3.2

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

### `vault_plugin_path`

- Path from where plugins can be loaded
- Default value: `/usr/local/lib/vault/plugins`

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
- Default value: true

### `vault_user`

- OS user name
- Default value: vault

### `vault_group`

- OS group name
- Default value: bin

### `vault_manage_group`

- Should this role manage the vault group?
- Default value: false

### `vault_group_name`

- Inventory group name
- Default value: vault_instances

### `vault_cluster_name`

- Cluster name label
- Default value: dc1

### `vault_datacenter`

- Datacenter label
- Default value:  dc1

### `vault_ui`

- Enable vault web UI
- Default value:  true

## Storage Backend Variables

### `vault_backend`
- Which storage backend should be selected, choices are: consul, etcd, file, s3, and dynamodb
- Default value: consul

### `vault_backend_tls_src_files`

- User-specified source directory for TLS files for storage communication
- {{ vault_tls_src_files }}

### `vault_backend_tls_config_path`

- Path to directory containing backend tls config files
- {{ vault_tls_config_path }}

### `vault_backend_tls_cert_file`

- Specifies the path to the certificate for backend communication (if supported).
- {{ vault_tls_cert_file }}

### `vault_backend_tls_key_file`

- Specifies the path to the private key for backend communication (if supported).
- {{ vault_tls_key_file }}

### `vault_backend_tls_ca_file`

- CA certificate used for backend communication (if supported). This defaults to system bundle if not specified.
- {{ vault_tls_ca_file }}

### Consul Storage Backend

#### `vault_backend_consul`

- Backend consul template filename
- Default value: `backend_consul.j2`

#### `vault_consul`

- host:port value for connecting to Consul HA backend
- Default value: 127.0.0.1:8500

#### `vault_consul_scheme`

- Scheme for Consul backend
- Supported values: http, https
- Default value: http

#### `vault_consul_path`

- Name of Vault's Consul K/V root path
- Default value: vault

#### `vault_consul_service`

- Name of the Vault service to register in Consul
- Default value: vault

#### `vault_consul_token`

- ACL token for accessing Consul
- Default value: none

### etcd Storage Backend

#### vault_etcd

- Address of etcd storage
- Default value: 127.0.0.1:2379

#### vault_etcd_api:

- API version
- Default value: v3

#### vault_etcd_path

- Path for Vault storage
- Default value: /vault/

#### vault_etcd_discovery_srv

- Discovery server
- Default value: none

#### vault_etcd_discovery_srv_name

- Discovery server name
- Default value: none

#### vault_etcd_ha_enabled

- Use storage for High Availability mode
- Default value: false

#### vault_etcd_sync

- Use etcdsync
- Default value: true

#### vault_etcd_username

- Username
- Default value: none

#### vault_etcd_password

- Password
- Default value: none

#### vault_etcd_request_timeout

-Request timeout
- Default value: "5s"

#### vault_etcd_lock_timeout

- Lock timeout
- Default value: "15s"

### File Storage Backend

#### `vault_backend_file`

- Backend file template filename
- Default value: `backend_file.j2`

### DynamoDB Storage Backend

For additional documentation for the various options available, see the
[Vault documentation](https://www.vaultproject.io/docs/configuration/storage/dynamodb.html)
for the DynamoDB storage backend.

#### `vault_dynamodb`

- Specifies an alternative DynamoDB endpoint.
- Default value: none
  - Can be overridden with the environment variable `AWS_DYNAMODB_ENDPOINT`.

#### `vault_dynamodb_table`

- Name of the DynamoDB table used to store Vault data.
  - If the table does not already exist, it will be created during
    initialization.
- Default value: `"vault-dynamodb-backend"`
  - Can be overridden with the environment variable `AWS_DYNAMODB_TABLE`.

#### `vault_dynamodb_ha_enabled`

- Whether High Availability is enabled for this storage backend.
- Default value: `"false"`
  - Can be overridden with the environment variable `DYNAMODB_HA_ENABLED`.
    - The missing `AWS_` prefix is not a typo, this particular variable is not
      prefixed in both the Vault documentation and source code.

#### `vault_dynamodb_max_parallel`

- The maximum number of concurrent requests.
- Default value: `"128"`

#### `vault_dynamodb_region`

- The AWS region.
- Default value: `us-east-1`
  - Can be overridden with the environment variable `AWS_DEFAULT_REGION`

#### `vault_dynamodb_read_capacity`

- Number of reads per second to provision for the table.
- Only used during table creation, has no effect if the table already exists.
- Default value: `5`
  - Can be overridden with the environment variable `AWS_DYNAMODB_READ_CAPACITY`.

#### `vault_dynamodb_write_capacity`

- Number of writes per second to provision for the table.
- Only used during table creation, has no effect if the table already exists.
- Default value: `5`
  - Can be overridden with the environment variable `AWS_DYNAMODB_WRITE_CAPACITY`.

#### `vault_dynamodb_access_key`

- AWS access key to use for authentication.
- Default value: none
  - Can be overridden with the environment variable `AWS_ACCESS_KEY_ID`
- Leaving both this and `vault_dynamodb_secret_key` blank will cause Vault to
  attempt to retrieve the credentials from the AWS metadata service.

#### `vault_dynamodb_secret_key`

- AWS secret key used for authentication.
- Default value: none
  - Can be overridden with the environment variable `AWS_SECRET_ACCESS_KEY`
- Leaving both this and `vault_dynamodb_access_key` blank will cause Vault to
  attempt to retrieve the credentials from the AWS metadata service.

#### `vault_dynamodb_session_token`

- AWS session token.
- Default value: none
  - Can be overridden with the environment variable `AWS_SESSION_TOKEN`

### `vault_log_level`

- [Log level](https://www.consul.io/docs/agent/options.html#_log_level)
  - Supported values: trace, debug, info, warn, err
- Default value: info
- Requires Vault version 0.11.1 or higher

### `vault_iface`

- Network interface
  - Can be overridden with `VAULT_IFACE` environment variable
- Default value: eth1

### `vault_address`

- Primary network interface address to use
- Default value: `"{{ hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}"`

### `vault_port`

- TCP port number to on which to listen
- Default value: 8200

### `vault_max_lease_ttl`

- Configures the [maximum possible lease duration](https://www.vaultproject.io/docs/config/#max_lease_ttl) for tokens and secrets.
- Default value: 768h (32 days)

### `vault_default_lease_ttl`

- Configures the [default lease duration](https://www.vaultproject.io/docs/config/#default_lease_ttl) for tokens and secrets.
- Default value: 768h (32 days)

### `vault_main_config`

- Main configuration file name (full path)
- Default value: `"{{ vault_config_path }}/vault_main.hcl"`

### `vault_main_configuration_template`

- Vault main configuration template file
- Default value: *vault_main_configuration.hcl.j2*

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
- Default value: false

### `validate_certs_during_api_reachable_check`

- Disable Certificate Validation for API reachability check
- Default value: true

### `vault_tls_config_path`

- Path to TLS certificate and key
- Default value `/etc/vault/tls`

### `vault_tls_disable`

- [Disable TLS](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_disable)
  - Can be overridden with `VAULT_TLS_DISABLE` environment variable
- Default value: 1

### `vault_tls_gossip`

- Enable TLS Gossip to storage (if supported)
- Default value: 0

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
- Default value: tls12

### `vault_tls_cipher_suites`

- [Comma-separated list of supported ciphersuites](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_cipher_suites)
- Default value: ""

### `vault_tls_prefer_server_cipher_suites`

- [Prefer server's cipher suite over client cipher suite](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_prefer_server_cipher_suites)
  - Can be overridden with `VAULT_TLS_PREFER_SERVER_CIPHER_SUITES` environment variable
- Default value: false

### `vault_tls_require_and_verify_client_cert`

- [Require clients to present a valid client certificate](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_require_and_verify_client_cert)
- Default value: false

### `vault_tls_disable_client_certs`

- [Disable requesting for client certificates](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_disable_client_certs)
- Default value: false

### `vault_tls_copy_keys`

- Copy TLS files from src to dest
- Default value: true

### `vault_tls_files_remote_src`

- Copy from remote source if TLS files are already on host
- Default value: false

### `vault_bsdinit_template`
- BSD init template file
- Default value: `vault_service_bsd_init.j2`

### `vault_sysvinit_template`
- SysV init  template file
- Default value: `vault_sysvinit.j2`

### `vault_debian_init_template`
- Debian init template file
- Default value: `vault_service_debian_init.j2`

### `vault_systemd_template`
- Systemd service template file
- Default value: `vault_service_systemd.j2`

### `vault_telemetry_enabled`
- Enable [Vault telemetry](https://www.vaultproject.io/docs/configuration/telemetry.html)
- If enabled, you must set *vault_statsite_address* or *vault_statsd_address* with a format of "FQDN:PORT"
- If enabled, optionally set *vault_telemetry_disable_hostname* to strip the hostname prefix from telemetry data
- Default value: *false*

## OS Distribution Variables

The `vault` binary works on most Linux platforms and is not distribution
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
- Default value: SHA256 summary

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
- Default value: SHA256 summary

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
- Default value: SHA256 summary

### `vault_enable_logrotate`

- Enable logrotation for systemd based systems
- Default value: false

### `vault_logrotate_freq`

- Determines how frequently to rotate vault logs
- Default value: 7

### `vault_logrotate_template`

- Logrotate template file
- Default value: `vault_logrotate.j2`

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
ansible-playbook -i hosts site.yml --extra-vars "vault_backend_file=backend_file.j2"
```

You need to make sure that the template file `backend_file.j2` is in the
role directory for this to work.

### Vagrant and VirtualBox

See `examples/README_VAGRANT.md` for details on quick Vagrant deployments
under VirtualBox for testing, etc.

## example virtualBox playbook
example playbook for a file based  vault instance.

```
- hosts: all
  gather_facts: True
  become: true
  vars:
    vault_backend: file
    vault_cluster_disable: True
    vault_log_level: debug
  roles:
    - vault

```

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
- Default value: false

### `vault_hsm_app`

- Set which cryptography app to use.
- Default value: pkcs11

### `vault_backend_seal`

> NOTE: This seal will be migrated to the `pkcs11` seal and made consistent with the other seal types with respect to breaking naming changes soon.

- Backend seal template filename
- Default value: `vault_backend_seal.j2`

### `vault_seal_lib`

- Set to the absolute path of the HSM library vault will call
- Default value: `/lib64/hsmlibrary.so`

### `vault_seal_pin`

- The PIN for login. May also be specified by the VAULT_HSM_PIN environment variable. If set via the environment variable, Vault will obfuscate the environment variable after reading it, and it will need to be re-set if Vault is restarted.
- Default value: 12345

### `vault_seal_key_label`

- The label of the key to use. If the key does not exist and generation is enabled, this is the label that will be given to the generated key. May also be specified by the VAULT_HSM_KEY_LABEL environment variable.
- Default value: vault-hsm-key

### `vault_seal_generate_key`

- If no existing key with the label specified by key_label can be found at Vault initialization time, instructs Vault to generate a key. This is a boolean expressed as a string (e.g. "true"). May also be specified by the VAULT_HSM_GENERATE_KEY environment variable. Vault may not be able to successfully generate keys in all circumstances, such as if proprietary vendor extensions are required to create keys of a suitable type.
- Default value: false

### `vault_seal_key_mechanism`

-  Do not change this unles you know you need to. The encryption/decryption mechanism to use, specified as a decimal or hexadecimal (prefixed by 0x) string. May also be specified by the VAULT_HSM_MECHANISM environment variable.
- Default value: ''
- Example for RSA: 0x0009

### `vault_seal_token_label`

- The slot token label to use. May also be specified by the VAULT_HSM_TOKEN_LABEL environment variable. This label will only be applied when `vault_softcard_enable` is true.
- Default value: ''

### `vault_softcard_enable`

- Enable if you plan to use a softcard on your HSM.
- Default value: false

### `vault_seal_slot`

- The slot number to use, specified as a string (e.g. "0"). May also be specified by the VAULT_HSM_SLOT environment variable. This label will only be applied when `vault_softcard_enable` is false (default).
- Default value: 0

## Vault GCP Cloud KMS Auto-unseal

This feature enables operators to delegate the unsealing process to Google Key Management System Cloud to ease operations in the event of partial failure and to aid in the creation of new or ephemeral clusters.

This Auto-unseal mechanism is Open Source in Vault 1.0 but would require Enterprise binaries for any earlier version.

### `vault_gkms`

- Set to True to enable Google Cloud KMS Auto-Unseal.
- Default value: false

### `vault_backend_gkms`

- Backend seal template filename
- Default value: `vault_seal_gcpkms.j2`

### `vault_gkms_project`

- GCP Project where the key reside.
- Default value: ''

### `vault_gkms_credentials_src_file`

- User-specified source directory for GCP Credential on Ansible control node.
- Default value: ''

### `vault_gkms_credentials`

- Path to GCP credential on Vault server.
- Default value: `/home/vault/vault-kms.json`

### `vault_gkms_region`

- GCP Region where the key reside.
- Default value: global

### `vault_gkms_key_ring`

- The id of the Google Cloud Platform KeyRing to which the key shall belong.
- Default value: vault

### `vault_gkms_crypto_key`

- The CryptoKey's name. A CryptoKey's name must be unique within a location and match the regular expression [a-zA-Z0-9_-]{1,63}
- Default value: vault_key

## Vault AWS KMS Auto-unseal

This feature enabled operators to delegate the unsealing process to AWS KMS to ease operations in the event of a partial failure and to
aid in the creation of new or ephemeral clusters.

### `vault_awskms`

- Set to true to enable AWS KMS Auto-unseal
- Default value: false

### `vault_awskms_backend`

- Backend seal template filename
- Default value: `vault_seal_awskms.j2`

### `vault_awskms_region`

- Which AWS KMS region to use
- Default value: us-east-1

### `vault_awskms_access_key`

- The AWS Access Key to use for talking to AWS KMS
- Default value: AWS_ACCESS_KEY_ID

### `vault_awskms_secret_key`

- The AWS Secret Key ID to use for takling to AWS KMS
- Default value: AWS_SECRET_ACCESS_KEY

### `vault_awskms_key_id`

- The KMS Key ID to use for AWS KMS
- Default value: VAULT_AWSKMS_SEAL_KEY_ID

### `vault_awskms_endpoint`

- The endpoint to use for KMS
- Default value: AWS_KMS_ENDPOINT

## Vault Azure Key Vault Auto-unseal

This feature enabled operators to delegate the unsealing process to AZURE Key Vaultto ease operations in the event of a partial failure and to aid in the creation of new or ephemeral clusters.

### `vault_azurekeyvault`

- Set to true to enable AZURE Key Vault Auto-unseal
- Default value: false

### `vault_backend_azurekeyvault`

- Backend seal template filename
- Default value: `vault_seal_azurekeyvault.j2`

### `vault_azurekeyvault_client_id`

- Application ID related to Service Principal Name for the Application used to connect to Azure
- Default value: EXAMPLE_CLIENT_ID

### `vault_azurekeyvault_client_secret`

- Client Secret is the secret key attached to your Application
- Default value: EXAMPLE_CLIENT_SECRET

### `vault_azurekeyvault_tenant_id`

- Tenant ID is your Directory ID in Azure
- Default value: EXAMPLE_TENANT_ID

### `vault_azurekeyvault_vault_name`

- The name of the Vault which hosts the key
- Default value: vault

### `vault_azurekeyvault_key_name`

- The key hosted in the Vault in Azure Key Vault
- Default value: vault_key

## License

BSD-2-Clause

## Author Information

[Brian Shumate](http://brianshumate.com)

## Contributors

Special thanks to the folks listed in [CONTRIBUTORS.md](https://github.com/brianshumate/ansible-vault/blob/master/CONTRIBUTORS.md) for their
contributions to this project.
