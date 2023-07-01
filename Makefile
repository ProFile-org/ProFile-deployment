output: setup ping deploy

setup:
	terraform -chdir=terraform output -raw ssh_private_keys > .local/ansible.pem
	echo -e "[all]\n`terraform -chdir=terraform output -raw public_ip`" > .local/inventory
	ssh-keyscan -t rsa,dsa,ecdsa,ed25519 `terraform -chdir=terraform output -raw public_ip` >> ~/.ssh/known_hosts
	sudo chmod 600 .local/ansible.pem
ping:
	ansible -i .local/inventory all -u root --private-key .local/ansible.pem -m ping

deploy:
	ansible-playbook -i .local/inventory -u root --private-key .local/ansible.pem ansible/playbooks/Profile-set-up.yaml

connect:
	ssh -i .local/ansible.pem root@`terraform -chdir=terraform output -raw public_ip`