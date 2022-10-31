#!/bin/bash
export ANSIBLE_CONFIG=ansible.cfg
ansible-playbook main.yml --extra-vars '{"create_local_kubernetes_config":true}'