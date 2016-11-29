@test "Logging something." {
  run id
  [ "${status}" -eq 0 ]
}
