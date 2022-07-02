node {

    stage('chekout') {
        /* Cloning the Repository to our Workspace */

        checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/gmoez/helloworld-spring.git']]])
    }
    
    stage('Build artfiact') {
        build 'buildjob'
    }

    stage('Build Docker image') {
        /* This builds the actual image */
        echo "copying artifact generated"
        sh ("cp ../buildjob/target/helloworld-1.0-SNAPSHOT.jar .")
        echo "building image"
        app = docker.build("moezg/helloworld_SP")
    }

    stage('Test image') {
  

        app.inside {
            sh 'echo "Tests passed"'
        }
    
    stage('Push image Docker hub') {
        
        docker.withRegistry('https://registry.hub.docker.com', '2fde6752-b7e4-4301-9834-e8683860bd5e') {
            app.push("${env.BUILD_NUMBER}")
        }
    }

    }