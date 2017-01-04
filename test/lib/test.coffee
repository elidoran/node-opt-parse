assert = require 'assert'
parser = require '../../lib'

describe 'test parser', ->

  it 'should call an inner parse which throws an error', ->
    assert.throws parser

  it 'should call inner parse when it has been changed', ->
    original = parser.parse
    parser.parse = -> 'tested'
    assert.equal parser(), 'tested'
    parser.parse = original

  it 'should accept plugins to change parse', ->

    original = parser.parse

    parser.use (options, opt) -> # `opt` is `parser` ...
      opt.parse = -> 'tested'
      return

    assert.equal parser(), 'tested'
    parser.parse = original

  it 'should accept two plugins which work together', ->

    original = parser.parse

    # normally these would be provided as package names and get require()'d.
    # instead, i'll take advantage of being able to provide them directly.
    parser.use (options, opt) -> opt.parse = -> 'tested' + opt.extra
    parser.use (options, opt) -> opt.extra = ' it' ; return

    assert.equal parser(), 'tested it'

    parser.parse = original
    delete parser.extra
