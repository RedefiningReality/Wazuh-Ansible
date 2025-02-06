# Ansible for Wazuh
Ansible roles and playbook to install Wazuh agents on Linux and Windows machines. Used to install Wazuh agents on VMs in Illinois Tech's cyber range.

## [Inventory](inventory)
Update files in this directory to suit your needs. It currently has inventory files for [Game of Active Directory](https://orange-cyberdefense.github.io/GOAD/) and a custom "services" network.
- [goad](inventory/goad) ⇒ Game of Active Directory on 192.168.10.0/24
- [services](inventory/services) ⇒ custom services network on 192.168.30.0/24
- [test](inventory/test) ⇒ a sample of hosts from goad and services for testing

## [Roles](roles)
The bread and butter of this repo: roles for installing Wazuh agents on Linux and Windows. Feel free to use these in your own playbook.
- [wazuh_linux](roles/wazuh_linux) ⇒ installs Wazuh agent on Linux
- [wazuh_windows](roles/wazuh_windows) ⇒ installs Wazuh agent on Windows
### Variables
- **wazuh_manager** ⇒ Wazuh manager server to connect to
- **agent_name** ⇒ name for host in Wazuh (specify for each host in inventory)
- **agent_group**  ⇒ group to add each host to (specify under group vars in inventory or in playbook)

## [Playbook (install.yml)](install.yml)
Calls the roles to run them.

## Runners
- [ping.sh](ping.sh) ⇒ ensure hosts are reachable
- [test.sh](test.sh) ⇒ runs install.yml playbook for hosts in test inventory
- [build.sh](build.sh) ⇒ runs install.yml playbook for all hosts (in goad and services inventories)
