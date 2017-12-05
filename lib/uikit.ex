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
      defdelegate uk_style(style), to: UIKit
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

      iex> uk_style(width(:auto) | position(:bottom))
      [class: "uk-width-auto uk-position-bottom"]

  """
  def uk_style(attr) do
    attr
    |> AttrBuilder.new()
    |> AttrBuilder.build()
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
      use Taggart.HTML

      defmacro unquote(:"uk_#{name}")(style \\ nil, do: block) do
        name = unquote(name)
        tag = unquote(tag)
        seed = unquote(seed)
        attr = unquote(attr)

        quote location: :keep do
          name = unquote(name)
          tag = unquote(tag)
          seed = unquote(seed)
          attr = unquote(attr)

          attr0 = AttrBuilder.new(name, seed: seed, attr: attr)

          unquote(tag)(nil, AttrBuilder.build(attr0 | unquote(style))) do
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
    quote location: :keep do
      def unquote(name)(style \\ nil) do
        AttrBuilder.new(unquote(name), styles: [style], attr: unquote(opts[:attr]))
      end
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
