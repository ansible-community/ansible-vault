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
<table>
<tr>
<th>Name</th>
<th>Description</th>
<th>Default Value</th>
</tr>

<tr>
<td>

```
vault_version
```

</td><td>Version to install</td><td>

```yaml
{{ lookup('env', 'VAULT_VERSION') | default('1.5.5', true) }}{{ '+prem' if vault_enterprise_premium else '' }}{{ '.hsm' if vault_enterprise_premium_hsm else '' }}
```

</td></tr>

<tr>
<td>

```
vault_architecture_map
```

</td><td></td><td>

```yaml
aarch64: arm64
amd64: amd64
armv7l: arm
x86_64: amd64

```

</td></tr>

<tr>
<td>

```
vault_architecture
```

</td><td></td><td>

```yaml
{{ vault_architecture_map[ansible_architecture] }}
```

</td></tr>

<tr>
<td>

```
vault_os
```

</td><td></td><td>

```yaml
{{ ansible_system | lower }}
```

</td></tr>

<tr>
<td>

```
vault_pkg
```

</td><td>Vault package filename</td><td>

```yaml
vault_{{ vault_version }}_{{ vault_os }}_{{ vault_architecture }}.zip
```

</td></tr>

<tr>
<td>

```
vault_shasums
```

</td><td>SHA summaries filename (included for convenience not for modification)</td><td>

```yaml
vault_{{ vault_version }}_SHA256SUMS
```

</td></tr>

<tr>
<td>

```
vault_zip_url
```

</td><td>Package download URL</td><td>

```yaml
https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version }}_{{ vault_os }}_{{ vault_architecture }}.zip
```

</td></tr>

<tr>
<td>

```
vault_checksum_file_url
```

</td><td>SHA summaries URL</td><td>

```yaml
https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version }}_SHA256SUMS
```

</td></tr>

<tr>
<td>

```
vault_repository_url
```

</td><td>Name of rhsm repo</td><td>

```yaml
{{ _vault_repository_url | default() }}
```

</td></tr>

<tr>
<td>

```
vault_repository_key_url
```

</td><td></td><td>

```yaml
{{ _vault_repository_key_url | default() }}
```

</td></tr>

<tr>
<td>

```
vault_rhsm_subscription_name
```

</td><td>Name of rhsm subscription</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_rhsm_repo_id
```

</td><td>Name of rhsm repo</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_start_pause_seconds
```

</td><td>Some installations may need some time between the first Vault start and the first restart. Setting this to a value >0 will add a pause time after the first Vault start.</td><td>

```yaml
0
```

</td></tr>

<tr>
<td>

```
vault_install_hashi_repo
```

</td><td>Set this to true when installing Vault via HashiCorp Linux repository. When set, you can also define vault_repository_key_url and vault_repository_url to override the default URL of the GPG key for the repository and the default URL of the repository used.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_install_remotely
```

</td><td>Set this to true will download Vault binary from each target instead of localhost</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_privileged_install
```

</td><td>Set this to true if you see permission errors when the vault files are downloaded and unpacked locally. This issue can show up if the role has been downloaded by one user (like root), and the installation is done with a different user.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_bin_path
```

</td><td>Binary installation path</td><td>

```yaml
{{ '/usr/bin' if (vault_install_hashi_repo) else '/usr/local/bin' }}
```

</td></tr>

<tr>
<td>

```
vault_config_path
```

</td><td>Configuration file path</td><td>

```yaml
/etc/vault.d
```

</td></tr>

<tr>
<td>

```
vault_plugin_path
```

</td><td>Path from where plugins can be loaded</td><td>

```yaml
/usr/local/lib/vault/plugins
```

</td></tr>

<tr>
<td>

```
vault_data_path
```

</td><td>Data path</td><td>

```yaml
{{ '/opt/vault/data' if (vault_install_hashi_repo) else '/var/vault' }}
```

</td></tr>

<tr>
<td>

```
vault_log_path
```

</td><td>Log path</td><td>

```yaml
/var/log/vault
```

</td></tr>

<tr>
<td>

```
vault_run_path
```

</td><td>PID file location</td><td>

```yaml
/var/run/vault
```

</td></tr>

<tr>
<td>

```
vault_home
```

</td><td></td><td>

```yaml
/home/{{ vault_user }}
```

</td></tr>

<tr>
<td>

```
vault_harden_file_perms
```

</td><td>Whether this role should disallow Vault from writing into config and plugin path. This should be enabled to follow Production Hardening.</td><td>

```yaml
true
```

</td></tr>

<tr>
<td>

```
vault_manage_user
```

</td><td>Should this role manage the vault user?</td><td>

```yaml
{{ false if (vault_install_hashi_repo) else true }}
```

</td></tr>

<tr>
<td>

```
vault_user
```

</td><td>OS user name</td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_manage_group
```

