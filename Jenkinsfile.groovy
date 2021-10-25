node{

    ansiColor('xterm') {

        stage('Git Pull') {
            git branch: 'main', url: 'https://github.com/danfmihai/ami-jenkins.git'
        }

        stage('Create AMI') {
            sh '''packer init .
                packer build .'''
        }    
    }
}