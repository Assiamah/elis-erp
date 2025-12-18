'use strict'
const fs = require('fs')
const semver = require('semver')
const test = require('tape')

fs.readFile('package.json', (err, data) => {
  if (err) { throw err }

  const pkg = JSON.parse(data)
  const deps = pkg.dependencies || {}
  const ddeps = pkg.devDependencies || {}
  let cnt = 0

  for (var i in ddeps) { deps[i] = ddeps[i] }

  test('ducktape', (t) => {
    t.ok(pkg.name, `name: ${pkg.name}`)
    t.ok(pkg.description, `description: ${pkg.description}`)
    t.ok(semver.valid(pkg.version), `version: ${pkg.version}`)
    t.ok(pkg.scripts.test, `test: ${pkg.scripts.test}`)
    t.ok(pkg.scripts.travis, `travis: ${pkg.scripts.travis}`)
    t.ok(pkg.scripts.cover, `cover: ${pkg.scripts.cover}`)

    exec('readdir', 'node_modules', (files) => {
      for (let i = files.length - 1; i >= 0; i--) {
        const module = files[i]
        if (module[0] === '@') {
          exec('readdir', `node_modules/${module}`, (files) => {
            for (let i = files.length - 1; i >= 0; i--) {
              checkpackage(`node_modules/${module}/${files[i]}/package.json`, deps)
            }
          })
        } else {
          checkpackage(`node_modules/${module}/package.json`, deps)
        }
      }
    })
    function checkpackage (deppackage, deps) {
      exec('readFile', deppackage, (data) => {
        const pkg = JSON.parse(data)
        const requiredVersion = deps[pkg.name]
        if (requiredVersion) {
          exec('readFile', deppackage, (data) => {
            const version = JSON.parse(data).version
            t.ok(semver.satisfies(version, requiredVersion), `dependencies: ${pkg.name}@${requiredVersion} (${version})`)
          })
        }
      })
    }
    function exec (fn, file, cb) {
      cnt++
      fs[fn](file, (err, data) => {
        if (!err) { cb(data) }
        if (!--cnt) { t.end() }
      })
    }
  })
})
 // has description
 // blacklisted modules (hyperquest)
 // folder structurte
 // does it have coverage
 // does it have travis
