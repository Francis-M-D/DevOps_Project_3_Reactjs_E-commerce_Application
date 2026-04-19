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
                script {
                    if (env.BRANCH_NAME == 'master') {
                        sh 'bash build.sh prod'
                    } else {
                        sh 'bash build.sh dev'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'Docker_Credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'

                    script {
                        if (env.BRANCH_NAME == 'master') {
                            sh 'docker push $PROD_IMAGE'
                        } else {
                            sh 'docker push $DEV_IMAGE'
                        }
                    }
                }
            }
        }
	
	stage('Deploy') {
            when {
                expression {
                    return env.BRANCH_NAME == 'master'
                }
            }
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
