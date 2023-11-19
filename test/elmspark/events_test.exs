defmodule Elmspark.EventsTest do
  use Elmspark.DataCase

  alias Elmspark.EventStore.Events
  alias Elmspark.EventStore.Event

  describe "events" do
    test "new" do
      aggregate_id = UUID.uuid4()

      event_data =
        %{
          name: "test_event",
          aggregate_id: aggregate_id,
          data: "some data"
        }

      assigned_time = "~U[2023-11-18 21:00:00.000000Z]"

      to_time = fn -> assigned_time end

      assert %Event{
               name: "test_event",
               aggregate_id: ^aggregate_id,
               data: "some data",
               inserted_at: ^assigned_time
             } = Events.new(event_data, to_time)
    end

    test "insert" do
      aggregate_id = UUID.uuid4()

      event =
        Events.new(%{
          name: "test_event",
          aggregate_id: aggregate_id,
          data: "some data"
        })

      Events.insert(event)

      [stored_event] = Events.get_all()

      assert stored_event == event
    end

    test "filter" do
      aggregate_id = UUID.uuid4()
      other_aggregate_id = UUID.uuid4()

      event_a = Events.new(%{
        name: "test_event",
        aggregate_id: aggregate_id,
        data: "some data"
      })

      event_b = Events.new(%{
        name: "test_event",
        aggregate_id: aggregate_id,
        data: "moar data"
      })

      other_aggregate_event = Events.new(%{
        name: "test_event",
        aggregate_id: other_aggregate_id,
        data: "some other aggregate data"
      })

      Events.insert_many([event_a, event_b, other_aggregate_event])

      assert [^event_a, ^event_b] = Events.filter(& &1.aggregate_id == aggregate_id)
    end
  end
end
