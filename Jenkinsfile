pipeline {
    agent any

    environment {
        IMAGE           = "zainab0405/zainab-portfolio"
        S3_BUCKET       = "zainab-portfolio-2025"
        CF_DISTRIBUTION = "E18UQLERRVG4XM"
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

        stage('Deploy to S3') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    sh """
                        aws s3 sync . s3://${S3_BUCKET} \
                          --delete \
                          --exclude '.git/*' \
                          --exclude 'terraform/*' \
                          --exclude 'monitoring/*' \
                          --exclude 'Jenkinsfile' \
                          --exclude 'Dockerfile' \
                          --region us-east-1
                    """
                }
            }
        }

        stage('Invalidate CloudFront') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    sh """
                        aws cloudfront create-invalidation \
                          --distribution-id ${CF_DISTRIBUTION} \
                          --paths '/*'
                    """
                }
            }
        }
    }

    post {
        success { echo '✅ Déployé sur CloudFront !' }
        failure { echo '❌ Échec du pipeline' }
    }
}
