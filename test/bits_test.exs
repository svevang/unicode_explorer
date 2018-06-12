defmodule BitsTest do
  use ExUnit.Case

  doctest UnicodeExplorer.Bits

  describe "extract_bits/1" do
    assert UnicodeExplorer.Bits.extract_bits(97) == [0, 1, 1, 0, 0, 0, 0, 1]
  end


end
