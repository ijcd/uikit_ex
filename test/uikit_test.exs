defmodule UIKit.UIKitTest do
  use ExUnit.Case
  import UIKit

  defp s2s(ss), do: Phoenix.HTML.safe_to_string(ss)

  defcomponent :foo
  defcomponent :tag, tag: :span
  defcomponent :seed, seed: true
  defcomponent :unseed, seed: false
  defcomponent :attr, attr: true
  defcomponent :attr_unseed, attr: true, seed: false

  describe "defcomponent" do

    test "defines a basic component" do
      assert ~s|<div class="uk-foo"></div>| == s2s(uk_foo(do: nil))
    end

    test "defines a basic component with a different tag" do
      assert ~s|<span class="uk-tag"></span>| == s2s(uk_tag(do: nil))
    end

    test "defines a seeded component" do
      assert ~s|<div class="uk-seed"></div>| == s2s(uk_seed(do: nil))
    end

    test "defines an unseeded component" do
      assert ~s|<div></div>| == s2s(uk_unseed(do: nil))
    end

    test "defines a component with a boolean attr" do
      assert ~s|<div uk-attr class="uk-attr"></div>| == s2s(uk_attr(do: nil))
    end

    test "defines a an unseeded component with a boolean attr" do
      assert ~s|<div uk-attr-unseed></div>| == s2s(uk_attr_unseed(do: nil))
    end

    test "basic component with style" do
      assert ~s|<div class="uk-foo uk-foo-auto"></div>| == s2s(uk_foo(:auto, do: nil))
    end

    test "basic component with styles" do
      assert ~s|<div class="uk-foo uk-foo-auto uk-foo-wide"></div>| == s2s(uk_foo(:auto | :wide, do: nil))
    end
  end

  describe "defstyle" do
  end

  describe "defboolean" do
  end

  describe "defdata" do
  end
end
