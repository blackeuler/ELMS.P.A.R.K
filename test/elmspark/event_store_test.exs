defmodule Elmspark.EventStoreTest do
  use Elmspark.DataCase

  alias Elmspark.EventStore

  describe "event_store" do
    test "store_events" do
      EventStore.store_events([%{event: "test_event"}])

      assert EventStore.get_events() == [%{event: "test_event"}]
    end
  end
end
