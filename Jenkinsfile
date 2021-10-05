pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package -s settings.xml'
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
      }//end stages
    }//end pipeline
