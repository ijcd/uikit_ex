defmodule UIKit.Element.Navigation do
  import UIKit

  # <li class="uk-disabled"><a href=""></a></li>
  defcomponent :breadcrumb,
    tag: :ul
  defcomponent :breadcrumb_item,
    tag: :li,
    seed: :never

  defcomponent :dotnav,
    tag: :ul,
    styles: [
      :vertical
    ]
  defcomponent :dotnav_item,
    tag: :li,
    seed: :never

  def nav_styles do
    [
      :default,
      :primary,
      :center,
      :dropdown_nav,
      :navbar_dropdown_nav
    ]    
  end

  def nav_options do
    [
      :targets,
      :toggle,
      :content,
      :collapsible,
      :multiple,
      :transition,
      :animation,
      :duration
    ]
  end

  ## nav component
  # <ul class="uk-nav">
  # <ul class="uk-nav uk-nav-default">
  # <ul class="uk-nav uk-nav-primary">...</ul>
  # <ul class="uk-nav uk-nav-default uk-nav-center">...</ul>
  # <ul class="uk-nav uk-dropdown-nav">...</ul>
  # <ul class="uk-nav uk-navbar-dropdown-nav">...</ul>
  defcomponent :nav,
    tag: :ul,
    seed: :always,
    styles: __MODULE__.nav_styles,
    component_options: __MODULE__.nav_options
  ## accordion
  # <ul class="uk-nav-default uk-nav-parent-icon" uk-nav>
  # <ul class="uk-nav-parent-icon" uk-nav="multiple: true">...</ul>
  defcomponent :nav_accordion,
    tag: :ul,
    component: :nav,
    seed: :never,
    attr: true

  ## nested
  # <ul class="uk-nav-sub">
  # <li><a href="#">Sub item</a></li>
  defcomponent :nav_sub,
    tag: :ul
  defcomponent :nav_sub_item,
    tag: :li,
    seed: :never
  defcomponent :nav_parent_icon,
    tag: :ul,
    seed: :empty,
    attr: "uk-nav"
  ## header footer
  # <li class="uk-nav-header"></li>
  # <li class="uk-nav-divider"></li>
  defcomponent :nav_header, tag: :li
  defcomponent :nav_footer, tag: :li
  defcomponent :nav_divider, tag: :li

  # where should this be?
  defstyle :dropdown_nav

  defcomponent :navbar,
    tag: :nav,
    seed_value: "navbar-container",
    attr: true,
    styles: [
      :transparent
    ],
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

  defcomponent :navbar_dropdown,
    component: :drop

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
    seed: :empty,
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
    seed: :empty,
    attr: true
end
