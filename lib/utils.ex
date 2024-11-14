defmodule Utils do
  def random_sleep do
    Process.sleep(Enum.random(1000..5000))
  end

  def chance?(percent) do
    Enum.random(1..100) <= percent
  end
end
