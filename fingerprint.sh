#!/bin/bash

ssh-keyscan app1-ctr app1 app2-ctr app2 app3-ctr app3 db1-ctr db1 > /root/.ssh/known_hosts
