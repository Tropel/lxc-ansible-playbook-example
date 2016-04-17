lxc-ansible-playbook-example
============================

Ansible playbooks example to create LXC containers with fixed IP addresses using dnsmasq.

## Usage

First, set up LXC using [hnakamur/setup_lxc_on_vagrant: Vagrantfile to set up LXC 2.x on Ubuntu 14.04 or 16.04](https://github.com/hnakamur/setup_lxc_on_vagrant).

Then, run the following on the virtual machine.

```
sudo apt-get install -y git
git clone https://github.com/hnakamur/lxc-ansible-playbook-example
cd lxc-ansible-playbook-example
(cd lxchost && sudo ansible-playbook local_dev.yml)
```

It may take a very long time to download the CentOS 7 container image file, so please be patient.
(It took about twenty minutes in my environment).

When the playbook finishes successfully, the following four containers are created.

```
vagrant@vagrant-ubuntu-trusty-64:~/lxc-ansible-playbook-example$ sudo lxc-ls -f
NAME  STATE   AUTOSTART GROUPS IPV4       IPV6
db01  RUNNING 0         -      10.0.3.111 -
db02  RUNNING 0         -      10.0.3.112 -
web01 RUNNING 0         -      10.0.3.101 -
web02 RUNNING 0         -      10.0.3.102 -
```

Run an example playbook on the `web` and `db` host groups.

```
vagrant@vagrant-ubuntu-trusty-64:~/lxc-ansible-playbook-example$ (cd web && sudo ansible-playbook local_dev.yml)

PLAY ***************************************************************************

TASK [setup] *******************************************************************
ok: [web02]
ok: [web01]

TASK [../common/roles/show_ip : Show IP address] *******************************
ok: [web01] => {
    "msg": "ipv4_address=10.0.3.101"
}
ok: [web02] => {
    "msg": "ipv4_address=10.0.3.102"
}

PLAY RECAP *********************************************************************
web01                      : ok=2    changed=0    unreachable=0    failed=0
web02                      : ok=2    changed=0    unreachable=0    failed=0

vagrant@vagrant-ubuntu-trusty-64:~/lxc-ansible-playbook-example$ (cd db && sudo ansible-playbook local_dev.yml)

PLAY ***************************************************************************

TASK [setup] *******************************************************************
ok: [db01]
ok: [db02]

TASK [../common/roles/show_ip : Show IP address] *******************************
ok: [db01] => {
    "msg": "ipv4_address=10.0.3.111"
}
ok: [db02] => {
    "msg": "ipv4_address=10.0.3.112"
}

PLAY RECAP *********************************************************************
db01                       : ok=2    changed=0    unreachable=0    failed=0
db02                       : ok=2    changed=0    unreachable=0    failed=0
```

## License
MIT
