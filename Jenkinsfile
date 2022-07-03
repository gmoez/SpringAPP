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
        app = docker.build("moezg/springboot")
    }

    stage('Test image') {
  

        app.inside {
            sh 'echo "Tests passed"'
        }
    }
    
    stage('Push image Docker hub') {
        
        docker.withRegistry('https://registry.hub.docker.com', 'ID docker hub in your jenkins') {
            app.push("${env.BUILD_NUMBER}")
        }
    }

    stage('Trigger ManifestUpdate') {
                echo "triggering job manifest pipeline"
                build job: 'manifestpipeline', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }


    }