</td><td>Should this role manage the vault group?</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_group
```

</td><td>OS group name</td><td>

```yaml
{{ 'vault' if (vault_install_hashi_repo) else 'bin' }}
```

</td></tr>

<tr>
<td>

```
vault_groups
```

</td><td>OS additional groups as in ansibles user module</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_dotfile
```

</td><td></td><td>

```yaml
.bashrc
```

</td></tr>

<tr>
<td>

```
vault_dotfile_disable
```

</td><td></td><td>

```yaml
{{ true if (vault_install_hashi_repo) else false }}
```

</td></tr>

<tr>
<td>

```
vault_enable_log
```

</td><td>Enable log to vault_log_path</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_enable_logrotate
```

</td><td>Enable logrotation for systemd based systems</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_logrotate_freq
```

</td><td>Determines how frequently to rotate vault logs</td><td>

```yaml
7
```

</td></tr>

<tr>
<td>

```
vault_logrotate_template
```

</td><td>Logrotate template file</td><td>

```yaml
vault_logrotate.j2
```

</td></tr>

<tr>
<td>

```
vault_exec_output
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_service_restart
```

</td><td>Should the playbook restart Vault service when needed</td><td>

```yaml
true
```

</td></tr>

<tr>
<td>

```
vault_service_reload
```

</td><td>Should the playbook reload Vault service when the main config changes.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_cluster_name
```

</td><td>Cluster name label</td><td>

```yaml
dc1
```

</td></tr>

<tr>
<td>

```
vault_datacenter
```

</td><td>Datacenter label</td><td>

```yaml
dc1
```

</td></tr>

<tr>
<td>

```
vault_log_level
```

</td><td>log level: Supported values: trace, debug, info, warn, err</td><td>

```yaml
{{ lookup('env', 'VAULT_LOG_LEVEL') | default('info', true) }}
```

</td></tr>

<tr>
<td>

```
vault_iface
```

</td><td>Network interface, Can be overridden with VAULT_IFACE environment variable</td><td>

```yaml
{{ lookup('env', 'VAULT_IFACE') | default(ansible_default_ipv4.interface, true) }}
```

</td></tr>

<tr>
<td>

```
vault_address
```

</td><td>Primary network interface address to use</td><td>

```yaml
{{ hostvars[inventory_hostname]['ansible_' + vault_iface]['ipv4']['address'] }}
```

</td></tr>

<tr>
<td>

```
vault_ui
```

</td><td>Enable vault web UI</td><td>

```yaml
{{ lookup('env', 'VAULT_UI') | default(true, true) }}
```

</td></tr>

<tr>
<td>

```
vault_port
```

</td><td>TCP port number to on which to listen</td><td>

```yaml
8200
```

</td></tr>

<tr>
<td>

```
vault_use_config_path
```

</td><td>Use "{{ vault_config_path }}" to configure vault instead of "{{ vault_main_config }}"</td><td>

```yaml
{{ vault_transit or vault_awskms or vault_azurekeyvault or vault_gkms | default(false) }}
```

</td></tr>

<tr>
<td>

```
vault_main_config
```

</td><td>Main configuration file name (full path)</td><td>

```yaml
{{ vault_config_path }}/vault_main.hcl
```

</td></tr>

<tr>
<td>

```
vault_main_configuration_template
```

</td><td>Vault main configuration template file</td><td>

```yaml
vault_main_configuration.hcl.j2
```

</td></tr>

<tr>
<td>

```
vault_listener_localhost_enable
```

</td><td>Set this to true if you enable listen vault on localhost</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_http_proxy
```

</td><td>Address to be used as the proxy for HTTP and HTTPS requests unless overridden by vault_https_proxy or vault_no_proxy</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_https_proxy
```

</td><td>Address to be used as the proxy for HTTPS requests unless overridden by vault_no_proxy</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_no_proxy
```

