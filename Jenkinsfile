pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
               // git credentialsId: 'id_gitlab', url: 'https://repo-dev.efi-academy.com/houcem/myapp-j2e-g17.git'
              checkout scm 

            }
        }
        
       stage('Build'){
           steps{
               script{
                   withMaven(globalMavenSettingsConfig: '', jdk: 'java', maven: 'maven', mavenSettingsConfig: '', traceability: true) {
                      sh ' mvn clean install package'
                          }
                 
               }
           }
       }
       

      stage('Nexus'){
         steps{

              nexusArtifactUploader artifacts: [[artifactId: 'new-year-app-houcem', classifier: '', file: 'myapp-g17.war', type: 'war']], credentialsId: 'id_nexus', groupId: 'com.example', nexusUrl: '172.16.2.45:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'myapp-g17', version: '1.0.0'
         }

      }


       
       stage('deploy'){
           steps{
               deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'id_tomcat', path: '', url: 'http://172.16.17.100:8080')], contextPath: null, war: '**/*.war'
               
           }
           
       }
       
    }
  
  post {
      
      success {
          echo "Pipeline ${env.JOB_NAME} Réussi!"
      }
    
      failure {
          
          echo "Echec du Pipeline ${env.JOB_NAME} !"
      }
      }  
}
