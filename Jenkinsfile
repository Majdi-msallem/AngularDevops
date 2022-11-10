properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    tools { nodejs "NodeJS" }
    environment { 
        registry = "bahaeddinesaid/tpachatprojectfront" 
        registryCredential = 'dockerHub' 
	
	dockerImage = '' 
    }		

    stages {
        stage('Checkout GIT') {
            steps {

                echo 'Pulling...';
                git branch: 'bahaeddine',
                url : 'https://github.com/bahaeddinesaid/TP_Achat_devops_front',
		credentialsId: '05193d27-514a-4ce0-aa03-95d9d90dfe60';
            }
        }
	    
        stage('Install') {
          
          steps { 
            echo 'Installing ...';
            sh 'npm install'; }
        }
      
        stage('Build') {
        steps {
          echo 'Building ...';
          sh 'npm run build --prod'; }
        }
      
        stage('show Node version') {
            steps {
                echo 'Showing Node version ...';
                sh """ node --version """;
            }
        }

      stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":latest" 
                }
            } 
        }

        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 

        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:latest" 
            }
        }
      
	 stage('Docker-compose') {
            steps {
                echo 'Running docker-compose...';
                sh """ docker-compose up -d """;
               sh """ docker-compose ps """;
            }
        }

        stage('show Date') {
            steps {
                echo 'Showing Date...';
                sh """ date """;
            }
        }

    }
  
    post {
            always{
                
                emailext to: "bahaeddine.said@esprit.tn",
                subject: "[DevOps Angular]jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
                body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}",
		attachLog: true
                
            }
        }	


}
