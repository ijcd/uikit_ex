defmodule UIKit do
  alias UIKit.Attributes
  import UIKit.Variadic

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
      import UIKit
    end
  end

  @doc """
  Used to insert a custom class.
  or Taggart.

  ## Examples

      [class("my-special-class"), position(:bottom)]

  """
  defmacro class(attrs) when is_list(attrs) do
    quote location: :keep do
      Enum.map(unquote(attrs), &attr(class: &1))
    end    
  end

  # make variadic versions
  for n <- 1..10, do: make_variadic_class(:class, n)

  @doc """
  Allows the insertion of custom attributes.

  ## Examples

      attr(id: "the-id", href="#")

  """
  defmacro attr(), do: nil
  defmacro attr(attrs) when is_list(attrs) do
    quote location: :keep do
      Enum.map(unquote(attrs), &Attributes.RawAttribute.new(&1))
    end
  end

  @doc """
  Renders a tag without the need for defstyle or defcomponent
  or Taggart.

  ## Examples

      uk(:img, animation(:kenburns), transform_origin(:center_right), attr(src: "/images/dark.jpg", alt: "")))

  """
  defmacro uk(tag, styles, do: block) when is_list(styles) do
    quote location: :keep do
      tag = unquote(tag)
      styles = unquote(styles)

      attributes = Attributes.build(
        Attributes.TagContext.new(nil, seed: false),
        styles
      )     

      Taggart.HTML.unquote(tag)(nil, attributes, do: unquote(block))
    end
  end

  # make variadic versions
  for n <- 1..10, do: make_variadic_uk_block(:uk, n)

  defmacro uk(tag, styles) when is_list(styles) do
    quote location: :keep, generated: true do
      tag = unquote(tag)
      styles = unquote(styles)

      attributes = Attributes.build(
        Attributes.TagContext.new(nil, seed: false),
        styles
      )       

      case tag do
        t when t in [:area, :base, :br, :col, :command, :embed, :hr, :img, :input, :keygen, :link, :menuitem, :meta, :param, :source, :track, :wbr] ->
          Taggart.HTML.unquote(tag)(attributes)
        _ -> 
          Taggart.HTML.unquote(tag)(nil, attributes, do: "")
      end
    end
  end

  # make variadic versions
  for n <- 1..10, do: make_variadic_uk(:uk, n)


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

      defmacro unquote(:"uk_#{name}")(styles \\ [], block)

      # TODO: check for allowed styles and component_options (maybe only in dev?)
      defmacro unquote(:"uk_#{name}")(styles, do: block) when is_list(styles) do
        name = unquote(name)
        tag = unquote(tag)
        seed = unquote(seed)
        attr = unquote(attr)

        quote location: :keep do
          name = unquote(name)
          tag = unquote(tag)
          seed = unquote(seed)
          attr = unquote(attr)

          attributes = Attributes.build(
            Attributes.TagContext.new(name, seed: seed, attr: attr),
            unquote(styles)
          )

          Taggart.HTML.unquote(tag)(nil, attributes) do
            unquote(block)
          end
        end
      end

      # make variadic versions
      for n <- 1..10, do: make_variadic_component(:"uk_#{name}", n)
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

      defmacro unquote(name)(styles \\ [])

      # TODO: check for allowed styles and component_options (maybe only in dev?)
      defmacro unquote(name)(styles) when is_list(styles) do
        name = unquote(name)
        seed = unquote(seed)
        attr = unquote(attr)

        quote location: :keep do
          name = unquote(name)
          styles = unquote(styles)
          seed = unquote(seed)
          attr = unquote(attr)

          Attributes.ComponentClass.new(name, styles, seed: seed, attr: attr)
        end
      end

      # make variadic versions
      for n <- 1..10, do: make_variadic_style(name, n)
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