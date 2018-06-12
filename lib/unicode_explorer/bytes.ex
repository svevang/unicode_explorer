defmodule UnicodeExplorer.Bytes do

  @moduledoc """
  Tools for manipulating byte matrix representations in Elixir.
  """

  @doc """
  Given a list of binaries, create a 2D matrix of bytes padded with nils
  represented as a nested list.
  iex(1)> s = ["aa", "bbb", "cccc", "ddd", "ee", "f"]
  ["aa", "bbb", "cccc", "ddd", "ee", "f"]
  iex(2)> UnicodeExplorer.byte_matrix(s)
  [
      'abcdef',
      [97, 98, 99, 100, 101, nil],
      [nil, 98, 99, 100, nil, nil],
      [nil, nil, 99, nil, nil, nil]
  ]
  """
  def byte_matrix(key_list, acc \\ []) do
    {bytes, remaning_keys} = Enum.unzip(key_list
    |> Enum.map(fn(key)->
      case byte_size(key) do
        0 -> {nil, key}
        _ ->
          <<byte::size(8), rest::binary>> = key
          {byte, rest}
      end
    end))
  
    # As long as we are recursing on at least one string, keep going.
    case Enum.any?(bytes) do
      true -> byte_matrix(remaning_keys, [bytes | acc])
      false -> Enum.reverse(acc)
    end
  end

end