</td><td>Comma separated values which specify hosts that should be exluded from proxying. Follows golang conventions</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_tcp_listeners
```

</td><td>A list of tcp listeners. Each listener can define any of the listener specific variables described in further detail below.</td><td>

```yaml
[map[vault_address:{{ vault_address }} vault_cluster_address:{{ vault_cluster_address }} vault_port:{{ vault_port }} vault_tls_ca_file:{{ vault_tls_ca_file }} vault_tls_cert_file:{{ vault_tls_cert_file }} vault_tls_certs_path:{{ vault_tls_certs_path }} vault_tls_cipher_suites:{{ vault_tls_cipher_suites }} vault_tls_disable:{{ vault_tls_disable }} vault_tls_disable_client_certs:{{ vault_tls_disable_client_certs }} vault_tls_key_file:{{ vault_tls_key_file }} vault_tls_min_version:{{ vault_tls_min_version }} vault_tls_private_path:{{ vault_tls_private_path }} vault_tls_require_and_verify_client_cert:{{ vault_tls_require_and_verify_client_cert }}]]
```

</td></tr>

<tr>
<td>

```
vault_backend_consul
```

</td><td>Backend consul template filename</td><td>

```yaml
vault_backend_consul.j2
```

</td></tr>

<tr>
<td>

```
vault_backend_file
```

</td><td>Backend file template filename</td><td>

```yaml
vault_backend_file.j2
```

</td></tr>

<tr>
<td>

```
vault_backend_raft
```

</td><td>Backend raft integrated storage template filename</td><td>

```yaml
vault_backend_raft.j2
```

</td></tr>

<tr>
<td>

```
vault_backend_etcd
```

</td><td></td><td>

```yaml
vault_backend_etcd.j2
```

</td></tr>

<tr>
<td>

```
vault_backend_s3
```

</td><td></td><td>

```yaml
vault_backend_s3.j2
```

</td></tr>

<tr>
<td>

```
vault_backend_dynamodb
```

</td><td></td><td>

```yaml
vault_backend_dynamodb.j2
```

</td></tr>

<tr>
<td>

```
vault_backend_mysql
```

</td><td></td><td>

```yaml
vault_backend_mysql.j2
```

</td></tr>

<tr>
<td>

```
vault_backend_gcs
```

</td><td></td><td>

```yaml
vault_backend_gcs.j2
```

</td></tr>

<tr>
<td>

```
vault_cluster_disable
```

</td><td>Disable HA clustering</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_cluster_address
```

</td><td>Address to bind to for cluster server-to-server requests</td><td>

```yaml
{{ hostvars[inventory_hostname]['ansible_' + vault_iface]['ipv4']['address'] }}:{{ (vault_port | int) + 1 }}
```

</td></tr>

<tr>
<td>

```
vault_cluster_addr
```

</td><td>Address to advertise to other Vault servers in the cluster for request forwarding</td><td>

```yaml
{{ vault_protocol }}://{{ vault_cluster_address }}
```

</td></tr>

<tr>
<td>

```
vault_api_addr
```

</td><td>https://www.vaultproject.io/docs/concepts/ha.htmlclient-redirection</td><td>

```yaml
{{ vault_protocol }}://{{ vault_redirect_address | default(hostvars[inventory_hostname]['ansible_' + vault_iface]['ipv4']['address']) }}:{{ vault_port }}
```

</td></tr>

<tr>
<td>

```
vault_disable_api_health_check
```

</td><td>flag for disabling the health check on vaults api address</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_max_lease_ttl
```

</td><td>Configures the maximum possible lease duration for tokens and secrets.</td><td>

```yaml
768h
```

</td></tr>

<tr>
<td>

```
vault_default_lease_ttl
```

</td><td>Configures the default lease duration for tokens and secrets.</td><td>

```yaml
768h
```

</td></tr>

<tr>
<td>

```
vault_backend_tls_src_files
```

</td><td>User-specified source directory for TLS files for storage communication</td><td>

```yaml
{{ vault_tls_src_files }}
```

</td></tr>

<tr>
<td>

```
vault_backend_tls_certs_path
```

</td><td>Path to directory containing backend tls certificate files</td><td>

```yaml
{{ vault_tls_certs_path }}
```

</td></tr>

<tr>
<td>

```
vault_backend_tls_private_path
```

</td><td>Path to directory containing backend tls key files</td><td>

```yaml
{{ vault_tls_private_path }}
```

</td></tr>

<tr>
<td>

```
vault_backend_tls_cert_file
```

</td><td>Specifies the path to the certificate for backend communication (if supported).</td><td>

```yaml
{{ vault_tls_cert_file }}
```

</td></tr>

<tr>
<td>

```
vault_backend_tls_key_file
```

</td><td>Specifies the path to the private key for backend communication (if supported).</td><td>

```yaml
{{ vault_tls_key_file }}
```

</td></tr>

<tr>
<td>

```
vault_backend_tls_ca_file
```

</td><td>CA certificate used for backend communication (if supported). This defaults to system bundle if not specified.</td><td>

```yaml
{{ vault_tls_ca_file }}
```

</td></tr>

<tr>
<td>

```
vault_consul
```

</td><td>host:port value for connecting to Consul HA backend</td><td>

```yaml
127.0.0.1:8500
```

</td></tr>

<tr>
<td>

```
vault_consul_path
```

</td><td>Name of Vault's Consul K/V root path</td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_consul_service
```

