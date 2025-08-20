# Solution
This project deploys the a golang webservice by leveraging container technologies and automation tools.

## Technical details
- **Github Actions**: were used to configure the entire deployment process.
- **Ansible**: was used to install k3s in the host machine and deploy to deploy the application.
- **Terraform**: was used to launch all infrastructure components necessary to deploy an EC2 following best practices. Through EC2's user_data property I was able to configure privilege escalation without the need of a password and to setup the public key that is used by `ansible-paybook` to ssh into the machine and finish the setup process.
- **Golang**: used for the code of the application.
- **OpenAPI spec**: used to document the api developed and deployed as part of this solution.

## TODO
- [X] MVP of word service
- [X] Terraform Code to provision ec2 instance and all supporting resources
	- [X] Enable privilege escalation without password
	- [X] Configure ssh authorized keys for Ansible playbook
- [X] Ansible code to configure instance
	- [X] Instal k3s and dependencies
	- [X] Configure k8s cluster
- [X] Create Dockerfile to build the app
- [X] Setup Github Actions
- [ ] Deploy K8S manifests with Ansible
- [X] Create the OpenAPI spec
- [ ] Refactor the MVP
	- [ ] Add unit tests
	- [ ] Integration tests
	- [ ] Update code organization to emulate a production
- [ ] Monitoring
	- [ ] Add Grafana and prometheus for monitoring
	- [ ] Fallback to aws cloudwatch
- [ ] Deploy sonarqube community on an ec2 instance
	- [ ] Integrate Sonarqube Community to Github Actions
