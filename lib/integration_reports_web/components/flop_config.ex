defmodule IntegrationReportsWeb.FlopConfig do
  @moduledoc false

  def pagination_opts do
    [
      page_links: :hide,
      wrapper_attrs: [
        class: "text-center mt-4 mb-5"
      ],
      previous_link_content: Phoenix.HTML.raw("← Previous"),
      previous_link_attrs: [
        class: "p-2 mr-2 border rounded border-slate-500"
      ],
      next_link_content: Phoenix.HTML.raw("Next →"),
      next_link_attrs: [
        class: "p-2 ml-2 border rounded border-slate-500"
      ]
    ]
  end
end