</td><td>Name of the Vault service to register in Consul</td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_consul_scheme
```

</td><td>Scheme for Consul backend</td><td>

```yaml
http
```

</td></tr>

<tr>
<td>

```
vault_etcd
```

</td><td>vault_consul_token:  Address of etcd storage</td><td>

```yaml
127.0.0.1:2379
```

</td></tr>

<tr>
<td>

```
vault_etcd_api
```

</td><td>API version</td><td>

```yaml
v3
```

</td></tr>

<tr>
<td>

```
vault_etcd_path
```

</td><td>Path for Vault storage</td><td>

```yaml
/vault/
```

</td></tr>

<tr>
<td>

```
vault_etcd_discovery_srv
```

</td><td>Discovery server</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_etcd_discovery_srv_name
```

</td><td>Discovery server name</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_etcd_ha_enabled
```

</td><td>Use storage for High Availability mode</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_etcd_sync
```

</td><td>Use etcdsync</td><td>

```yaml
true
```

</td></tr>

<tr>
<td>

```
vault_etcd_username
```

</td><td>Username</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_etcd_password
```

</td><td>Password</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_etcd_request_timeout
```

</td><td>Request timeout</td><td>

```yaml
5s
```

</td></tr>

<tr>
<td>

```
vault_etcd_lock_timeout
```

</td><td>Lock timeout</td><td>

```yaml
15s
```

</td></tr>

<tr>
<td>

```
vault_s3_access_key
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_s3_secret_key
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_s3_bucket
```

</td><td></td><td>

```yaml
vault_backend
```

</td></tr>

<tr>
<td>

```
vault_s3_region
```

</td><td></td><td>

```yaml
us-east-1
```

</td></tr>

<tr>
<td>

```
vault_s3_endpoint
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_s3_disable_ssl
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_s3_force_path_style
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_s3_kms_key_id
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_s3_session_token
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_s3_max_parallel
```

</td><td></td><td>

```yaml
128
```

</td></tr>

<tr>
<td>

```
vault_dynamodb
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_DYNAMODB_ENDPOINT') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_table
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_DYNAMODB_TABLE') | default('vault-dynamodb-backend', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_ha_enabled
```

</td><td></td><td>

```yaml
{{ lookup('env', 'DYNAMODB_HA_ENABLED') | default('false', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_max_parallel
```

</td><td></td><td>

```yaml
128
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_region
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_DEFAULT_REGION') | default('us-east-1', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_read_capacity
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_DYNAMODB_READ_CAPACITY') | default('5', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_write_capacity
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_DYNAMODB_WRITE_CAPACITY') | default('5', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_access_key
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_ACCESS_KEY_ID') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_secret_key
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_SECRET_ACCESS_KEY') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_dynamodb_session_token
```

</td><td></td><td>

```yaml
{{ lookup('env', 'AWS_SESSION_TOKEN') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_mysql
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_username
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_password
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_database
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_table
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_tls_ca_file
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_max_parallel
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_max_idle_connections
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_mysql_max_connection_lifetime
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_gcs_bucket
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_gcs_ha_enabled
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_gcs_chunk_size
```

</td><td></td><td>

```yaml
8192
```

</td></tr>

<tr>
<td>

```
vault_gcs_max_parallel
```

</td><td></td><td>

```yaml
128
```

</td></tr>

<tr>
<td>

```
vault_gcs_copy_sa
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_gcs_credentials_src_file
```

</td><td></td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_gcs_credentials_dst_file
```

</td><td></td><td>

```yaml
{{ vault_home }}/{{ vault_gcs_credentials_src_file | basename }}
```

</td></tr>

<tr>
<td>

```
vault_backend
```

</td><td>Which storage backend should be selected, choices are: raft, consul, etcd, file, s3, and dynamodb</td><td>

```yaml
raft
```

</td></tr>

<tr>
<td>

```
vault_raft_group_name
```

</td><td>Inventory group name of servers hosting the raft backend</td><td>

```yaml
vault_raft_servers
```

</td></tr>

<tr>
<td>

```
vault_raft_cluster_members
```

</td><td>Members of the raft cluster</td><td>

```yaml
[
{% for server in groups[vault_raft_group_name] %}
  {
    "peer": "{{ server }}",
    "api_addr": "{{ hostvars[server]['vault_api_addr'] |
    default(vault_protocol + '://' + hostvars[server]['ansible_' + hostvars[server]['ansible_default_ipv4']['interface']]['ipv4']['address'] + ':' + (vault_port|string)) }}"
  },
{% endfor %}
]

```

</td></tr>

<tr>
<td>

```
vault_raft_data_path
```

</td><td>Data path for Raft</td><td>

```yaml
{{ lookup('env', 'VAULT_RAFT_DATA_PATH') | default(vault_data_path, true) }}
```

</td></tr>

<tr>
<td>

```
vault_raft_node_id
```

</td><td>Node_id for Raft</td><td>

```yaml
{{ lookup('env', 'VAULT_RAFT_NODE_ID') | default(inventory_hostname_short, true) }}
```

</td></tr>

<tr>
<td>

```
vault_raft_leader_tls_servername
```

</td><td>TLS servername to use when connecting with HTTPS</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_performance_multiplier
```

