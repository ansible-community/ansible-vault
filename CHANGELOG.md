## NEXT

- Add support for proxy configuration

## v2.5.3
- Add Prometheus telemetry support (thanks @bbayszczak)
- Add tag check_vault to to Vault status debug task (thanks @NorthFuture)
- Fixed indentation of vault config file (thanks @rasta-rocket)
- Add RHEL 8 support (thanks @kwevers)

## v2.5.2

- Vault v1.3.2
- Update documentation

## v2.5.1

- Vault v1.3.1
- Add MySQL storage (thanks @ericsysmin)
- Update status task (thanks @ericsysmin)
- Add group creation task (thanks @karras)
- Update documentation (thanks @ilpianista)
- Update documentation

## v2.5.0

- Vault v1.3.1
- Update documentation

## v2.4.0

- Vault v1.2.4
- Restart after binary change (thanks @bbaassssiiee)
- Use command for vault version in main tasks (thanks @bbaassssiiee)
- Update API status check (thanks @bbaassssiiee)
- Support Fedora (thanks @rbjorklin)
- Update CONTRIBUTORS
- Update documentation

## v2.3.4

- Vault v1.2.3
- Fix s3 backend configuration and template (thanks @ebostijancic)
- Update documentation

## v2.3.3

- Vault v1.2.2
- Update documentation

## v2.3.2

- Fix Vault installation check (thanks @jpiron)
- Update documentation

## v2.3.0

- Vault v1.2.0
- Update documentation

## v2.2.3

- Vault v1.1.5
- Add DynamoDB storage backend (thanks @chris-dudley)
- Update CONTRIBUTORS
- Update documentation

## v2.2.2

- Vault v1.1.4
- Add support for backend tls configuration (thanks @rhenwood3995)
- Fix template line break (thanks @fhemberger)
- ansible_default_ipv4 interface used as default (thanks @fhemberger)
- Update vault_home (thanks @zeridon)
- Add s3 storage backend template (thanks @dvmonroe)
- Update documentation (thanks @dvmonroe)
- Update CONTRIBUTORS

## v2.2.1

- Resolve some task argument issues
- Clean up line length a bit
- Use Filesystem Storage Backend in Vagrant example playbook
- Update Vagrantfile
- Update documentation

## v2.2.0

- Clean up task items
- Fixup Get installed Vault version for multiline/quotes
- Update vault_home value (thanks @xeivieni)
- Add plugin_dir configuration (thanks @vmwiz)
- Fix: Force `/bin/bash` on Get Vault package checksum (local) (thanks @fleu42)

## v2.1.9

- Vault version 1.1.2
- Feature: add etcd storage (thanks @cordula-grau)
- Fix: Resolve deprecation warnings (thanks @cordula-grau)
- Fix: Move become flag to required resources (thanks @cordula-grau)
- Reposition some main variables
- Remove `vault_tls_cipher_suites` values/fall back to Vault defaults
- Remove unimplemented `vault_syslog_enable`
- Rename `vault_listener_template` to `vault_main_configuration_template`
  - Rename corresponding template file to `vault_main_configuration.hcl.j2`
- Update documentation

## v2.1.8

- Vault version 1.1.1
- Allow sealed state for standalone instance (thanks @kwevers)
- Revert long line syntax change in main tasks (thanks @kwevers)
- Ensure systemd is reloaded on unit changes (thanks @kwevers)
- Add vault_bin_path to the PATH (thanks @kwevers)
- Update documentation

## v2.1.7

- Minimum Ansible version to 2.7
- Support install on Debian Testing (thanks @gfeun)
- Update for E206 [lint]
  - tasks/tls
- Update for E201 [lint]
  - tasks/main
- Update for E504 [lint]
  - tasks/install
  - tasks/install_enterprise
- Use bool filter in template conditionals
- Consistent seal template filenames
  - awskms seal (now named vault_seal_awskms.j2)
  - azurekeyvault seal (now named `vault_seal_azurekeyvault.j2`)
  - gcpkms seal template (now named `vault_seal_gcpkms.j2`)
  - pkcs11 seal template (now named `vault_seal_pkcs11.j2`)
- Consistent service template names
  - BSD style init script (now named `vault_service_bsd_init.j2`)
  - Debian style init script (now named `vault_service_debian_init.j2`)
  - systemd unit (now named `vault_service_systemd.j2`)

## v2.1.6

- Resolve environment additions/create .bashrc (thanks @gfeun)
- Update documentation
- Update license
- Update variables

## v2.1.5

- Vault v1.1.0
- Add additional health responses to API reachability check (thanks @enqack)
- VAULT_ADDR and VAULT_CACERT export in ~/.bashrc (thanks @planetrobbie)
- Update documentation

## v2.1.4

- Replace Azure Key Vault variables to resolve #85
- Tidy and reorganize main variables

## v2.1.3

- Vault v1.0.3
- Skip certificate copy if desired (thanks @Fuochi-YNAP)
- Skip health check if desired (thanks @Fuochi-YNAP)
- Add Azure Key Auto Unseal configuration (thanks @nehrman)

