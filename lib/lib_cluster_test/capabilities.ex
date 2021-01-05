defmodule LibClusterTest.Capabilities do
  use GenServer
  require Logger

  def say_hey() do
    GenServer.call({:via, Horde.Registry, {LibClusterTest.Registry, __MODULE__}}, :hey)
  end

  def start_link(_) do
    case GenServer.start_link(__MODULE__, [],
           name: {:via, Horde.Registry, {LibClusterTest.Registry, __MODULE__}}
         ) do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        Logger.info("Already started at #{inspect(pid)}")
        :ignore
    end
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call(:hey, _from, state) do
    {:reply, {:hey, self()}, state}
  end
end
