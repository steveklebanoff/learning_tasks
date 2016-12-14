defmodule LearningTasks.ArtistFinder do
  def find("Crash Artist") do
    5/0
  end

  def find(artist_name, sleep_time \\ 2) do
    IO.puts "* #{String.pad_trailing(artist_name, 20)} \t Starting task"
    :timer.sleep(sleep_time * 1000)
    IO.puts "* #{String.pad_trailing(artist_name, 20)} \t Done with task"
    {:ok, "spotify_#{artist_name}_#{sleep_time}"}
  end
end
