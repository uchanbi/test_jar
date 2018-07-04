def label = "worker-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
  containerTemplate(name: 'gradle', image: 'gradle:4.5.1-jdk9', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'java', image: 'java', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.8', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:latest', command: 'cat', ttyEnabled: true)
],
volumes: [
  hostPathVolume(mountPath: '/home/gradle/.gradle', hostPath: '/tmp/jenkins/.gradle'),
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
  node(label) {
 
    stage('Maven Build') {

        git url: 'https://github.com/uchanbi/test_jar.git'
        container('java') {
            sh 'javac HelloWorld/Main.java'
          sh 'java -cp . HelloWorld.Main'
          sh 'jar cfme Main.jar Manifest.txt HelloWorld.Main HelloWorld/Main.class'
          
        }
      
    }
    stage('Create Docker images') {
      container('docker') {
          sh 'docker login --username=bihanc --password=hobbit@123' 
          sh 'docker build -t bihanc/jenkinspipe:${BUILD_NUMBER} .'
          sh 'docker push bihanc/jenkinspipe:${BUILD_NUMBER} '
        
        
      }
    }
    stage('Run kubectl') {
      container('kubectl') {
        sh "kubectl set image deployment.extensions/hellow-app hellows-app=bihanc/jenkinspipe:${BUILD_NUMBER} -n hellows"
      }
    }
    stage('Run helm') {
      container('helm') {
        sh "helm list"
      }
    }
  }
}