</td><td>Performance multiplier for Raft</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_trailing_logs
```

</td><td>Logs entries count left on log store after snapshot</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_snapshot_threshold
```

</td><td>Minimum Raft commit entries between snapshots</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_max_entry_size
```

</td><td>Maximum number of bytes for a Raft entry</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_autopilot_reconcile_interval
```

</td><td>Interval after which autopilot will pick up any state changes</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_cloud_auto_join
```

</td><td>Defines any cloud auto-join metadata. If supplied, Vault will attempt to automatically discover peers in addition to what can be provided via leader_api_addr</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_cloud_auto_join_scheme
```

</td><td>URI scheme to be used for auto_join</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_cloud_auto_join_port
```

</td><td>Port to be used for auto_join</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_raft_cloud_auto_join_exclusive
```

</td><td>If set to true, any leader_api_addr occurences will be removed from the configuration. Keeping this to false will allow auto_join and leader_api_addr to coexist</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_enable
```

</td><td>Enable Consul service registration</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_template
```

</td><td>Consul service registration template filename</td><td>

```yaml
vault_service_registration_consul.hcl.j2
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_check_timeout
```

</td><td>Specifies the check interval used to send health check information back to Consul.</td><td>

```yaml
5s
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_address
```

</td><td>host:port value for connecting to Consul service registration</td><td>

```yaml
127.0.0.1:8500
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_service
```

</td><td></td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_service_tags
```

</td><td>Specifies a comma-separated list of tags to attach to the service registration in Consul.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_service_address
```

</td><td>Specifies a service-specific address to set on the service registration in Consul.</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_disable_registration
```

</td><td>Specifies whether Vault should register itself with Consul.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_scheme
```

</td><td></td><td>

```yaml
http
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_token
```

</td><td>ACL token for registering with Consul service registration</td><td>

```yaml
<no value>
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_tls_certs_path
```

</td><td>path to tls certificate</td><td>

```yaml
{{ vault_tls_certs_path }}
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_tls_private_path
```

</td><td>path to tls key</td><td>

```yaml
{{ vault_tls_private_path }}
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_tls_cert_file
```

</td><td>Server certificate</td><td>

```yaml
{{ vault_tls_cert_file }}
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_tls_key_file
```

</td><td>Server key</td><td>

```yaml
{{ vault_tls_key_file }}
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_tls_ca_file
```

</td><td></td><td>

```yaml
{{ vault_tls_ca_file }}
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_tls_min_version
```

</td><td></td><td>

```yaml
{{ vault_tls_min_version }}
```

</td></tr>

<tr>
<td>

```
vault_service_registration_consul_tls_skip_verify
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_service_registration_kubernetes_enable
```

</td><td>Enable Kubernetes service registration</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_service_registration_kubernetes_template
```

</td><td>Kubernetes service registration template filename</td><td>

```yaml
vault_service_registration_kubernetes.hcl.j2
```

</td></tr>

<tr>
<td>

```
vault_service_registration_kubernetes_namespace
```

</td><td>Kubernetes namespace to register</td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_service_registration_kubernetes_pod_name
```

</td><td>Kubernetes pod name to register</td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_bsdinit_template
```

</td><td>BSD init template file</td><td>

```yaml
vault_service_bsd_init.j2
```

</td></tr>

<tr>
<td>

```
vault_sysvinit_template
```

</td><td>SysV init template file</td><td>

```yaml
vault_sysvinit.j2
```

</td></tr>

<tr>
<td>

```
vault_debian_init_template
```

</td><td>Debian init template file</td><td>

```yaml
vault_service_debian_init.j2
```

</td></tr>

<tr>
<td>

```
vault_systemd_template
```

</td><td>Systemd service template file</td><td>

```yaml
vault_service_systemd.j2
```

</td></tr>

<tr>
<td>

```
vault_systemd_service_name
```

</td><td>Systemd service unit name</td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_systemd_unit_path
```

</td><td></td><td>

```yaml
/lib/systemd/system
```

</td></tr>

<tr>
<td>

```
validate_certs_during_api_reachable_check
```

</td><td>Disable Certificate Validation for API reachability check</td><td>

```yaml
true
```

</td></tr>

<tr>
<td>

```
vault_tls_certs_path
```

</td><td>Path to TLS certificates</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_DIR') | default(('/opt/vault/tls' if (vault_install_hashi_repo) else '/etc/vault/tls'), true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_private_path
```

</td><td>Path to TLS keys</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_DIR') | default(('/opt/vault/tls' if (vault_install_hashi_repo) else '/etc/vault/tls'), true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_src_files
```

