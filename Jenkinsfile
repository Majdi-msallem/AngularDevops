properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    tools { nodejs "NodeJS" }
    environment { 
        registry = "majdimsallem/front" 
        registryCredential = 'dockerhub_id' 
	
	dockerImage = '' 
    }		

    stages {
        stage('Checkout GIT') {
            steps {

                echo 'Pulling...';
                git branch: 'master',
                url : 'https://github.com/Majdi-msallem/AngularDevops.git';
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
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
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
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        }
      
	 stage('Docker-compose') {
            steps {
                echo 'Running docker-compose...';
                sh """ docker-compose up -d -y --force-recreate """;
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
                
                emailext to: "majdi.msallem@esprit.tn",
                subject: "[DevOps Angular]jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
                body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}",
		attachLog: true
                
            }
        }	


}