## v2.1.2

- Vault v1.0.2
- Update documentation

## v2.1.1

- Vault v1.0.1
- AWS KMS seal support (thanks @jeffWelling)
- Enable web UI by default
- Update documentation

## v2.1.0

- Vault v1.0.0
- GCPKMS seal support (thanks @planetrobbie)
- Update documentation

## v2.0.9

- Correct systemd unit (thanks @jpiron)
- Add initial telemetry support (thanks @jeffWelling)
- Vagrant box memory increased to 2048MB
- Update documentation

## v2.0.8

- Vault v0.11.5
- Conditional capabilites based on systemd version (thanks @bdossantos)
- Update documentation

## v2.0.7

- Vault v0.11.3
- Templates in main tasks as variables (thanks @nathkn)
- systemd unit updates (thanks @bdossantos)
- Update documentation

## v2.0.5

- Vault v0.11.2
- Update systemd unit
- Update Consul storage backend template (thanks @jpiron)
- Configuration updates (thanks @jpiron)
- Add client cert validation options to listener configuration (thanks @nathkn)

## v2.0.4

- Vault v0.11.1
- Update tasks/normalize conditionals
- Update TLS variable names to match documentation
- Conditional mlock capability (thanks @jpiron)
- Streamline installation tasks (thanks @jpiron)
- Update documentation

## v2.0.3

- Vault version 0.10.4
- Debian 9 support
- Update support for enterprise versions (thanks @drewmullen)
- Log rotation updates (thanks @drewmullen)
- Update systemd unit file
- Update documentation

## v2.0.2

- Option to disable cert validation during API reachability (thanks @eripa)
- Update systemd unit to address #41

## v2.0.1

- Vault v0.10.1
- Simplify cleanup task in remote install
- enable_ui option (thanks @aarnaud)
- Enhance API reachable check (thanks @aarnaud)
- Add support for HTTPS in Consul backend (thanks @eripa)
- Add support for HTTP 429 when vault_cluster_disable false (thanks @eripa)
- Update CONTRIBUTORS
- Update documentation

## v2.0.0

- Vault version 0.10.0
- Update documentation
- Update Vagrant documentation

## v1.8.0

- Vault version 0.9.6
- Update is Vault API reachable task (thanks @rarguelloF)
- File storage backend (thanks @aarnaud)
- Update example versions
- Update license date
- Update CONTRIBUTORS
- Update documentation

## v1.7.9

- Vault version 0.9.5
- Remove abs check on cluster_address in Consul backend to fix #33
- Update documentation

## v1.7.8

- Vault version 0.9.4
- TLS already on remote source option (thanks @calebtonn)
- Update documentation

## v1.7.7

- Vault version 0.9.3
- Update documentation

## v1.7.6

- Vault version 0.9.2
- Update documentation

## v1.7.5

- Vault version 0.9.1
- Update documentation

## v1.7.4

- Vault version 0.9.0
- Use HTTPS when TLS is enabled (thanks @tbartelmess)
- Add Consul ACL token option to configuration (thanks @Lavoaster)
- Update CONTRIBUTORS.md

## v1.7.3

- Vault v0.8.3
- Updated supporting software versions
- Add vault_max_lease_ttl and vault_default_lease_ttl (thanks @bilke)

## v1.7.2

- Vault v0.8.2
- Update README (thanks @Gerrrr)
- Update init scripts (thanks @Gerrrr)
- Add vault_consul_service in consul storage template (thanks @Gerrrr)
- Update CONTRIBUTORS.md (thanks @groggemans)

## v1.7.1

- Vault v0.8.1

## v1.7.0

- Vault v0.8.0
- Fix Missing Defaults for TLS (thanks @marc-sensenich)
- Add missing redirect_addr in HA consul config (thanks @groggemans)
- Update CONTRIBUTORS

## v1.6.8

- Enterprise task changes
- Add `vault_install_remotely` docs
- Add `vault_remote_tmp` variable and use it
- Rename `cluster_nodes` label to `vault_instances`

## v1.6.7

- Vault version 0.7.3
- Update documentation

## v1.6.6

- Explicit Vault address (0.0.0.0 is not good for HA mode)
- Update listener template (thanks @groggemans)
- Add vault_consul_path in consul storage template (thanks @groggemans)
- Fix BSD init task and remove unused grouping (thanks @groggemans)
- Update defaults order (thanks @groggemans)
- Make vault user management configurable (thanks @groggemans)
- Add UI switch (enterprise) and fix tls_disable (thanks @groggemans)
- Remove no longer used 'primary_node' variable (thanks @groggemans)
- Add missing README entries (thanks @groggemans)

## v1.6.5

- Correct main tasks

## v1.6.4

- Enable Vault Enterprise tasks
- Remove `redirect_addr` in favor of request forwarding
- Make `vault_log_level` environment variable override
- Update documentation

## v1.6.3

- Correct Vault Enterprise variables to address #18

## v1.6.2

- Vault version 0.7.2
- Minor play updates
- Move asserts to asserts.yml file (thanks @groggemans)

