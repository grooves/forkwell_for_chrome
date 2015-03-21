require 'test/helper'

describe 'Example', ->
  ary = [1, 2, 3]

  it 'succeed', ->
    assert ary.indexOf(3) is 2

  it.skip 'fail', ->
    assert ary.indexOf(0) is 2
