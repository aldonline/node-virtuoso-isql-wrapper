isql = require './isql'

console.log 'calling isql'

cli = new isql.Client
  port: 1111
  usr: 'dba'
  pwd: 'dba'
  command: 'isql'

cli.exec 'status()', (err, res) ->
  console.log [err, res]