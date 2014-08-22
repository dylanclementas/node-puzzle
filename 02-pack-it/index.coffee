VAL_SIZE = 32
BitArray = class
  data = []
  constructor: (val) ->
    switch typeof val
      # assume length
      when 'number'
        for i in [0..Math.floor(val / VAL_SIZE)-1] then data[i] = 0
      # assume buffer
      when 'object' then data = val
      else throw err "Invalid type #{typeof val}"

  set: (index, value) ->
    if !value then return
    mask = 1 << index % VAL_SIZE
    data[Math.floor(index / VAL_SIZE)] |= mask

  getArray: -> return data
  toArray: ->
    ret = []
    for i in data
      console.log 'Num = ', i
      for n in [0..VAL_SIZE-1]
        mask = 1 << n
        val = (i & mask)
        ret.push val isnt 0
    return ret

exports.pack = (data, cb) ->
  array = new BitArray data.length
  for val, i in data
    array.set i, val
  cb null, array.getArray()


exports.unpack = (buffer, cb) ->
  array = new BitArray buffer
  cb null, array.toArray()
