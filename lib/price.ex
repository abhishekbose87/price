defmodule Price do
  defdelegate fetch_latest_price(crypto_currency), to: Price.Cache
end
