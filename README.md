# UIKit

[![Hex.pm](https://img.shields.io/hexpm/v/uikit.svg)](https://hex.pm/packages/uikit)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/uikit/index.html)
[![Build Status](https://travis-ci.org/ijcd/uikit.svg?branch=master)](https://travis-ci.org/ijcd/uikit)

** WARNING: This is alpha software. Much of it is already useable, but it is not done yet. Expect changes. **

[UIKit](https://getuikit.com/) is a front-end framework for working
with HTML and CSS. It is noteworthy in its approach to handling DOM
changes. From the UIKit documentation:

> UIkit is listening for DOM manipulations and will automatically
> initialize, connect and disconnect components as they are inserted
> or removed from the DOM. That way it can easily be used with
> JavaScript frameworks like Vue.js and React.

This makes it easy to use with projects that do their own DOM
manipulation, like [Presto](https://github.com/ijcd/presto).

[Documentation](http://hexdocs.pm/uikit/)

## Usage

For now, the best examples for working with the library are in the [demo app](https://github.com/ijcd/uikit_demo).

In general, UIKit elements show up as functions that take attribute atom and functions.
Internally, UIKit will combine those to create the right output.

The library is helpful, because without it, you will have to remember all of the intricate combinations
of HTML tags and attributes. Combined with [taggart](https://github.com/ijcd/taggart), you can also
create helper functions to further decompose your views.

```
uk_section(:default, padding(:remove_vertical)) do
  uk_container do
    h1 "Padding Remove"
    uk_grid(:match, child_width("1-3@m")) do
      lorem()
      lorem()
      lorem()
    end
  end
end
```

### Simple Usage

To use UIKit in your Phoenix Views, simply pull it into your view code and use it:

```
use UIKit
```

A simple alert:

```
uk_alert(:danger) do
  uk_alert_close_link("#")
  h3 "Notice"
  p "Lorem ipsum dolor sit amet."
end
```

### Nested Layouts

In `app.html.eex`:

```
<%= render @view_module, @view_template, Map.put(assigns, :layout, {MyWeb.LayoutView, "nested.html"}) %>
```

```
defmodule MyWeb.LayoutView do
  use MyWeb, :view

  use Taggart.HTML
  use UIKit

  def render("nested.html", assigns) do
    uk_container(:center) do
      Phoenix.View.render(assigns[:view_module], assigns[:view_template], assigns)
    end
  end
end
```


## Installation

The package can be installed by adding `uikit` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:uikit, "~> 0.1.0"}
  ]
end
```

Getting the front-end parts to work is trickier. If you get stuck, you can refer to [this tutorial](https://medium.com/@ravernkoh/installing-uikit-3-in-phoenix-1-3-and-brunch-ba6c0262ab9c)


Update some javascript dependencies:

```
cd assets
yarn add jquery
yarn add uikit
yarn add sass-brunch
```

Update `assets/brunch-config.js`:

```
  ...
  // Configure your plugins
  plugins: {
    ...
    sass: {
      options: {
        includePaths: ["node_modules"]
      }
    }
    ...
  },
  npm: {
    enabled: true,
    globals: {
      $: "jquery",
      jQuery: "jquery",
      UIkit: "uikit",
      icons: "uikit/dist/js/uikit-icons",
    },
    styles: {
    }
  }
  ...
```

UIKit uses Sass, so you will need that too. Update `assets/css/app.scss`

```
@import "uikit/src/scss/variables.scss";
@import "uikit/src/scss/mixins.scss";
@import "uikit/src/scss/uikit.scss";
```

And for icons, add this to `assets/js/app.js`:

```
uikit.use(icons);
```

