#!/bin/bash
ansible goad -i inventory/goad -m win_ping
ansible services -i inventory/services -m ping
