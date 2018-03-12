defmodule UIKit.UIKitTest do
  use ExUnit.Case
  import UIKit
  import UIKit.Element.{Behavior,Component,Layout,Navigation,Style}

  defp s2s(ss), do: Phoenix.HTML.safe_to_string(ss)

  defcomponent :foo
  defcomponent :tag, tag: :span
  defcomponent :seed, seed: :always
  defcomponent :unseed, seed: :never
  defcomponent :attr, attr: true
  defcomponent :attr_unseed, attr: true, seed: :never
  defcomponent :attr_from_opts, attr_opts: [:href]
  defcomponent :seed_with_attrs, seed: [type: "button"]

  defstyle :bar
  defstyle :barseed, seed: :always

  describe "class" do
    test "renders a basic class" do
      assert ~s|<img class="custom-class uk-position-center">| == s2s(uk(:img, class("custom-class"), position(:center)))
    end

    test "renders multiple classes" do
      assert ~s|<img class="custom-class custom2">| == s2s(uk(:img, class("custom-class"), class("custom2")))
    end

    test "renders multiple classes in one tag" do
      assert ~s|<img class="custom-class custom2">| == s2s(uk(:img, class("custom-class", "custom2")))
    end

    test "regression #1" do
      require UIKit.Element.Component
      assert ~s|<div class=\"uk-card uk-card-default uk-card-body test-fixed\"></div>| == s2s(uk_card(:default, :body, class("test-fixed"), do: nil))
    end
  end  

  describe "attr" do
    test "renders in a tag properly" do
      assert ~s|<div class="uk-foo" style="background-image: url(&#39;/images/dark.jpg&#39;);"></div>| == s2s(uk_foo(attr(style: "background-image: url('/images/dark.jpg');"), do: nil))
    end
  end

  describe "uk" do
    test "renders a void tag" do
      assert ~s|<img class="uk-animation-kenburns">| == s2s(uk(:img, animation(:kenburns)))
    end

    test "renders a void tag with multiple styles" do
      assert ~s|<img class="uk-animation-kenburns uk-position-center">| == s2s(uk(:img, animation(:kenburns), position(:center)))
    end

    test "renders an empty content tag (void aware)" do
      assert ~s|<div class="uk-animation-kenburns"></div>| == s2s(uk(:div, animation(:kenburns)))
    end

    test "renders a content tag" do
      assert ~s|<div class="uk-animation-kenburns">content</div>| == s2s(uk(:div, animation(:kenburns), do: "content"))
    end

    test "renders a conent tag with multiple styles" do
      assert ~s|<div class="uk-animation-kenburns uk-position-center">content</div>| == s2s(uk(:div, animation(:kenburns), position(:center), do: "content"))
    end

    test "renders a content tag with multiple styles and attrs" do
      assert ~s|<div alt="" class="uk-animation-kenburns uk-position-center uk-position-small" src="/images/dark.jpg">content</div>| == s2s(uk(:div, animation(:kenburns), position(:center, :small), attr(src: "/images/dark.jpg", alt: ""), do: "content"))
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

    test "allows seeding with other attrs" do
      assert ~s|<div type="button"></div>| == s2s(uk_seed_with_attrs(do: nil))      
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
      assert ~s|<div class="uk-foo uk-foo-auto uk-foo-wide"></div>| == s2s(uk_foo(:auto, :wide, do: nil))
    end

    test "works with string classes (regression)" do
      assert ~s|<div uk-grid class="uk-grid-match uk-child-width-1-3@m"></div>| == s2s(uk_grid(:match, child_width("1-3@m"), do: ""))
    end

    test "works with recursive versions of the same tag (regression)" do
      assert ~s|<div class="uk-section"><div class="uk-section uk-section-default"></div></div>| == s2s(uk_section(do: uk_section(:default, do: "")))
    end

    test "seed_empty prevents seeding for empty tags" do
      assert ~s|<ul class=\"uk-breadcrumb\"><li>Go</li></ul>| == s2s(uk_breadcrumb(do: uk_breadcrumb_item(do: "Go")))          
    end

    test "allows specifying the component name" do
      assert ~s|<ul uk-nav class="uk-nav-primary uk-nav-parent-icon"></ul>| == s2s(uk_nav_accordion(:primary, :parent_icon, do: nil))
    end

    test "allows specifying component options" do
      assert ~s|<ul class="uk-nav-primary uk-nav-parent-icon" uk-nav="multiple: true"></ul>| == s2s(uk_nav_accordion(:primary, :parent_icon, [multiple: true], do: nil))
    end

    test "allows specifying only component options" do
      assert ~s|<ul uk-nav="multiple: true"></ul>| == s2s(uk_nav_accordion([multiple: true], do: nil))
    end

    test "allows specifying an alternate seed_value" do
      assert ~s|<nav uk-navbar class=\"uk-navbar-container uk-margin\"></nav>| == s2s(uk_navbar(margin(), do: nil))
    end

    test "works with opts given as a variable" do
      opts = [cls_drop: "uk-navbar-dropdown", boundary: "!nav"]
      assert ~s|<div class=\"uk-navbar-dropdown\" uk-drop=\"cls-drop: uk-navbar-dropdown; boundary: !nav\"></div>| == s2s(uk_navbar_dropdown([__uk_opts: opts], do: nil))
    end

    def the_opts do
      [cls_drop: "uk-navbar-dropdown", boundary: "!nav"]
    end

    test "works with opts given as a function" do
      assert ~s|<div class=\"uk-navbar-dropdown\" uk-drop=\"cls-drop: uk-navbar-dropdown; boundary: !nav\"></div>| == s2s(uk_navbar_dropdown([__uk_opts: the_opts()], do: nil))
    end

    test "allows some opts to be promoted to attrs" do
      assert ~s|<div class=\"uk-attr-from-opts\"></div>| == s2s(uk_attr_from_opts(do: nil))
      assert ~s|<div class=\"uk-attr-from-opts\" href="#"></div>| == s2s(uk_attr_from_opts([href: "#"], do: nil))
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

    test "creates attrs for attr styles (regression)" do
      assert ~s|<header uk-grid class="uk-comment-header uk-grid-medium uk-flex uk-flex-middle"></header>| == s2s(uk_comment_header(grid(:medium), flex(:middle), do: nil))
    end

    test "handles breakpoints (breakpoints)" do
      assert ~s|<div class="uk-visible@l"></div>| == s2s(uk_unseed(visible("@l"), do: nil))
    end
  end

  # describe "defboolean" do
  # end

  # describe "defdata" do
  # end
end
