defmodule UIKit.ContainerTest do
  use ExUnit.Case
  use Taggart.HTML
  import UIKit.Layout.Container
  import UIKit.StyleHelpers

  test "renders default container" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_container do
          h1("heading")
          "content"
        end
      )

    assert html == "<div class=\"uk-container\"><h1>heading</h1>content</div>"
  end

  test "renders muted and xsmall container with padding" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_container(position(:relative)) do
          h1("heading")
          "content"
        end
      )

    assert html == "<div class=\"uk-container uk-position-relative\"><h1>heading</h1>content</div>"
  end
end
