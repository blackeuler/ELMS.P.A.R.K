defmodule Elmspark.EventStore.Event do
  defstruct [:aggregate_id, :name, :data, :inserted_at]
end
