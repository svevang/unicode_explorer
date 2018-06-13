defmodule UnicodeExplorer do
  @moduledoc """
  UnicodeExplorer is a tool for exploring strings and binaries in Elixir.
  """

  @doc """
  Print out the binary representation of a unicode string. Takes in a list of strings and prints out a matrix of binaries.

      iex(1)> UnicodeExplorer.print(["az", "bé"])

      ---------- ---------- 
      az         bé         
      ---------- ---------- 
       0       a  0       b 
       1          1         
       1          1         
       0          0         
       0          0         
       0          0         
       0          1         
       1          0         
      ---------- ---------- 
       0       z  1       é 
       1          1         
       1          0         
       1          0         
       1          0         
       0          0         
       1          1         
       0          1         
      ---------- ---------- 
                  1         
                  0         
                  1         
                  0         
                  1         
                  0         
                  0         
                  1         
      :ok
      iex(2)> 

  """
  def print(key_list) do
    key_list
    |> UnicodeExplorer.Bits.bit_matrix
    |> Enum.with_index
    |> Enum.each(fn({byte_row, byte_row_index})->

      print_byte_row_header(key_list, byte_row_index)

      byte_row
      |> Enum.zip
      |> Enum.with_index
      |> Enum.each(fn({bit_row, bit_row_index})->
        bit_row = Tuple.to_list(bit_row)
        print_bit_row_header(bit_row, bit_row_index)
        bit_row
        |> Enum.with_index
        |> Enum.each(fn({bit_value, bit_col_index})->
          print_bit(bit_value, bit_row_index, byte_row_index, Enum.fetch!(key_list, bit_col_index))
        end)
        print_bit_row_footer(bit_row, bit_row_index)

      end)
    end)
  end

  # Util for printing out a **byte** row header
  defp print_byte_row_header(key_list, byte_row_index) when byte_row_index == 0 do
    IO.write "\n"
    key_list |> Enum.each(fn(_)->
      IO.write "---------- "
    end)

    IO.write("\n")

    key_list |> Enum.each(fn(k)->
      truncated_key = String.slice(k, 0..11)
      IO.write(String.pad_trailing(truncated_key, 11, " "))
    end)

    IO.write "\n"
  end

  defp print_byte_row_header(_key_list, _bit_row_index), do: :noop

  # Print out a **bit** row header, a dashed line to separate bytes as they are printed.
  defp print_bit_row_header(bit_row, bit_row_index) when bit_row_index == 0 do
    bit_row
    |> Enum.each(fn(_i)->
      # FIXME const padding
      IO.write "---------- "
    end)
    IO.write("\n")
  end

  defp print_bit_row_header(_bit_row, _bit_row_index), do: :noop

  defp print_bit_row_footer(_key_list, _byte_row_index) do
    IO.write("\n")
  end

  defp print_bit(bit, _bit_row_index, _byte_index, _key) when bit == nil do
    # FIXME const padding
    IO.write("           ")
  end

  defp print_bit(bit, bit_row_index, byte_index, key) when bit_row_index == 0 do
    target_and_trailing_bytes = :binary.part(key, {byte_index, byte_size(key) - byte_index })
    byte_label = if String.valid?(target_and_trailing_bytes), do: String.first(target_and_trailing_bytes), else: " "
    # FIXME const padding
    IO.write " #{bit}       #{byte_label} "
  end

  defp print_bit(bit, _bit_row_index, _byte_index, _key) do
    # FIXME const padding
    IO.write " #{bit}         "
  end

end
