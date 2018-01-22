defmodule UIKit.Element.Style do
  import UIKit

  defstyle :parent

  defstyle :active
  defstyle :disabled

  defstyle :align,
    styles: (for col <- [:left, :center, :right], bp <- [:s, :m, :l, :xl], do: "uk-align-#{col}@{bp}")

  defcomponent :light
  defstyle :light

  defcomponent :dark
  defstyle :dark

  def margin_styles do
    [
      # normal
      :"",
      :top,
      :bottom,
      :left,
      :right,
      # small
      :small,
      :small_top,
      :small_bottom,
      :small_left,
      :small_right,
      # medium
      :medium,
      :medium_top,
      :medium_bottom,
      :medium_left,
      :medium_right,
      # large
      :large,
      :large_top,
      :large_bottom,
      :large_left,
      :large_right,
      # xlarge
      :xlarge,
      :xlarge_top,
      :xlarge_bottom,
      :xlarge_left,
      :xlarge_right,
      # remove
      :remove,
      :remove_top,
      :remove_bottom,
      :remove_left,
      :remove_right,
      :remove_vertical,
      :remove_adjacent,
      # auto
      :auto,
      :auto_top,
      :auto_bottom,
      :auto_left,
      :auto_right,
      :auto_vertical,
    ]
  end

  defcomponent :margin,
    seed: :empty,
    styles: __MODULE__.margin_styles,
    component_options: [
      :margin,
      :first_column
    ]    
  defstyle :margin,
    styles: __MODULE__.margin_styles,
    component_options: [
      :margin,
      :first_column
    ]    
  defboolean :child_margins,
    bool: :margin

  defcomponent :panel,
    styles: [
      :scrollable
    ]
  defstyle :panel,
    styles: [
      :scrollable
    ]

  defstyle :float,
    styles: [
      :left,
      :right
    ]

  defstyle :clearfix

  defstyle :overflow,
    styles: [
      :hidden,
      :auto
    ]

  defstyle :resize,
    styles: [
      :vertical
    ]

  defstyle :display,
    styles: [
      :block,
      :inline,
      :inline_block
    ]

  defcomponent :inline,
    styles: [
      :clip
    ]
  defstyle :inline,
    styles: [
      :clip
    ]

  defstyle :height,
    styles: [
      :"1_1",
      :small,
      :max_small,
      :medium,
      :max_medium,
      :large,
      :max_large
    ]

  defstyle :height_viewport,
    component_options: [
      :offset_top,
      :offset_bottom,
      :expand
    ]

  defstyle :height_match,
    component_options: [
      :target,
      :row
    ]

  defstyle :responsive,
    styles: [
      :width,
      :height
    ]

  defstyle :border,
    styles: [
      :rounded,
      :circle
    ]

  defstyle :box_shadow,
    styles: [
      # size
      :small,
      :medium,
      :large,
      :xlarge,
      # bottom
      :bottom,
      # hover
      :hover_small,
      :hover_medium,
      :hover_large,
      :hover_xlarge
    ]

  defstyle :dropcap

  defstyle :leader,
    attr: true,
    component_options: [
      :fill,
      :media
    ]

  defstyle :logo,
    styles: [
      :inverse
    ]

  defstyle :svg,
    attr: true,
    allowed_tags: [:img]

  defstyle :gif,
    attr: true,
    allowed_tags: [:img]

  # defstyle :video,
  #   attr: true,
  #   component_options: [
  #     :autoplay,
  #     :automute
  #   ]

  defstyle :blend,
    styles: [
      :multiply,
      :screen,
      :overlay,
      :darken,
      :lighten,
      :color_dodge,
      :color_burn,
      :hard_light,
      :soft_light,
      :difference,
      :exclusion,
      :hue,
      :saturation,
      :color,
      :luminosity
    ]

  defstyle :transform_center

  defstyle :transform_origin,
    styles: [
      :top_left,
      :top_center,
      :top_right,
      :center_left,
      :center_right,
      :bottom_left,
      :bottom_center,
      :bottom_right,
    ]

  # defboolean :disabled,
  #   allowed_tags: [
  #     :input,
  #     :select,
  #     :textarea,
  #     :button
  #   ]

  defstyle :drag

  defstyle :hidden,
    styles: [
      # breakpoints
      :"@s",
      :"@m",
      :"@l",
      :"@xl",
      # hover
      :hover,
      # touch
      :touch,
      :notouch
    ]

  defstyle :visible,
    styles: [
      # breakpoints
      :"@s",
      :"@m",
      :"@l",
      :"@xl",
      # toggle
      :toggle
    ]

  defstyle :invisible,
    styles: [
      :hover
    ]

  defcomponent :width,
    seed: :empty,
    styles: [
      # columns
      :"1-1",
      :"1-2",
      :"1-3",
      :"2-3",
      :"1-4",
      :"3-4",
      :"1-5",
      :"2-5",
      :"3-5",
      :"4-5",
      :"1-6",
      :"5-6",
      # auto / expand
      :auto,
      :expand,
      # size
      :small,
      :medium,
      :large,
      :xlare,
      :xxlarge,
      # responsive
      :"*",
      :"*@s",
      :"*@m",
      :"*@l",
      :"*@xl",
    ]

  defstyle :width,
    seed: :empty,
    styles: [
      # columns
      :"1-1",
      :"1-2",
      :"1-3",
      :"2-3",
      :"1-4",
      :"3-4",
      :"1-5",
      :"2-5",
      :"3-5",
      :"4-5",
      :"1-6",
      :"5-6",
      # auto / expand
      :auto,
      :expand,
      # size
      :small,
      :medium,
      :large,
      :xlare,
      :xxlarge,
      # responsive
      :"*",
      :"*@s",
      :"*@m",
      :"*@l",
      :"*@xl",
    ]

  defstyle :child_width,
    seed: :empty,
    styles: [
      # columns
      :"1-1",
      :"1-2",
      :"1-3",
      :"2-3",
      :"1-4",
      :"3-4",
      :"1-5",
      :"2-5",
      :"3-5",
      :"4-5",
      :"1-6",
      :"5-6",
      # auto / expand
      :auto,
      :expand,
      # responsive
      :"*",
      :"*@s",
      :"*@m",
      :"*@l",
      :"*@xl",
    ]
end
