defmodule IntegrationReportsWeb.OrdersLive do
  use IntegrationReportsWeb, :live_view

  alias IntegrationReports.Transaction

  def handle_params(params, _, socket) do
    %{orders: orders, meta: meta} = Transaction.list_pending_company_orders(params)

    socket =
      socket
      |> assign(:orders, orders)
      |> assign(:meta, meta)
      |> assign(:page_title, "Orders")

    {:noreply, socket}
  end
end
