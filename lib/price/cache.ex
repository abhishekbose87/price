defmodule Price.Cache do

  use Agent

  @me __MODULE__

  def start_link() do
    Agent.start_link(&init/0, name: @me)
  end

  def init do
    ExCmc.API.fetch_latest_prices()
  end

  def fetch_latest_price(crypto_currency) do
    Agent.get(@me, fn(state) ->
      IO.inspect(state)
      find_price(state, crypto_currency)
    end)
  end

  def find_price(state, crypto_currency) do
    Enum.find(state, fn(price) ->
      price["symbol"] == crypto_currency
    end)["price_usd"]
  end

end
