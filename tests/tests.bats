@test "Logging in and running \"id\"." {
  run ssh -o Port=2222 localhost "id"
  [ "${status}" -eq 0 ]
}
