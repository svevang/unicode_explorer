defmodule UnicodeExplorerTest do
  use ExUnit.Case
  doctest UnicodeExplorer
  import ExUnit.CaptureIO

  describe "print/1" do
    test "prints and list of binaries" do
      words = ["another", "test", "josé"]
      fun = fn() -> UnicodeExplorer.print(words) end
      assert capture_io(fun) =~ """
---------- ---------- ---------- 
another    test       josé       
---------- ---------- ---------- 
 0       a  0       t  0       j 
 1          1          1         
 1          1          1         
 0          1          0         
 0          0          1         
 0          1          0         
 0          0          1         
 1          0          0         
---------- ---------- ---------- 
 0       n  0       e  0       o 
 1          1          1         
 1          1          1         
 0          0          0         
 1          0          1         
 1          1          1         
 1          0          1         
 0          1          1         
---------- ---------- ---------- 
 0       o  0       s  0       s 
 1          1          1         
 1          1          1         
 0          1          1         
 1          0          0         
 1          0          0         
 1          1          1         
 1          1          1         
---------- ---------- ---------- 
 0       t  0       t  1       é 
 1          1          1         
 1          1          0         
 1          1          0         
 0          0          0         
 1          1          0         
 0          0          1         
 0          0          1         
---------- ---------- ---------- 
 0       h             1         
 1                     0         
 1                     1         
 0                     0         
 1                     1         
 0                     0         
 0                     0         
 0                     1         
---------- ---------- ---------- 
 0       e                       
 1                               
 1                               
 0                               
 0                               
 1                               
 0                               
 1                               
---------- ---------- ---------- 
 0       r                       
 1                               
 1                               
 1                               
 0                               
 0                               
 1                               
 0                               
"""
    end
  end

end
