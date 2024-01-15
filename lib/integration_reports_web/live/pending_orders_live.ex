defmodule IntegrationReportsWeb.PendingOrdersLive do
  use IntegrationReportsWeb, :live_view

  alias IntegrationReports.Transactions

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    validate_per_page = fn per_page ->
      case per_page do
        "todos" ->
          nil

        _ ->
          String.to_integer(per_page)
      end
    end

    sort_by = (params["sort_by"] || "created_at") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    per_page = (params["per_page"] || "5") |> validate_per_page.()
    page = (params["page"] || "1") |> String.to_integer()

    options = %{
      sort_by: sort_by,
      sort_order: sort_order,
      per_page: per_page,
      page: page
    }

    pending_orders = Transactions.list_pending_company_orders(options)
    total_pending_orders = length(Transactions.list_pending_company_orders())

    {:noreply,
     assign(
       socket,
       pending_orders: pending_orders,
       options: options,
       qty: total_pending_orders
     )}
  end

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    params = %{socket.assigns.options | per_page: per_page}
    socket = push_patch(socket, to: ~p"/pending-orders?#{params}")

    {:noreply, socket}
  end

  def sort_link(assigns) do
    ~H"""
    <.link patch={
      ~p"/pending-orders?#{%{sort_by: @sort_by, sort_order: next_sort_order(@options.sort_order)}}"
    }>
      <%= render_slot(@inner_block) %>
      <%= sort_indicator(@sort_by, @options) %>
    </.link>
    """
  end

  defp next_sort_order(sort_order) do
    case sort_order do
      :asc -> :desc
      :desc -> :asc
    end
  end

  defp sort_indicator(column, %{sort_by: sort_by, sort_order: sort_order})
       when column == sort_by do
    case sort_order do
      :asc -> "👆"
      :desc -> "👇"
    end
  end

  defp sort_indicator(_, _), do: ""
end
