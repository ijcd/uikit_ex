defmodule UIKit.Layout do
  import UIKit
  alias UIKit.Attr

  # could be style?
  @column_styles [
    (for col <- 1..6, bp <- [:s, :m, :l, :xl], do: "uk-column-1-#{col}@{bp}"),
    :divider,
    :span
  ] |> List.flatten

  defcomponent :column, styles: @column_styles
  defstyle :column, styles: @column_styles

  defcomponent :comment, tag: :article, styles: :primary
  defcomponent :comment_header, tag: :header
  defcomponent :comment_avatar, tag: :img
  defcomponent :comment_title
  defcomponent :comment_meta
  defcomponent :comment_body
  defcomponent :comment_list, tag: :ul

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
  @flex_styles [
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

  defcomponent :flex, styles: @flex_styles
  defstyle :flex, styles: @flex_styles


  # <div class="uk-flex-center" uk-grid>
  #     <div></div>
  #     <div class="uk-flex-first"></div>
  # </div>
  defcomponent :grid,
    seed: false,
    boolean: true,
    styles: [
      # style
      :small,
      :medium,
      :large,
      :collabpse,
      # divider
      :divider,
      # height
      :match,
      :item_match
    ],
    component_options: [
      :margin,
      :first_column
    ]

  defcomponent :grid_parallax,
    component_options: [
      :target,
      :translate
    ]

  defstyle :position,
    styles: [
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