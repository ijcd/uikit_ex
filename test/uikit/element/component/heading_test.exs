defmodule UIKit.HeadingTest do
  use ExUnit.Case
  use Taggart.HTML
  use UIKit

  test "renders default heading" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_heading do
          "content"
        end
      )

    assert html == "<h1>content</h1>"
  end

  test "renders default heading with param" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_heading(:primary) do
          "content"
        end
      )

    assert html == "<h1 class=\"uk-heading-primary\">content</h1>"
  end

  test "renders default heading with param and modifiers" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_heading(:primary | text(:center)) do
          "content"
        end
      )

    assert html == "<h1 class=\"uk-heading-primary uk-text-center\">content</h1>"
  end
end
