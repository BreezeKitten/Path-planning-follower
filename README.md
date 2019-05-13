# path_planning_follower

The ROS package would creat a node to plan a path from start to goal and control mobile robot to follow the path.

Block diagram about PPF node is following:
![image](image/PPF_blockdiagram.jpg)


The detail theory about path planning and control law refer to chapter 11, Robotics: Modeling, Planning and Control. B. Sicilano, L. Sciavicco, L. Villani

-------------------------------------------
Update @ 20190513  
New version rename by PPY_slowdown.py   
In the version you can set goal to 1, then the velocity will be slow down when approaching the goal.




How to use?

1.  git clone the package into your ROS workspace/src
2.  cd path_planning_follower/src
3.1  chmod +x PPY.py   //this make the PPY.py be excutable
3.2  chmod +x PPY_slowdown.py   //this make the PPY_slowdown.py be excutable
4.  go back to you workspace, then catkin_make.

Topic:

Subscribe:

"/robot_pose" (nav_msgs.msg/Odometry) or (geometry_msgs/Twist)

"/subgoal_position" (geometry_msgs/Twist):{  
  linear.x = subgoal_x  
  linear.y = subgoal_y  
  linear.z = direct_x  
  angular.x = direct_y   
  angular.y = goal  // dafult be 0. set be 1 if the subgoal is actually global goal.
  
}

Publish:

"/cmd_vel" (geometry_msgs/Twist):{  
linear.x = V (linear velocity)   
angular.z = W (angular velocity)  
}

"/desired_path" (nav_msgs/Path)

update @ 20190504   
add a new topic the publish the calculated Path  
One can see the Path in rviz by adding the topic "/desired_path"  
