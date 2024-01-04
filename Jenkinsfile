pipeline {
    agent any

    environment {
        TF_HOME = tool 'Terraform'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    git 'https://github.com/yourusername/your-terraform-repo.git'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'terraform-credentials', variable: 'GOOGLE_CREDENTIALS')]) {
                        sh "echo '$GOOGLE_CREDENTIALS' > account.json"
                        sh "${TF_HOME}/bin/terraform init -backend-config=backend.tfvars"
                        sh "${TF_HOME}/bin/terraform plan -out=tfplan"
                    }
                }
            }
        }

        stage('Terraform Apply or Destroy') {
            steps {
                script {
                    def userInput = input message: '¿Aplicar (apply) o destruir (destroy) en Terraform?', parameters: [choice(name: 'ACTION', choices: 'apply\ndestroy', description: 'Seleccione la acción')]

                    withCredentials([string(credentialsId: 'terraform-credentials', variable: 'GOOGLE_CREDENTIALS')]) {
                        sh "echo '$GOOGLE_CREDENTIALS' > account.json"
                        
                        if (userInput == 'apply') {
                            sh "${TF_HOME}/bin/terraform apply -auto-approve tfplan"
                        } else if (userInput == 'destroy') {
                            sh "${TF_HOME}/bin/terraform destroy -auto-approve"
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'rm -rf .terraform'
            }
        }
    }
}
