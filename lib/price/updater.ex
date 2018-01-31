require Logger
defmodule Price.Updater do
  use Task

  def start_link() do
    Logger.info "Process #{inspect(self())} Price.Updater started"
    Task.start_link(&poll/0)
  end

  def poll() do
    receive do
    after
      5 * 60_000 ->
        spawn_link(&update_price/0)
        poll()
    end
  end

  defp update_price() do
    Price.Cache.update
    Logger.info "Process #{inspect(self())} helping go to the moon!"
  end
end
