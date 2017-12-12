defmodule UIKit.TextTest do
  use ExUnit.Case
  use Taggart.HTML, except: [table: 2]
  use UIKit

  test "renders default text with param" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_text(:large) do
          "content"
        end
      )

    assert html == "<p class=\"uk-text-large\">content</p>"
  end

  test "renders default text with params" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_text(:large, :center) do
          "content"
        end
      )

    assert html == "<p class=\"uk-text-large uk-text-center\">content</p>"
  end
end
