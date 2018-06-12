# UnicodeExplorer

Unicode Explorer is a tool to print out a Elixir binaries. Each byte is
printed out in binary and if the string is UTF-8, any valid graphemes
starting at that byte are also printed.


## Installation

Make sure you have Elixir installed. Then clone and build the app:


```
$ mix deps.get
$ mix compile

```

## Usage
To print out the Erlang string (a.k.a binary), launch `iex` and
call `UnicodeExplorer.print\1`

```
$ iex -S mix

iex(1)> UnicodeExplorer.print(["hello", "wörld"])

---------- ---------- 
hello      wörld      
---------- ---------- 
 0       h  0       w 
 1          1         
 1          1         
 0          1         
 1          0         
 0          1         
 0          1         
 0          1         
---------- ---------- 
 0       e  1       ö 
 1          1         
 1          0         
 0          0         
 0          0         
 1          0         
 0          1         
 1          1         
---------- ---------- 
 0       l  1         
 1          0         
 1          1         
 0          1         
 1          0         
 1          1         
 0          1         
 0          0         
---------- ---------- 
 0       l  0       r 
 1          1         
 1          1         
 0          1         
 1          0         
 1          0         
 0          1         
 0          0         
---------- ---------- 
 0       o  0       l 
 1          1         
 1          1         
 0          0         
 1          1         
 1          1         
 1          0         
 1          0         
---------- ---------- 
            0       d 
            1         
            1         
            0         
            0         
            1         
            0         
            0         
:ok
iex(2)>
```


