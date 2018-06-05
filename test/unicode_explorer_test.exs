defmodule UnicodeExplorerTest do
  use ExUnit.Case
  doctest UnicodeExplorer
  import ExUnit.CaptureIO

  describe "print/3" do
    test "prints and list of binaries" do
      words = ["another", "test", "fine", "watermelon", "josé"]
      fun = fn() -> UnicodeExplorer.print(Enum.sort(words)) end
      assert capture_io(fun) =~ "----------------------------------------\n 0 a     0 f     0 j     0 t     0 w    "
    end
  end

  describe "longest_bitlength/1" do
    test "find the max number of bits for a list of binaries" do
      keys = ["a", "aa", "é"]
      assert UnicodeExplorer.max_bitlength(keys) == 2 * 8

      keys = ["a", "aa", "aé"]
      assert UnicodeExplorer.max_bitlength(keys) == 3 * 8
    end
  end

end
