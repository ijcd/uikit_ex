defmodule UIKit.UIKitTest do
  use ExUnit.Case
  import UIKit
  alias UIKit.Element.{Behavior,Layout}

  defp s2s(ss), do: Phoenix.HTML.safe_to_string(ss)

  defcomponent :foo
  defcomponent :tag, tag: :span
  defcomponent :seed, seed: true
  defcomponent :unseed, seed: false
  defcomponent :attr, attr: true
  defcomponent :attr_unseed, attr: true, seed: false

  defstyle :bar
  defstyle :barseed, seed: true

  describe "uk_class" do
    test "returns an empty class" do
      assert "" == uk_class()
    end

    test "returns a single class" do
      assert "uk-transition-scale-up" == uk_class(Behavior.transition(:scale_up))
    end

    test "returns multiple classes" do
      assert "uk-transition-scale-up uk-position-cover" == uk_class(Behavior.transition(:scale_up) | Layout.position(:cover))
    end
  end

  describe "attr" do
    test "returns an empty attr" do
      assert nil == attr()
    end

    test "returns an attr" do
      assert %UIKit.AttrBuilder{attrs: [{"", {:style, "background-image: url('/images/dark.jpg');"}}], component: "", styles: []} == attr(style: "background-image: url('/images/dark.jpg');")
    end

    test "returns multiple attrs" do
      assert %UIKit.AttrBuilder{attrs: [{"", {:style, "background-image: url('/images/dark.jpg');"}}, {"", {:alt_longer, "a dark background"}}], component: "", styles: []} == attr(style: "background-image: url('/images/dark.jpg');", alt_longer: "a dark background")
    end

    test "renders in a tag properly" do
      assert ~s|<div class="uk-foo" style="background-image: url(&#39;/images/dark.jpg&#39;);"></div>| == s2s(uk_foo(attr(style: "background-image: url('/images/dark.jpg');"), do: nil))
    end
  end

  describe "uk" do
    test "renders a void tag" do
      assert ~s|<img class="uk-animation-kenburns">| == s2s(uk(:img, Behavior.animation(:kenburns)))
    end

    test "renders a void tag with multiple styles" do
      assert ~s|<img class="uk-animation-kenburns uk-position-center">| == s2s(uk(:img, Behavior.animation(:kenburns) | Layout.position(:center)))
    end

    test "renders an empty content tag (void aware)" do
      assert ~s|<div class="uk-animation-kenburns"></div>| == s2s(uk(:div, Behavior.animation(:kenburns)))
    end

    test "renders a content tag" do
      assert ~s|<div class="uk-animation-kenburns">content</div>| == s2s(uk(:div, Behavior.animation(:kenburns), do: "content"))
    end

    test "renders a conent tag with multiple styles" do
      assert ~s|<div class="uk-animation-kenburns uk-position-center">content</div>| == s2s(uk(:div, Behavior.animation(:kenburns) | Layout.position(:center), do: "content"))
    end

    test "renders a conent tag with multiple styles and attrs" do
      assert ~s|<div alt="" class="uk-animation-kenburns uk-position-center" src="/images/dark.jpg">content</div>| == s2s(uk(:div, Behavior.animation(:kenburns) | Layout.position(:center) | (attr(src: "/images/dark.jpg", alt: "")), do: "content"))
    end
  end

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
    test "handles a root style" do
      assert ~s|<div class="uk-foo uk-bar"></div>| == s2s(uk_foo(bar(), do: nil))
    end

    test "handles a style with a substyle" do
      assert ~s|<div class="uk-foo uk-bar-bang"></div>| == s2s(uk_foo(bar(:bang), do: nil))
    end

    test "handles a style with multiple substyles" do
      assert ~s|<div class="uk-foo uk-bar-bang uk-bar-bonk uk-bar-bink"></div>| == s2s(uk_foo(bar(:bang, :bonk, :bink), do: nil))
    end

    test "handles a seeded style" do
      assert ~s|<div class="uk-foo uk-barseed"></div>| == s2s(uk_foo(barseed(), do: nil))
    end

    test "handles a seeded style with a substyle" do
      assert ~s|<div class="uk-foo uk-barseed uk-barseed-bang"></div>| == s2s(uk_foo(barseed(:bang), do: nil))
    end

    test "handles a seeded style with multiple substyles" do
      assert ~s|<div class="uk-foo uk-barseed uk-barseed-bang uk-barseed-bonk uk-barseed-bing"></div>| == s2s(uk_foo(barseed(:bang, :bonk, :bing), do: nil))
    end

    test "handles a keyword list of component options" do
      assert ~s|<div class="uk-foo" uk-bar="bgy: -400; sepia: 100"></div>| == s2s(uk_foo(bar(bgy: -400, sepia: 100), do: nil))
    end    
  end

  describe "defboolean" do
  end

  describe "defdata" do
  end
end