</td><td>User-specified source directory for TLS files</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_SRC_FILES') | default(role_path ~ '/files', true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_disable
```

</td><td>disable tls</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_DISABLE') | default(1, true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_gossip
```

</td><td>Enable TLS Gossip to storage (if supported)</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_GOSSIP') | default(0, true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_copy_keys
```

</td><td>Copy TLS files from src to dest</td><td>

```yaml
{{ false if (vault_install_hashi_repo) else true }}
```

</td></tr>

<tr>
<td>

```
vault_protocol
```

</td><td></td><td>

```yaml
{% if vault_tls_disable %}http{% else %}https{% endif %}
```

</td></tr>

<tr>
<td>

```
vault_tls_cert_file
```

</td><td>Server certificate</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_CERT_FILE') | default(('tls.crt' if (vault_install_hashi_repo) else 'server.crt'), true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_key_file
```

</td><td>Server key</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_KEY_FILE') | default(('tls.key' if (vault_install_hashi_repo) else 'server.key'), true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_ca_file
```

</td><td>CA certificate filename</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_CA_CRT') | default('ca.crt', true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_client_ca_file
```

</td><td>Client CA certificate filename</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_tls_min_version
```

</td><td>Client CA certificate filename</td><td>

```yaml
{{ lookup('env', 'VAULT_TLS_MIN_VERSION') | default('tls12', true) }}
```

</td></tr>

<tr>
<td>

```
vault_tls_cipher_suites
```

</td><td>Client CA certificate filename</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_tls_files_remote_src
```

</td><td>Copy from remote source if TLS files are already on host</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_tls_require_and_verify_client_cert
```

</td><td>Copy from remote source if TLS files are already on host</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_tls_disable_client_certs
```

</td><td>Copy from remote source if TLS files are already on host</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_transit
```

</td><td>Set to true to enable Vault Transit Auto-unseal</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_transit_backend
```

</td><td>Backend seal template filename</td><td>

```yaml
vault_seal_transit.j2
```

</td></tr>

<tr>
<td>

```
vault_transit_config
```

</td><td>Destination configuration file</td><td>

```yaml
{{ vault_config_path }}/vault_transit.hcl
```

</td></tr>

<tr>
<td>

```
vault_transit_address
```

</td><td>Vault Address of the instance used for auto unseal</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_transit_token
```

</td><td>Token used to authenticate to the external vault instance</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_transit_disable_renewal
```

</td><td>Wether to disable automatic token renewal</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_transit_key_name
```

</td><td>Name of the key used for auto unseal</td><td>

```yaml
autounseal
```

</td></tr>

<tr>
<td>

```
vault_transit_mount_path
```

</td><td>Path where the transit engine is mounted to</td><td>

```yaml
transit/
```

</td></tr>

<tr>
<td>

```
vault_transit_namespace
```

</td><td>Namespace of the mounted transit engine</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_transit_tls_ca_cert_file
```

</td><td>CA Certificate of the external vault instance</td><td>

```yaml
{{ vault_tls_ca_file }}
```

</td></tr>

<tr>
<td>

```
vault_transit_tls_client_cert_file
```

</td><td>Client Certificate of the external vault instance</td><td>

```yaml
autounseal_client_cert.pem
```

</td></tr>

<tr>
<td>

```
vault_transit_tls_client_key_file
```

</td><td>Client Key of the external vault instance</td><td>

```yaml
autounseal_client_key.pem
```

</td></tr>

<tr>
<td>

```
vault_transit_tls_server_name
```

