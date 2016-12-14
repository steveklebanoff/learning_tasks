defmodule LearningTasks.AsyncFetcher do
  def fetch(artist_names) do
    Enum.each(artist_names, fn(artist_name) ->
      Task.async(fn() ->
        LearningTasks.ArtistFinder.find(artist_name)
      end)
    end)
  end
end
