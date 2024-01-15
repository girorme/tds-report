defmodule IntegrationReports.Transaction.OrderHistory do
  @moduledoc false

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "TRANSACTION_ORDER_HISTORY" do
    field :source, :string
    field :transaction_order_id, :binary_id
    field :status, :string
    field :company_status, :string
    field :data, :string
    field :received_at, :utc_datetime
    field :code, :integer
    field :order_status, :string
  end
end
