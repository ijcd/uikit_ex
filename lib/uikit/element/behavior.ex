defmodule UIKit.Element.Behavior do
  import UIKit

  # TODO: notifications are all JS -- how to handle this? Event components?
  # IDEA: event components combined with Presto to forward notifications?

  defcomponent(:animation_toggle)

  defstyle(
    :animation,
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
  )

  def parallax_options do
    [
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
  end

  defcomponent(:parallax, options: __MODULE__.parallax_options())
  defstyle(:parallax, options: __MODULE__.parallax_options())

  # defboolean :scroll,
  #   component_options: [
  #     :duration,
  #     :offset
  #   ]

  def scrollspy_options do
    [
      :cls,
      :hidden,
      :offset_top,
      :offset_left,
      :repeat,
      :delay
    ]
  end

  defcomponent(:scrollspy, component_options: __MODULE__.scrollspy_options())
  defstyle(:scrollspy, component_options: __MODULE__.scrollspy_options())

  def sticky_options do
    [
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
  end

  # TODO: spreadsheet compare seed/boolean (T/F)
  defcomponent(
    :sticky,
    seed: :empty,
    attr: true,
    component_options: __MODULE__.sticky_options()
  )

  defstyle(:sticky, component_options: __MODULE__.sticky_options())

  def transition_styles do
    [
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
      :slide_right_medium
    ]
  end

  defcomponent(
    :transition,
    seed: :empty,
    styles: __MODULE__.transition_styles()
  )

  defstyle(:transition, styles: __MODULE__.transition_styles())
end
