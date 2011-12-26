Really thin wrapper atop Virtuoso iSQL command line utility.

    isql = require 'virtuoso-isql-wrapper'
    
    cli = new isql.Client
      port:1111
      usr: 'dba'
      pwd: 'dba'
    
    cli.exec 'status()', ( err, res ) ->
      console.log "status: \n " + res

