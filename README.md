## Infra Training: Terraform + Ansible

Training project to create Digital Ocean Droplets with Terraform and configure them with Ansible. Terraform provisions the droplets; Ansible connects over SSH to configure access, security, and monitoring.

### What this project does
- Create cloud VMs via Terraform
- Generate an Ansible inventory for those hosts
- Configure servers with Ansible:
  - Create a non-root admin user and SSH keys
  - Harden SSH (disable root login, key-only auth)
  - Configure UFW (allow SSH, Node Exporter)
  - Install and run Node Exporter
  - Configure Prometheus scraping for new droplets

### Prerequisites
- Terraform v1.3+ and Ansible v2.14+
- Cloud provider account and API token
- SSH key uploaded to the provider; you know its fingerprint

### Project structure
- Terraform in `terraform/` (creates droplets, writes `ansible/inventory.ini`)
- Ansible in `ansible/` (playbooks and roles to configure hosts)

### Quickstart
- Terraform
```bash
cd terraform
# set your values in terraform/terraform.tfvars:
# do_token, ssh_fingerprint, ssh_private_key_path
terraform init
terraform apply
```

- Verify inventory and connectivity
```bash
ansible -i ansible/inventory.ini all -m ping
```

- Configure hosts with Ansible
```bash
# Main entrypoint (applies roles like user bootstrap, SSH hardening, UFW, Node Exporter)
ansible-playbook -i ansible/inventory.ini ansible/main.yaml
```

- Destroy when done
```bash
cd terraform && terraform destroy
```



