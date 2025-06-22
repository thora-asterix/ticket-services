pipeline {
    agent any

    environment {
        IMAGE_NAME = "ticket-services"
        REGISTRY_HOST = "ttrialkhqq62.jfrog.io"
        REPO_PATH = "{$REGISTRY_HOST}/ticket-services-docker-local"
        JFROG_CREDENTIALS = credentials('jfrog-docker')
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/thora-asterix/ticket-services.git', credentialsId: 'github-creds'
            }
        }

        stage('Build JAR') {
            steps {
                bat './gradlew clean build'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME}:latest ."
                bat "docker tag ${IMAGE_NAME}:latest ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
            }
        }

        stage('Push to JFrog') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jfrog-docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    bat "echo $PASSWORD | docker login ${DOCKER_REGISTRY} -u $USERNAME --password-stdin"
                    bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
        }
    }
}