</td><td>TLS Servername of the external vault instance</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_transit_tls_skip_verify
```

</td><td>Wether to disable TLS certificate verification</td><td>

```yaml
{{ lookup('env', 'VAULT_SKIP_VERIFY') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_awskms
```

</td><td>Set to true to enable AWS KMS Auto-unseal</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_awskms_config
```

</td><td></td><td>

```yaml
{{ vault_config_path }}/vault_awskms.hcl
```

</td></tr>

<tr>
<td>

```
vault_awskms_backend
```

</td><td>Backend seal template filename</td><td>

```yaml
vault_seal_awskms.j2
```

</td></tr>

<tr>
<td>

```
vault_awskms_region
```

</td><td>Which AWS KMS region to use</td><td>

```yaml
{{ lookup('env', 'AWS_DEFAULT_REGION') | default('us-east-1', false) }}
```

</td></tr>

<tr>
<td>

```
vault_awskms_access_key
```

</td><td>The AWS Access Key to use for talking to AWS KMS</td><td>

```yaml
{{ lookup('env', 'AWS_ACCESS_KEY_ID') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_awskms_secret_key
```

</td><td>The AWS Secret Key ID to use for takling to AWS KMS</td><td>

```yaml
{{ lookup('env', 'AWS_SECRET_ACCESS_KEY') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_awskms_key_id
```

</td><td>The KMS Key ID to use for AWS KMS</td><td>

```yaml
{{ lookup('env', 'VAULT_AWSKMS_SEAL_KEY_ID') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_awskms_endpoint
```

</td><td>The endpoint to use for KMS</td><td>

```yaml
{{ lookup('env', 'AWS_KMS_ENDPOINT') | default('', false) }}
```

</td></tr>

<tr>
<td>

```
vault_azurekeyvault
```

</td><td>Set to true to enable AZURE Key Vault Auto-unseal</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_azurekeyvault_config
```

</td><td>Backend seal template filename</td><td>

```yaml
{{ vault_config_path }}/vault_azurekeyvault.hcl
```

</td></tr>

<tr>
<td>

```
vault_azurekeyvault_backend
```

</td><td></td><td>

```yaml
vault_seal_azurekeyvault.j2
```

</td></tr>

<tr>
<td>

```
vault_gkms
```

</td><td>Set to True to enable Google Cloud KMS Auto-Unseal.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_backend_gkms
```

</td><td>Backend seal template filename</td><td>

```yaml
vault_seal_gcpkms.j2
```

</td></tr>

<tr>
<td>

```
vault_gkms_project
```

</td><td>GCP Project where the key reside.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_gkms_credentials_src_file
```

</td><td>User-specified source directory for GCP Credential on Ansible control node.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_gkms_credentials_content
```

</td><td>User-specified GCP Credential file content.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_gkms_credentials
```

</td><td>Path to GCP credential on Vault server.</td><td>

```yaml
/home/vault/vault-kms.json
```

</td></tr>

<tr>
<td>

```
vault_gkms_region
```

</td><td>GCP Region where the key reside.</td><td>

```yaml
global
```

</td></tr>

<tr>
<td>

```
vault_gkms_key_ring
```

</td><td>The id of the Google Cloud Platform KeyRing to which the key shall belong.</td><td>

```yaml
vault
```

</td></tr>

<tr>
<td>

```
vault_gkms_crypto_key
```

</td><td>The CryptoKey's name. A CryptoKey's name must be unique within a location and match the regular expression [a-zA-Z0-9_-]{1,63}</td><td>

```yaml
vault_key
```

</td></tr>

<tr>
<td>

```
vault_gkms_copy_sa
```

</td><td>Copy GCP SA credentials file from Ansible control node to Vault server. When not true and no value is specified for vault_gkms_credentials_src_file, the default instance service account credentials are used.</td><td>

```yaml
true
```

</td></tr>

<tr>
<td>

```
vault_enterprise_premium_hsm
```

</td><td>Set to True if using premium binary. Basically just includes "+prem" in "vault_version" var</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_hsm_app
```

</td><td>Set which cryptography app to use.</td><td>

```yaml
pkcs11
```

</td></tr>

<tr>
<td>

```
vault_backend_seal
```

</td><td>Backend seal template filename</td><td>

```yaml
vault_seal_pkcs11.j2
```

</td></tr>

<tr>
<td>

```
vault_seal_lib
```

</td><td>Set to the absolute path of the HSM library vault will call</td><td>

```yaml
/lib64/hsmlibrary.so
```

</td></tr>

<tr>
<td>

```
vault_seal_pin
```

</td><td>The PIN for login. May also be specified by the VAULT_HSM_PIN environment variable. If set via the environment variable, Vault will obfuscate the environment variable after reading it, and it will need to be re-set if Vault is restarted.</td><td>

```yaml
12345
```

</td></tr>

<tr>
<td>

```
vault_seal_key_label
```

</td><td>The label of the key to use. If the key does not exist and generation is enabled, this is the label that will be given to the generated key. May also be specified by the VAULT_HSM_KEY_LABEL environment variable.</td><td>

```yaml
vault-hsm-key
```

</td></tr>

<tr>
<td>

```
vault_seal_hmac_key_label
```

</td><td>The label of the HMAC key to use. If the key does not exist and generation is enabled, this is the label that will be given to the generated HMAC key. May also be specified by the VAULT_HSM_HMAC_KEY_LABEL environment variable.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_seal_generate_key
```

</td><td>If no existing key with the label specified by key_label can be found at Vault initialization time, instructs Vault to generate a key. This is a boolean expressed as a string (e.g. "true"). May also be specified by the VAULT_HSM_GENERATE_KEY environment variable. Vault may not be able to successfully generate keys in all circumstances, such as if proprietary vendor extensions are required to create keys of a suitable type.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_seal_key_mechanism
```

</td><td>Do not change this unles you know you need to. The encryption/decryption mechanism to use, specified as a decimal or hexadecimal (prefixed by 0x) string. May also be specified by the VAULT_HSM_MECHANISM environment variable.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_seal_token_label
```

</td><td>The slot token label to use. May also be specified by the VAULT_HSM_TOKEN_LABEL environment variable. This label will only be applied when vault_softcard_enable is true.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_seal_slot
```

</td><td>The slot number to use, specified as a string (e.g. "0"). May also be specified by the VAULT_HSM_SLOT environment variable. This label will only be applied when vault_softcard_enable is false (default).</td><td>

```yaml
0
```

</td></tr>

<tr>
<td>

```
vault_softcard_enable
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_telemetry_enabled
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_unauthenticated_metrics_access
```

</td><td></td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_entropy_seal
```

</td><td>Set to True to include entropy stanza which enables entropy augmentation for supported seals. Supported Seal types include PKCS11, AWS KMS, and Vault Transit.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_enterprise
```

</td><td>Set this to true when installing Vault Enterprise; this is not currently possible as a "remote only" install method</td><td>

```yaml
{{ lookup('env', 'VAULT_ENTERPRISE') | default(false, true) }}
```

</td></tr>

<tr>
<td>

```
vault_enterprise_pkg
```

</td><td>package filename</td><td>

```yaml
vault-enterprise_{{ vault_version }}_{{ vault_os }}_{{ vault_architecture }}.zip
```

</td></tr>

<tr>
<td>

```
vault_enterprise_shasums
```

</td><td>SHA summaries filename (included for convenience not for modification)</td><td>

```yaml
vault-enterprise_{{ vault_version }}_SHA256SUMS
```

</td></tr>

<tr>
<td>

```
vault_enterprise_premium
```

</td><td>Set to True if using premium binary. Basically just includes "+prem" in "vault_version" var</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_configure_enterprise_license
```

</td><td>Manage enterprise license file with this role. Set to true to use vault_license_path or vault_license_file.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_license_path
```

</td><td>Path to enterprise license on the remote host (destination path). license_path in the main configuration file. Only used if vault_configure_enterprise_license: true.</td><td>

```yaml
{{ vault_config_path }}/license.hclic
```

</td></tr>

<tr>
<td>

```
vault_license_file
```

</td><td>Path to enterprise license on the Ansible controller (source file for upload). Upload skipped when empty or undefined. Only used if vault_configure_enterprise_license: true.</td><td>

```yaml

```

</td></tr>

<tr>
<td>

```
vault_plugins_enable
```

</td><td>List of plugins to enable (Check uner tasks/plugins to see supported plugins.)</td><td>

```yaml
[]
```

</td></tr>

<tr>
<td>

```
vault_plugins_src_dir_remote
```

</td><td>Directory where temporary plugin zip/installation files are placed. When installation is processed remotely.</td><td>

```yaml
/usr/local/src/vault/plugins
```

</td></tr>

<tr>
<td>

```
vault_plugins_src_dir_local
```

</td><td>Directory where temporary plugin zip/installation files are placed. When installation is processed locally.</td><td>

```yaml
{{ role_path }}/files/plugins
```

</td></tr>

<tr>
<td>

```
vault_plugins_src_dir_cleanup
```

</td><td>Whether to clean up the temporary plugin zip/installation file directory after plugin install. Warning: When plugins don't provide a version number this could cause the plugins to be downloaded every time and thus breaking idempotence.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_plugin_install
```

</td><td>Setting this to remote will download the acme plugin to each target instead of copying it from localhost.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_plugin_acme_install
```

</td><td>Setting this to remote will download the acme plugin to each target instead of copying it from localhost.</td><td>

```yaml
remote
```

</td></tr>

<tr>
<td>

```
vault_plugin_acme_sidecar_install
```

</td><td>Whether to install vault acme sidecar for HTTP-01/TLS_ALPN_01 challenges in addition to DNS-01.</td><td>

```yaml
false
```

</td></tr>

<tr>
<td>

```
vault_plugin_acme_version
```

</td><td>Version of the acme plugin to install, can be set to latest for obtaining the latest available version.</td><td>

```yaml
latest
```

</td></tr>

<tr>
<td>

```
vault_plugin_acme_zip
```

</td><td></td><td>

```yaml
{{ vault_os }}_{{ vault_architecture }}.zip
```

</td></tr>

<tr>
<td>

```
vault_plugin_acme_release_url
```

</td><td></td><td>

```yaml
https://github.com/remilapeyre/vault-acme/releases/download/v{{ vault_plugin_acme_version }}
```

</td></tr>

<tr>
<td>

```
vault_plugin_acme_zip_sha256sum
```

</td><td></td><td>

```yaml
{{ (lookup('url', vault_plugin_acme_release_url ~ '/vault-acme_SHA256SUMS', wantlist=true) | select('match', '.*' + vault_plugin_acme_zip + '$') | first).split()[0] }}
```

</td></tr>

</table>
<!--ansdoc -->
