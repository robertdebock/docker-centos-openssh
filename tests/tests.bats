@test "Logging in and running \"id\"." {
  run ssh -i .ssh/id_rsa -o Port=2222 -o "StrictHostKeyChecking no" root@localhost "id"
  [ "${status}" -eq 0 ]
}
