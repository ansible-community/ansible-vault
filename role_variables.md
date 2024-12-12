# Role Variables

The role defines variables in `defaults/main.yml`:

## `vault_listener_localhost_enable`

 - Set this to true if you enable listen vault on localhost
 - Default value: *false*

## `vault_privileged_install`

 - Set this to true if you see permission errors when the vault files are
   downloaded and unpacked locally. This issue can show up if the role has
   been downloaded by one user (like root), and the installation is done
   with a different user.
 - Default value: *false*

## `vault_version`

- Version to install
  - Can be overridden with `VAULT_VERSION` environment variable
  - Will include ".hsm" if vault_enterprise_hsm=True

- Default value: 1.5.5

## `vault_enterprise`

- Set this to true when installing Vault Enterprise; this is not currently
  possible as a "remote only" install method
  - Can be overridden with `VAULT_ENTERPRISE` environment variable
- Default value: *false*

## `vault_pkg`

- package filename
- Default value: `"vault_{{ vault_version }}_linux_amd64.zip"`

## `vault_enterprise_pkg`

- package filename
- Default value: `"vault-enterprise_{{ vault_version }}_{{ vault_os }}_{{ vault_architecture }}.zip"`

## `vault_zip_url`

- Package download URL
- Default value: `"https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version }}_linux_amd64.zip"`
- Override this var if you have your zip hosted internally
- Works for enterprise installs also

## `vault_checksum_file_url`

- SHA summaries URL
- Override this var if you have your sha file is hosted internally
- Default value: `"https://releases.hashicorp.com/vault/{{ vault_version }}/vault_{{ vault_version}}_SHA256SUMS"`

## `vault_install_hashi_repo`

- Set this to `true` when installing Vault via HashiCorp Linux repository.
  When set, you can also define `vault_repository_key_url` and `vault_repository_url`
  to override the default URL of the GPG key for the repository and the default URL of the
  repository used.
- Default value: *false*

## `vault_rhsm_repo_id`

- Name of rhsm repo
- Set this to the name of your rhsm repo when installing Vault via a RHSM repository (RedHat Satellite/Foreman/etc.).
  When set, you need make sure `vault_install_hashi_repo` is set to `true` to enable repo install. And optionally also
  the rhsm subscription name with `vault_rhsm_subscription_name`.
- Default value: null

## `vault_rhsm_subscription_name`

- Name of rhsm subscription
- Set the rhsm subscription name to attach the rhsm subscription via subscription-manager.
  When set, you need make sure `vault_install_hashi_repo` is set to `true` to enable repo install. And also that
  `vault_rhsm_repo_id` is set.
- Default value: null

## `vault_install_remotely`

- Set this to `true` will download Vault binary from each target instead of localhost
- Default value: *false*

## `vault_shasums`

- SHA summaries filename (included for convenience not for modification)
- Default value: `"vault_{{ vault_version }}_SHA256SUMS"`

## `vault_enterprise_shasums`

- SHA summaries filename (included for convenience not for modification)
- Will attempt to download from `vault_checksum_file_url` if not present in files/
- Default value: `"vault-enterprise_{{ vault_version }}_SHA256SUMS"`

## `vault_bin_path`

- Binary installation path
- Default value: `/usr/local/bin`

## `vault_config_path`

- Configuration file path
- Default value: `/etc/vault.d`

## `vault_use_config_path`

- Use `"{{ vault_config_path }}"` to configure vault instead of `"{{ vault_main_config }}"`
- default vaule: *false*

## `vault_plugin_path`

- Path from where plugins can be loaded
- Default value: `/usr/local/lib/vault/plugins`

## `vault_plugins_enable`

- List of plugins to enable (Check uner `tasks/plugins` to see supported plugins.)
- For example: `vault_plugins_enable: [ 'acme', 'example' ]`
- Default value: `[]`

## `vault_plugins_src_dir_remote`

- Directory where temporary plugin zip/installation files are placed.
  When installation is processed remotely.
- Default value: `/usr/local/src/vault/plugins`

## `vault_plugins_src_dir_local`

- Directory where temporary plugin zip/installation files are placed.
  When installation is processed locally.
- Default value: `{{ role_path }}/files/plugins`

## `vault_plugins_src_dir_cleanup`

- Whether to clean up the temporary plugin zip/installation file directory after plugin install.
  Warning: When plugins don't provide a version number this could cause the plugins to be downloaded every time and thus breaking idempotence.
- Default value: `false`

## `vault_data_path`

- Data path
- Default value: `/var/vault`

## `vault_log_path`

- Log path
- Default value: `/var/log/vault`

## `vault_run_path`

- PID file location
- Default value: `/var/run/vault`

## `vault_harden_file_perms`

