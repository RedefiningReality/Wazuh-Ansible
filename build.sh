#!/bin/bash
ansible-playbook -i inventory/goad -i inventory/services install.yml
