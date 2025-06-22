pipeline {
    agent any

    environment {
        IMAGE_NAME    = 'ticket-services'
        REGISTRY_HOST = 'ttrialkhqq62.jfrog.io' // Replace with your actual JFrog domain
        REPO_PATH     = "${env.REGISTRY_HOST}/ticket-services-docker-local"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-creds', url: 'https://github.com/thora-asterix/ticket-services.git'
            }
        }

        stage('Build JAR') {
            steps {
                bat './gradlew clean build'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${env.IMAGE_NAME}:latest ."
                bat "docker tag ${env.IMAGE_NAME}:latest ${env.REPO_PATH}/${env.IMAGE_NAME}:latest"
            }
        }

        stage('Push to JFrog') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'jfrog-docker',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    bat "echo ${env.PASSWORD} | docker login ${env.REGISTRY_HOST} -u ${env.USERNAME} --password-stdin"
                    bat "docker push ttrialkhqq62.jfrog.io/ticket-services-docker-local/ticket-services:latest"
                }
            }
        }
    }
}
