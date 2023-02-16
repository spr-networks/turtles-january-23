# turtles-january-23
Turtles Contest - January 23


![image](https://user-images.githubusercontent.com/37549748/213887535-f6399acf-991e-4fbc-9a9f-bb0312110145.png)

## Writeup

https://www.supernetworks.org/pages/blog/january-2023-turtles

# Submissions are now over

## Winners:

1. @itszn13 

## Rules 
1. Submit writeups by e-mail to turtles@supernetworks.org
2. The best writeup along with the first two writeups (that are correct) will be awarded pis as prizes. Writeups should include functional exploits

## How to play

This is a self hosted challenge -- your goal is to pivot from t1_start across the environment and collect three flags along the way. 

## Dependencies
See host-install.sh. Make sure wireless-regdb is installed on the host, along with the mac hwsim drivers. It was observed that missing the regulatory db on the host stops the challenges from running correctly.

## Running the system
```
docker-compose up -d
sudo ./setup.sh

docker exec -it t1_start bash or ssh root@localhost -p 2222 (password is mutant_n1nj4_turtle)
```
