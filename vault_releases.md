# Vault Releases

From the [official release channels](https://www.hashicorp.com/official-release-channels),
this role supports [Linux Repositories](https://www.hashicorp.com/official-packaging-guide)
and the [Release Site](https://releases.hashicorp.com).

The enterprise edition comes with optional support for
[HSM](https://developer.hashicorp.com/vault/docs/enterprise/hsm)
and/or [FIPS](https://developer.hashicorp.com/vault/docs/enterprise/fips).

## Release Site

The file format of the release site is as follows:
```
https://releases.hashicorp.com/vault/1.18.2/vault_1.18.2_linux_amd64.zip
https://releases.hashicorp.com/vault/1.18.2+ent/vault_1.18.2+ent_linux_amd64.zip
https://releases.hashicorp.com/vault/1.18.2+ent.hsm/vault_1.18.2+ent.hsm_linux_amd64.zip
https://releases.hashicorp.com/vault/1.18.1+ent.hsm.fips1402/vault_1.18.1+ent.hsm.fips1402_linux_amd64.zip
```

The checksum files follow the same naming scheme:
```
https://releases.hashicorp.com/vault/1.18.2+ent.hsm.fips1402/vault_1.18.2+ent.hsm.fips1402_SHA256SUMS
https://releases.hashicorp.com/vault/1.18.2+ent.hsm.fips1402/vault_1.18.2+ent.hsm.fips1402_SHA256SUMS.sig
https://releases.hashicorp.com/vault/1.18.2+ent.hsm.fips1402/vault_1.18.2+ent.hsm.fips1402_SHA256SUMS.72D7468F.sig
```

We see that the directory and filename of the enterprise edition
contains `+ent`, and HSM and FIPS are separated with `.hsm` and
`.fips1402`, respectively.

## Linux Repositories

### Debian

```
$ apt-cache show $(apt-cache search vault | awk '{print $1}') | grep -E 'Package|Maintainer' | grep HashiCorp -B1 | grep Package | sort -u
Package: consul-template
Package: envconsul
Package: vault
Package: vault-benchmark
Package: vault-enterprise
Package: vault-enterprise-fips1402
Package: vault-enterprise-hsm
Package: vault-enterprise-hsm-fips1402
Package: vault-radar
Package: vault-secrets-gateway
```

```
$ apt-cache madison vault-enterprise
vault-enterprise | 1.18.2+ent-1 | https://apt.releases.hashicorp.com bookworm/main amd64 Packages
vault-enterprise | 1.18.1+ent-1 | https://apt.releases.hashicorp.com bookworm/main amd64 Packages
vault-enterprise | 1.18.0+ent-1 | https://apt.releases.hashicorp.com bookworm/main amd64 Packages
vault-enterprise | 1.17.9+ent-1 | https://apt.releases.hashicorp.com bookworm/main amd64 Packages
...
```

To install a specific version of a package, the version is added to the package name with a `=`, e.g.:
```
$ apt-get install vault-enterprise=1.18.2+ent-1
```
The trailing `-1` is mandatory.

### RPM

The format of the package name and version for RPM is:
```
$ dnf list available | grep hashicorp | grep vault
vault.x86_64                                                                             1.18.2-1                                                          hashicorp
vault-benchmark.x86_64                                                                   0.3.0-1                                                           hashicorp
vault-enterprise.i386                                                                    1.9.4+ent-1                                                       hashicorp
vault-enterprise.armv7hl                                                                 1.11.2+ent-1                                                      hashicorp
vault-enterprise.x86_64                                                                  1.18.2+ent-1                                                      hashicorp
vault-enterprise-fips1402.x86_64                                                         1.18.2+ent-1                                                      hashicorp
vault-enterprise-hsm.x86_64                                                              1.18.2+ent-1                                                      hashicorp
vault-enterprise-hsm-fips1402.x86_64                                                     1.18.2+ent-1                                                      hashicorp
vault-radar.x86_64                                                                       0.19.0-1                                                          hashicorp
vault-secrets-gateway.x86_64                                                             0.1.5-1                                                           hashicorp
```

To install a specific version of a package, the version is added to the package name with a `-`, e.g.:
```
$ dnf install vault-enterprise-1.18.2+ent
```
Notice that, different to the Debian package, the trailing `-1` is not required.
