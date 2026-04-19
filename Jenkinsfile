pipeline {
    agent any

    environment {
        DEV_IMAGE  = "ghostatdocker/react-app-dev:latest"
        PROD_IMAGE = "ghostatdocker/react-app-prod:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'bash build.sh'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'

                    script {
                        if (env.BRANCH_NAME == 'master') {
                            sh 'docker tag ghostatdocker/react-app-dev:latest $PROD_IMAGE'
                            sh 'docker push $PROD_IMAGE'
                        } else {
                            sh 'docker push $DEV_IMAGE'
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'bash deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
