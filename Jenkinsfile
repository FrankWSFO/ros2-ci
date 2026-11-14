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
        stage('Show ROS environment variables') {
            steps {
                sh 'env | grep ROS'
            }
        }
        stage('Run tests in dockerfile') {
            steps {
                sh '''
                    docker run --rm -it   -e DISPLAY=${DISPLAY}   -v /tmp/.X11-unix:/tmp/.X11-unix   -e LIBGL_ALWAYS_SOFTWARE=1 -v ~/.gazebo:/root/.gazebo   --name fastbot-waypoint-tests   fastbot-waypoint-tests
                '''
            }
        }
        stage('Stop the robot') {
            steps {
                sh '''
                roslaunch publisher_example stop.launch &
                STOP_ID=$!
                sleep 5s
                kill $STOP_ID
                '''
            }
        }
        stage('Reset the simulation') {
            steps {
                sh 'rosservice call /gazebo/reset_simulation "{}"'
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