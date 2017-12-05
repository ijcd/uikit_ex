defmodule UIKit.NoTagContext do
  @moduledoc """
  Raised when attempting to build a style without a tag context. If you use
  the symbol shorthand, you must first join to a tag with a component:

  GOOD:
    AttrBuilder.build(width(:auto) | :foo)

  BAD:
    AttrBuilder.build(:foo | :bar)

  """

  defexception message: @moduledoc
end
