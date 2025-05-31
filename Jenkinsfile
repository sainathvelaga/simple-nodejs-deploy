pipeline {
    agent {
        label 'AGENT-1'
        choice(name: 'TagKey', choices: ["Environment"], description: 'Choose tag')
        choice(name: 'TagValue', choices: ["Dev"], description: 'Choose tag')
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'appVersion', defaultValue: '1.0.0', description: 'What is the application version?')
    }
    environment{
        def appVersion = '' //variable declaration
        nexusUrl = 'nexus.daws78s.online:8081'
    }
    stages {
        stage('print the version'){
            steps{
                script{
                    echo "Application version: ${params.appVersion}"
                }
            }
        }
        stage('Init'){
            steps{
                sh """
                    cd terraform
                    terraform init
                """
            }
        }
        stage('Plan'){
            steps{
                sh """
                    pwd
                    cd terraform
                    terraform plan -var="app_version=${params.appVersion}"
                """
            }
        }

        stage('Deploy'){
            steps{
                sh """
                    cd terraform
                    terraform apply -auto-approve -var="app_version=${params.appVersion}"
                    terraform output -json > tf_output.json

                    """
            }
    

        }

        stage('Generate Ansible Inventory') {
            steps {
                sh '''
                    INSTANCE_IP=$(jq -r '.instance_ip.value' terraform/tf_output.json)
                    echo "[web]" > hosts.ini
                    echo "$INSTANCE_IP ansible_user=ec2-user ansible_password=DevOps321" >> hosts.ini
                '''
            }
        }
    

        stage("Execute Ansible") {
            steps {
                stage('Ansible-Playbook Execution') {
                    steps {
                    echo 'Executing Ansible Playbook'

                    sh '''
                    ansible-playbook -i hosts.ini deploy.yaml
                    '''
                    }
            }
        }
    }
    }   
    
    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        success { 
            echo 'I will run when pipeline is success'
        }
        failure { 
            echo 'I will run when pipeline is failure'
        }
        unstable { 
            echo 'I will run when pipeline is unstable'
        }
    }
}
// This Jenkinsfile defines a pipeline for deploying a Node.js application using Terraform and Ansible.
// It includes stages for initializing Terraform, planning and applying the deployment, generating an Ansible inventory
// file, and executing an Ansible playbook. The pipeline also includes parameters for application version and tag selection.
// The post section handles cleanup and notifications based on the pipeline's outcome. 
// The pipeline is designed to run on a specific agent labeled 'AGENT-1' and has a timeout of 30 minutes.
