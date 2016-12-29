@test "Waiting for the container to be ready." {
  run sleep 3
  [ "${status}" -eq 0 ]
}

@test "Logging in and running a simple command." {
  run ssh -i id_rsa.priv -o Port=2222 -o "StrictHostKeyChecking no" root@localhost "id"
  [ "${status}" -eq 0 ]
}

@test "Logging in and checking CentOS Version." {
  run ssh -i id_rsa.priv -o Port=2222 -o "StrictHostKeyChecking no" root@localhost "grep 7.3.1611 /etc/redhat-release"
  [ "${status}" -eq 0 ]
}

@test "Logging in and checking root filesystem." {
  run ssh -i id_rsa.priv -o Port=2222 -o "StrictHostKeyChecking no" root@localhost "df -t aufs /"
  [ "${status}" -eq 0 ]
}

@test "Killing the container with CTRL and C." {
  run kill -SIGINT $(docker inspect --format='{{.State.Pid}}' $(docker ps -ql))
  [ "${status}" -eq 0 ]
  skip
}

@test "Checking if container is killed." {
  result="$(docker ps | wc -l)"
  [ "$result" -eq 1 ]
  skip
}
