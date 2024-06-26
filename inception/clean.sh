#!/bin/bash

clear

# "docker ps -qa" returns the IDs of all containers, regardless of their state.

# stop all containers
echo "docker stop $(docker ps -qa)"
docker stop $(docker ps -qa)
echo ""

# removes all Docker containers
echo "docker rm $(docker ps -qa)"
docker rm $(docker ps -qa)
echo ""

# forcibly removes all Docker images
echo "docker rmi -f $(docker images -qa)"
docker rmi -f $(docker images -qa)
echo ""

# removes all Docker volumes
echo "docker volume rm $(docker volume ls -q)"
docker volume rm $(docker volume ls -q)
echo ""

# removes all Docker networks silently, suppressing error messages
echo "docker network rm $(docker network ls -q) 2>/dev/null"
docker network rm $(docker network ls -q) 2>/dev/null

make fclean
