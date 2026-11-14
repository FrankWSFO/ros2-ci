pipeline {
    agent any 
    stages {
        stage('Set up docker') {
            steps {
                sh '''
                    cd ~
                    bash ./setup_docker.sh
                '''
            }
        }
        stage('Build waypoint tests dockerfile') {
            steps {
                sh '''
                cd ~/ros2_ws/src
                docker build -f ./ros2_ci/fastbot-waypoint-tests -t fastbot-waypoint-tests .
                '''
            }
        }
        stage('Run tests in dockerfile') {
            steps {
                sh '''
                    docker run --rm -it   -e DISPLAY=${DISPLAY}   -v /tmp/.X11-unix:/tmp/.X11-unix   -e LIBGL_ALWAYS_SOFTWARE=1 -v ~/.gazebo:/root/.gazebo   --name fastbot-waypoint-tests   fastbot-waypoint-tests
                '''
            }
        }
        stage('Done') {
            steps {
                sleep 5
                echo 'Pipeline completed'
            }
        }
    }
}