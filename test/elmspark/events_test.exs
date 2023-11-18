defmodule Elmspark.EventsTest do
  use Elmspark.DataCase

  alias Elmspark.EventStore.Events
  alias Elmspark.EventStore.Event

  describe "events" do
    test "new" do
      aggregate_id = UUID.uuid4()

      event_data =
        %{name: "test_event", aggregate_id: aggregate_id, data: "some data"}

      assigned_time = "~U[2023-11-18 21:00:00.000000Z]"

      to_time = fn -> assigned_time end

      assert {:ok,
              %Event{
                name: "test_event",
                aggregate_id: ^aggregate_id,
                data: "some data",
                inserted_at: ^assigned_time
              }} = Events.new(event_data, to_time)
    end
  end
end
