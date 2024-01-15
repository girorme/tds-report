defmodule IntegrationReports.Transaction.StatusDomain do
  @moduledoc false

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "STATUS_DOMAIN" do
    field :description, :string
    field :created_at, :naive_datetime
    has_many :order, IntegrationReports.Transaction.Order, foreign_key: :status_id
  end
end
