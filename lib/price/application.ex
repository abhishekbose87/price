defmodule Price.Application do

  use Application

  def start(_type, _args) do
    Price.Cache.start_link()
  end

end
