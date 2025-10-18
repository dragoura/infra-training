provision:
	cd terraform && terraform apply -auto-approve

configure:
	cd ansible && ansible-playbook diagnostics.yaml

all: provision configure

