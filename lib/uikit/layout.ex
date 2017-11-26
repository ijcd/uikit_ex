defmodule UIKit.Style do
  defstruct [
    styles: []
  ]

  def new(style \\ [])
  def new(style), do: %__MODULE__{styles: [style]}

  def to_classes(for, style) do
    classes =
      style.styles
      |> Enum.map(fn
        {for, style} -> tuple_to_class({for, style})
        style -> tuple_to_class({for, style})
      end)
    (["uk-#{for}"] ++ classes) |> Enum.join(" ")
  end
  defp tuple_to_class({for, style}) do
    "#{style}"
    |> String.replace("_", "-")
    |> (&("uk-#{for}-#{&1}")).()
  end

  def join(%__MODULE__{} = a, %__MODULE__{} = b) do
    %{a | styles: a.styles ++ b.styles}
  end
  def join(%__MODULE__{} = a, b), do: join(a, new(b))
  def join(a, b), do: join(new(a), b)
end

defmodule UIKit.Layout.Section do
  use Taggart.HTML
  alias UIKit.Style

  def a | b, do: Style.join(a, b)

  def padding(sym), do: {:padding, sym}

  defmacro uk_section(do: block) do
    quote location: :keep do
      uk_section(:default) do
        unquote(block)
      end
    end
  end

  defmacro uk_section(style, do: block) when is_atom(style) do
    quote location: :keep do
      uk_section(Style.new(unquote(style))) do
        unquote(block)
      end
    end
  end

  defmacro uk_section(style, do: block) do
    quote location: :keep do
      div(class: Style.to_classes(:section, unquote(style))) do
        unquote(block)
      end
    end
  end
end


# defmodule UIKit.Inverse do
#   def light do
#     :light
#   end
#
#   def dark do
#     :dark
#   end
# end
#
# defmodule UIKit.Padding do
#   def remove_vertical do
#     :remove_vertical
#   end
# end
#
# defmodule UIKit.Layout do
#   use Taggart.HTML, except: [section: 2]
#
#   @styles [:default, :muted, :primary, :secondary]
#   @sizes [:xsmall, :small, :large, :xlarge]
#   # @modifiers [:section_overlap, :preserve_color]
#
#   def section(style, do: block) when style in @styles, do: section([style], do: block)
#   def section(styles, do: block) when is_list(styles)
#   do
#     classes = (["uk-section"] ++ Enum.map(styles, &"uk-section-#{&1}")) |> Enum.join(" ")
#     div(class: classes) do
#       block
#     end
#   end
#
#   def container(do: block) do
#     div(class: "uk-container") do
#       block
#     end
#   end
#   def container(:relative, do: block) do
#     div(class: "uk-container uk-position-relative") do
#       block
#     end
#   end
#
#   def grid(style, modifiers \\ [], do: block)
#     when style in [:match, :large]
#     when is_list(modifiers)
#   do
#     classes = (["uk-grid-#{style}"] ++ modifiers) |> Enum.join(" ")
#     div(class: classes, "uk-grid": true) do
#       block
#     end
#   end
# end
