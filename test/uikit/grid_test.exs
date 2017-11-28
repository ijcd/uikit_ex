defmodule UIKit.GridTest do
  use ExUnit.Case
  use Taggart.HTML
  import UIKit.Layout.Grid
  import UIKit.StyleHelpers

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
        uk_grid(:match | width(:child, 1, 3, :m)) do
          h1("heading")
          "content"
        end
      )

    assert html == "<div uk-grid class=\"uk-grid-match uk-child-width-1-3@m\"><h1>heading</h1>content</div>"
  end

  #
  # test "renders muted section" do
  #   html =
  #     Phoenix.HTML.safe_to_string(
  #       uk_grid(:muted) do
  #         h1("heading")
  #         "content"
  #       end
  #     )
  #
  # assert html == "<div class=\"uk-section uk-section-muted\"><h1>heading</h1>content</div>"
  # end
  #
  # test "renders muted and xsmall section" do
  #   html =
  #     Phoenix.HTML.safe_to_string(
  #       uk_grid(:muted | :xsmall) do
  #         h1("heading")
  #         "content"
  #       end
  #     )
  #
  #
  #   assert html == "<div class=\"uk-section uk-section-muted uk-section-xsmall\"><h1>heading</h1>content</div>"
  # end
  #
  # test "renders muted and xsmall section with padding" do
  #   html =
  #     Phoenix.HTML.safe_to_string(
  #       uk_grid(:muted | :xsmall | padding(:remove_vertical)) do
  #         h1("heading")
  #         "content"
  #       end
  #     )
  #
  #   assert html == "<div class=\"uk-section uk-section-muted uk-section-xsmall uk-padding-remove-vertical\"><h1>heading</h1>content</div>"
  # end
  #
  # test "renders muted and xsmall section with padding (preserving order)" do
  #   html =
  #     Phoenix.HTML.safe_to_string(
  #       uk_grid(:muted | padding(:remove_vertical) | :xsmall) do
  #         h1("heading")
  #         "content"
  #       end
  #     )
  #
  #   assert html == "<div class=\"uk-section uk-section-muted uk-padding-remove-vertical uk-section-xsmall\"><h1>heading</h1>content</div>"
  # end
end
