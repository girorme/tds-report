defmodule IntegrationReports.Transaction.Order do
  @moduledoc false

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "TRANSACTION_ORDER" do
    field :msg_id, :string
    field :partner_id, :binary_id
    field :partner_order_id, :string
    field :seller_id, :string
    field :executions, :integer
    field :type_id, :binary_id
    field :partner_status_id, :binary_id
    field :amount, :string
    field :created_at, :utc_datetime
    field :company_order_id, :string
    field :campaign_id, :binary_id

    has_many :order_execution, IntegrationReports.Transaction.OrderExecutions,
      foreign_key: :transaction_order_id

    belongs_to :status_domain, IntegrationReports.Transaction.StatusDomain,
      foreign_key: :status_id,
      type: :binary_id
  end
end
