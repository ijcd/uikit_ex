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
      import UIKit, only: [uk: 2, uk: 3]
      
      defdelegate a | b, to: UIKit
      defdelegate uk_class(style), to: UIKit
      defdelegate attr(attrs), to: UIKit
      defdelegate class(c), to: UIKit
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

      iex> uk_class(width(:auto) | position(:bottom))
      [class: "uk-width-auto uk-position-bottom"]

  """
  def uk_class(), do: ""
  def uk_class(attr) do
    attr
    |> AttrBuilder.build()
    |> Keyword.get(:class)
  end

  @doc """
  Used to insert a custom class.
  or Taggart.

  ## Examples

      class("my-special-class") | position(:bottom))

  """
  def class(attr) do
    AttrBuilder.new("", styles: [attr])
  end

  @doc """
  Allows the insertion of custom attributes.

  ## Examples

      attr(id: "the-id", href="#")

  """
  def attr(), do: nil
  def attr(attrs) when is_list(attrs) do
    attrs
    |> Enum.map(fn (a) -> AttrBuilder.new("", attr: a) end)
    |> Enum.reduce(fn(a, acc) -> AttrBuilder.join(acc, a) end)
  end

  @doc """
  Renders a tag without the need for defstyle or defcomponent
  or Taggart.

  ## Examples

      uk(:img, animation(:kenburns) | transform_origin(:center_right) | attr(src: "/images/dark.jpg", alt: "")))

  """
  defmacro uk(tag, style) do
    quote location: :keep, generated: true do
      tag = unquote(tag)
      case tag do
        t when t in [:area, :base, :br, :col, :command, :embed, :hr, :img, :input, :keygen, :link, :menuitem, :meta, :param, :source, :track, :wbr] ->
          Taggart.HTML.unquote(tag)(AttrBuilder.build(unquote(style)))
        _ -> 
          Taggart.HTML.unquote(tag)(nil, AttrBuilder.build(unquote(style)), do: "")
      end
    end
  end

  defmacro uk(tag, style, do: block) do
    quote location: :keep do
      Taggart.HTML.unquote(tag)(nil, AttrBuilder.build(unquote(style))) do
        unquote(block)
      end
    end
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

      # TODO: check for allowed styles and component_options (maybe only in dev?)
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

      def unquote(name)(styles \\ [])

      # TODO: check for allowed styles and component_options (maybe only in dev?)
      def unquote(name)(styles) when is_list(styles) do
        name = unquote(name)
        seed = unquote(seed)
        attr = unquote(attr)

        case styles do
          [{k, v} | _] ->
            attr =
              styles
              |> Enum.map(fn {k, v} -> "#{AttrBuilder.dasherize(k)}: #{v}" end)
              |> Enum.join("; ")

            AttrBuilder.new(name, seed: seed, styles: [], attr: attr)
          [] -> 
            AttrBuilder.new(name, seed: true, styles: styles, attr: attr)
          _ ->
            AttrBuilder.new(name, seed: seed, styles: styles, attr: attr)
        end
      end

      def unquote(name)(s1), do:  unquote(name)([s1])
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