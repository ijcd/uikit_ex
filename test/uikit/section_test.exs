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




# use Taggart.HTML, except: [section: 2]
#
# @styles [:default, :muted, :primary, :secondary]
# @sizes [:xsmall, :small, :large, :xlarge]
# # @modifiers [:section_overlap, :preserve_color]

# def section(style, do: block) when style in @styles, do: section([style], do: block)
# def section(styles, do: block) when is_list(styles)
# do
#   classes = (["uk-section"] ++ Enum.map(styles, &"uk-section-#{&1}")) |> Enum.join(" ")
#   div(class: classes) do
#     block
#   end
# end
#
# def container(do: block) do
#   div(class: "uk-container") do
#     block
#   end
# end
# def container(:relative, do: block) do
#   div(class: "uk-container uk-position-relative") do
#     block
#   end
# end
#
# def grid(style, modifiers \\ [], do: block)
#   when style in [:match, :large]
#   when is_list(modifiers)
# do
#   classes = (["uk-grid-#{style}"] ++ modifiers) |> Enum.join(" ")
#   div(class: classes, "uk-grid": true) do
#     block
#   end
# end




# defmacro uk_section(style \\ :default, opts)
#
# defmacro uk_section(style, do: block) when is_atom(style) do
#   quote location: :keep do
#     uk_section(Style.new(unquote(style))) do
#       unquote(block)
#     end
#   end
# end
# defmacro uk_section(%Style{} = style, do: block) do
#   quote location: :keep do
#     div(class: Style.to_classes(unquote(style))) do
#       unquote(block)
#     end
#   end
# end
# defmacro uk_section(one, two) do
#   IO.inspect(one, label: "ONE AST")
#   IO.inspect(two, label: "TWO AST")
#   quote do
#     IO.inspect(unquote(one))
#     IO.inspect(unquote(two))
#   end
# end
