defmodule UIKit do
  alias UIKit.AttrBuilder

  @moduledoc """
  Core UIKit wrapping code.
  """

  @doc """
  Used to bring UIKit functionality into your view module.

  ## Examples

    use UIKit

  """
  defmacro __using__(_opts) do
    quote do
      import UIKit.Element.Behavior
      import UIKit.Element.Component
      import UIKit.Element.Layout
      import UIKit.Element.Navigation
      import UIKit.Element.Style
      defdelegate a | b, to: UIKit
      defdelegate uk_classes(style), to: UIKit
    end
  end

  @doc """
  Combines to styles.

  ## Examples

      iex> width(:auto) | position(:bottom)
      %Style{...}

  """
  def a | b, do: AttrBuilder.join(a, b)

  @doc """
  Useful for embedding UIKit styles into other libraries, such as Phoenix.HTML
  or Taggart.

  ## Examples

      iex> uk_classes(width(:auto) | position(:bottom))
      [class: "uk-width-auto uk-position-bottom"]

  """
  def uk_classes(attr) do
    attr
    |> AttrBuilder.build()
    |> Keyword.get(:class)
  end

  @doc """
  Defines a new UIKit component.

  ## Examples

      iex> defcomponent :section, tag: :span

  """
  defmacro defcomponent(name, opts \\ []) do
    quote location: :keep, bind_quoted: [
      name: name,
      tag: Keyword.get(opts, :tag, :div),
      seed: Keyword.get(opts, :seed, true),
      attr: Keyword.get(opts, :attr, false),
    ] do
      require Taggart.HTML

      defmacro unquote(:"uk_#{name}")(style \\ nil, opts \\ [], do: block) do
        name = unquote(name)
        tag = Keyword.get(opts, :tag, unquote(tag))
        seed = unquote(seed)
        attr = unquote(attr)

        quote location: :keep do
          name = unquote(name)
          tag = unquote(tag)
          seed = unquote(seed)
          attr = unquote(attr)

          attr0 = AttrBuilder.new(name, seed: seed, attr: attr)

          Taggart.HTML.unquote(tag)(nil, AttrBuilder.build(attr0 | unquote(style))) do
            unquote(block)
          end
        end
      end
    end
  end

  @doc """
  Defines a new UIKit style.

  ## Examples

      iex> defstyle :width, styles: [:auto, :expand]

  """
  defmacro defstyle(name, opts \\ []) do
    quote location: :keep, bind_quoted: [
      name: name,
      seed: Keyword.get(opts, :seed, false),
      attr: Keyword.get(opts, :attr, false),
    ] do
      def unquote(name)(styles \\ nil)

      def unquote(name)(styles) when is_list(styles) do
        styles
        |> Enum.map(fn s -> unquote(name)(s) end)
        |> Enum.reverse
        |> Enum.reduce(&AttrBuilder.join/2)
      end

      def unquote(name)(style) do
        AttrBuilder.new(unquote(name), seed: unquote(seed), styles: [style], attr: unquote(attr))
      end

      def unquote(name)(s1, s2), do:  unquote(name)([s1, s2])
      def unquote(name)(s1, s2, s3), do:  unquote(name)([s1, s2, s3])
      def unquote(name)(s1, s2, s3, s4, s5), do:  unquote(name)([s1, s2, s3, s4])
      def unquote(name)(s1, s2, s3, s4, s5, s6), do:  unquote(name)([s1, s2, s3, s4, s5])
      def unquote(name)(s1, s2, s3, s4, s5, s6, s7), do:  unquote(name)([s1, s2, s3, s4, s5, s6])
      def unquote(name)(s1, s2, s3, s4, s5, s6, s7, s8), do:  unquote(name)([s1, s2, s3, s4, s5, s6, s7, s8])
      def unquote(name)(s1, s2, s3, s4, s5, s6, s7, s8, s9), do:  unquote(name)([s1, s2, s3, s4, s5, s6, s7, s8, s9])
      def unquote(name)(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10), do:  unquote(name)([s1, s2, s3, s4, s5, s6, s7, s8, s9, s10])
    end
  end

  @doc """
  Defines a new UIKit boolean-type style.

  ## Examples

      iex> defboolean :scroll

  """
  defmacro defboolean(_name, _opts \\ []) do
    quote location: :keep, bind_quoted: [
    ] do
    end
  end

  @doc """
  Defines a new UIKit data attribute.

  ## Examples

      iex> defdata :caption

  """
  defmacro defdata(_name, _opts \\ []) do
    quote location: :keep, bind_quoted: [
    ] do
    end
  end
end
