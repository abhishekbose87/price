defmodule Price.Cache do

  use Agent

  @me __MODULE__

  def start_link() do
    Agent.start_link(&init/0, name: @me)
  end

  def init do
    %{ "BTC": 1.35 }
  end

  def fetch_latest_price(crypto_currency) do
    Agent.get(@me, fn(state) ->
      state
    end)
  end

end
