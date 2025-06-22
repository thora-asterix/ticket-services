pipeline {
    agent any

    environment {
        IMAGE_NAME = "ticket-services"
        DOCKER_REGISTRY = "ttrialkhqq62.jfrog.io/ticket-services-docker-local"
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
                sh './gradlew clean build'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
                sh "docker tag ${IMAGE_NAME}:latest ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
            }
        }

        stage('Push to JFrog') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jfrog-docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "echo $PASSWORD | docker login ${DOCKER_REGISTRY} -u $USERNAME --password-stdin"
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
        }
    }
}