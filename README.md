# Creates AMI with Packer from the latest Amazon Linux image

## Prerequisites:

- Form the machine you're running Packer make sure you have the AWS CLI credentials to be able to connect to AWS. Check with command : `$ aws configure`
- Packer installed
- AWS CLI installed


To build the image AMI use:

```console
$ git clone https://github.com/danfmihai/ami-jenkins.git
$ cd ami-jenkins/

$ packer init .
$ packer build .
```

or use a Jenkins pipeline with `Jenkins.groovy file`