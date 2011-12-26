spawn = require('child_process').spawn

# http://nodejs.org/docs/latest/api/child_processes.html#child_Processes
# http://docs.openlinksw.com/virtuoso/isql.html

exec = ( options, cb ) ->
  o = # defaults
    port: 1111
    usr: 'dba'
    pwd: 'dba'
    sql: 'status()'
    command: 'isql'
    cwd: undefined
    # turning on verbose will log out
    # everything returned by Virtuoso
    # plus it will also set VERBOSE=TRUE
    # inside the isql call
    verbose: no
  # override defaults
  o[k] = v for own k, v of options
  verbose_arg = 'VERBOSE=' + if o.verbose then 'ON' else 'OFF'
  if o.verbose
    console.log 'Calling iSQL with options'
    console.log JSON.stringify o
  p = spawn o.command, [ String(o.port), o.usr, o.pwd, verbose_arg, "EXEC=#{o.sql}" ], cwd:o.cwd
  result = error = ''
  p.stdout.on 'data', (d) ->
    console.log 'out: ' + d if o.verbose
    result += d
  p.stderr.on 'data', (d) ->
    console.log 'err: ' + d if o.verbose
    error += d
  p.on 'exit', (code) ->
    if code is 0 and error is ''
      cb? null, result
    else
      cb? code:code, error:error
  p.stdin.end()

exports.Client = class Client
  constructor: ( @options ) ->
  exec: ( sql, cb ) ->
    o = {}
    o[k] = v for own k, v of @options
    o.sql = sql
    exec o, cb
