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
        stage('Sonar') {
            steps {
                withCredentials([string(credentialsId: 'Sonar', variable: 'sonar')]){
                sh 'mvn sonar:sonar \
  -Dsonar.host.url=http://34.125.27.246:9000 \
  -Dsonar.login=${sonar}'
                }
            }
        }//end of sonar
		stage('Docker Build') {
				steps {
						withDockerRegistry([ credentialsId: "Artifactory", url: "https://devopscicd.jfrog.io/" ]) {
						sh 'docker build -t "devops:${BUILD_NUMBER}" .'
						sh 'docker tag "devops:${BUILD_NUMBER}" devopscicd.jfrog.io/default-docker-local/"devops:${BUILD_NUMBER}"'

						}
					}
				}

		stage('Docker Push') {
				steps {
				withDockerRegistry([ credentialsId: "Artifactory url: "https://devopscicd.jfrog.io" ]) {
				sh 'docker push devopscicd.jfrog.io/default-docker-local/"devops:${BUILD_NUMBER}"'
						}
					}
				}

				stage ('Publish build docker info') {
				steps {
				script {
				server.publishBuildInfo buildInfo
			}
		}
	}
		
      }//end stages
    }//end pipeline