- Whether this role should disallow Vault from writing into config and plugin
  path. This should be enabled to follow [Production Hardening](https://learn.hashicorp.com/tutorials/vault/production-hardening).
- Default value: false

## `vault_manage_user`

- Should this role manage the vault user?
- Default value: true

## `vault_user`

- OS user name
- Default value: vault

## `vault_group`

- OS group name
- Default value: bin

## `vault_groups`

- OS additional groups as in ansibles user module
- Default value: null

## `vault_manage_group`

- Should this role manage the vault group?
- Default value: false

## `vault_cluster_name`

- Cluster name label
- Default value: dc1

## `vault_datacenter`

- Datacenter label
- Default value:  dc1

## `vault_ui`

- Enable vault web UI
- Default value:  true

## `vault_service_restart`

- Should the playbook restart Vault service when needed
- Default value: true

## `vault_service_reload`

- Should the playbook reload Vault service when the main config changes.
- Default value: false

## `vault_start_pause_seconds`

- Some installations may need some time between the first Vault start
  and the first restart. Setting this to a value `>0` will add a pause
  time after the first Vault start.
- Default value: 0

# TCP Listener Variables

## `vault_tcp_listeners`

- A list of tcp listeners. Each listener can define any of the listener specific variables described in further detail below.
- Default value:
```yaml
vault_tcp_listeners:
  - vault_address: '{{ vault_address }}'
    vault_port: '{{ vault_port }}'
    vault_cluster_address: '{{ vault_cluster_address }}'
    # vault_proxy_protocol_behavior: '{{ vault_proxy_protocol_behavior }}'
    # vault_proxy_protocol_authorized_addrs: '{{ vault_proxy_protocol_authorized_addrs }}'
    vault_tls_disable: '{{ vault_tls_disable }}'
    vault_tls_certs_path: '{{ vault_tls_certs_path }}'
    vault_tls_private_path: '{{ vault_tls_private_path }}'
    vault_tls_cert_file: '{{ vault_tls_cert_file }}'
    vault_tls_key_file: '{{ vault_tls_key_file }}'
    vault_tls_ca_file: '{{ vault_tls_ca_file }}'
    vault_tls_min_version: '{{ vault_tls_min_version }}'
    vault_tls_cipher_suites: '{{ vault_tls_cipher_suites }}'
    vault_tls_require_and_verify_client_cert: '{{ vault_tls_require_and_verify_client_cert }}'
    vault_tls_disable_client_certs: '{{ vault_tls_disable_client_certs }}'
    # vault_x_forwarded_for_authorized_addrs: '{{ vault_x_forwarded_for_authorized_addrs }}'
    # vault_x_forwarded_for_hop_skips: '{{ vault_x_forwarded_for_hop_skips }}'
    # vault_x_forwarded_for_reject_not_authorized: '{{ vault_x_forwarded_for_reject_not_authorized }}'
    # vault_x_forwarded_for_reject_not_present: '{{ vault_x_forwarded_for_reject_not_present }}'
```

# Storage Backend Variables

## `vault_backend`

- Which storage backend should be selected, choices are: raft, consul, etcd, file, s3, and dynamodb
- Default value: raft


## `vault_backend_tls_src_files`

- User-specified source directory for TLS files for storage communication
- `{{ vault_tls_src_files }}`

## `vault_backend_tls_certs_path`

- Path to directory containing backend tls certificate files
- `{{ vault_tls_certs_path }}`

## `vault_backend_tls_private_path`

- Path to directory containing backend tls key files
- `{{ vault_tls_private_path }}`

## `vault_backend_tls_cert_file`

- Specifies the path to the certificate for backend communication (if supported).
- `{{ vault_tls_cert_file }}`

## `vault_backend_tls_key_file`

- Specifies the path to the private key for backend communication (if supported).
- `{{ vault_tls_key_file }}`

## `vault_backend_tls_ca_file`

- CA certificate used for backend communication (if supported). This defaults to system bundle if not specified.
- `{{ vault_tls_ca_file }}`

## Raft Storage Backend
## `vault_raft_leader_tls_servername`

- TLS servername to use when connecting with HTTPS
- Default value: none

## `vault_raft_group_name`

- Inventory group name of servers hosting the raft backend
- Default value: vault_raft_servers

## `vault_raft_cluster_members`

- Members of the raft cluster
- Default value: hosts in `vault_raft_group_name` group
- Can be used to override the behaviour of dynamically selecting all hosts in `vault_raft_group_name`
- Example:
  ```
  vault_raft_cluster_members:
    - peer: vault-host-1
      api_addr: https://vault-host-1:8200
    - peer: vault-host-2
      api_addr: https://vault-host-2:8200
    - peer: vault-host-3
      api_addr: https://vault-host-2:8200
  ```
- Setting the `vault_raft_cluster_members` statically enables you to run the role against a single host (instead of the entire host group)

## `vault_raft_data_path`

- Data path for Raft
- Default value: vault_data_path

## `vault_raft_node_id`

- Node_id for Raft
- Default value: inventory_hostname_short

## `vault_raft_performance_multiplier`

- Performance multiplier for Raft
- Default value: none

## `vault_raft_trailing_logs`

- Logs entries count left on log store after snapshot
- Default value: none

## `vault_raft_snapshot_threshold`

- Minimum Raft commit entries between snapshots
- Default value: none

## `vault_raft_max_entry_size`

- Maximum number of bytes for a Raft entry
- Default value: none

## `vault_raft_autopilot_reconcile_interval`

- Interval after which autopilot will pick up any state changes
- Default value: none

## `vault_raft_cloud_auto_join`

- Defines any cloud auto-join metadata. If supplied, Vault will
  attempt to automatically discover peers in addition to what can
  be provided via `leader_api_addr`
- Default value: none

## `vault_raft_cloud_auto_join_exclusive`

- If set to `true`, any `leader_api_addr` occurences will be removed
  from the configuration.
  Keeping this to `false` will allow `auto_join` and `leader_api_addr`
  to coexist
- Default value: false

## `vault_raft_cloud_auto_join_scheme`

- URI scheme to be used for `auto_join`
- Default value: none (`https` is the default value set by
  Vault if not specified)

## `vault_raft_cloud_auto_join_port`

- Port to be used for `auto_join`
- Default value: none (`8200` is the default value set by
  Vault if not specified)

## Consul Storage Backend

## `vault_backend_consul`

- Backend consul template filename
- Default value: `backend_consul.j2`

## `vault_consul`

- host:port value for connecting to Consul HA backend
- Default value: 127.0.0.1:8500

## `vault_consul_scheme`

- Scheme for Consul backend
- Supported values: http, https
- Default value: http

## `vault_consul_path`

- Name of Vault's Consul K/V root path
- Default value: vault

## `vault_consul_service`

- Name of the Vault service to register in Consul
- Default value: vault

## `vault_consul_token`

- ACL token for accessing Consul
- Default value: none

## etcd Storage Backend

## `vault_etcd`

- Address of etcd storage
- Default value: 127.0.0.1:2379

## `vault_etcd_api`

- API version
- Default value: v3

## `vault_etcd_path`

- Path for Vault storage
- Default value: /vault/

## `vault_etcd_discovery_srv`

- Discovery server
- Default value: none

## `vault_etcd_discovery_srv_name`

- Discovery server name
- Default value: none

## `vault_etcd_ha_enabled`

- Use storage for High Availability mode
- Default value: false

## `vault_etcd_sync`

- Use etcdsync
- Default value: true

## `vault_etcd_username`

- Username
- Default value: none

## `vault_etcd_password`

- Password
- Default value: none

## `vault_etcd_request_timeout`

- Request timeout
- Default value: "5s"

## `vault_etcd_lock_timeout`

- Lock timeout
- Default value: "15s"

## File Storage Backend

## `vault_backend_file`

- Backend file template filename
- Default value: `backend_file.j2`

## Raft Integrated Storage Backend

## `vault_backend_raft`

- Backend raft integrated storage template filename
- Default value: `vault_backend_raft.j2`

## `vault_raft_node_id`

- Identifier for the node in the integrated storage Raft cluster
- Default value: "raft_node_1"

## `vault_raft_retry_join`

- Details of all the nodes are known beforehand
- Default value: "[]"

### `leader_api_addr`

- Address of a possible leader node.
- Default value: ""

### `leader_ca_cert_file`

- File path to the CA cert of the possible leader node.
- Default value: ""

### `leader_client_cert_file`

- File path to the client certificate for the follower node to establish client authentication with the possible leader node.
- Default value: ""

### `leader_client_key_file`

- File path to the client key for the follower node to establish client authentication with the possible leader node.
- Default value: ""

### `leader_ca_cert`

- CA cert of the possible leader node.
- Default value: ""

### `leader_client_cert`

- Client certificate for the follower node to establish client authentication with the possible leader node.
- Default value: ""

### `leader_client_key`

- Client key for the follower node to establish client authentication with the possible leader node.
- Default value: ""

## DynamoDB Storage Backend

For additional documentation for the various options available, see the
[Vault documentation](https://www.vaultproject.io/docs/configuration/storage/dynamodb.html)
for the DynamoDB storage backend.

## `vault_dynamodb`

- Specifies an alternative DynamoDB endpoint.
- Default value: none
  - Can be overridden with the environment variable `AWS_DYNAMODB_ENDPOINT`.

## `vault_dynamodb_table`

- Name of the DynamoDB table used to store Vault data.
  - If the table does not already exist, it will be created during
    initialization.
- Default value: `"vault-dynamodb-backend"`
  - Can be overridden with the environment variable `AWS_DYNAMODB_TABLE`.

## `vault_dynamodb_ha_enabled`

- Whether High Availability is enabled for this storage backend.
- Default value: `"false"`
  - Can be overridden with the environment variable `DYNAMODB_HA_ENABLED`.
    - The missing `AWS_` prefix is not a typo, this particular variable is not
      prefixed in both the Vault documentation and source code.

## `vault_dynamodb_max_parallel`

- The maximum number of concurrent requests.
- Default value: `"128"`

## `vault_dynamodb_region`

- The AWS region.
- Default value: `us-east-1`
  - Can be overridden with the environment variable `AWS_DEFAULT_REGION`

## `vault_dynamodb_read_capacity`

- Number of reads per second to provision for the table.
- Only used during table creation, has no effect if the table already exists.
- Default value: `5`
  - Can be overridden with the environment variable `AWS_DYNAMODB_READ_CAPACITY`.

## `vault_dynamodb_write_capacity`

- Number of writes per second to provision for the table.
- Only used during table creation, has no effect if the table already exists.
- Default value: `5`
  - Can be overridden with the environment variable `AWS_DYNAMODB_WRITE_CAPACITY`.

## `vault_dynamodb_access_key`

- AWS access key to use for authentication.
- Default value: none
  - Can be overridden with the environment variable `AWS_ACCESS_KEY_ID`
- Leaving both this and `vault_dynamodb_secret_key` blank will cause Vault to
  attempt to retrieve the credentials from the AWS metadata service.

## `vault_dynamodb_secret_key`

- AWS secret key used for authentication.
- Default value: none
  - Can be overridden with the environment variable `AWS_SECRET_ACCESS_KEY`
- Leaving both this and `vault_dynamodb_access_key` blank will cause Vault to
  attempt to retrieve the credentials from the AWS metadata service.

## `vault_dynamodb_session_token`

- AWS session token.
- Default value: none
  - Can be overridden with the environment variable `AWS_SESSION_TOKEN`

## Google Cloud Storage Storage Backend

## `vault_gcs_bucket`

- Specifies the name of the bucket to use for storage.
- Default value: none

## `vault_gcs_ha_enabled`

- Specifies if high availability mode is enabled.
- Default value: `"false"`


## `vault_gcs_chunk_size`

- Specifies the maximum size (in kilobytes) to send in a single request. If set to 0, it will attempt to send the whole object at once, but will not retry any failures.
- Default value: `"8192"`

## `vault_gcs_max_parallel`

- Specifies the maximum number of parallel operations to take place.
- Default value: `"128"`

## `vault_gcs_copy_sa`

- Copy GCP SA credentials file from Ansible control node to Vault server. When not `true` and no value is specified for `vault_gcs_credentials_src_file`, the default instance service account credentials are used.
- Default value: `"false"`

## `vault_gcs_credentials_src_file`

- Path to GCP SA credential on Ansible control node.
- Default value: none

## `vault_gcs_credentials_dst_file`

- Path to SA GCP credential on Vault server.
- Default value: `{{ vault_home }}/{{ vault_gcs_credentials_src_file | basename}}"`

## Consul Service Registration

For additional information on the various options, see the
[Vault documentation](https://www.vaultproject.io/docs/configuration/service-registration/consul)
for Consul service registration. Note that this is only available
starting at Vault version 1.4.

## `vault_service_registration_consul_enable`

- Enable Consul service registration
- Default value: false

## `vault_service_registration_consul_template`

- Consul service registration template filename
- Default value: `service_registration_consul.hcl.j2`

## `vault_service_registration_consul_address`

- host:port value for connecting to Consul service registration
- Default value: 127.0.0.1:8500

## `vault_service_registration_check_timeout`

- Specifies the check interval used to send health check information back to Consul.
- Default value: 5s

## `vault_service_registration_disable_registration`

- Specifies whether Vault should register itself with Consul.
- Default value: false

## `vault_service_registration_consul_scheme`

- Scheme for Consul service registration
- Supported values: http, https
- Default value: http

## `vault_service_registration_consul_service`

- Name of the Vault service to register in Consul
- Default value: vault

## `vault_service_registration_consul_service_tags`

- Specifies a comma-separated list of tags to attach to the service registration in Consul.
- Default value: ""

## `vault_service_registration_consul_service_address`

- Specifies a service-specific address to set on the service registration in Consul.
- Default value: nil

## `vault_service_registration_consul_token`

- ACL token for registering with Consul service registration
- Default value: none

## `vault_service_registration_consul_tls_certs_path`

- path to tls certificate
- default value `{{ vault_tls_certs_path }}`

## `vault_service_registration_consul_tls_private_path`

- path to tls key
- default value `{{ vault_tls_private_path }}`

## `vault_service_registration_consul_tls_ca_file`

- CA certificate filename
- Default value: `{{ vault_tls_ca_file }}`

## `vault_service_registration_consul_tls_cert_file`

- Server certificate
- Default value: `{{ vault_tls_cert_file }}`

## `vault_service_registration_consul_tls_key_file`

- Server key
- Default value: `{{ vault_tls_key_file }}`

## `vault_service_registration_consul_tls_min_version`

- [Minimum acceptable TLS version](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_min_version)
- Default value: `{{ vault_tls_min_version }}`

## `vault_service_registration_consul_tls_skip_verify`

- Disable verification of TLS certificates. Using this option is highly discouraged.
- Default value: false

## Kubernetes Service Registration

For additional information on the various options, see the
[Vault documentation](https://www.vaultproject.io/docs/configuration/service-registration/kubernetes)
for Kubernetes service registration. Note that this is only
available starting at Vault version 1.4.

## `vault_service_registration_kubernetes_consul_enable`

- Enable Kubernetes service registration
- Default value: false

## `vault_service_registration_kubernetes_template`

- Kubernetes service registration template filename
- Default value: `service_registration_kubernetes.hcl.j2`

## `vault_service_registration_kubernetes_namespace`

- Kubernetes namespace to register
- Default value: vault

## `vault_service_registration_pod_name`

- Kubernetes pod name to register
- Default value: vault

## `vault_log_level`

- [Log level](https://www.consul.io/docs/agent/options.html#_log_level)
  - Supported values: trace, debug, info, warn, err
- Default value: info
- Requires Vault version 0.11.1 or higher

## `vault_iface`

- Network interface
  - Can be overridden with `VAULT_IFACE` environment variable
- Default value: eth1

## `vault_address`

- Primary network interface address to use
- Default value: `"{{ hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}"`

## `vault_port`

- TCP port number to on which to listen
- Default value: 8200

## `vault_max_lease_ttl`

- Configures the [maximum possible lease duration](https://www.vaultproject.io/docs/config/#max_lease_ttl) for tokens and secrets.
- Default value: 768h (32 days)

## `vault_default_lease_ttl`

- Configures the [default lease duration](https://www.vaultproject.io/docs/config/#default_lease_ttl) for tokens and secrets.
- Default value: 768h (32 days)

## `vault_main_config`
- Main configuration file name (full path)
- Default value: `"{{ vault_config_path }}/vault_main.hcl"`

## `vault_main_configuration_template`

- Vault main configuration template file
- Default value: *vault_main_configuration.hcl.j2*

## `vault_custom_configuration`

- Vault custom configuration
- Default value: none

## `vault_http_proxy`

- Address to be used as the proxy for HTTP and HTTPS requests unless overridden by `vault_https_proxy` or `vault_no_proxy`
- Default value: `""`

## `vault_https_proxy`

- Address to be used as the proxy for HTTPS requests unless overridden by `vault_no_proxy`
- Default value: `""`

## `vault_no_proxy`

- Comma separated values which specify hosts that should be exluded from proxying.  Follows [golang conventions](https://godoc.org/golang.org/x/net/http/httpproxy)
- Default value: `""`

## `vault_cluster_address`

- Address to bind to for cluster server-to-server requests
- Default value: `"{{ hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}:{{ (vault_port | int) + 1}}"`

## `vault_cluster_addr`

- Address to advertise to other Vault servers in the cluster for request forwarding
- Default value: `"{{ vault_protocol }}://{{ vault_cluster_address }}"`

## `vault_api_addr`

- [HA Client Redirect address](https://www.vaultproject.io/docs/concepts/ha.html#client-redirection)
- Default value: `"{{ vault_protocol }}://{{ vault_redirect_address or hostvars[inventory_hostname]['ansible_'+vault_iface]['ipv4']['address'] }}:{{ vault_port }}"`
  - vault_redirect_address is kept for backward compatibility but is deprecated.

## `vault_disable_api_health_check`

- flag for disabling the health check on vaults api address
- Default value: `false`

## `vault_cluster_disable`

- Disable HA clustering
- Default value: false

## `validate_certs_during_api_reachable_check`

- Disable Certificate Validation for API reachability check
- Default value: true

## `vault_proxy_protocol_behavior`

- May be one of `use_always`, `allow_authorized`, or `deny_unauthorized`
- Enables [PROXY protocol](https://www.vaultproject.io/docs/configuration/listener/tcp#proxy_protocol_behavior) for listener.
- If enabled and set to something other than `use_always`, you must also set
  - [*vault_proxy_protocol_authorized_addrs*](https://www.vaultproject.io/docs/configuration/listener/tcp#proxy_protocol_authorized_addrs)
  - Comma-separated list of source IPs for which PROXY protocol information will be used.
- Default value: ""

## `vault_tls_certs_path`

- Path to TLS certificates
- Default value `/etc/vault/tls`

## `vault_tls_private_path`

- Path to TLS keys
- Default value `/etc/vault/tls`

## `vault_tls_disable`

- [Disable TLS](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_disable)
  - Can be overridden with `VAULT_TLS_DISABLE` environment variable
- Default value: 1

## `vault_tls_gossip`

- Enable TLS Gossip to storage (if supported)
- Default value: 0

## `vault_tls_src_files`

- User-specified source directory for TLS files
  - Override with `VAULT_TLS_SRC_FILES` environment variable
- Default value: `{{ role_path }}/files`

## `vault_tls_ca_file`

- CA certificate filename
  - Override with `VAULT_TLS_CA_CRT` environment variable
- Default value: `ca.crt`

## `vault_tls_client_ca_file`

- Client CA certificate filename
- Default value: ``

## `vault_tls_cert_file`

- Server certificate
  - Override with `VAULT_TLS_CERT_FILE` environment variable
- Default value: `server.crt`

## `vault_tls_key_file`

- Server key
  - Override with `VAULT_TLS_KEY_FILE` environment variable
- Default value: `server.key`

## `vault_tls_min_version`

- [Minimum acceptable TLS version](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_min_version)
  - Can be overridden with `VAULT_TLS_MIN_VERSION` environment variable
- Default value: tls12

## `vault_tls_cipher_suites`

- [Comma-separated list of supported ciphersuites](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_cipher_suites)
- Default value: ""

## `vault_tls_require_and_verify_client_cert`

- [Require clients to present a valid client certificate](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_require_and_verify_client_cert)
- Default value: false

## `vault_tls_disable_client_certs`

- [Disable requesting for client certificates](https://www.vaultproject.io/docs/configuration/listener/tcp.html#tls_disable_client_certs)
- Default value: false

## `vault_tls_copy_keys`

- Copy TLS files from src to dest
- Default value: true

## `vault_tls_files_remote_src`

- Copy from remote source if TLS files are already on host
- Default value: false

## `vault_x_forwarded_for_authorized_addrs`

- Comma-separated list of source IP CIDRs for which an X-Forwarded-For header will be trusted.
- Enables [X-Forwarded-For support.](https://www.vaultproject.io/docs/configuration/listener/tcp#x_forwarded_for_authorized_addrs)
- If enabled, you may also set any of the following parameters:
  - *vault_x_forwarded_for_hop_skips* with a format of "N" for the number of hops to skip
  - *vault_x_forwarded_for_reject_not_authorized* with true/false
  - *vault_x_forwarded_for_reject_not_present* with true/false
- Default value: ""

## `vault_bsdinit_template`
- BSD init template file
- Default value: `vault_service_bsd_init.j2`

## `vault_sysvinit_template`
- SysV init  template file
- Default value: `vault_sysvinit.j2`

## `vault_debian_init_template`
- Debian init template file
- Default value: `vault_service_debian_init.j2`

## `vault_systemd_template`
- Systemd service template file
- Default value: `vault_service_systemd.j2`

## `vault_systemd_service_name`
- Systemd service unit name
- Default value: "vault"

## `vault_telemetry_enabled`
- Enable [Vault telemetry](https://www.vaultproject.io/docs/configuration/telemetry.html)
- If enabled, you must set at least one of the following parameters according to your telemetry provider:
  - *vault_statsite_address* with a format of "FQDN:PORT"
  - *vault_statsd_address* with a format of "FQDN:PORT"
  - *vault_prometheus_retention_time* e.g: "30s" or "24h"
- If enabled, optionally set *vault_telemetry_disable_hostname* to strip the hostname prefix from telemetry data
- Default value: *false*

## `vault_unauthenticated_metrics_access`

- Configure [unauthenticated metrics access](https://www.vaultproject.io/docs/configuration/listener/tcp#configuring-unauthenticated-metrics-access)
- Default value: false

## `vault_telemetry_usage_gauge_period`

- Specifies the interval at which high-cardinality usage data is collected,
such as token counts, entity counts, and secret counts.
- Default value: *undefined*

# OS Distribution Variables

The `vault` binary works on most Linux platforms and is not distribution
specific. However, some distributions require installation of specific OS
packages with different naming, so this role was built with support for
popular Linux distributions and defines these variables to deal with the
differences across distributions:

## `vault_pkg`

- Vault package filename
- Default value: `{{ vault_version }}_linux_amd64.zip`

## `vault_centos_url`

- Vault package download URL
- Default value: `{{ vault_zip_url }}`

## `vault_centos_os_packages`

- List of OS packages to install
- Default value: list

## `vault_pkg`

- Vault package filename
- Default value: `"{{ vault_version }}_linux_amd64.zip"`

## `vault_debian_url`

- Vault package download URL
- Default value: `"{{ vault_zip_url }}"`

## `vault_sha256`

- Vault download SHA256 summary
- Default value: SHA256 summary

## `vault_debian_os_packages`

- List of OS packages to install
- Default value: list

## `vault_pkg`

- Vault package filename
- Default value: `"{{ vault_version }}_linux_amd64.zip"`

## `vault_redhat_url`

- Vault package download URL
- Default value: `"{{ vault_zip_url }}"`

## `vault_sha256`

- Vault package SHA256 summary
- Default value: SHA256 summary

## `vault_redhat_os_packages`

- List of OS packages to install
- Default value: list

## `vault_pkg`

- Vault package filename
- Default value: `"{{ vault_version }}_linux_amd64.zip"`

## `vault_ubuntu_url`

- Vault package download URL
- Default value: `"{{ vault_zip_url }}"`

## `vault_sha256`

- Vault package SHA256 summary
- Default value: SHA256 summary

## `vault_enable_log`

- Enable log to `vault_log_path`
- Default value: false

## `vault_enable_logrotate`

- Enable logrotation for systemd based systems
- Default value: false

## `vault_logrotate_freq`

- Determines how frequently to rotate vault logs
- Default value: 7

## `vault_logrotate_template`

- Logrotate template file
- Default value: `vault_logrotate.j2`

## `vault_ubuntu_os_packages`

- List of OS packages to install
- Default value: list

# Dependencies

> **NOTE**: Read these before executing the role to avoid certain frequently
encountered issues which are resolved by installing the correct dependencies.

## `gtar`

Ansible requires GNU tar and this role performs some local use of the
unarchive module, so ensure that your system has `gtar` installed.

## Python netaddr

The role depends on `python-netaddr` so:

```
pip install netaddr
```

on the Ansible control host prior to executing the role.

# Vault Enterprise

The role can install Vault Enterprise based instances.

Place the Vault Enterprise zip archive into `{{ role_path }}/files` and set
`vault_enterprise: true` or use the `VAULT_ENTERPRISE="true"` environment
variable. Attempts to download the package from `vault_zip_url` if zip is not found in files/.

Since v2.5.9 of this role you can also install Vault Enterprise via the HashiCorp Repo. In order to install Vault Enterprise via the HashiCorp Repo, set `vault_install_hashi_repo: true*` as well as `vault_enterprise: true`.

**Warning:** Non-Enterprise Package will be removed if already installed and vault_enterprise is set to *true* and vice versa.

# Vault Enterprise with HSM

The role can configure HSM based instances. Make sure to reference the [HSM support page](https://www.vaultproject.io/docs/configuration/seal/index.html) and take notice of the [behavior changes](https://www.vaultproject.io/docs/enterprise/hsm/behavior.html#initialization) after HSM is installed.

## `vault_enterprise_hsm`

- Set to True if using hsm binary. Basically just includes ".hsm" in "vault_version" var
- Default value: false

## `vault_configure_enterprise_license`

- Manage enterprise license file with this role. Set to `true` to use `vault_license_path` or `vault_license_file`.
- Default value: false

## `vault_license_path`

- Path to enterprise license on the remote host (destination path). [`license_path`](https://www.vaultproject.io/docs/configuration#license_path) in the main configuration file. Only used if `vault_configure_enterprise_license: true`.
- Default value: `{{ vault_config_path }}/license.hclic`

## `vault_license_file`

- Path to enterprise license on the Ansible controller (source file for upload). Upload skipped when empty or undefined. Only used if `vault_configure_enterprise_license: true`.
- Default value: ""

## `vault_hsm_app`

- Set which cryptography app to use.
- Default value: pkcs11

## `vault_backend_seal`

> NOTE: This seal will be migrated to the `pkcs11` seal and made consistent with the other seal types with respect to breaking naming changes soon.

- Backend seal template filename
- Default value: `vault_backend_seal.j2`

## `vault_seal_lib`

- Set to the absolute path of the HSM library vault will call
- Default value: `/lib64/hsmlibrary.so`

## `vault_seal_pin`

- The PIN for login. May also be specified by the VAULT_HSM_PIN environment variable. If set via the environment variable, Vault will obfuscate the environment variable after reading it, and it will need to be re-set if Vault is restarted.
- Default value: 12345

## `vault_seal_key_label`

- The label of the key to use. If the key does not exist and generation is enabled, this is the label that will be given to the generated key. May also be specified by the VAULT_HSM_KEY_LABEL environment variable.
- Default value: ''

## `vault_seal_hmac_key_label`

- The label of the HMAC key to use. If the key does not exist and generation is enabled, this is the label that will be given to the generated HMAC key. May also be specified by the VAULT_HSM_HMAC_KEY_LABEL environment variable.
- Default value: ''

## `vault_seal_generate_key`

- If no existing key with the label specified by key_label can be found at Vault initialization time, instructs Vault to generate a key. This is a boolean expressed as a string (e.g. "true"). May also be specified by the VAULT_HSM_GENERATE_KEY environment variable. Vault may not be able to successfully generate keys in all circumstances, such as if proprietary vendor extensions are required to create keys of a suitable type.
- Default value: false

## `vault_seal_key_mechanism`

-  Do not change this unles you know you need to. The encryption/decryption mechanism to use, specified as a decimal or hexadecimal (prefixed by 0x) string. May also be specified by the VAULT_HSM_MECHANISM environment variable.
- Default value: ''
- Example for RSA: 0x0009

## `vault_seal_token_label`

- The slot token label to use. May also be specified by the VAULT_HSM_TOKEN_LABEL environment variable. This label will only be applied when `vault_softcard_enable` is true.
- Default value: ''

## `vault_softcard_enable`

- Enable if you plan to use a softcard on your HSM.
- Default value: false

## `vault_seal_slot`

- The slot number to use, specified as a string (e.g. "0"). May also be specified by the VAULT_HSM_SLOT environment variable. This label will only be applied when `vault_softcard_enable` is false (default).
- Default value: 0

## `vault_entropy_seal`

- Set to True to [include `entropy` stanza](https://learn.hashicorp.com/tutorials/vault/hsm-entropy) which enables [entropy augmentation for supported seals](https://www.vaultproject.io/docs/configuration/entropy-augmentation). Supported Seal types include PKCS11, AWS KMS, and Vault Transit.
- Default value: false

The following stanza will be included in the hcl main configuration file if `vault_entropy_seal=true`:
```
entropy "seal" {
  mode = "augmentation"
}
```

# Vault GCP Cloud KMS Auto-unseal

This feature enables operators to delegate the unsealing process to Google Key Management System Cloud to ease operations in the event of partial failure and to aid in the creation of new or ephemeral clusters.

This Auto-unseal mechanism is Open Source in Vault 1.0 but would require Enterprise binaries for any earlier version.

## `vault_gkms`

- Set to True to enable Google Cloud KMS Auto-Unseal.
- Default value: false

## `vault_backend_gkms`

- Backend seal template filename
- Default value: `vault_seal_gcpkms.j2`

## `vault_gkms_project`

- GCP Project where the key reside.
- Default value: ''

## `vault_gkms_copy_sa`

- Copy GCP SA credentials file from Ansible control node to Vault server. When not `true` and no value is specified for `vault_gkms_credentials_src_file`, the default instance service account credentials are used.
- Default value: `"true"`

## `vault_gkms_credentials_src_file`

- User-specified source directory for GCP Credential on Ansible control node.
- Either this or vault_gkms_credentials_content must be set if vault_gkms enabled.
- Default value: ''

## `vault_gkms_credentials_content`

- User-specified GCP Credential file content.
- Either this or vault_gkms_credentials_src_file must be set if vault_gkms enabled.
- Default value: ''

## `vault_gkms_credentials`

- Path to GCP credential on Vault server.
- Default value: `/home/vault/vault-kms.json`

## `vault_gkms_region`

- GCP Region where the key reside.
- Default value: global

## `vault_gkms_key_ring`

- The id of the Google Cloud Platform KeyRing to which the key shall belong.
- Default value: vault

## `vault_gkms_crypto_key`

- The CryptoKey's name. A CryptoKey's name must be unique within a location and match the regular expression [a-zA-Z0-9_-]{1,63}
- Default value: vault_key

# Vault OCI KMS Auto-unseal

This feature enabled operators to delegate the unsealing process to OCI KMS to ease operations in the event of a partial failure and to
aid in the creation of new or ephemeral clusters.

## `vault_ocikms`

- Set to true to enable OCI KMS Auto-unseal.
- Default value: false

## `vault_ocikms_backend`

- Backend seal template filename.
- Default value: `vault_seal_ocikms.j2`

## `vault_ocikms_auth_type_api_key`

- Specifies if using API key to authenticate to OCI KMS service.
- Default value: false

## `vault_ocikms_key_id`

- The OCI KMS key ID to use.
- Default value: VAULT_OCIKMS_SEAL_KEY_ID

## `vault_ocikms_crypto_endpoint`

- The OCI KMS cryptographic endpoint (or data plane endpoint) to be used to make OCI KMS encryption/decryption requests.
- Default value: VAULT_OCIKMS_CRYPTO_ENDPOINT

## `vault_ocikms_management_endpoint`

- The OCI KMS management endpoint (or control plane endpoint) to be used to make OCI KMS key management requests.
- Default value: VAULT_OCIKMS_MANAGEMENT_ENDPOINT

# Vault Transit Auto-unseal
This enables Vault to use another Vault instance for the unseal process using its transit secret engine

## `vault_transit`

- Set to true to enable Vault Transit Auto-unseal
- Default value: `false`

## `vault_transit_backend`

- Backend seal template filename
- Default value: `vault_seal_transit.j2`

## `vault_transit_config`:

- Destination configuration file
- Default value: `vault_transit.hcl`

## `vault_transit_address`:

- Vault Address of the instance used for auto unseal
- Default value: ``, this variable is mandatory if `vault_transit: true`

## `vault_transit_token`:

- Token used to authenticate to the external vault instance
- Default value: ``, this variable is mandatory if `vault_transit: true`

## `vault_transit_disable_renewal`:

- Wether to disable automatic token renewal
- Default value: `false`

## `vault_transit_key_name`

- Name of the key used for auto unseal
- Default value: `autounseal`

## `vault_transit_mount_path`:

- Path where the transit engine is mounted to
- Default value: `transit/`

## `vault_transit_namespace`:

- Namespace of the mounted transit engine
- Default value: ``, omitted per default

## `vault_transit_tls_ca_cert`:

- CA Certificate of the external vault instance
- Default value: `ca_cert.pem`,  omitted if `vault_transit_tls_skip_verify: true`

## `vault_transit_tls_client_cert`:

- Client Certificate of the external vault instance
- Default value: `client_cert.pem`,  omitted if `vault_transit_tls_skip_verify: true`

## `vault_transit_tls_client_key`:

- Client Key of the external vault instance
- Default value: `ca_cert.pem`,  omitted if `vault_transit_tls_skip_verify: true`

## `vault_transit_tls_server_name`

- TLS Servername of the external vault instance
- Default value: ``, omitted per default

## `vault_transit_tls_skip_verify`:

- Wether to disable TLS certificate verification
- Default: `false`, can also be set via `VAULT_SKIP_VERIFY`

# Vault AWS KMS Auto-unseal

This feature enabled operators to delegate the unsealing process to AWS KMS to ease operations in the event of a partial failure and to
aid in the creation of new or ephemeral clusters.

## `vault_awskms`

- Set to true to enable AWS KMS Auto-unseal
- Default value: false

## `vault_awskms_backend`

- Backend seal template filename
- Default value: `vault_seal_awskms.j2`

## `vault_awskms_region`

- Which AWS KMS region to use
- Default value: us-east-1

## `vault_awskms_access_key`

- The AWS Access Key to use for talking to AWS KMS
- Default value: AWS_ACCESS_KEY_ID

## `vault_awskms_secret_key`

- The AWS Secret Key ID to use for takling to AWS KMS
- Default value: AWS_SECRET_ACCESS_KEY

## `vault_awskms_key_id`

- The KMS Key ID to use for AWS KMS
- Default value: VAULT_AWSKMS_SEAL_KEY_ID

## `vault_awskms_endpoint`

- The endpoint to use for KMS
- Default value: AWS_KMS_ENDPOINT

# Vault Azure Key Vault Auto-unseal

This feature enabled operators to delegate the unsealing process to AZURE Key Vaultto ease operations in the event of a partial failure and to aid in the creation of new or ephemeral clusters.

## `vault_azurekeyvault`

- Set to true to enable AZURE Key Vault Auto-unseal
- Default value: false

## `vault_backend_azurekeyvault`

- Backend seal template filename
- Default value: `vault_seal_azurekeyvault.j2`

## `vault_azurekeyvault_client_id`

- Application ID related to Service Principal Name for the Application used to connect to Azure
- Default value: EXAMPLE_CLIENT_ID

## `vault_azurekeyvault_client_secret`

- Client Secret is the secret key attached to your Application
- Default value: EXAMPLE_CLIENT_SECRET

## `vault_azurekeyvault_tenant_id`

- Tenant ID is your Directory ID in Azure
- Default value: EXAMPLE_TENANT_ID

## `vault_azurekeyvault_vault_name`

- The name of the Vault which hosts the key
- Default value: vault

## `vault_azurekeyvault_key_name`

- The key hosted in the Vault in Azure Key Vault
- Default value: vault_key

# Vault plugins

## acme plugin

Installs vault-acme plugin, also enables the plugin if authenticated against vault (`VAULT_ADDR`, `VAULT_TOKEN` env).

## `vault_plugin_acme_install`
- Setting this to `remote` will download the acme plugin to each target instead of copying it from localhost.
- Choices: remote / local
- Default value: `remote`

## `vault_plugin_acme_sidecar_install`
- Whether to install vault acme sidecar for `HTTP-01`/`TLS_ALPN_01` challenges in addition to DNS-01.
- Default value: `false`

## `vault_plugin_acme_version`
- Version of the acme plugin to install, can be set to `latest` for obtaining the latest available version.
- Default value: `latest`
