defmodule UIKit.Element.Layout do
  import UIKit

  # could be style?
  def column_styles do
    [
      (for col <- 1..6, bp <- [:s, :m, :l, :xl], do: "uk-column-1-#{col}@#{bp}"),
      :divider,
      :span
    ] |> List.flatten
  end

  defcomponent :column, styles: __MODULE__.column_styles
  defstyle :column, styles: __MODULE__.column_styles

  defcomponent :container,
    styles: [
      :small,
      :large,
      :expand
    ]

  # uk-height-viewportn
  defcomponent :cover_container,
    component_options: [
      :automute,
      :width,
      :height
    ]
  defboolean :cover,
    allowed_tags: [
      :img,
      :video,
      :iframe
    ]

  # TODO: bp is optional, and we probably won't pass it as a built string
  def flex_styles do
    [
      # kind
      :inline,
      # styles
      (for pos <- [:left, :center, :right, :between, :around], bp <- [:s, :m, :l, :xl], do: "uk-flex-#{pos}@#{bp}"),
      # vertical
      :stretch,
      :top,
      :middle,
      :bottom,
      # direction
      :row,
      :row_reverse,
      :column,
      :column_reverse,
      # wrap
      :wrap,
      :wrap_reverse,
      :nowrap,
      # wrap modifier
      :wrap_stretch,
      :wrap_between,
      :wrap_background,
      :wrap_top,
      :wrap_middle,
      :wrap_bottom,
      # item order
      (for where <- [:first, :last], bp <- [:s, :m, :l, :xl], do: "uk-flex-#{where}@#{bp}"),
      # dimensions
      :none,
      :auto,
      :"1"
    ] |> List.flatten
  end

  # TODO: uk-flex-first and uk-flex-last are indicators that don't need the seed
  defcomponent :flex, styles: __MODULE__.flex_styles
  defstyle :flex,
    seed: :always,
    styles: __MODULE__.flex_styles

  def grid_styles do
    [
      # style
      :small,
      :medium,
      :large,
      :collapse,
      # divider
      :divider,
      # height
      :match,
      :item_match
    ]
  end

  # TODO: uk-grid-margin is an indicators that doesn't need the seed
  # <div class="uk-flex-center" uk-grid>
  #     <div></div>
  #     <div class="uk-flex-first"></div>
  # </div>
  defcomponent :grid,
    seed: :never,
    attr: true,
    styles: __MODULE__.grid_styles,
    component_options: [
      :margin,
      :first_column
    ]
  defstyle :grid,
    attr: true,
    styles: __MODULE__.grid_styles

  defcomponent :grid_parallax,
    component_options: [
      :target,
      :translate
    ]

  def position_styles do  
    [
      # position
      :top,
      :left,
      :right,
      :bottom,
      :top_left,
      :top_center,
      :top_right,
      :center,
      :center_left,
      :center_right,
      :bottom_left,
      :bottom_center,
      :bottom_right,
      # cover
      :cover,
      # size
      :small,
      :medium,
      :large,
      # utility
      :relative,
      :absolute,
      :fixed,
      :z_index
    ]
  end

  defcomponent :position,
    seed: :empty,
    styles: __MODULE__.position_styles
  defstyle :position,
    styles: __MODULE__.position_styles

  # - uk-preserve-color
  # - uk-padding-remove-vertical
  defcomponent :section,
    styles: [
      # style
      :default,
      :muted,
      :primary,
      :secondary,
      # size
      :xsmall,
      :small,
      :large,
      :xlarge,
      # overlap
      :overlap
    ]
end
