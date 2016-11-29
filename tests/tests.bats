@test "Waiting for the container to be ready." {
  run sleep 3
  [ "${status}" -eq 0 ]
}

@test "Logging in and running a command." {
  run ssh -i id_rsa.priv -o Port=2222 -o "StrictHostKeyChecking no" root@localhost "id"
  [ "${status}" -eq 0 ]
}
