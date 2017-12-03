defmodule UIKit.Behavior do
  import UIKit
  alias UIKit.Attr

  # TODO: notifications are all JS -- how to handle this? Event components?
  # IDEA: event components combined with Presto to forward notifications?

  defcomponent :animation_toggle
  defstyle :animation,
    styles: [
      # style
      :fade,
      :scale_up,
      :scale_down,
      :slide_top,
      :slide_bottom,
      :slide_left,
      :slide_right,
      :slide_top_small,
      :slide_bottom_small,
      :slide_left_small,
      :slide_right_small,
      :slide_top_medium,
      :slide_bottom_medium,
      :slide_left_medium,
      :slide_right_medium,
      :kenburns,
      :shake,
      # modifiers
      :fast,
      :reverse
    ]

  defcomponent :parallax,
    component_options: [
      # normal
      :easing,
      :target,
      :viewport,
      :media,
      # animation
      :x,
      :y,
      :bgy,
      :bgx,
      :rotate,
      :scale,
      :color,
      :background_color,
      :border_color,
      :opacity,
      :blur,
      :hue,
      :grayscale,
      :invert,
      :saturate,
      :sepia
    ]

  defboolean :scroll,
    component_options: [
      :duration,
      :offset
    ]

  defcomponent :scrollspy,
    component_options: [
      :cls,
      :hidden,
      :offset_top,
      :offset_left,
      :repeat,
      :delay
    ]

  # TODO: spreadsheet compare seed/boolean (T/F)
  defcomponent :sticky,
    seed: false,
    boolean: true,
    component_options: [
      :top,
      :bottom,
      :offset,
      :animation,
      :cls_active,
      :cls_inactive,
      :width_element,
      :show_on_up,
      :media,
      :target
    ]

  defstyle :transition,
    styles: [
      :fade,
      :scale_up,
      :scale_down,
      :slide_top,
      :slide_bottom,
      :slide_left,
      :slide_right,
      :slide_top_small,
      :slide_bottom_small,
      :slide_left_small,
      :slide_right_small,
      :slide_top_medium,
      :slide_bottom_medium,
      :slide_left_medium,
      :slide_right_medium,
    ]
end