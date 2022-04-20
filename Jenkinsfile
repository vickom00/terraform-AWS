pipeline {
    agent any

    stages {
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform  plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Manual Check') {
            steps {
                input message: 'Apply this Terraform', ok: 'Yes'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}