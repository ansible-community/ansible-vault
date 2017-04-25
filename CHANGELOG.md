## v1.0.0

- Installs Vault
- Installs Vault with Consul backend onto Consul VMs from brianshumate.consul

## v1.0.1

- Update documentation

## v1.0.2

- Set correct RAM amount in Vagrantfile
- Rename Vagrant inventory back to cluster_nodes

## v1.0.3

- Move all vars to defaults
- Documentation updates

## v1.0.4

- Correct URL in docs
- Remove vars dir
- Enable download once / copy many install

## v1.0.5

- Remove unnecessary include

## v1.0.6

- Add fail on old distro versions
- Remove all distro specific includes

## v1.0.7

- Fix var names

## v1.0.8

- Add files dir

## v1.0.9

- Add files dir

## v1.0.10

- Fix binary name

## v1.0.11

- Update/validate CentOS 7 box
- Update documentation
- Update failure cases for CentOS
- Fix SysV init script

## v1.2.0

- Vault 0.6.3
- Dynamic SHA
- Streamline tasks
- Streamline and consolidate variables
- Move OS variables to vars
- Separate install tasks
- Remove OS specific tasks
- Update documentation

## v1.2.1

- Include installation tasks

## v1.2.2

- Fix variable name

## v1.2.3

- Vault 0.6.4

## v1.2.4

- Vaule 0.6.5

## v1.2.5

- Updated configuration templates
- Updated documentation

## v1.2.6

- Check for local packages and summary files

## v1.2.7

- Update main tasks
- Update install tasks
- Prefer compact YAML format across all tasks files

## v1.2.8

- Fix issue in wait_for (thanks @pierrefh)
- Add contributing guidelines in CONTRIBUTING.md
- Fix checksum var

## v1.2.9

- Fix backend template inclusion
- Correct backend filename


## v1.2.10

- Use all defined variables (thanks @arledesma)
- Make redirect_address more specific by adding redirect address variable
- Update CONTRIBUTORS
- Fix merge conflict (thanks @arledesma)
- Fix missed variable (thanks @arledesma)

## v1.3.0

- Add support for version specification via VAULT_VERSION environment variable
- Renamed backend configuration template
- Renamed main template to be inline with configuration section naming
- Fix broken unit file

## v1.3.1

- Vault 0.7.0
- Initial TLS bits (thanks @arledesma)
- Fix logging options (thanks @arledesma)
- Update documentation

## v1.3.2

- Make vault user a system account

## v1.3.3

- Update systemd unit file

## v1.3.4

- Use vault_port+1 in cluster_addr for HA vault (thanks @arledesma)
- Update CHANGELOG
- Update Vagrant README

## v1.3.5

- Remove explicit cluster_addr and let Vault default the value for now

## v1.3.6

- Handle cluster_addre differently
- Cleanup tasks
- Consistent variable style
- Cleanup meta

## v1.3.7

- Replace lost double quote (thanks @arledesma)
- Add explicit vault user permissions to config (thanks @arledesma)
- Remove duplicate cluster_address var
- Update README / consistent variable style / more links to docs

## v1.3.8

- Move TLS bits to separate task
- Short circuit TLS bits as bad things™ were happening due to the empty
  cert and key values during the Vault SSL Certificate and Key copy ops
  (probably an Ansible bug, copying entire contents of files to vault etc dir)
  No bueno

## v1.3.9

- Fix quote removal/type finagling YAML sadness (thanks @arledesma)

## v1.3.10

- Fix other modes / types ノ( ゜-゜ノ)

## v1.3.11

- Update init scripts

## v1.3.12

- Made VAULT_IFACE environment variable override

## v1.4.0

- Updated many variables with environment variable overrides
- Add `vault_tls_config_path` variable with reasonable default value
- Set currently/reasonably secure `vault_tls_cipher_suites` defaults
- Update listener template to finally close #3
- Improve cleanup task
- Update versions
- Update documentation
- Update ignores

## v1.4.1

- Fix finicky var quoting issue

## v1.4.2

- All quoting issues sorted

## v1.5.0

- Add initial multi-architecture and OS support
- Add FreeBSD support
- Update documentation

## v1.5.1

- Fixed vault_tls_cert_file and vault_tls_key_file vars

## v1.5.2

- Switch to local actions (addresses #13)

## v1.5.3

- Revert local_action tasks
  - They are broken in every case I tested, and connection local is perfectly
    valid for running things on the local host -_-

## v1.5.4

- Update documentation on new netaddr dependency :sweat:

## v1.5.5

- Back to local_action for the download and unzip tasks
- Already using grep, so let's just awk for the SHA and then register it
- Add remote install capability (thanks @bilke)
