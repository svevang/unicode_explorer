defmodule UnicodeExplorer.Bits do
  @moduledoc """
  A collection of utils for dealing with bits.
  """

  @doc """
  Given a byte, return a list of bits.

  Example:
  iex(1)> UnicodeExplorer.Bits.extract_bits(97)
  [0, 1, 1, 0, 0, 0, 0, 1]
  """
  def extract_bits(byte, acc \\ [])

  def extract_bits(byte, _acc) when byte == nil do
    Enum.map(1..8, fn(_)-> nil end)
  end

  # done recursing
  def extract_bits(byte, acc) when byte_size(byte) == 0 do
    Enum.reverse(acc)
  end

  # in case we are passed an integer
  def extract_bits(byte, acc) when is_bitstring(byte) == false do
    extract_bits(<<byte::size(8)>>, acc)
  end

  def extract_bits(byte, acc) do
    <<target_bit::size(1), rest::bitstring>> = byte
    extract_bits(rest, [target_bit | acc])
  end

  @doc """
  Given a list of binaries, create a 3D matrix of bytes padded with nils
  represented as a nested list.
  """
  def bit_matrix(key_list) do
    key_list
    |> UnicodeExplorer.Bytes.byte_matrix
    |> Enum.map(fn(byte_column)->
      byte_column
      |> Enum.map(fn(byte)-> 
        UnicodeExplorer.Bits.extract_bits(byte)
      end)
    end)
  end
end
