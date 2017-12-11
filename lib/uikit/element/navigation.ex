defmodule UIKit.Element.Navigation do
  import UIKit

  # <li class="uk-disabled"><a href=""></a></li>
  defcomponent :breadcrumb,
    tag: :ul
  defcomponent :breadcrumb_item, tag: :li

  # <li class="uk-active"><a href=""></a></li>
  # <div class="uk-position-relative uk-light">
  #     <!-- The element which is wrapped goes here -->
  #     <div class="uk-position-bottom-center uk-position-small">
  #         <ul class="uk-dotnav">...</ul>
  #     </div>
  # </div>
  # <div class="uk-position-center-right uk-position-medium uk-position-fixed">
  #   <ul class="uk-dotnav uk-dotnav-vertical">...</ul>
  # </div>
  defcomponent :dotnav,
    tag: :ul,
    styles: [
      :vertical
    ]
  defcomponent :dotnav_item, tag: :li

  defcomponent :nav,
    styles: [
      :default,
      :primary,
      :center
    ],
    component_options: [
      :targets,
      :toggle,
      :content,
      :collapsible,
      :multiple,
      :transition,
      :animation,
      :duration
    ]
  defcomponent :nav_sub, tag: :ul
  defcomponent :nav_parent_icon,
    tag: :ul,
    seed: false,
    attr: "uk-nav"
  defcomponent :nav_header, tag: :li
  defcomponent :nav_footer, tag: :li

  # where should this be?
  defstyle :dropdown_nav

  defcomponent :navbar,
    tag: :nav,
    seed: false,
    attr: "uk-navbar",
    component_options: [
      :align,
      :mode,
      :delay_show,
      :delay_hide,
      :boundary,
      :boundary_align,
      :offset,
      :dropbar,
      :dropbar_mode,
      :duration
    ]
  defcomponent :navbar_container,
    seed: false,
    attr: "uk-navbar",
    syltes: [
      :transparent
    ]
  defcomponent :navbar_left
  defcomponent :navbar_center
  defcomponent :navbar_center_left
  defcomponent :navbar_center_right
  defcomponent :navbar_right
  defcomponent :navbar_nav, tag: :ul
  defcomponent :navbar_subtitle
  defcomponent :navbar_item

  defstyle :navbar_toggle
  defboolean :navbar_toggle_icon

  defcomponent :navbar_dropdown
  defboolean :navbar_dropdown_nav

  defstyle :navbar_dropdown_width_2
  defstyle :navbar_dropdown_width_3
  defstyle :navbar_dropdown_width_4
  defstyle :navbar_dropdown_width_5

  def padding_styles do
    [
      :small,
      :large,
      :remove,
      :remove_top,
      :remove_bottom,
      :remove_left,
      :remove_right,
      :remove_vertical,
      :remove_horizontal
    ]
  end

  defcomponent :padding, styles: __MODULE__.padding_styles
  defstyle :padding, styles: __MODULE__.padding_styles

  defcomponent :pagination, tag: :ul

  defstyle :pagination_next
  defstyle :pagination_previous

  defcomponent :subnav,
    tag: :ul,
    styles: [
      :divider,
      :pill
    ]
  defcomponent :subnav_item

  defcomponent :tab,
    tag: :ul,
    seed: false,
    attr: true,
    styles: [
      :bottom,
      :left,
      :right
    ],
    component_options: [
      :connect,
      :toggle,
      :active,
      :animation,
      :duration,
      :swiping,
      :media
    ]

  defcomponent :totop,
    seed: false,
    attr: true
end
