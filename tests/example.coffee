isql = require '../lib/isql'
path = require 'path'

console.log 'calling isql'

cli = new isql.Client
  port: 1111
  usr: 'dba'
  pwd: 'dba'
  command: 'isql'

test_exec = ( cb ) ->
  console.log 'will try to execute status()'
  cli.exec 'status()', (err, res) ->
    console.log [err, res]
    cb?()

test_sql_path = path.join __dirname, 'test.sql'

test_load = ( cb ) ->
  console.log 'will try to load ' + test_sql_path
  cli.load test_sql_path, ( err, res) ->
    console.log [err, res]
    cb?()

test_load ->
  test_exec()