## v1.6.1

- Vault version 0.7.1
- Further task cleanup

## v1.6.0

- Add initial Vault Enterprise variables
- Add initial Vault Enterprise installation tasks
- Update when statements to avoid warnings about template delimiters
- Update documentation

## v1.5.7

- Add TLS directory task to TLS tasks (thanks @cwill747)
- Update CONTRIBUTORS
- Update CONTRIBUTING
- Update documentation

## v1.5.6

- Update remote tasks

## v1.5.5

- Back to local_action for the download and unzip tasks
- Already using grep, so let's just awk for the SHA and then register it
- Add remote install capability (thanks @bilke)

## v1.5.4

- Update documentation on new netaddr dependency _sweat_

## v1.5.3

- Revert local_action tasks
  - They are broken in every case I tested, and connection local is perfectly
    valid for running things on the local host :|

## v1.5.2

- Switch to local actions (addresses #13)

## v1.5.1

- Fixed vault_tls_cert_file and vault_tls_key_file vars

## v1.5.0

- Add initial multi-architecture and OS support
- Add FreeBSD support
- Update documentation

## v1.4.2

- All quoting issues sorted

## v1.4.1

- Fix finicky var quoting issue

## v1.4.0

- Updated many variables with environment variable overrides
- Add `vault_tls_config_path` variable with reasonable default value
- Set currently/reasonably secure `vault_tls_cipher_suites` defaults
- Update listener template to finally close #3
- Improve cleanup task
- Update versions
- Update documentation
- Update ignores

## v1.3.12

- Made VAULT_IFACE environment variable override

## v1.3.11

- Update init scripts

## v1.3.10

- Fix other modes / types ノ( ゜-゜ノ)

## v1.3.9

- Fix quote removal/type finagling YAML sadness (thanks @arledesma)

## v1.3.8

- Move TLS bits to separate task
- Short circuit TLS bits as bad things™ were happening due to the empty
  cert and key values during the Vault SSL Certificate and Key copy ops
  (probably an Ansible bug, copying entire contents of files to vault etc dir)
  No bueno

## v1.3.7

- Replace lost double quote (thanks @arledesma)
- Add explicit vault user permissions to config (thanks @arledesma)
- Remove duplicate cluster_address var
- Update README / consistent variable style / more links to docs

## v1.3.6

- Handle cluster_addre differently
- Cleanup tasks
- Consistent variable style
- Cleanup meta

## v1.3.5

- Remove explicit cluster_addr and let Vault default the value for now

## v1.3.4

- Use vault_port+1 in cluster_addr for HA vault (thanks @arledesma)
- Update CHANGELOG
- Update Vagrant README

## v1.3.3

- Update systemd unit file

## v1.3.2

- Make vault user a system account

## v1.3.1

- Vault 0.7.0
- Initial TLS bits (thanks @arledesma)
- Fix logging options (thanks @arledesma)
- Update documentation

## v1.3.1

- Add support for version specification via VAULT_VERSION environment variable
- Renamed backend configuration template
- Renamed main template to be inline with configuration section naming
- Fix broken unit file

## v1.2.10

- Use all defined variables (thanks @arledesma)
- Make redirect_address more specific by adding redirect address variable
- Update CONTRIBUTORS
- Fix merge conflict (thanks @arledesma)
- Fix missed variable (thanks @arledesma)

## v1.2.9

- Fix backend template inclusion
- Correct backend filename

## v1.2.8

- Fix issue in wait_for (thanks @pierrefh)
- Add contributing guidelines in CONTRIBUTING.md
- Fix checksum var

## v1.2.7

- Update main tasks
- Update install tasks
- Prefer compact YAML format across all tasks files

## v1.2.6

- Check for local packages and summary files

## v1.2.5

- Updated configuration templates
- Updated documentation

## v1.2.4

- Vaule 0.6.5

## v1.2.3

- Vault 0.6.4

## v1.2.2

- Fix variable name

## v1.2.1

- Include installation tasks

## v1.2.0

- Vault 0.6.3
- Dynamic SHA
- Streamline tasks
- Streamline and consolidate variables
- Move OS variables to vars
- Separate install tasks
- Remove OS specific tasks
- Update documentation

## v1.0.21

- Update/validate CentOS 7 box
- Update documentation
- Update failure cases for CentOS
- Fix SysV init script

## v1.0.20

- Fix binary name


## v1.0.9

- Add files dir

## v1.0.8

- Add files dir

## v1.0.7

- Fix var names

## v1.0.6

- Add fail on old distro versions
- Remove all distro specific includes

## v1.0.5

- Remove unnecessary include

## v1.0.4

- Correct URL in docs
- Remove vars dir
- Enable download once / copy many install

## v1.1.2

- Move all vars to defaults
- Documentation updates

## v1.0.2

- Set correct RAM amount in Vagrantfile
- Rename Vagrant inventory back to cluster_nodes

## v1.0.2

- Update documentation

## v1.0.0

- Installs Vault
- Installs Vault with Consul backend onto Consul VMs from brianshumate.consul
