pipeline {
  agent any
      environment {
        DOCKER_CREDENTIALS = credentials('docker')
    }


  stages {
    stage('Checkout Source') {
      steps {
        git url:'https://github.com/srikanthrdy/Azure-Springboot-Maven-Project.git', branch:'master'
      }
    }
     stage('Maven Build'){
      steps{
        script{
           withMaven(globalMavenSettingsConfig: '', jdk: '', maven: 'Maven', mavenSettingsConfig: '', traceability: true) {
             sh 'mvn clean package'
           } 
        }
      }
    }
      stage('SonarQube'){
      steps{
        script{
           withMaven(globalMavenSettingsConfig: '', jdk: '', maven: 'Maven', mavenSettingsConfig: '', traceability: true) {
            sh 'mvn sonar:sonar'
           }
        }
      }
    }
    stage('Build image'){
       steps{
           script{
             // dockerImage=docker.build dockerimagename + ":$BUILD_NUMBER"
             sh 'docker build -t maven-app:$BUILD_NUMBER .'
             sh 'docker images'
           }
       }
    }
    
      stage('Pushing Image'){
        steps{
          script{ 
                    sh 'docker tag maven-app:$BUILD_NUMBER sr79979/maven-app:$BUILD_NUMBER'
                    sh 'docker images'
                    withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                       sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                       sh 'docker push sr79979/maven-app:$BUILD_NUMBER'
          }
        }
      }
   }
 }
     

    // stage('Deploying Spring container to Kubernetes') {
    //   steps {
    //     sshagent(['k8s-ssh-key']) {
    //        sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.14.146'
    //        sh 'scp -o StrictHostKeyChecking=no Service.yaml Deployment.yaml ec2-user@172.31.14.146:/home/ec2-user'
    //        sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.14.146 kubectl apply -f Deployment.yaml'
    //        sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.14.146 kubectl apply -f Service.yaml'
    //     }
    //   }
    // }
  // }
 }
