# Creates AMI with Packer from the latest Amazon Linux image

## Prerequisites:

- Form the machine your running Packer make sure you have the AWS CLI credentials to be able to connect to AWS.
- Packer installed

To build the image AMI use:

```console
$ git clone https://github.com/danfmihai/ami-jenkins.git
$ cd ami-jenkins/

$ packer init .
$ packer build .
```