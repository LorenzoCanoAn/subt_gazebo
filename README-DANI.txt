link directories   : sshfs danilo@felix:/home/danilo/work/uav  /home/danilo/work/uav

on sirena          : roslaunch subt_gazebo shaper.launch
on sirena          : roslaunch subt_gazebo cueva_lidar.launch

on felix           : rosrun slibon slibon (doesn't print anything now)

path file          : subt_gazebo/paths/bend-right.txt

generate rnd paths : ./deep-test-generator.bash

record data        : rosrun slibon datarecorder _output:=/home/danilo/work/uav/deep/random-data.txt _use:=cloud _append:=true

filter data: ./filter.sh  data-july8-cloud-tmp.txt

launch fully for training : python3 /home/danilo/work/uav/tenflow/nets/fully.py -m july8.h5 -d /home/danilo/deep-data/july8/data-july8-cloud-filtered.txt
launch fully for testing  : python3 /home/danilo/work/uav/tenflow/nets/fully.py -m july8.h5 -T /home/danilo/deep-data/july8/data-july8-cloud-filtered.txt

#use slimu without deep-test-generator.bash
#rosrun slibon slimu _dy:=0.05 _z0:=1.5 _wx:=$wx _wz:=$wz _wyaw:=$wyaw _wroll:=$wroll _wpitch:=$wpitch _x0:=$xzero _xsin:=
#rosrun slibon slimu _follow:=/home/danilo/work/uav/paths/bend-right.txt _rate:=30


keras_export/convert_model.py