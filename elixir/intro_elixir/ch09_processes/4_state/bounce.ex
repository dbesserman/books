defmodule Bounce do
  def report(count \\ 1) do
    # new count is a state to be preserved between calls
    new_count = receive do
      msg -> IO.puts("Received #{count}: #{msg}")
      count + 1
    end

    report(new_count)
  end
end
