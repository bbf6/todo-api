#!/bin/bash

rails db:create
rails db:migrate
rails db:seed

kill -0 $(cat tmp/pids/server.pid)
rails s -b 0.0.0.0
