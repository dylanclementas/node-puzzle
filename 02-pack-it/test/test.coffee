assert = require 'assert'
packer = require '../index'
data = require './data'


describe 'packer', ->

  res = null

  it 'should pack data efficiently', (done) ->
    packer.pack data, (err, buffer) ->
      if err then return done err
      res = buffer
      console.log 'buffer.length =', buffer.length
      assert buffer.length <= 128
      done()

  it 'should unpack data w/o errors', (done) ->
    packer.unpack res, (err, sample) ->
      if err then return done err
      console.log 'Buffer =', sample.length, data.length
      assert.deepEqual data, sample
      done()
