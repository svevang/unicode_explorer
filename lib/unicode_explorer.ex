defmodule UnicodeExplorer do
  @moduledoc """
  Documentation for UnicodeExplorer.
  """

  def max_bitlength(keys) do
    # find the length in bits of the longest string
    (
      keys
      |> Enum.map(fn(s)-> byte_size(s) end)
      |> Enum.max
    ) * 8
  end

  @doc """
  Print out the binary representation of a unicode string.
  """
  def print(key_list, index \\ 0, longest_bitlength \\ nil) do

    longest_bitlength = longest_bitlength || max_bitlength(key_list)

    # print a header
    if index == 0 do
      IO.write "\n"
      Enum.each(key_list, fn(k)-> IO.puts(k) end)
    end

    # base case: we're finished recursing
    if longest_bitlength == index do
      :ok
    else
      curr_byte_index = Kernel.div(index, 8)

      # print row header
      if Kernel.rem(index, 8) == 0 do
        key_list
        |> Enum.each(fn(i)->
            IO.write "--------"
        end) 
        IO.write("\n")
      end


      # print the next byte from each binary
      Enum.each(key_list, fn(key) ->
        if byte_size(key) >= curr_byte_index + 1 do

          # carve off the previous bytes we're not interested in, setting our target byte
          byte_offset_in_bits = curr_byte_index * 8
          <<_leading::size(byte_offset_in_bits), target_byte::size(8), _rest::binary>> = key

          # do the same with the leading bits or our target byte
          leading_bits = index - (8 * curr_byte_index)
          rest_bit_size = 8 - (leading_bits + 1)
          <<_leading::size(leading_bits), target_bit::size(1), _rest::size(rest_bit_size)>> = <<target_byte>>

          # try printing out a char for the current byte, TODO works only with ascii
          <<_leading::size(byte_offset_in_bits), target_and_trailing_bytes::binary>> = key
          byte_label = if rest_bit_size == 7 && String.valid?(target_and_trailing_bytes), do: String.first(target_and_trailing_bytes), else: " "

          IO.write " #{target_bit} #{byte_label}    "
        else
          IO.write "        "
        end
      end)

      IO.write("\n")

      print(key_list, index + 1, longest_bitlength)
    end
  end
end
