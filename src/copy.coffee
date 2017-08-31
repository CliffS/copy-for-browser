#!/usr/local/bin/coffee

Exec = require('child_process').spawnSync
Path = require 'path'
fs   = require 'fs-extra'

copy = ->

  root = Exec('npm', [ 'root' ]).stdout.toString().trim()
  base = Path.dirname root

  pack = require Path.join base, 'package.json'

  files = pack.vendorFiles
  files = [ files ] if typeof files is 'string'

  dest = Path.join base, 'public', 'js', 'vendor'
  fs.mkdirs dest
  .then (ans) ->
    opts =
      overwrite: true
      preserveTimestamps: true
    Promise.all (fs.copy Path.join(root, file), Path.join(dest, Path.basename file), opts for file in files)
  .catch (err) ->
    console.log "Error:", err

module.exports = copy
