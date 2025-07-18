pipeline {
    agent any

    stages {
        stage('Build & Push Docker Image') {
            steps {
                script {
                    def imageName = "wildechild/file-converter-app"

                    // Build Docker image
                    docker.build(imageName)

                    // Push to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
                        sh "docker push ${imageName}"
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@3.87.17.252 "
                            docker pull wildechild/file-converter-app:latest &&
                            docker stop file-converter || true &&
                            docker rm file-converter || true &&
                            docker run -d -p 5000:5000 --name file-converter wildechild/file-converter-app:latest
                        "
                    '''
                }
            }
        }
    }
}
