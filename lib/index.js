'use strict'

// create an outer function which calls into the inner function.
// this is so plugins can swap in a newer inner function.
module.exports = function outerParse() {
  return module.exports.parse.apply(module.exports, arguments)
}

// there's no default parser. that way, others can be placed here and
// there isn't a dependency for this package.
module.exports.parse = function noImplementationParse() {
  throw new Error('No parser provided. Did you meant to use @opt/nopt')
}

// make plugins possible via this package's use() function:
module.exports.use = require('@use/core').gen()
