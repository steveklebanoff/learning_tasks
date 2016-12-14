defmodule LearningTasks.SupervisedFetcher do

  def fetch(artist_names) do
    # NEW CODE: creating supervisor
    {:ok, supervisor_pid} = Task.Supervisor.start_link()

    references = Map.new(artist_names, fn(artist_name) ->
      # NEW CODE: use Task.Supervisor.async_nolink
      async_task = Task.Supervisor.async_nolink(
        supervisor_pid,
        fn() -> LearningTasks.ArtistFinder.find(artist_name) end
      )
      { async_task.ref, true }
    end)

    receive_messages(references)
  end

  defp receive_messages(pending_references, result \\ []) do
    receive do
      {ref, {:ok, spotify_uri}} ->
        process_message(
          Map.delete(pending_references, ref), # new references, removed one processed
          [spotify_uri | result] # new result with appended spotify_uri
        )
      # NEW CODE
      {:DOWN, ref, _, _, down_state} ->
        if down_state == :normal do
          process_message(pending_references, result)
        else
          process_message(
            Map.delete(pending_references, ref), # new references, removed one processed
            ["error" | result] # new result with appended spotify_uri
          )
        end
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
