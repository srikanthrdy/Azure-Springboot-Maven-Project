pipeline {
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git url:'https://github.com/srikanthrdy/Azure-Springboot-Maven-Project.git', branch:'master'
      }
    }
     stage('Maven Build'){
      steps{
        script{
           withMaven(globalMavenSettingsConfig: '', jdk: '', maven: '', mavenSettingsConfig: '', traceability: true) {
             sh 'mvn clean package'
          // } 
        }
      }
    }
      stage('SonarQube'){
      steps{
        script{
           withMaven(globalMavenSettingsConfig: '', jdk: '', maven: 'Maven', mavenSettingsConfig: '', traceability: true) {
            sh 'mvn clean verify sonar:sonar   -Dsonar.projectKey=Azure-Springboot-Maven-Project   -Dsonar.projectName='Azure-Springboot-Maven-Project'   -Dsonar.host.url=http://localhost:9000   -Dsonar.token=sqp_99e88202e7bfd51e18c4f860af60609ff9f383d3'
           }
        }
      }
    }
    stage('Build image'){
       steps{
           script{
             dockerImage=docker.build dockerimagename + ":$BUILD_NUMBER"
           }
       }
    }

     stage('Pushing Image'){
       environment{
         rigistryCredential = "Dockerhub-Credential"
       }
       steps{
          script{
            docker.withRegistry ('https://registry.hub.docker.com', rigistryCredential ){
              dockerImage.push("latest")
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
  }
}
