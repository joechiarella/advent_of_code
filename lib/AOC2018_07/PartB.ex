defmodule AOC2018_07.PartB do
  alias AOC2018_07.Helpers

  defmodule State do
    defstruct time: 0, free_workers: 0, busy_workers: [], completed: [], remaining: [], offset: 0
  end

  defmodule Worker do
    defstruct working_on: ?0, remaining: 0
  end

  def solve(file, workers, offset) do
    parsed = Helpers.parse(file)

    initial_state = %State{time: 0, free_workers: workers, remaining: parsed, offset: offset}

    tick(initial_state)
  end

  def tick(%State{time: time, remaining: [], busy_workers: []}), do: time

  def tick(%State{free_workers: 0} = state) do
    # IO.puts "No free workers"
    tock(state)
  end

  def tick(state) do
    next = get_ready(state)

    case next do
      :none -> tock(state)
      step -> begin(state, step)
    end
  end

  def begin(%State{remaining: remaining, free_workers: free_workers, busy_workers: workers} = state, step) do
    remaining = Enum.reject(remaining, &(&1 == step))

    workers = [ create_worker(step, state.offset) | workers]

    new_state = %State{state | remaining: remaining, free_workers: free_workers - 1, busy_workers: workers}
    tick(new_state)
  end

  def create_worker({step, _}, offset) do
    # IO.puts "Creating worker for step #{step}"
    %Worker{working_on: step, remaining: step - ?@ + offset}
  end

  def get_ready(%State{remaining: remaining, completed: completed}) do
    ready = remaining
    |> Enum.find(:none, &(can_start(&1, completed)))

    # IO.puts "Ready to begin: #{inspect ready}"
    ready
  end

  def can_start({_, prereqs}, completed) do
    prereqs
    |> Enum.all?(fn done -> done in completed end)
  end

  #increment time by 1, then tick
  def tock(%State{} = state) do
    # IO.puts "TOCK #{state.time}"
    done_workers = tock(state.busy_workers)
    remaining_workers = state.busy_workers -- done_workers
    |> Enum.map(fn worker ->
      %Worker{worker | remaining: worker.remaining - 1}
    end)


    %State{
      state |
      time: state.time + 1,
      free_workers: state.free_workers + length(done_workers),
      completed: state.completed ++ Enum.map(done_workers, fn worker ->
        worker.working_on
        end),
      busy_workers: remaining_workers,
      remaining: Enum.reject(state.remaining, fn {step, _pre} ->
        Enum.any?(done_workers, fn done ->
          step == done.working_on
        end)
      end)
    }
    |> tick
  end

  # Completed
  def tock([%Worker{remaining: remaining} = worker| rest]) when remaining == 1 do
    [worker | tock(rest)]
  end

  # Working on
  def tock([_ | rest]) do
    tock(rest)
  end

  def tock([]) do
    []
  end



end



