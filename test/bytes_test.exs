defmodule BytesTest do
  use ExUnit.Case
  doctest UnicodeExplorer.Bytes

  describe "byte_matrix/1" do
    s = ["aa", "bbb", "cccc", "ddd", "ee", "f"]
    assert UnicodeExplorer.byte_matrix(s) == [
        'abcdef',
        [97, 98, 99, 100, 101, nil],
        [nil, 98, 99, 100, nil, nil],
        [nil, nil, 99, nil, nil, nil]
    ]
  end

end
