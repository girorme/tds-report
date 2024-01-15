defmodule IntegrationReportsWeb.ErrorJSONTest do
  use IntegrationReportsWeb.ConnCase, async: true

  test "renders 404" do
    assert IntegrationReportsWeb.ErrorJSON.render("404.json", %{}) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500" do
    assert IntegrationReportsWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
