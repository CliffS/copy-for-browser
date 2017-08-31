#!/usr/local/bin/coffee

Exec = require('child_process').spawnSync
Path = require 'path'
fs   = require 'fs-extra'

copy = ->

  copyset = (dest, files) ->
    new Promise (resolve, reject) ->
      files = [ files ] if typeof files is 'string'
      fs.mkdirs dest
      .then (ans) ->
        console.log "Path #{ans} created" if ans?
        opts =
          overwrite: true
          preserveTimestamps: true
        Promise.all (fs.copy Path.join(root, file), Path.join(dest, Path.basename file), opts for file in files)
      .then (result) ->
        s = if result.length is 1 then '' else 's'
        console.log "Copied #{result.length} file#{s} to #{dest}"
        resolve()
      .catch (err) ->
        reject err

  root = Exec('npm', [ 'root' ]).stdout.toString().trim()
  base = Path.dirname root

  pack = require Path.join base, 'package.json'

  section = pack.browser
  Promise.all (copyset path, files for path, files of section)
  .catch (err) ->
    console.error err.toString()



module.exports = copy
