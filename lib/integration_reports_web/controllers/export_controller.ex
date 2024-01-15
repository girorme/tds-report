defmodule IntegrationReportsWeb.ExportController do
  use IntegrationReportsWeb, :controller

  alias IntegrationReports.Transactions

  def create(conn, _params) do
    fields = [:bandeira, :pedido_integration_report, :parceiro, :pedido_parceiro, :msg]
    csv_data = csv_content(Transactions.list_pending_company_orders(), fields)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"pedidos-pend-integração.csv\""
    )
    |> put_root_layout(false)
    |> send_resp(200, csv_data)
  end

  defp csv_content(records, fields) do
    records
    |> Enum.map(fn record ->
      record
      # gives an empty map
      |> Map.take([])
      |> Map.merge(Map.take(record, fields))
      |> Map.values()
    end)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
