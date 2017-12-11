defmodule UIKit.NoTagContext do
  @moduledoc """
  Raised when attempting to build a style without a tag context.
  If you use the symbol shorthand, you must first join to a tag with a component:

  GOOD:
    width(:auto) | :foo     # width() provides context
    uk_foo(:foo | :bar)     # uk_foo() provides context

  BAD:
    :foo | :bar             # No context. Try class(:foo) | class(:bar)
    uk(:div, :foo)          # No context. Try uk(:div, class(:foo))

  """

  defexception message: @moduledoc
end
