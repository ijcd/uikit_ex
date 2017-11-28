defmodule UIKit.Attr do
  defstruct [
    module: nil,
    styles: [],
    boolean: false,
  ]

  # def new(), do: %__MODULE__{styles: []}
  # def new(nil), do: %__MODULE__{styles: []}
  def new(style), do: %__MODULE__{styles: [style]}

  def join(%__MODULE__{} = a, %__MODULE__{} = b) do
    %{a | styles: a.styles ++ b.styles}
  end
  def join(%__MODULE__{} = a, nil), do: a
  def join(%__MODULE__{} = a, b), do: join(a, new(b))
  def join(a, b), do: join(new(a), b)

  def build(%__MODULE__{} = attr) do
    for = attr.module
    class_seed = if(attr.boolean, do: [], else: ["uk-#{for}"])
    boolean = if(attr.boolean, do: ["uk-#{for}"], else: [])
    classes = Enum.map(attr.styles, &resolve_class(for, &1))

    joined_classes =
      case (class_seed ++ classes) do
        [] -> nil
         c -> Enum.join(c, " ")
      end

    [
      class: joined_classes,
      "#{boolean}": attr.boolean,
    ]
  end

  defp resolve_class(_for, {m, style}), do: tuple_to_class({m, style})
  defp resolve_class(for, style), do: tuple_to_class({for, style})

  # TODO: move to StyleHelpers?
  defp tuple_to_class({:width, {kind, cols, over, media}}) do
    "uk-#{kind}-width-#{cols}-#{over}@#{media}"
  end
  defp tuple_to_class({for, style}) do
    "#{style}"
    |> String.replace("_", "-")
    |> (&("uk-#{for}-#{&1}")).()
  end
end

defmodule UIKit.StyleHelpers do
  alias UIKit.Attr

  def a | b, do: Attr.join(a, b)
  def padding(sym), do: {:padding, sym}
  def position(sym), do: {:position, sym}
  def margin(sym), do: {:margin, sym}
  def flex(sym), do: {:flex, sym}
  def width(kind, cols, over, media), do: {:width, {kind, cols, over, media}}
end

defmodule UIKit.Layout.Section do
  use Taggart.HTML
  alias UIKit.Attr

  # @styles [:default, :muted, :primary, :secondary]
  # @sizes [:xsmall, :small, :large, :xlarge]

  defmacro uk_section(style \\ :default, do: block) do
    quote location: :keep do
      div(nil, (%Attr{module: :section} | unquote(style)) |> Attr.build()) do
        unquote(block)
      end
    end
  end
end

defmodule UIKit.Layout.Container do
  use Taggart.HTML
  alias UIKit.Attr

  defmacro uk_container(style \\ nil, do: block) do
    quote location: :keep do
      div(nil, (%Attr{module: :container} | unquote(style)) |> Attr.build()) do
        unquote(block)
      end
    end
  end
end

defmodule UIKit.Layout.Grid do
  use Taggart.HTML
  alias UIKit.Attr

  defmacro uk_grid(style \\ nil, do: block) do
    quote location: :keep do
      div(nil, (%Attr{module: :grid, boolean: true} | unquote(style)) |> Attr.build()) do
        unquote(block)
      end
    end
  end
end
