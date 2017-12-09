defmodule UIKit.WidthTest do
  use ExUnit.Case
  use Taggart.HTML, except: [table: 2]
  use UIKit

  test "renders default width with param" do
    html =
      Phoenix.HTML.safe_to_string(
        uk_width(:expand) do
          "content"
        end
      )

    assert html == "<div class=\"uk-width-expand\">content</div>"
  end
end
