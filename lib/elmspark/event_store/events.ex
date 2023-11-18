defmodule Elmspark.EventStore.Events do
  alias Elmspark.EventStore.Event

  def new(%{aggregate_id: aggregate_id, name: name, data: data}, to_time \\ &DateTime.utc_now/0) do
    {:ok, %Event{
      aggregate_id: aggregate_id,
      name: name,
      data: data,
      inserted_at: to_time.()
    }}
  end
end
