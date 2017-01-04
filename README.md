# @opt/parse
[![Build Status](https://travis-ci.org/elidoran/node-opt-parse.svg?branch=master)](https://travis-ci.org/elidoran/node-opt-parse)
[![Dependency Status](https://gemnasium.com/elidoran/node-opt-parse.png)](https://gemnasium.com/elidoran/node-opt-parse)
[![npm version](https://badge.fury.io/js/%40opt%2Fparse.svg)](http://badge.fury.io/js/%40opt%2Fparse)
[![Coverage Status](https://coveralls.io/repos/github/elidoran/node-opt-parse/badge.svg?branch=master)](https://coveralls.io/github/elidoran/node-opt-parse?branch=master)

Modular options parser allowing plugins to provide everything.

This package doesn't do parsing, it provides the target for plugins to add their stuff.

The expectations are:

1. You will use plugins. If you weren't, you'd just `require()` your favorite parser.
2. So, you will call `parse.use()` at least once to load at least one plugin.
3. So, you can specify the plugin providing the options parser as the first param, like: `parser.use('some-parser-plugin', 'another-plugin')`. For example, use `@opt/nopt` to use `nopt` to parse.

The above expectations mean this package doesn't do parsing itself. It has no dependency on a parser package. So, no baggage when requiring different parsers.


## Install

```sh
npm install @opt/parse --save
```


## Usage

```javascript
var parse = require('@opt/parse')

// Must provide a plugin with parse implementation. This uses @opt/nopt.
// other plugins are optional. May specify them in separate use() calls.
parse.use('@opt/nopt', '@opt/words', '@opt/require')

// then use parse as you would use `nopt`,
// plus any changes made possible by the plugins added
options = parse({}, {}, process.argv, 2)
```


## Usage: Plugins

See [@use/core](https://www.npmjs.com/package/@use/core) to understand how the `use()` function behaves.

See real plugins:

1. [@opt/nopt](https://www.npmjs.com/package/@opt/nopt)
2. [@opt/words](https://www.npmjs.com/package/@opt/words)
3. [@opt/require](https://www.npmjs.com/package/@opt/require)

TODO: Make a plugin to handle type def stuff. It could be parser implementation agnostic. Then, the parser implementation plugins could grab all additional type defs from a standard format.

Example of writing a plugin for **@opt/parse**:

```javascript
module.exports = function (options, opt) {
  // use `options` to help configure what you're going to do
  // change `nopt` for your plugin's interests...
  // for example, add to typeDefs like @opt/words does:
  var nopt = require('nopt')

  nopt.typeDefs.someNewType = {
    type: theTypeKey, // used in options spec
    validate: function validateThisType(data, key, value) {
      // either return false for invalid
      // or, return true and optionally change data[key]
    }
  }
}
```


## MIT License
