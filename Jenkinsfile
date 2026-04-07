pipeline {
    agent any

    environment {
        IMAGE = "zainab0405/zainab-portfolio"
        EC2_IP = "35.180.254.156"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE}:${BUILD_NUMBER} -t ${IMAGE}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${IMAGE}:${BUILD_NUMBER}"
                    sh "docker push ${IMAGE}:latest"
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'ec2-ssh-key',
                    keyFileVariable: 'SSH_KEY'
                )]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no -i $SSH_KEY ubuntu@${EC2_IP} '
                            docker pull ${IMAGE}:latest &&
                            docker stop portfolio || true &&
                            docker rm portfolio || true &&
                            docker run -d --name portfolio -p 80:80 --restart always ${IMAGE}:latest
                        '
                    """
                }
            }
        }
    }

    post {
        success { echo '✅ Déploiement réussi !' }
        failure { echo '❌ Échec du pipeline' }
    }
}
