defmodule UIKit.AttrBuilderTest do
  use ExUnit.Case
  alias UIKit.AttrBuilder

  @empty AttrBuilder.new(:foo)
  @seeded AttrBuilder.new(:foo, seed: true)
  @boolean AttrBuilder.new(:foo, attr: true)
  @valued AttrBuilder.new(:foo, attr: "uk-bar")
  @styles AttrBuilder.new(:foo, styles: [:bar, :baz])
  @styles_seeded AttrBuilder.new(:foo, seed: true, styles: [:bar, :baz])
  @styles_valued AttrBuilder.new(:foo, styles: [:bar, :baz], attr: "uk-bar")
  @styles_valued_seeded AttrBuilder.new(:foo, seed: true, styles: [:bar, :baz], attr: "uk-bar")

  @all [@empty, @seeded, @boolean, @valued, @styles, @styles_seeded, @styles_valued, @styles_valued_seeded]

  describe "new" do
    test "constructs an empty AttrBuilder" do
      assert @empty == %AttrBuilder{component: :foo, attrs: [], styles: []}
    end

    test "constructs AttrBuilderBuilder with seed style" do
      assert @seeded == %AttrBuilder{component: :foo, attrs: [], styles: [foo: nil]}
    end

    test "constructs AttrBuilderBuilder with boolean attr" do
      assert @boolean == %AttrBuilder{component: :foo, attrs: [foo: true], styles: []}
    end

    test "constructs AttrBuilderBuilder with value attr" do
      assert @valued == %AttrBuilder{component: :foo, attrs: [foo: "uk-bar"], styles: []}
    end

    test "constructs AttrBuilderBuilder with several styles" do
      assert @styles == %AttrBuilder{component: :foo, attrs: [], styles: [foo: :bar, foo: :baz]}
    end

    test "constructs AttrBuilderBuilder with several styles and a seed" do
      assert @styles_seeded == %AttrBuilder{component: :foo, attrs: [], styles: [foo: nil, foo: :bar, foo: :baz]}
    end

    test "constructs AttrBuilderBuilder with several styles and values" do
      assert @styles_valued == %AttrBuilder{component: :foo, attrs: [foo: "uk-bar"], styles: [foo: :bar, foo: :baz]}
    end

    test "constructs AttrBuilderBuilder with several styles and a seed and values" do
      assert @styles_valued_seeded == %AttrBuilder{component: :foo, attrs: [foo: "uk-bar"], styles: [foo: nil, foo: :bar, foo: :baz]}
    end
  end

  describe "build" do
    test "builds an empty AttrBuilder" do
      b = @empty |> AttrBuilder.build()
      assert b == [class: nil]
    end

    test "builds a seeded AttrBuilder" do
      b = @seeded |> AttrBuilder.build()
      assert b == [class: "uk-foo"]
    end

    test "builds an AttrBuilder with a boolean attribute" do
      b = @boolean |> AttrBuilder.build()
      assert b == [class: nil, "uk-foo": true]
    end

    test "builds an AttrBuilder with a value attribute" do
      b = @valued |> AttrBuilder.build()
      assert b == [class: nil, "uk-foo": "uk-bar"]
    end

    test "builds an AttrBuilder with multiple styles" do
      b = @styles |> AttrBuilder.build()
      assert b == [class: "uk-foo-bar uk-foo-baz"]
    end

    test "builds an AttrBuilder with multiple styles and a seed" do
      b = @styles_seeded |> AttrBuilder.build()
      assert b == [class: "uk-foo uk-foo-bar uk-foo-baz"]
    end

    test "builds symbols joined into the AttrBuilder as component attributes" do
      b = AttrBuilder.join(@seeded, AttrBuilder.join(:bar, :baz)) |> AttrBuilder.build()
      assert b == [class: "uk-foo uk-foo-bar uk-foo-baz"]
    end

    test "warns when trying to build without a tag context" do
      assert_raise UIKit.NoTagContext, fn ->
        AttrBuilder.join(:bar, :baz) |> AttrBuilder.build() |> IO.inspect
      end
    end
  end

  describe "join" do
    test "joins two empty AttrBuilders" do
      assert @empty = AttrBuilder.join(@empty, @empty)
    end

    test "joins empty and other AttrBuilders" do
      for ab <- @all do
        assert ab == AttrBuilder.join(@empty, ab)
      end
    end

    test "joins two AttrBuilders" do
      expected = %AttrBuilder{component: :foo, styles: [foo: :far, foo: :faz, boo: :bar, boo: :baz], attrs: [foo: true, boo: "uk-baa"]}
      assert expected == AttrBuilder.join(
        AttrBuilder.new(:foo, styles: [:far, :faz], attr: true),
        AttrBuilder.new(:boo, styles: [:bar, :baz], attr: "uk-baa")
      )
    end

    test "joins and AttrBuilder to a symbol (class shorthand)" do
      expected = %AttrBuilder{component: :foo, attrs: [foo: true], styles: [foo: :far, foo: :faz, nil: :bang]}
      assert expected == AttrBuilder.join(
        AttrBuilder.new(:foo, styles: [:far, :faz], attr: true),
        :bang
      )
    end

    test "joins of anything with nil do nothing" do
      for ab <- @all do
        assert ab == AttrBuilder.join(ab, nil)
      end
    end

    test "joins an AttrBuilder with a symbol" do
      assert %AttrBuilder{attrs: [], component: :foo, styles: [nil: :bar]} == AttrBuilder.join(@empty, :bar)
    end

    test "joins two symbols" do
      assert %AttrBuilder{attrs: [], component: nil, styles: [nil: :foo, nil: :bar]} == AttrBuilder.join(:foo, :bar)
    end

    test "joins symbols into a named component" do
      assert %AttrBuilder{attrs: [], component: :foo, styles: [foo: nil, nil: :bar, nil: :baz]} == AttrBuilder.join(@seeded, AttrBuilder.join(:bar, :baz))
    end


    # test "warns joining to a naked symbol (tag context missing)" do
    #   assert_raise UIKit.NoContextForStyleJoin, fn ->
    #     AttrBuilder.join(
    #       :bang,
    #       AttrBuilder.new(:foo, styles: [:far, :faz], attr: true)
    #     )
    #   end
    # end
  end
end
