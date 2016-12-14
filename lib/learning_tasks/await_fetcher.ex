defmodule LearningTasks.AwaitFetcher do
  def fetch(artist_names) do
    artist_names
    |> Enum.map(fn(artist_name) ->
      Task.async(fn() ->
        LearningTasks.ArtistFinder.find(artist_name)
      end)
    end)
    |> Enum.map(&(Task.await(&1)))
  end
end
