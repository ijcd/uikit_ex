defmodule UIKit.Attributes do
  @moduledoc false

  @doc false
  defmodule TagContext do
    @moduledoc false
    defstruct [:component, :seed, :seed_value, :attr, :opts, :attr_opts]

    def new(component, opts \\ []) do
      # seed style if indicated, append given styles for component
      # values are (:always, :empty, :never)
      # default is :always for components, and :empty for styles
      # [{:width, nil}, {:width, :auto}]
      # <div class="uk-width uk-width-auto">
      seed = Keyword.get(opts, :seed, :always)
      seed_value = Keyword.get(opts, :seed_value, component)

      # attr is boolean or value, named by component
      # {:width, true}    {:width, "auto"}
      # <div uk-width> or <div uk-width="auto">
      attr = Keyword.get(opts, :attr, false)

      # attr_opts are passed in as opts, but become html attributes
      attr_opts = Keyword.get(opts, :attr_opts, [])

      # component opts are uikit "flags" used to control uikit components
      component_opts = Keyword.get(opts, :opts, [])

      %__MODULE__{
        component: component,
        seed: seed,
        seed_value: seed_value,
        attr: attr,
        opts: component_opts,
        attr_opts: attr_opts
      }
    end
  end

  defmodule ComponentClass do
    @moduledoc false
    defstruct [:component, :seed, :attr, :styles]

    def new(component, styles, opts \\ []) do
      seed = Keyword.get(opts, :seed, false)
      attr = Keyword.get(opts, :attr, false)
      %__MODULE__{
        component: component,
        seed: seed,
        attr: attr,
        styles: styles
      }
    end
  end

  defmodule RawAttribute do
    defstruct [:name, :value]

    def new({name, value}) do
      %__MODULE__{
        name: name,
        value: value
      }
    end
  end


  # Initial entry
  @doc false
  def build(context, styles) do
    # seed indicates that the root class should always be included <div class="uk-flex uk-flex-inline:>
    # for :empty, only match on atom or string (non-struct) styles (indicates same component)
    seed = case {context.seed, Enum.filter(styles, fn s -> is_atom(s) or is_binary(s) end)} do
      {:always, _} -> [class: classify(["uk", context.seed_value])]
      {:empty, []} -> [class: classify(["uk", context.seed_value])]
      {:empty, _} -> []
      {:never, _} -> []
    end

    # attr indicates a boolean attribute, or similar <div uk-grid> or <div uk-grid="foo: 1">
    attr = case {context.opts, context.attr} do
      # no component options, so fall back to attr
      {[], false} -> []
      {[], true} -> [{classify(["uk", context.component]), context.attr}]         # uk-grid
      {[], _} -> [{classify([context.attr]), true}]                               # uk-slidenav-prev

      # build attr from component options
      _ -> [{classify(["uk", context.component]), keyword_to_options(context.opts)}]
    end

    style_attrs = 
      styles
      |> List.flatten
      |> Enum.map(&make_attr(context, &1))

    compress(attr ++ seed ++ context.attr_opts ++ style_attrs)
  end

  @doc false
  def make_attr(context, a) when is_atom(a) or is_binary(a) do
    {:class, classify(["uk", context.component, a])}
  end

  @doc false
  def make_attr(_context, %RawAttribute{} = ra) do
    [{ra.name, ra.value}]
  end

  @doc false
  def make_attr(_context, %ComponentClass{} = cc) do
    # seed indicates that the root class should always be indlucde <div class="uk-flex uk-flex-inline:>
    seed = case {cc.seed, cc.styles} do
      {:always, _} -> [class: classify(["uk", cc.component])]
      {:empty, []} -> [class: classify(["uk", cc.component])]
      {:empty, _} -> []
      {:never, _} -> []
    end

    attr = cond do
      cc.attr -> [{classify(["uk", cc.component]), cc.attr}]
      true -> []
    end

    cond do
      [] == cc.styles ->
        attr ++ seed
      Keyword.keyword?(cc.styles) ->
        name = classify(["uk", cc.component])
        value = keyword_to_options(cc.styles)
        attr ++ [{name, value}]
      true -> 
        attr ++ seed ++ Enum.map(cc.styles, &make_attr(cc, &1))
    end
  end

  # [class: "foo", class: "foo-bar"] -> [class: ["foo", "foo-bar"]]
  @doc false
  def compress(attributes) when is_list(attributes) do
    attributes
    |> List.flatten
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Enum.map(fn
      {k, [v]} -> {k, v}
      {k, v} -> {k, Enum.join(v, " ")}
    end)
    |> Enum.into([])
  end

  @doc false
  def keyword_to_options(kw) do
    Enum.map(kw, fn {k, v} -> "#{dasherize(k)}: #{v}" end) |> Enum.join("; ")
  end

  @doc false
  def dasherize(nil), do: nil
  def dasherize(s), do: String.replace("#{s}", "_", "-")

  @doc false
  def classify(segments) when is_list(segments) do
    segments
      |> Enum.map(&dasherize/1)
      |> Enum.join("-")
      |> String.replace("-@", "@")
  end
end
