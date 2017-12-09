defmodule UIKit.GridTest do
  use ExUnit.Case
  use Taggart.HTML, except: [table: 2]
  use UIKit

  test "renders default grid" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_grid do
          h1("heading")
          "content"
        end
      )

    assert html == "<div uk-grid><h1>heading</h1>content</div>"
  end

  test "renders default grid with param" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_grid(:match) do
          h1("heading")
          "content"
        end
      )

    assert html == "<div uk-grid class=\"uk-grid-match\"><h1>heading</h1>content</div>"
  end

  test "renders grid with child width" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_grid(:match | child_width("1-3@m")) do
          h1("heading")
          "content"
        end
      )

    assert html == "<div uk-grid class=\"uk-grid-match uk-child-width-1-3@m\"><h1>heading</h1>content</div>"
  end
end
