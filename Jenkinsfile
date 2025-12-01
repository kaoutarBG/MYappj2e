pipeline {
    agent any 
        
    stages {
        
        stage ('Clone'){
            steps{
                git credentialsId: 'id_gitlab', url: 'https://repo-dev.efi-academy.com/houcem/myapp-j2e-g20.git'
                              
            }
        }
       
       stage('Build'){
           steps{
               withMaven(jdk: 'java', maven: 'maven', traceability: true) {
                        sh 'mvn clean install package'
                  }
           }
       }    
       
       stage('Deploy'){
           steps{
               
               deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'id_tomcat', path: '', url: 'http://172.16.20.100:8080')], contextPath: null, war: '**/*.war'
           }
       }
       
          
    }
}