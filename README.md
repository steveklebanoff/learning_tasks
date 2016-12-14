# Learning Tasks

Elixir Task demos for the 12/15/2016 [San Diego Elixir/Erlang meetup](https://www.meetup.com/San-Diego-Elixir-Erlang/events/235317088/).

See accompanying [slides](https://docs.google.com/presentation/d/1g8CLIzrk1c8uVmFhiFLjyK0CZwzLgSC1gIZwMK9asVY/edit?usp=sharing).

## Tasks

[Tasks](http://elixir-lang.org/docs/v1.0/elixir/Task.html) are processes meant to execute one particular action throughout their life-cycle, often with little or no communication with other processes. The most common use case for tasks is to compute a value asynchronously.

For the purpose of this exercise, we're going to explore a few different functions of the Task module.  We're not going to worry about tail call optimization for now.

## Using this project

To autoload modules in console, run `iex -S mix`

#### ArtistFinder

This is file that simulates finding a spotify artist id.

#### ForEachFetcher

This simulates how we do things now.  Does one at a time.

`LearningTasks.ForEachFetcher.fetch(artist_names)`

#### Task.async

Allows us to kick off jobs to be done in another Elixir process.

#### AsyncFetcher

Kicks off jobs using Task.async.

`LearningTasks.AsyncFetcher.fetch(artist_names)`

But, how do we get the results?  Use `flush` to see messages received.

#### AwaitFetcher

Waits for results so you can return them

`LearningTasks.AwaitFetcher.fetch(artist_names)`

*What is the problem with this?*  If the second task is done before the first, we don't have a chance to do anything with the results.

#### ReceiveFetcher

Collects all results by keeping track of the references we created, and removing them as they get processed

`LearningTasks.ReceiveFetcher.fetch(artist_names)`

*What is the problem with this?* If an error occurs it will crash the whole system

> async tasks link the caller and the spawned process. This means that, if the caller crashes, the task will crash too and vice-versa. This is on purpose: if the process meant to receive the result no longer exists, there is no purpose in completing the computation.
> If this is not desired, use Task.start/1 or consider starting the task under a Task.Supervisor using async_nolink or start_child.

See: `LearningTasks.ReceiveFetcher.fetch(["Talking Heads", "Crash Artist", "Sister Nancy"])`


#### Creating a Supervised Receive Fetcher

We are going to use [Task.Supervisor.async_nolink](https://hexdocs.pm/elixir/Task.Supervisor.html#async_nolink/2) to continue even when errors are raised

See: `LearningTasks.SupervisedFetcher.fetch(["Grateful Dead", "Crash Artist", "Talking Heads"])`

## Nice to have additions:
- Run credo on all files
- Add benchmarks for each, figure out easy way to run this
- Change to &(&1) syntax where applicable
- Consider tail call optimization implications
