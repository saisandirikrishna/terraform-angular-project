pipeline {
    agent any

    tools {
        nodejs 'Node22'
    }

    stages {

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Angular') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Check Build Output') {
            steps {
                sh 'ls -R dist'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t angular-app:${BUILD_NUMBER} .'
            }
        }

        stage('Push To ECR') {
    steps {
        sh '''
        aws ecr get-login-password --region us-east-1 | \
        docker login --username AWS --password-stdin 082123057082.dkr.ecr.us-east-1.amazonaws.com

        docker tag angular-app:${BUILD_NUMBER} \
        082123057082.dkr.ecr.us-east-1.amazonaws.com/angular-app:${BUILD_NUMBER}

        docker push \
        082123057082.dkr.ecr.us-east-1.amazonaws.com/angular-app:${BUILD_NUMBER}

        docker tag angular-app:${BUILD_NUMBER} \
        082123057082.dkr.ecr.us-east-1.amazonaws.com/angular-app:latest

        docker push \
        082123057082.dkr.ecr.us-east-1.amazonaws.com/angular-app:latest
        '''
    }
}

    stage('Debug EKS') {
        steps {
            sh '''
            export KUBECONFIG=/var/lib/jenkins/.kube/config

            whoami
            pwd
            kubectl config current-context
            kubectl get nodes
            '''
        }
    }

stage('Deploy To EKS') {
    steps {
        sh '''
        export KUBECONFIG=/var/lib/jenkins/.kube/config

        kubectl apply -f k8s/
        kubectl rollout restart deployment/angular-app
        kubectl rollout status deployment/angular-app
        '''
    }
}
    }
}