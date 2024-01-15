defmodule IntegrationReports.Transaction.OrderExecutions do
  @moduledoc false

  use Ecto.Schema

  @derive {
    Flop.Schema,
    filterable: [:msg, :data], sortable: [:created_at, :msg], default_limit: 5
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "TRANSACTION_ORDER_EXECUTIONS" do
    field :type_id, :binary_id
    field :msg, :string
    field :data, :string
    field :created_at, :naive_datetime
    field :http_code, :integer
    field :count_exec, :integer

    belongs_to :order, IntegrationReports.Transaction.Order,
      foreign_key: :transaction_order_id,
      type: :binary_id
  end
end
