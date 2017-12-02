defmodule UIKit.Component do
  use Taggart.HTML

  defmodule Attr do
    defstruct [
      name: nil,
      styles: [],
      seed: true,
      boolean: false,
    ]

    # def new(), do: %__MODULE__{styles: []}
    # def new(nil), do: %__MODULE__{styles: []}
    def new(style), do: %__MODULE__{styles: [style]}

    def join(%__MODULE__{} = a, %__MODULE__{} = b) do
      %{a | styles: a.styles ++ b.styles}
    end
    def join(%__MODULE__{} = a, nil), do: a
    def join(%__MODULE__{} = a, b), do: join(a, new(b))
    def join(a, b), do: join(new(a), b)

    def build(%__MODULE__{} = attr) do
      for = attr.name
      class_seed = if(attr.boolean || !attr.seed, do: [], else: ["uk-#{for}"])
      boolean = if(attr.boolean, do: ["uk-#{for}"], else: [])
      classes = Enum.map(attr.styles, &resolve_class(for, &1))

      joined_classes =
        case (class_seed ++ classes) do
          [] -> nil
           c -> Enum.join(c, " ")
        end

      [
        class: joined_classes,
        "#{boolean}": attr.boolean,
      ]
    end

    defp resolve_class(_for, {m, style}), do: tuple_to_class({m, style})
    defp resolve_class(for, style), do: tuple_to_class({for, style})

    # TODO: move to StyleHelpers?
    defp tuple_to_class({:width, {kind, cols, over, media}}) do
      "uk-#{kind}-width-#{cols}-#{over}@#{media}"
    end
    defp tuple_to_class({for, style}) do
      "#{style}"
      |> String.replace("_", "-")
      |> (&("uk-#{for}-#{&1}")).()
    end
  end

  def a | b, do: Attr.join(a, b)

  defmacro defcomponent(name, opts \\ []) do
    quote location: :keep, bind_quoted: [
      name: name,
      tag: Keyword.get(opts, :tag, :div),
      default_style: Keyword.get(opts, :default_style),
      seed: Keyword.get(opts, :seed, true),
      boolean: Keyword.get(opts, :boolean, false),
    ] do
      defmacro unquote(:"uk_#{name}")(style \\ unquote(default_style), do: block) do
        name = unquote(name)
        tag = unquote(tag)
        seed = unquote(seed)
        boolean = unquote(boolean)

        quote location: :keep do
          name = unquote(name)
          tag = unquote(tag)
          seed = unquote(seed)
          boolean = unquote(boolean)

          attr0 = %Attr{
            name: name,
            seed: seed,
            boolean: boolean
          }

          unquote(tag)(nil, Attr.build(attr0 | unquote(style))) do
            unquote(block)
          end
        end
      end
    end
  end

  defmacro defstyle(_name, _opts \\ []) do
    quote location: :keep, bind_quoted: [
    ] do
    end
  end

  defmacro defboolean(_name, _opts \\ []) do
    quote location: :keep, bind_quoted: [
    ] do
    end
  end

  defmacro defdata(_name, _opts \\ []) do
    quote location: :keep, bind_quoted: [
    ] do
    end
  end


end

