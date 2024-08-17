pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                   sh './build.sh'
            }
        } 
        stage('Deploy') {
            steps {
                   sh './deploy.sh'
            }
        }
     }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
 }
