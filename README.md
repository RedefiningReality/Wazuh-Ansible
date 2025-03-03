# Ansible for Wazuh
Ansible roles and playbook to install Wazuh agents on Linux and Windows machines. Used to install Wazuh agents on VMs in Illinois Tech's cyber range.

**NOT FOR PRODUCTION USE**  
I did not necessarily follow Ansible best practices nor account for all edge cases, so it's worth giving the tasks a manual review before running this in your environment. For example:
- the wazuh_linx role assumes your Linux distro uses apt for package management
- the sysmon_windows role assumes you're using 64-bit versions of Windows
- (bug) the auditd_logging role modifies the ossec.conf file every time it is run

⚠️ Be sure to update the .msi URL in [the defaults file for the wazuh_windows role](roles/wazuh_windows/defaults/main.yml) ⚠️  
You can find an up-to-date URL on [this page](https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-windows.html) of the Wazuh documentation.

## [Inventory](inventory)
Update files in this directory to suit your needs. It currently has inventory files for [Game of Active Directory](https://orange-cyberdefense.github.io/GOAD/) and a custom "services" network.
- [goad](inventory/goad) ⇒ Game of Active Directory on 192.168.10.0/24
- [services](inventory/services) ⇒ custom services network on 192.168.30.0/24
- [test](inventory/test) ⇒ a sample of hosts from goad and services for testing

## [Roles](roles)
The bread and butter of this repo: roles for installing Wazuh agents on Linux and Windows. Feel free to use these in your own playbook.
- [wazuh_linux](roles/wazuh_linux) ⇒ installs Wazuh agent on Linux
- [wazuh_windows](roles/wazuh_windows) ⇒ installs Wazuh agent on Windows
- [sysmon_windows](roles/sysmon_windows) ⇒ installs Sysmon on Windows and configures Sysmon logging for Wazuh
  - Uses the [SwiftOnSecurity Sysmon config](https://github.com/SwiftOnSecurity/sysmon-config) by default but you can change this in [the defaults file](roles/sysmon_windows/defaults/main.yml)
- [defender_logging](roles/defender_logging) ⇒ forwards Windows Defender logs to Wazuh
- [aurora_edr](roles/aurora_edr) ⇒ installs [Aurora Lite](https://aurora-agent-manual.nextron-systems.com/en/latest/usage/what-is-aurora.html) (free EDR) and forwards logs to Wazuh
  - Be sure to replace [aurora-license.lic](roles/aurora_edr/files/aurora-license.lic) in roles->aurora_edr->files with your license! You can get a free license [here](https://www.nextron-systems.com/aurora/#get-aurora-lite).
- [powershell_logging](roles/powershell_logging) ⇒ enables PowerShell logging on Windows and forwards logs to Wazuh
- [auditd_logging](roles/auditd_logging) ⇒ logs all commands and shell execution and forwards logs to Wazuh
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