defmodule UIKit.Layout do
  import UIKit.Component

  # <li class="uk-open"></li>
  defcomponent :accordion,
    tag: :ul,
    seed: false,
    boolean: true,
    component_opts: [
      :targets,
      :active,
      :collapsible,
      :multiple,
      :animation,
      :transition,
      :duration
    ]
  defcomponent :accordion_title,
    tag: :h3
  defcomponent :accordion_content,
    tag: :div

  defcomponent :alert,
    boolean: true,
    seed: false,
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
  defcomponent :alert_close,
    tag: :a,
    boolean: "uk-close"

  defstyle :align,
    styles: (for col <- [:left, :center, :right], bp <- [:s, :m, :l, :xl], do: "uk-align-#{col}@{bp}")

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

  # Use the .uk-text-lead class from the Text component to create a leading paragraph.
  defcomponent :article, tag: :article
  defcomponent :article_title, tag: :h1
  defcomponent :article_meta, tag: :p

  defstyle :background,
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

  # <span class="uk-badge"></span>
  # <a class="uk-badge"></a>
  defcomponent :badge,
    tag: :span

  # <li class="uk-disabled"><a href=""></a></li>
  defcomponent :breadcrumb,
    tag: :ul

  # - uk-width-1-1
  # disabled
  defcomponent :button,
    tag: [:button, :a],
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
  defcomponent :button_group

  defcomponent :card,
    styles: [
      #style
      :default,
      :primary,
      :secondary,
      #size
      :small,
      :large,
      #hover
      :hover,
      :large,
      #media
      :media_top,
      :media_bottom,
      :media_left,
      :media_right
  ]
  defcomponent :card_header
  defcomponent :card_body
  defcomponent :card_footer
  defcomponent :card_title,
    tag: :h3
  defcomponent :card_media,
    styles: [
      :top,
      :bottom,
      :left,
      :right
    ]
  # <div class="uk-card-badge uk-label"></div>
  defcomponent :card_badge


  # <button type="button" uk-close></button>
  # <a href="" uk-close></a>
  # <div uk-alert>
  #     <button class="uk-alert-close" type="button" uk-close></button>
  # </div>
  # <button class="uk-modal-close-default" type="button" uk-close></button>
  # TODO: see modal?
  defboolean :close,
    styles: [:large],
    allowed_tags: [:a, :button]

  # could be style?
  defcomponent :column,
    styles: [
      (for col <- 1..6, bp <- [:s, :m, :l, :xl], do: "uk-column-1-#{col}@{bp}"),
      :divider,
    ] |> List.flatten
  defstyle :column,
    styles: [
      :span
    ]

  defcomponent :comment,
    tag: :article,
    styles: :primary
  defcomponent :comment_header,
    tag: :header
  defcomponent :comment_avatar,
    tag: :img
  defcomponent :comment_title
  defcomponent :comment_meta
  defcomponent :comment_body
  defcomponent :comment_list,
    tag: :ul

  defcomponent :container,
    styles: [
      :small,
      :large,
      :expand
    ]

  defcomponent :countdown_days,
    component_options: [:date]
  defcomponent :countdown_hours,
    tag: :span,
    seed: "uk-countdown-number"
  defcomponent :countdown_minutes,
    tag: :span,
    seed: "uk-countdown-number"
  defcomponent :countdown_seconds,
    tag: :span,
    seed: "uk-countdown-number"
  defcomponent :countdown_number,
    tag: :span,
    seed: "uk-countdown-number"
  defcomponent :coundown_separator
  defcomponent :coundown_label

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

  defcomponent :description_list,
    tag: :dl,
    styles: [
      :divider
    ]

  defcomponent :divider,
    tag: :hr,
    styles: [
      :icon,
      :smal
    ]

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

  defcomponent :drop,
    seed: false,
    boolean: true,
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
      :right_bottom,
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
      :duration,
    ]
  # <div class="uk-drop-grid uk-child-width-1-2@m" uk-grid>...</div>
  defcomponent :drop_grid

  defcomponent :dropdown,
    seed: false,
    boolean: true,
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
      :right_bottom,
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

  # TODO: bp is optional, and we probably won't pass it as a built string
  defcomponent :flex,
    styles: [
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

  # TODO: "formify" macro that walks the AST and converts tags into these
  defcomponent :form,
    seed: false,
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
      :controls,
    ]
  defcomponent :input,
    tag: :input
  defcomponent :select,
    tag: :select
  defcomponent :textarea,
    tag: :textarea
  defcomponent :radio,
    tag: :input,
    extra_attrs: [type: :radio]
  defcomponent :checkbox,
    tag: :input,
    extra_attrs: [type: :checkbox]
  defcomponent :range,
    tag: :input,
    extra_attrs: [type: :range]
  defcomponent :fieldset,
    tag: :fieldset
  defcomponent :form_label,
    tag: :label
  defcomponent :form_controls,
    styles: [
      :text
    ]
  defcomponent :form_icon,
    tag: :span,
    styles: [
      :flip
    ],
    boolean: [icon: :user]
  defcomponent :form_custom,
    component_options: [
      :target
    ]

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

  defcomponent :heading,
    tag: :h1,
    seed: false,
    styles: [
      :primary,
      :hero,
      :divider,
      :bullet,
      :line
    ]

  defcomponent :icon,
    styles: [
      :link,
      :button,
      :image,
    ],
    component_options: [
      :icon,
      :ratio
    ]

  defcomponent :iconnav,
    tag: :ul,
    styles: [
      :vertical
    ]

  defstyle :light
  defstyle :dark

  defcomponent :label,
    tag: :span,
    styles: [
      :success,
      :warning,
      :danger
    ]

  defcomponent :lightbox,
    seed: false,
    boolean: true,
    component_options: [
      :animation,
      :autoplay,
      :autoplay_interval,
      :pause_on_hover,
      :video_autoplay,
      :index,
      :toggle
    ]

  # lightbox
  defdata :caption
  defdata :poster

  # lightbox
  defdata :type,
    options: [
      :image,
      :video,
      :iframe
    ]

  defcomponent :link,
    tag: :a,
    styles: [
      :muted,
      :text,
      :reset
    ]

  defcomponent :list,
    tag: :ul,
    styles: [
      :list,
      :bullet,
      :striped,
      :large
    ]

  defstyle :margin,
    styles: [
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
  defboolean :margin,
    component_options: [
      :margin,
      :first_column
    ]

  defboolean :marker

  defcomponent :modal,
    seed: false,
    boolean: true,
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
  # <div class="uk-modal-dialog" uk-overflow-auto></div>
  defcomponent :modal_dialog
  defcomponent :modal_body
  defcomponent :modal_title,
    tag: :h2
  defcomponent :modal_close,
    tag: :button,
    styles: [
      :default,
      :outside,
      :full,
      :large
    ]

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
  defcomponent :nav_sub,
    tag: :ul
  defcomponent :nav_parent_icon,
    tag: :ul,
    seed: false,
    boolean: "uk-nav"
  defcomponent :nav_header,
    tag: :li
  defcomponent :nav_footer,
    tag: :li

  # where should this be?
  defstyle :dropdown_nav

  # where should these be?
  defstyle :active
  defstyle :parent

  defcomponent :navbar,
    tag: :nav,
    seed: false,
    boolean: "uk-navbar",
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
    boolean: "uk-navbar",
    syltes: [
      :transparent
    ]
  defcomponent :navbar_left
  defcomponent :navbar_center
  defcomponent :navbar_center_left
  defcomponent :navbar_center_right
  defcomponent :navbar_right
  defcomponent :navbar_nav,
    tag: :ul
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

  # where should these be?
  defstyle :logo

  # TODO: notifications are all JS -- how to handle this? Event components?
  # IDEA: event components combined with Presto to forward notifications?

  defcomponent :offcanvas,
    seed: false,
    boolean: true,
    component_options: [
      :mode,
      :flip,
      :overlay
    ]
  defcomponent :offcanvas_bar
  defcomponent :offcanvas_content
  # TODO: maybe close() needs to detect what it is inside somehow?
  defcomponent :offcanvas_close

  defstyle :overlay,
    styles: [
      :default,
      :primary
    ]
  defcomponent :overlay_icon,
    tag: :span

  defcomponent :padding,
    styles: [
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

  defcomponent :pagination,
    tag: :ul

  defstyle :pagination_next
  defstyle :pagination_previous

  defstyle :active
  defstyle :disabled

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

  defcomponent :placholder

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

  # Print has no components

  defcomponent :progress,
    tag: :progress

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

  defcomponent :search,
    tag: :form,
    styles: [
      :default,
      :large,
      :navbar
    ]
  defcomponent :search_input,
    extra_attrs: [type: "search", placeholder: ""]
  defboolean :search_icon
  defstyle :search_toggle

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

  defcomponent :slidenav_container
  defboolean :slidenav_next
  defboolean :slidenav_previous

  defcomponent :slideshow,
    seed: false,
    boolean: true,
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
  defcomponent :slideshow_items,
    tag: :ul
  defcomponent :slideshow_item,
    styles: [
      :next,
      :previous
    ]
  defcomponent :slideshow_parallax,
    component_options: [
      # where?
    ]

  defcomponent :sortable,
    seed: false,
    boolean: true,
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
  defcomponent :sortable_handle

  defcomponent :spinner

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

  defcomponent :subnav,
    tag: :ul,
    styles: [
      :divider,
      :pill
    ]

  defcomponent :switcher,
    seed: false,
    boolean: true,
    component_options: [
      :connect,
      :toggle,
      :active,
      :animation,
      :duration,
      :swiping
    ]
  defstyle :switcher_item

  defcomponent :tab,
    tag: :ul,
    seed: false,
    boolean: true,
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

  defcomponent :table,
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
  defstyle :table,
    styles: [
      :shrink,
      :expand,
      :link
    ]

  defcomponent :text,
    tag: :p,
    seed: false,
    styles: [
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
      (for col <- [:left, :center, :right], bp <- [:s, :m, :l], do: "uk-text-#{col}@{bp}"),
      # vertical align
      :top,
      :middle,
      :bottom,
      :baseline,
      # wrapping
      :truncate,
      :break,
      :nowrap
    ] |> List.flatten

  defstyle :text,
    styles: [
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
      (for col <- [:left, :center, :right], bp <- [:s, :m, :l], do: "uk-text-#{col}@{bp}"),
      # vertical align
      :top,
      :middle,
      :bottom,
      :baseline,
      # wrapping
      :truncate,
      :break,
      :nowrap
    ] |> List.flatten

  defcomponent :thumbnav,
    tag: :ul,
    styles: [
      :vertical
    ]

  defcomponent :tile,
    styles: [
      :default,
      :muted,
      :primary,
      :secondary
    ]

  # TODO: bring in comonent_option docs for all items
  defcomponent :toggle,
    seed: false,
    boolean: true,
    tag: [:button, :a],
    component_options: [
      :target,
      :mode,
      :cls,
      :animation,
      :duration,
      :queued
    ]

  defcomponent :tooltip,
    seed: false,
    boolean: true,
    component_options: [
      :pos,
      :offset,
      :animation,
      :duration,
      :delay,
      :cls
    ]

  defcomponent :totop,
    seed: false,
    boolean: true

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

  # upload is javascript only

  ## UTILITY
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
    boolean: true,
    component_options: [
      :fill,
      :media
    ]

  defstyle :logo,
    styles: [
      :inverse
    ]

  defstyle :svg,
    boolean: true,
    allowed_tags: [:img]

  defstyle :gif,
    boolean: true,
    allowed_tags: [:img]

  defstyle :video,
    boolean: true,
    component_options: [
      :autoplay,
      :automute
    ]

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
    styles: (for v <- [:top, :center, :bottom], h <- [:left, :center, :right], do: "uk-transform-origin-#{v}-#{h}")

  defboolean :disabled,
    allowed_tags: [
      :input,
      :select,
      :textarea,
      :button
    ]

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
    seed: false,
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
    seed: false,
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
    seed: false,
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

defmodule UIKit.Styles do
  def padding(sym), do: {:padding, sym}
  def position(sym), do: {:position, sym}
  def margin(sym), do: {:margin, sym}
  def flex(sym), do: {:flex, sym}
  def text(sym), do: {:text, sym}
  def width(kind, cols, over, media), do: {:width, {kind, cols, over, media}}
end

defmodule UIKit do
  defmacro __using__(_opts) do
    quote do
      import UIKit.Layout
      import UIKit.Styles
      defdelegate a | b, to: UIKit.Component
    end
  end
end
