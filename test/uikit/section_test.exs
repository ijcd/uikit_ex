defmodule UIKit.SectionTest do
  use ExUnit.Case
  use Taggart.HTML
  import UIKit.Layout.Section
  import UIKit.StyleHelpers

  test "renders default section" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_section do
          h1("heading")
          "content"
        end
      )

    assert html == "<div class=\"uk-section uk-section-default\"><h1>heading</h1>content</div>"
  end

  test "renders default section again" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_section(:default) do
          h1("heading")
          "content"
        end
      )

    assert html == "<div class=\"uk-section uk-section-default\"><h1>heading</h1>content</div>"
  end

  test "renders muted section" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_section(:muted) do
          h1("heading")
          "content"
        end
      )

  assert html == "<div class=\"uk-section uk-section-muted\"><h1>heading</h1>content</div>"
  end

  test "renders muted and xsmall section" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_section(:muted | :xsmall) do
          h1("heading")
          "content"
        end
      )


    assert html == "<div class=\"uk-section uk-section-muted uk-section-xsmall\"><h1>heading</h1>content</div>"
  end

  test "renders muted and xsmall section with padding" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_section(:muted | :xsmall | padding(:remove_vertical)) do
          h1("heading")
          "content"
        end
      )

    assert html == "<div class=\"uk-section uk-section-muted uk-section-xsmall uk-padding-remove-vertical\"><h1>heading</h1>content</div>"
  end

  test "renders muted and xsmall section with padding (preserving order)" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_section(:muted | padding(:remove_vertical) | :xsmall) do
          h1("heading")
          "content"
        end
      )

    assert html == "<div class=\"uk-section uk-section-muted uk-padding-remove-vertical uk-section-xsmall\"><h1>heading</h1>content</div>"
  end
end
