pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/admin105-sudo/CICD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t username/myapp:latest .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push username/myapp:latest'
            }
        }
    }
}
