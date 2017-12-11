defmodule UIKit.AttrBuilder do
  @moduledoc false

  defstruct [
    component: nil,
    styles: [],
    attrs: [],
  ]

  def new(component, opts \\ []) do
    opt_styles = Keyword.get(opts, :styles, [])

    # seed style if indicated, append given styles for component
    # [{:width, nil}, {:width, :auto}
    # <div class="uk-width uk-width-auto">
    seed = if(opts[:seed], do: [{component, nil}], else: [])
    styles = seed ++ Enum.map(opt_styles, &{component, &1})

    # attr is boolean or value, named by component
    # {:width, true}    {:width, "auto"}
    # <div uk-width> or <div uk-width="auto">
    attrs = if(opts[:attr], do: [{component, opts[:attr]}], else: [])

    %__MODULE__{
      component: component,
      styles: styles,
      attrs: attrs,
    }
  end

  def join(a, nil), do: a

  def join(%__MODULE__{} = a, sym) when is_atom(sym) do
    %{a | styles: a.styles ++ [{nil, sym}]}
  end

  def join(%__MODULE__{} = a, %__MODULE__{} = b) do
    %{a | styles: a.styles ++ b.styles, attrs: a.attrs ++ b.attrs}
  end

  def join(a, b) when is_atom(a) do
    join(__MODULE__.new(nil, styles: [a]), b)
  end

  def build(%__MODULE__{} = attr) do
    classes =
      attr.styles
      |> Enum.map(&as_class(attr.component, &1))
      |> join_classes()

    attrs =
      attr.attrs
      |> Enum.map(&as_attr(&1))

    [class: classes] ++ attrs
  end

  defp as_class(c1, c2, prefix \\ "uk")

  defp as_class(nil, {nil, _}, _), do: raise UIKit.NoTagContext

  defp as_class(c1, {c2, style}, prefix) do
    component = c2 || c1
    [prefix, dasherize(component), dasherize(style)]
    |> Enum.reject(&is_nil/1)
    |> Enum.join("-")
  end

  defp as_attr({"", {attr, val}}) do
    sym = as_class("", {attr, nil}, nil) |> String.to_atom()
    {sym, val}
  end

  defp as_attr({attr, val}) do
    sym = as_class(nil, {attr, nil}) |> String.to_atom()
    {sym, val}
  end

  defp join_classes([]), do: nil
  defp join_classes(c), do: Enum.join(c, " ")

  def dasherize(nil), do: nil
  def dasherize(s), do: String.replace("#{s}", "_", "-")
end
