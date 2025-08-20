# Solution
This project deploys the a golang webservice by leveraging container technologies and automation tools.

## Technical details
- **Github Actions**: were used to configure the entire deployment process.
- **Ansible**: was used to install k3s in the host machine and deploy to deploy the application.
- **Terraform**: was used to launch all infrastructure components necessary to deploy an EC2 following best practices. Through EC2's user_data property I was able to configure privilege escalation without the need of a password and to setup the public key that is used by `ansible-paybook` to ssh into the machine and finish the setup process.
- **Golang**: used for the code of the application.
- **OpenAPI spec**: used to document the api developed and deployed as part of this solution.

## What is done
- [X] All configuration is done through pipelines with a mix of Terraform and Ansible. Ansible inventory is updated dynamically every time the instance is destroyed and recreated.
- [X] K3s cluster was installed successfully in the instance.
- [X] K8s objects are deployed automatically by just adding the files to `k3s` and running the pipeline.
- [X] Application is tested and built in the pipeline.
- [X] The container is pushed to docker hub automatically when the pipeline runs.
- [X] Unit Tests

## What is missing
- Hability to access the application from outside the EC2 instance:
    - Missing configuration to expose the service using a public IP.
- Monitoring and Code Quality pipelines.
- Some jobs need fine-tunning to only run when absolutely necessary.

## Closing remarks
- Awesome challenge
