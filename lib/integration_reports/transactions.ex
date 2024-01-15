defmodule IntegrationReports.Transactions do
  @moduledoc false

  import Ecto.Query

  alias IntegrationReports.Repo
  alias IntegrationReports.Transaction.OrderExecutions

  def list_order_executions() do
    OrderExecutions
    |> Repo.all()
  end

  def list_order_executions_flop(params) do
    case Flop.validate_and_run(OrderExecutions, params, for: OrderExecutions) do
      {:ok, {orders, meta}} ->
        %{orders: orders, meta: meta}

      {:error, meta} ->
        %{orders: [], meta: meta}
    end
  end

  def list_pending_company_orders() do
    pending_company_orders_query()
    |> Repo.all()
  end

  def list_pending_company_orders(options) when is_map(options) do
    pending_company_orders_query()
    |> sort(options)
    |> Repo.all()
  end

  def pending_company_orders_query() do
    from toe in OrderExecutions,
      join: torder in "TRANSACTION_ORDER",
      on: torder.id == toe.transaction_order_id,
      join: sd in "STATUS_DOMAIN",
      on: sd.id == torder.status_id,
      join: c in "CAMPAIGN",
      on: c.id == torder.campaign_id,
      join: f in "FLAG",
      on: f.id == c.flag_id,
      join: p in "PARTNER",
      on: p.id == torder.partner_id,
      where: sd.description == ^"ERRO_CRIAR_company",
      select: %{
        bandeira: f.name,
        pedido_integration_report: type(torder.id, :binary_id),
        pedido_parceiro: torder.partner_order_id,
        parceiro: p.name,
        msg: toe.msg,
        created_at: torder.created_at
      }
  end

  defp sort(query, %{sort_by: sort_by, sort_order: sort_order}) do
    order_exp = {sort_order, sort_by}
    order_by(query, ^order_exp)
  end

  defp sort(query, _options), do: query

  defp paginate(query, %{page: page, per_page: per_page}) do
    offset = max((page - 1) * per_page, 0)

    query
    |> limit(^per_page)
    |> offset(^offset)
  end

  defp paginate(query, _options), do: query

  def order_executions_query() do
    from(o in OrderExecutions)
  end
end
