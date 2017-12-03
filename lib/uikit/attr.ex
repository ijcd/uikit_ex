defmodule UIKit.Attr do
  @moduledoc false

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
    class_seed = if(attr.seed, do: ["uk-#{for}"], else: [])
    boolean_attrs = if(attr.boolean, do: ["uk-#{for}": true], else: [])
    classes = Enum.map(attr.styles, &resolve_class(for, &1))

    joined_classes =
      case (class_seed ++ classes) do
        [] -> nil
         c -> Enum.join(c, " ")
      end

    [class: joined_classes] ++ boolean_attrs
  end

  def resolve_class(_for, {m, style}), do: tuple_to_class({m, style})
  def resolve_class(for, style), do: tuple_to_class({for, style})

  # TODO: move to StyleHelpers?
  def tuple_to_class({:width, {kind, cols, over, media}}) do
    "uk-#{kind}-width-#{cols}-#{over}@#{media}"
  end
  def tuple_to_class({for, style}) do
    ["uk", dasherize(for), dasherize(style)]
    |> Enum.reject(&is_nil/1)
    |> Enum.join("-")
  end

  defp dasherize(nil), do: nil
  defp dasherize(s), do: String.replace("#{s}", "_", "-")
end
