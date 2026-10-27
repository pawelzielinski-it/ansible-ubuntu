#!/bin/bash

/root/fingerprint.sh
ansible-playbook /etc/ansible/playbooks/create_users.yml
ansible-playbook /etc/ansible/playbooks/postgres.yml
ansible-playbook /etc/ansible/playbooks/apache.yml
