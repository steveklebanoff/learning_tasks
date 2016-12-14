defmodule LearningTasks.ForEachFetcher do
  def fetch(artist_names) do
    Enum.map(artist_names, fn(artist_name) ->
      {:ok, name} = LearningTasks.ArtistFinder.find(artist_name)
      name
    end)
  end
end
