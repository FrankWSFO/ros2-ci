To start jenkins, run 

    bash ~/webpage_ws/start_jenkins.sh

Follow the directions outputted in the terminal to go to the Jenkins server webpage (i.e., see /home/user/jenkins__pid__url.txt for PID and url).
Log in with
username: admin
password: \<what you find in ~/webpage_ws/jenkins/secrets/initialAdminPassword\>

From there, you should see the "Fastbot Waypoint Action Test" as one of the jobs that appears on the dashboard. 
Click on it. 
Once you've arrived at the job's page, in the bottom left, you can see the builds, which should trigger upon a pull request being accepted. 
You can click on any build already/currently being built, and in the left side menubar, you can click on the "Console Output" button to view console output and see if the build was a success (or just see if there's a check by the job's name). 