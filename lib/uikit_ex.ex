defmodule UIKit.Component do
  use Taggart.HTML

  defmodule Attr do
    defstruct [
      name: nil,
      styles: [],
      seed: true,
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
      for = attr.name
      class_seed = if(attr.boolean || !attr.seed, do: [], else: ["uk-#{for}"])
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

  def a | b, do: Attr.join(a, b)

  defmacro defcomponent(name, opts \\ []) do
    quote location: :keep, bind_quoted: [
      name: name,
      tag: Keyword.get(opts, :tag, :div),
      default_style: Keyword.get(opts, :default_style),
      seed: Keyword.get(opts, :seed, true),
      boolean: Keyword.get(opts, :boolean, false),
    ] do
      defmacro unquote(:"uk_#{name}")(style \\ unquote(default_style), do: block) do
        name = unquote(name)
        tag = unquote(tag)
        seed = unquote(seed)
        boolean = unquote(boolean)

        quote location: :keep do
          name = unquote(name)
          tag = unquote(tag)
          seed = unquote(seed)
          boolean = unquote(boolean)

          attr0 = %Attr{
            name: name,
            seed: seed,
            boolean: boolean
          }

          unquote(tag)(nil, Attr.build(attr0 | unquote(style))) do
            unquote(block)
          end
        end
      end
    end
  end
end

defmodule UIKit.Layout do
  import UIKit.Component

  defcomponent :section, default_style: :default
  defcomponent :container
  defcomponent :grid, boolean: true
  defcomponent :heading, tag: :h1, seed: false
  defcomponent :width, seed: false
  defcomponent :text, tag: :p, seed: false
end

defmodule UIKit.Styles do
  def padding(sym), do: {:padding, sym}
  def position(sym), do: {:position, sym}
  def margin(sym), do: {:margin, sym}
  def flex(sym), do: {:flex, sym}
  def text(sym), do: {:text, sym}
  def width(kind, cols, over, media), do: {:width, {kind, cols, over, media}}
end

defmodule UIKit do
  defmacro __using__(_opts) do
    quote do
      import UIKit.Layout
      import UIKit.Styles
      defdelegate a | b, to: UIKit.Component
    end
  end
end
