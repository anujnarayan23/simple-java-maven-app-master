pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package -s settings.xml'
                sh 'mvn deploy -s settings.xml'
            }
        }//end build
	    
        stage('Test') {
            steps {
                sh 'mvn test'
                junit 'target/surefire-reports/*.xml'
            }
        }//end of test
	    
        stage('Sonar Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                sh 'mvn sonar:sonar' 
              }
            }
        }//end of sonar
	    
	stage("Sonar Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }//end of Sonar Quality gate
	    
	stage('Docker Build') {
	    steps {
		withDockerRegistry([ credentialsId: "Artifactory", url: "https://devopscicd.jfrog.io/" ]) {
		sh 'docker build -t "devops:${BUILD_NUMBER}" .'
		sh 'docker tag "devops:${BUILD_NUMBER}" devopscicd.jfrog.io/default-docker-local/"devops:${BUILD_NUMBER}"'
		}
	    }
	}//end of Docker Build
	    
	stage('Docker Push') {
	    steps {
		withDockerRegistry([ credentialsId: "Artifactory", url: "https://devopscicd.jfrog.io" ]) {
		sh 'docker push devopscicd.jfrog.io/default-docker-local/"devops:${BUILD_NUMBER}"'
		}
	     }
	}//end of Docker Push
	
	// 			stage ('Publish build docker info') {
	// 			steps {
	// 			script {
	// 			server.publishBuildInfo buildInfo
	// 		}
	// 	}
	// }
		
      }//end stages
    }//end pipeline
