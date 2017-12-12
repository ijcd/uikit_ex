defmodule UIKit.Attributes do
  @moduledoc false

  @doc false
  defmodule TagContext do
    @moduledoc false
    defstruct [:component, :seed, :attr]

    def new(component, opts \\ []) do
      # seed style if indicated, append given styles for component
      # [{:width, nil}, {:width, :auto}
      # <div class="uk-width uk-width-auto">
      seed = Keyword.get(opts, :seed, true)

      # attr is boolean or value, named by component
      # {:width, true}    {:width, "auto"}
      # <div uk-width> or <div uk-width="auto">
      attr = Keyword.get(opts, :attr, false)

      %__MODULE__{
        component: component,
        seed: seed,
        attr: attr,
      }
    end
  end

  defmodule ComponentClass do
    @moduledoc false
    defstruct [:component, :seed, :attr, :styles]

    def new(component, styles, opts \\ []) do
      seed = Keyword.get(opts, :seed, false)
      attr = Keyword.get(opts, :attr, false)
      %__MODULE__{component: component, seed: seed, attr: attr, styles: styles}
    end
  end

  defmodule RawAttribute do
    defstruct [:name, :value]

    def new({name, value}) do
      %__MODULE__{name: name, value: value}
    end
  end


  # Initial entry
  @doc false
  def build(context, styles) do
    # attr indicates a boolean attribute, or similar <div uk-grid> or <div uk-grid="foo: 1">
    attr = case context.attr do
      true -> [{classify(["uk", context.component]), context.attr}]
      _ -> []
    end

    # seed indicates that the root class should always be indlucde <div class="uk-flex uk-flex-inline:>
    seed = case context.seed do
      true -> [class: classify(["uk", context.component])]
      _ -> []
    end

    compress(attr ++ seed ++ (styles |> List.flatten |> Enum.map(&make_attr(context, &1))))
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
    seed = cond do
      cc.seed || cc.styles == [] -> [{:class, classify(["uk", cc.component])}]
      true -> []
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
        value = Enum.map(cc.styles, fn {k, v} -> "#{dasherize(k)}: #{v}" end) |> Enum.join("; ")
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
  def dasherize(nil), do: nil
  def dasherize(s), do: String.replace("#{s}", "_", "-")

  @doc false
  def classify(segments) when is_list(segments) do
    segments
      |> Enum.map(&dasherize/1)
      |> Enum.join("-")
  end
end
