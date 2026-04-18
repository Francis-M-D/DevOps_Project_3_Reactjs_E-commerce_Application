pipeline {
    agent any

    environment {
        DEV_REPO = "ghostatdocker/react-app-dev"
        PROD_REPO = "ghostatdocker/react-app-prod"
        IMAGE = "react-app"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: "dev", url: 'https://github.com/Francis-M-D/DevOps_Project_3_Reactjs_E-commerce_Application.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push to Dev') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                docker tag $IMAGE $DEV_REPO:latest
                docker push $DEV_REPO:latest
                '''
            }
        }

        stage('Push to Prod') {
            when {
                branch 'master'
            }
            steps {
                sh '''
                docker tag $IMAGE $PROD_REPO:latest
                docker push $PROD_REPO:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}
