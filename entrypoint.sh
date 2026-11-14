#!/bin/bash
source /opt/ros/humble/setup.bash
source /usr/share/gazebo/setup.sh
source /fastbot_ws/install/setup.bash

cleanup() { kill $SIM_PID $SERVER_PID 2>/dev/null; wait 2>/dev/null; }
trap cleanup EXIT

echo "Starting sim"

ros2 launch fastbot_gazebo one_fastbot_room.launch.py &
SIM_PID=$!

echo "Waiting for completion of sim startup"

# wait for the sim to be ready (don't just sleep)
timeout 180 bash -c 'until ros2 topic list | grep -q /fastbot/scan; do sleep 1; done' \
  || { echo "Sim never came up"; exit 1; }

echo "Finished sim startup. Starting action server"

ros2 run fastbot_waypoints fastbot_action_server &
SERVER_PID=$!

echo "Waiting for completion of action server startup"

timeout 120 bash -c 'until ros2 action list | grep -q /fastbot_waypoint_as; do sleep 1; done' \
  || { echo "Action server never came up"; exit 1; }

echo "Starting test"

colcon test --packages-select fastbot_waypoints --event-handler=console_direct+
TEST_RC=$?
colcon test-result --all || TEST_RC=1

echo "Test complete"

exit $TEST_RC

# /bin/bash", "-c", "source /opt/ros/galactic/setup.bash && source /usr/share/gazebo/setup.sh && source /fastbot_ws/install/setup.bash && ros2 launch fastbot_gazebo one_fastbot_room.launch.py & \
#     source /opt/ros/galactic/setup.bash && source /fastbot_ws/install/setup.bash && ros2 run fastbot_waypoints fastbot_action_server & \
#     source /opt/ros/galactic/setup.bash && source /fastbot_ws/install/setup.bash && colcon test --packages-select fastbot_waypoints --event-handler=console_direct+ && colcon test-result --all"]