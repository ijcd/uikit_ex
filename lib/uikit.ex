# TODO: typecheck styles and component_options

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

      Taggart.HTML.unquote(tag)(
        nil,
        Attributes.build(Attributes.TagContext.new(nil, seed: :never), styles),
        do: unquote(block)
      )
    end
  end

  # make variadic versions
  for n <- 1..10, do: make_variadic_uk_block(:uk, n)

  defmacro uk(tag, styles) when is_list(styles) do
    quote location: :keep, generated: true do
      tag = unquote(tag)
      styles = unquote(styles)

      case tag do
        t when t in [:area, :base, :br, :col, :command, :embed, :hr, :img, :input, :keygen, :link, :menuitem, :meta, :param, :source, :track, :wbr] ->
          Taggart.HTML.unquote(tag)(
            Attributes.build(Attributes.TagContext.new(nil, seed: :never), styles)
          )
        _ -> 
          Taggart.HTML.unquote(tag)(
            nil, 
            Attributes.build(Attributes.TagContext.new(nil, seed: :never), styles),
            do: ""
          )
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
      component: Keyword.get(opts, :component, name),
      tag: Keyword.get(opts, :tag, :div),
      seed: Keyword.get(opts, :seed, :always),
      seed_value: Keyword.get(opts, :seed_value, name),
      attr: Keyword.get(opts, :attr, false),
      attr_opts: Keyword.get(opts, :attr_opts, []),
    ] do
      require Taggart.HTML

      # /3
      # uk_name([styles], [opts], [do: block]) -> TERMINAL
      # uk_name([styles], [do: block]) -> uk_name([styles], [], [do: block]) -> /3
      # /2
      # uk_name([styles], [do: block]) -> uk_name([styles], [], [do: block]) -> /3
      # /1
      # uk_name([do: block]) -> uk_name([], [], [do: block]) -> /3
      # uk_name(:atom) -> uk_name([:atom], [], [do: nil]) -> /3
      # uk_name(content) -> uk_name([], [], [do: content]) -> /3
      # /3 -> /13
      # uk_name(p1..p10, [opts], [do: block]) -> uk_name([p1..p10], [opts], [do: block]) -> /3

      #
      # uk_name/3
      #

      # TODO: check for allowed styles and component_options (maybe only in dev?)
      defmacro unquote(:"uk_#{name}")(styles, opts, do: block) when is_list(opts) and is_list(styles) do
        name = unquote(name)
        component = unquote(component)
        tag = unquote(tag)
        seed = unquote(seed)
        seed_value = unquote(seed_value)
        attr = unquote(attr)
        attr_opts = unquote(attr_opts)

        quote location: :keep do
          name = unquote(name)
          component = unquote(component)
          tag = unquote(tag)
          seed = unquote(seed)
          seed_value = unquote(seed_value)
          attr = unquote(attr)
          opts = unquote(opts)
          attr_opts = unquote(attr_opts)

          # opts might be passed in programmatically
          opts = if Keyword.has_key?(opts, :__uk_opts) do
            opts[:__uk_opts]
          else
            opts
          end

          # split out the attr_opts
          {attr_opts, opts} = Keyword.split(opts, attr_opts)

          Taggart.HTML.unquote(tag)(
            nil,
            Attributes.build(
              Attributes.TagContext.new(
                component,
                seed: seed,
                seed_value: seed_value,
                attr: attr,
                attr_opts: attr_opts,
                opts: opts
              ),
              unquote(styles)
            )
          ) do
            unquote(block)
          end
        end
      end

      #
      # uk_name/2 - forwards results to uk_name/3 with empty options default
      #

      defmacro unquote(:"uk_#{name}")([{_k, _v} | _rest] = opts, do: block) when is_list(opts) do
      	name = :"uk_#{unquote(name)}"
      	quote location: :keep do
      	  unquote(name)([], unquote(opts), do: unquote(block))
      	end
      end

      defmacro unquote(:"uk_#{name}")(styles, do: block) when is_list(styles) do
        name = :"uk_#{unquote(name)}"
        quote location: :keep do
          unquote(name)(unquote(styles), [], do: unquote(block))
        end
      end

      #
      # uk_name/1 - forwards results to uk_name/3 with empty options default, detecting block or content
      #

      defmacro unquote(:"uk_#{name}")(content \\ "")

      # uk_tag() do "foo" end
      defmacro unquote(:"uk_#{name}")([do: content]) do        
        name = :"uk_#{unquote(name)}"
        quote do
          unquote(name)([], [], do: unquote(content))
        end
      end

      # uk_tag(:divider)
      defmacro unquote(:"uk_#{name}")(style) when is_atom(style) do
        name = :"uk_#{unquote(name)}"
        quote do
          unquote(name)([unquote(style)], [], do: nil)
        end
      end

      # uk_tag("foo")
      defmacro unquote(:"uk_#{name}")(opts) when is_list(opts) do
        name = :"uk_#{unquote(name)}"
        quote do
          unquote(name)([], unquote(opts), do: nil)
        end
      end

      # uk_tag("foo")
      defmacro unquote(:"uk_#{name}")(content) do
        name = :"uk_#{unquote(name)}"
        quote do
          unquote(name)([], [], do: unquote(content))
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
      seed: Keyword.get(opts, :seed, :empty),
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

      iex> defboolean :margin

  """
  defmacro defboolean(name, opts \\ []) do
    quote location: :keep, bind_quoted: [
      name: name,
      bool: Keyword.get(opts, :bool, name),
    ] do
      bool_name = :"uk_#{bool}"

      defmacro unquote(name)() do
        bool_name = unquote(bool_name)

        quote location: :keep do
          attr([{unquote(bool_name), true}])
        end      
      end
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