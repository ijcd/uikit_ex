defmodule UIKit.Style do
  defstruct [
    styles: []
  ]

  def new(), do: %__MODULE__{styles: []}
  def new(nil), do: %__MODULE__{styles: []}
  def new(style), do: %__MODULE__{styles: [style]}

  def join(%__MODULE__{} = a, %__MODULE__{} = b) do
    %{a | styles: a.styles ++ b.styles}
  end
  def join(%__MODULE__{} = a, b), do: join(a, new(b))
  def join(a, b), do: join(new(a), b)

  def to_classes(for, %__MODULE__{styles: styles}) do
    classes =
      styles
      |> Enum.map(fn
        {f, style} -> tuple_to_class({f, style})
        style -> tuple_to_class({for, style})
      end)
    (["uk-#{for}"] ++ classes) |> Enum.join(" ")
  end
  def to_classes(for, style), do: to_classes(for, new(style))

  defp tuple_to_class({for, style}) do
    "#{style}"
    |> String.replace("_", "-")
    |> (&("uk-#{for}-#{&1}")).()
  end
end

defmodule UIKit.StyleHelpers do
  alias UIKit.Style

  def a | b, do: Style.join(a, b)
  def padding(sym), do: {:padding, sym}
  def position(sym), do: {:position, sym}
end

defmodule UIKit.Layout.Section do
  use Taggart.HTML
  alias UIKit.Style

  @styles [:default, :muted, :primary, :secondary]
  @sizes [:xsmall, :small, :large, :xlarge]

  defmacro uk_section(style \\ :default, do: block) do
    quote location: :keep do
      div(class: Style.to_classes(:section, unquote(style))) do
        unquote(block)
      end
    end
  end
end

defmodule UIKit.Layout.Container do
  use Taggart.HTML
  alias UIKit.Style

  defmacro uk_container(style \\ nil, do: block) do
    quote location: :keep do
      div(class: Style.to_classes(:container, unquote(style))) do
        unquote(block)
      end
    end
  end
end

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
