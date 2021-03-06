defmodule UIKit.Element.Component do
  import UIKit

  # <li class="uk-open"></li>
  defcomponent(
    :accordion,
    tag: :ul,
    seed: :never,
    attr: true,
    component_opts: [
      :targets,
      :active,
      :collapsible,
      :multiple,
      :animation,
      :transition,
      :duration
    ]
  )

  defcomponent(:accordion_title, tag: :h3)
  defcomponent(:accordion_content, tag: :div)

  defcomponent(:open, tag: :li)
  defstyle(:open)

  defcomponent(
    :alert,
    seed: :never,
    attr: true,
    styles: [
      :primary,
      :success,
      :warning,
      :danger
    ],
    component_options: [
      :animation,
      :duration,
      :sel_close
    ]
  )

  defmacro uk_alert_close_link(href) do
    quote location: :keep do
      a(href: unquote(href), class: "uk-alert-close", "uk-close": true)
    end
  end

  defmacro uk_alert_close_button() do
    quote location: :keep do
      button(class: "uk-alert-close", type: "button", "uk-close": true)
    end
  end

  # Use the .uk-text-lead class from the Text component to create a leading paragraph.
  defcomponent(:article, tag: :article)
  defcomponent(:article_title, tag: :h1)
  defcomponent(:article_meta, tag: :p)

  defcomponent(
    :background,
    seed: :empty,
    styles: [
      # style
      :default,
      :muted,
      :primary,
      :secondary,
      # size
      :cover,
      :contain,
      # position
      :top_left,
      :top_center,
      :top_right,
      :center_left,
      :center_center,
      :center_right,
      :bottom_left,
      :bottom_center,
      :bottom_right,
      # repeat
      :norepeat,
      # attachment
      :fixed,
      # responsive
      :image@s,
      :image@m,
      :image@l,
      :image@xl,
      # blend
      :blend_multiply,
      :blend_screen,
      :blend_overlay,
      :blend_darken,
      :blend_lighten,
      :blend_color_dodge,
      :blend_color_burn,
      :blend_hard_light,
      :blend_soft_light,
      :blend_difference,
      :blend_exclusion,
      :blend_hue,
      :blend_saturation,
      :blend_color,
      :blend_luminosity
    ]
  )

  defstyle(
    :background,
    seed: :empty,
    styles: [
      # style
      :default,
      :muted,
      :primary,
      :secondary,
      # size
      :cover,
      :contain,
      # position
      :top_left,
      :top_center,
      :top_right,
      :center_left,
      :center_center,
      :center_right,
      :bottom_left,
      :bottom_center,
      :bottom_right,
      # repeat
      :norepeat,
      # attachment
      :fixed,
      # responsive
      :image@s,
      :image@m,
      :image@l,
      :image@xl,
      # blend
      :blend_multiply,
      :blend_screen,
      :blend_overlay,
      :blend_darken,
      :blend_lighten,
      :blend_color_dodge,
      :blend_color_burn,
      :blend_hard_light,
      :blend_soft_light,
      :blend_difference,
      :blend_exclusion,
      :blend_hue,
      :blend_saturation,
      :blend_color,
      :blend_luminosity
    ]
  )

  # <span class="uk-badge"></span>
  # <a class="uk-badge"></a>
  defcomponent(:badge, tag: :span)

  defmacro uk_badge_link(href, do: content) do
    quote location: :keep do
      a(class: "uk-badge", href: unquote(href), do: unquote(content))
    end
  end

  defmacro uk_badge_link(href, content) do
    quote location: :keep do
      uk_badge_link(unquote(href), do: unquote(content))
    end
  end

  # - uk-width-1-1
  # disabled
  defcomponent(
    :button,
    tag: :button,
    attr_opts: [:href, :disabled, :type],
    styles: [
      # style
      :default,
      :primary,
      :secondary,
      :danger,
      :text,
      :link,
      # sizes
      :small,
      :large,
      # overlap
      :overlap
    ]
  )

  defcomponent(
    :button_link,
    tag: :a,
    seed_value: "button",
    component: :button,
    attr_opts: [:href, :disabled, :type],
    styles: [
      # style
      :default,
      :primary,
      :secondary,
      :danger,
      :text,
      :link,
      # sizes
      :small,
      :large,
      # overlap
      :overlap
    ]
  )

  defcomponent(:button_group)

  defcomponent(
    :card,
    styles: [
      # style
      :default,
      :primary,
      :secondary,
      # size
      :small,
      :large,
      # hover
      :hover,
      :large,
      # media
      :media_top,
      :media_bottom,
      :media_left,
      :media_right
    ]
  )

  defcomponent(:card_header)
  defcomponent(:card_body, component: :card)
  defcomponent(:card_footer)
  defcomponent(:card_title, tag: :h3)

  defcomponent(
    :card_media,
    seed: :empty,
    styles: [
      :top,
      :bottom,
      :left,
      :right
    ]
  )

  defstyle(
    :card_media,
    seed: :empty,
    styles: [
      :top,
      :bottom,
      :left,
      :right
    ]
  )

  # <div class="uk-card-badge uk-label"></div>
  defcomponent(:card_badge)

  # <button type="button" uk-close></button>
  # <a href="" uk-close></a>
  # <div uk-alert>
  #     <button class="uk-alert-close" type="button" uk-close></button>
  # </div>
  # <button class="uk-modal-close-default" type="button" uk-close></button>
  # TODO: see modal?
  # defboolean :close,
  #   styles: [:large],
  #   allowed_tags: [:a, :button]

  # defcomponent :close,
  #   tag: :a,
  #   seed: :never,
  #   attr: true,  
  #   attr_opts: [:href]
  # defcomponent :close_button,
  #   tag: :button,
  #   seed: :never,
  #   attr: true

  defcomponent(
    :close,
    tag: :button,
    seed: [type: "button"],
    attr: true,
    attr_opts: [:href]
  )

  defcomponent(
    :close_link,
    tag: :a,
    seed: :never,
    attr: true,
    component: :close,
    attr_opts: [:href]
  )

  defcomponent(:comment, tag: :article, styles: :primary)
  defcomponent(:comment_header, tag: :header)

  # BUG: unable to use :img since defcomponent is currently insisting on content tags
  # defcomponent :comment_avatar,
  #   tag: :img,
  #   attr_opts: [:src, :width, :height, :alt]

  defcomponent(:comment_title, tag: :h4)
  defcomponent(:comment_meta, tag: :ul)
  defcomponent(:comment_meta_item, tag: :li)
  defcomponent(:comment_body)
  defcomponent(:comment_list, tag: :ul)
  defcomponent(:comment_list_item, tag: :li)

  defstyle(:comment_meta)
  defstyle(:comment_avatar)

  defcomponent(:countdown, component_options: [:date])

  defcomponent(:countdown_number, tag: :span)

  defcomponent(
    :countdown_days,
    tag: :span,
    seed: [class: "uk-countdown-number uk-countdown-days"]
  )

  defcomponent(
    :countdown_hours,
    tag: :span,
    seed: [class: "uk-countdown-number uk-countdown-hours"]
  )

  defcomponent(
    :countdown_minutes,
    tag: :span,
    seed: [class: "uk-countdown-number uk-countdown-minutes"]
  )

  defcomponent(
    :countdown_seconds,
    tag: :span,
    seed: [class: "uk-countdown-number uk-countdown-seconds"]
  )

  defcomponent(:countdown_separator, tag: :span)
  defcomponent(:countdown_label)

  defstyle(:countdown_number, seed_value: "countdown-number")
  defstyle(:countdown_days, seed: [class: "uk-countdown-number uk-countdown-days"])
  defstyle(:countdown_hours, seed: [class: "uk-countdown-number uk-countdown-hours"])
  defstyle(:countdown_minutes, seed: [class: "uk-countdown-number uk-countdown-minutes"])
  defstyle(:countdown_seconds, seed: [class: "uk-countdown-number uk-countdown-seconds"])
  defstyle(:countdown_separator)

  defcomponent(
    :description_list,
    tag: :dl,
    styles: [
      :divider
    ]
  )

  defcomponent(
    :divider,
    tag: :hr,
    styles: [
      :icon,
      :smal
    ]
  )

  defcomponent(
    :drop,
    seed: :never,
    attr: true,
    styles: [
      :bottom_left,
      :bottom_center,
      :bottom_right,
      :bottom_justify,
      :top_left,
      :top_center,
      :top_right,
      :top_justify,
      :left_top,
      :left_center,
      :left_bottom,
      :right_top,
      :right_center,
      :right_bottom
    ],
    component_options: [
      :toggle,
      :pos,
      :mode,
      :delay_show,
      :delay_hide,
      :boundary,
      :boundary_align,
      :flip,
      :offset,
      :animation,
      :duration
    ]
  )

  # <div class="uk-drop-grid uk-child-width-1-2@m" uk-grid>...</div>
  defcomponent(:drop_grid)

  defcomponent(
    :dropdown,
    seed: :never,
    attr: true,
    styles: [
      :bottom_left,
      :bottom_center,
      :bottom_right,
      :bottom_justify,
      :top_left,
      :top_center,
      :top_right,
      :top_justify,
      :left_top,
      :left_center,
      :left_bottom,
      :right_top,
      :right_center,
      :right_bottom
    ],
    component_options: [
      :toggle,
      :pos,
      :mode,
      :delay_show,
      :delay_hide,
      :boundary,
      :boundary_align,
      :flip,
      :offset,
      :animation,
      :duration
    ]
  )

  # TODO: "formify" macro that walks the AST and converts tags into these
  defcomponent(
    :form,
    seed: :empty,
    styles: [
      # style
      :danger,
      :success,
      # size
      :large,
      :small,
      # width
      :width_large,
      :width_medium,
      :width_small,
      :width_xsmall,
      # blank
      :blank,
      # layout
      :stacked,
      :horizontal,
      :label,
      :controls
    ]
  )

  defcomponent(:input, tag: :input)
  defcomponent(:select, tag: :select)
  defcomponent(:textarea, tag: :textarea)
  defcomponent(:radio, tag: :input, extra_attrs: [type: :radio])
  defcomponent(:checkbox, tag: :input, extra_attrs: [type: :checkbox])
  defcomponent(:range, tag: :input, extra_attrs: [type: :range])
  defcomponent(:fieldset, tag: :fieldset)
  defcomponent(:form_label, tag: :label)

  defcomponent(
    :form_controls,
    styles: [
      :text
    ]
  )

  defcomponent(
    :form_icon,
    tag: :span,
    styles: [
      :flip
    ],
    attr: [icon: :user]
  )

  defcomponent(
    :form_custom,
    component_options: [
      :target
    ]
  )

  defcomponent(
    :heading,
    tag: :h1,
    seed: :never,
    styles: [
      :primary,
      :hero,
      :divider,
      :bullet,
      :line
    ]
  )

  # defcomponent :icon,
  #   styles: [
  #     :link,
  #     :button,
  #     :image,
  #   ],
  #   component_options: [
  #     :icon,
  #     :ratio
  #   ]

  defmacro uk_icon(icon, styles \\ []) do
    quote location: :keep do
      styles = [attr("uk-icon": "icon: #{unquote(icon)}"), unquote(styles)]
      uk(:span, styles)
    end
  end

  defmacro uk_icon_link(icon) do
    quote location: :keep do
      Taggart.HTML.a(nil, href: "#", "uk-icon": "icon: #{unquote(icon)}")
    end
  end

  defcomponent(
    :iconnav,
    tag: :ul,
    styles: [
      :vertical
    ]
  )

  defcomponent(:iconnav_item, tag: :li)

  defcomponent(
    :label,
    tag: :span,
    styles: [
      :success,
      :warning,
      :danger
    ]
  )

  defcomponent(
    :lightbox,
    seed: :empty,
    attr: true,
    component_options: [
      :animation,
      :autoplay,
      :autoplay_interval,
      :pause_on_hover,
      :video_autoplay,
      :index,
      :toggle
    ]
  )

  # lightbox
  defdata(:caption)
  defdata(:poster)

  # lightbox
  defdata(
    :type,
    options: [
      :image,
      :video,
      :iframe
    ]
  )

  defcomponent(
    :link,
    tag: :a,
    seed: :empty,
    attr_opts: [:href, :disabled, :type],
    styles: [
      :muted,
      :text,
      :reset
    ]
  )

  defcomponent(
    :list,
    tag: :ul,
    styles: [
      :list,
      :bullet,
      :striped,
      :large
    ]
  )

  defcomponent(:list_item, tag: :li)

  # defboolean :marker

  defcomponent(
    :modal,
    seed: :empty,
    attr: true,
    styles: [
      :conatiner,
      :full
    ],
    component_styles: [
      :esc_close,
      :bg_close,
      :stack,
      :container
    ]
  )

  # <div class="uk-modal-dialog" uk-overflow-auto></div>
  defcomponent(:modal_dialog)
  defcomponent(:modal_body)
  defcomponent(:modal_title, tag: :h2)

  defcomponent(
    :modal_close,
    tag: :button,
    styles: [
      :default,
      :outside,
      :full,
      :large
    ]
  )

  defcomponent(
    :offcanvas,
    seed: :empty,
    attr: true,
    component_options: [
      :mode,
      :flip,
      :overlay
    ]
  )

  defcomponent(:offcanvas_bar)
  defcomponent(:offcanvas_content)
  # TODO: maybe close() needs to detect what it is inside somehow?
  defcomponent(:offcanvas_close)

  defcomponent(
    :overlay,
    styles: [
      :default,
      :primary
    ]
  )

  defstyle(
    :overlay,
    seed: :always,
    styles: [
      :default,
      :primary
    ]
  )

  defcomponent(:overlay_icon, tag: :span)

  defcomponent(:placholder)

  defcomponent(:progress, tag: :progress)

  defcomponent(
    :search,
    tag: :form,
    styles: [
      :default,
      :large,
      :navbar
    ]
  )

  defcomponent(:search_input, extra_attrs: [type: "search", placeholder: ""])
  defboolean(:search_icon)
  defstyle(:search_toggle)

  defcomponent(
    :slideshow,
    seed: :never,
    attr: true,
    component_options: [
      :slide,
      :fade,
      :scale,
      :pull,
      :push,
      # animation (are these in the right place?, maybe they go on parallax?
      :animation,
      :autoplay,
      :autoplay_interval,
      :pause_on_hover,
      :velocity,
      :ratio,
      :min_height,
      :max_height,
      :index
    ]
  )

  defcomponent(:slideshow_items, tag: :ul)
  # defcomponent :slideshow_item,
  #   styles: [
  #     :next,
  #     :previous
  #   ]
  defcomponent(:slideshow_parallax)

  # defmacro uk_icon(icon, styles \\ []) do
  #   quote location: :keep do
  #     styles = [attr("uk-icon": "icon: #{unquote(icon)}"), unquote(styles)]
  #     uk(:span, styles)
  #   end
  # end

  defmacro uk_slideshow_item(index, styles \\ [], do: block) do
    quote location: :keep do
      styles = [attr("uk-slideshow-item": "#{unquote(index)}"), unquote(styles)]
      uk(:li, styles, do: unquote(block))
    end
  end

  defcomponent(
    :sortable,
    seed: :empty,
    attr: true,
    component_options: [
      :group,
      :animation,
      :threshold,
      :cls_item,
      :cls_placeholder,
      :cls_drag,
      :cls_drag_state,
      :cls_base,
      :cls_no_drag,
      :cls_empty,
      :cls_custom,
      :handle
    ]
  )

  defcomponent(:sortable_handle)

  defcomponent(:spinner)

  defcomponent(
    :switcher,
    seed: :empty,
    attr: true,
    component_options: [
      :connect,
      :toggle,
      :active,
      :animation,
      :duration,
      :swiping
    ]
  )

  defstyle(:switcher_item)

  defcomponent(
    :table,
    tag: :table,
    styles: [
      :divider,
      :striped,
      :hover,
      :small,
      :justify,
      :middle,
      :responsive
    ]
  )

  defstyle(
    :table,
    styles: [
      :shrink,
      :expand,
      :link
    ]
  )

  defcomponent(
    :text,
    tag: :p,
    seed: :empty,
    styles:
      [
        # modifiers
        :lead,
        :meta,
        # size
        :small,
        :large,
        # font weight
        :bold,
        :uppercase,
        :capitalize,
        :lowercase,
        # color
        :muted,
        :primary,
        :success,
        :warning,
        :danger,
        # background
        :background,
        # alignment
        :left,
        :right,
        :center,
        :justify,
        # responsive
        for(
          col <- [:left, :center, :right],
          bp <- [:s, :m, :l],
          do: "uk-text-#{col}@{bp}"
        ),
        # vertical align
        :top,
        :middle,
        :bottom,
        :baseline,
        # wrapping
        :truncate,
        :break,
        :nowrap
      ]
      |> List.flatten()
  )

  defstyle(
    :text,
    styles:
      [
        # modifiers
        :lead,
        :meta,
        # size
        :small,
        :large,
        # font weight
        :bold,
        :uppercase,
        :capitalize,
        :lowercase,
        # color
        :muted,
        :primary,
        :success,
        :warning,
        :danger,
        # background
        :background,
        # alignment
        :left,
        :right,
        :center,
        :justify,
        # responsive
        for(
          col <- [:left, :center, :right],
          bp <- [:s, :m, :l],
          do: "uk-text-#{col}@{bp}"
        ),
        # vertical align
        :top,
        :middle,
        :bottom,
        :baseline,
        # wrapping
        :truncate,
        :break,
        :nowrap
      ]
      |> List.flatten()
  )

  defcomponent(
    :thumbnav,
    tag: :ul,
    styles: [
      :vertical
    ]
  )

  defcomponent(:thumnav_item, tag: :li)

  defcomponent(
    :tile,
    styles: [
      :default,
      :muted,
      :primary,
      :secondary
    ]
  )

  # TODO: bring in comonent_option docs for all items
  defcomponent(
    :toggle,
    seed: :empty,
    attr: true,
    tag: [:button, :a],
    component_options: [
      :target,
      :mode,
      :cls,
      :animation,
      :duration,
      :queued
    ]
  )

  defcomponent(
    :tooltip,
    seed: :empty,
    attr: true,
    component_options: [
      :pos,
      :offset,
      :animation,
      :duration,
      :delay,
      :cls
    ]
  )
end
