#!/bin/sh

# PROVIDE: vault
# REQUIRE: LOGIN
# KEYWORD: shutdown

# shellcheck disable=SC1091
. /etc/rc.subr

name="vault"
# shellcheck disable=2034
rcvar=$(set_rcvar)


load_rc_config $name
# shellcheck disable=2154
: "${vault_enable="NO"}"
# shellcheck disable=2154
: "${vault_users="vault"}"

# shellcheck disable=2034
restart_cmd=vault_restart
# shellcheck disable=2034
start_cmd=vault_start
# shellcheck disable=2034
stop_cmd=vault_stop

vault_start() {
    echo "Starting ${name}."
    for user in ${vault_users}; do
        mkdir /var/run/vault
        chown -R "{{ vault_user }}:{{ vault_group }}" /var/run/vault/
        su -m "${user}" -c "{{ vault_bin_path }}/vault server -config={{ vault_main_config }} {% if vault_log_level is defined %}-log-level={{ vault_log_level | lower }}{% endif %}&"
    done
}

vault_stop() {
    echo "Stopping $name."
    pids=$(pgrep vault)
    pkill vault
    wait_for_pids "${pids}"
}

vault_restart() {
    vault_stop
    vault_start
}

run_rc_command "$1"