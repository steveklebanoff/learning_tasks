defmodule LearningTasks.ReceiveFetcher do

  def fetch(artist_names) do
    # Create a map that contains all of the references
    # of the tasks we kicked off
    references = Map.new(artist_names, fn(artist_name) ->
      async_task = Task.async(
        fn() -> LearningTasks.ArtistFinder.find(artist_name) end
      )
      { async_task.ref, true }
    end)

    # Begin receiving messages
    receive_messages(references)
  end

  defp receive_messages(pending_references, result \\ []) do
    receive do
      {ref, {:ok, spotify_uri}} ->
        process_message(
          Map.delete(pending_references, ref), # new references, removed one processed
          [spotify_uri | result] # new result with appended spotify_uri
        )
    end
  end

  defp process_message(references, result) when references == %{} do
    # done processing
    result
  end

  defp process_message(references, result) do
    # continue processing
    receive_messages(references, result)
  end
end
