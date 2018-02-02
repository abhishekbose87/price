defmodule Price.Cache do

  use Agent

  @me __MODULE__

  def start_link() do
    Agent.start_link(&init/0, name: @me)
    Price.Updater.start_link()
  end

  def init do
    ExCmc.API.fetch_latest_prices()
  end

  def fetch_latest_price(crypto_currency) do
    Agent.get(@me, fn(state) ->
      find_price(state, crypto_currency)
    end)
  end

  def find_price(state, crypto_currency) do
    Enum.find(state, fn(price) ->
      price["symbol"] == crypto_currency
    end)["price_usd"]
    |> String.to_float
  end

  def update do
    Agent.update(@me, fn(state) ->
      ExCmc.API.fetch_latest_prices()
    end)
  end

end
