def label = "worker-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'java', image: 'java', command: 'cat', ttyEnabled: true),
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
          sh 'docker push bihanc/jenkinspipe:${BUILD_NUMBER} 
        
      }
    }
  }
}
