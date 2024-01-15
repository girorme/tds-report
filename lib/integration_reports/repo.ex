defmodule IntegrationReports.Repo do
  use Ecto.Repo,
    otp_app: :integration_reports,
    adapter: Ecto.Adapters.Tds
end
