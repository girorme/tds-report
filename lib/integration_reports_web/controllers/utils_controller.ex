defmodule IntegrationReportsWeb.UtilsController do
  @moduledoc false
  use IntegrationReportsWeb, :controller

  def health_check(conn, _params) do
    conn
    |> json(%{healthy: true})
  end
end
