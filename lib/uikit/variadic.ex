defmodule UIKit.Variadic do
  @moduledoc false

  @doc false
  defmacro make_variadic_class(name, n) do    
    quote location: :keep, bind_quoted: [name: name, n: n] do
      params = for p <- 1..n, do: Macro.var(:"p#{p}", nil)

      defmacro unquote(name)(unquote_splicing(params)) do
        name = unquote(name)
        params = unquote(params)
        quote location: :keep do
          unquote(name)(unquote(params))
        end
      end
    end
  end  

  @doc false
  defmacro make_variadic_uk(name, n) do    
    quote location: :keep, bind_quoted: [name: name, n: n] do
      params = for p <- 1..n, do: Macro.var(:"p#{p}", nil)

      defmacro unquote(name)(tag, unquote_splicing(params)) do
        name = unquote(name)
        params = unquote(params)
        quote location: :keep do
          unquote(name)(unquote(tag), unquote(params))
        end
      end
    end
  end  

  @doc false
  defmacro make_variadic_uk_block(name, n) do    
    quote location: :keep, bind_quoted: [name: name, n: n] do
      params = for p <- 1..n, do: Macro.var(:"p#{p}", nil)

      defmacro unquote(name)(tag, unquote_splicing(params), do: block) do
        name = unquote(name)
        params = unquote(params)
        quote location: :keep do
          unquote(name)(unquote(tag), unquote(params), do: unquote(block))
        end
      end
    end
  end  

  @doc false
  defmacro make_variadic_component(name, n) do    
    quote location: :keep, bind_quoted: [name: name, n: n] do
      params = for p <- 1..n, do: Macro.var(:"p#{p}", nil)

      defmacro unquote(name)(unquote_splicing(params), do: block) do
        name = unquote(name)
        params = unquote(params)
        quote location: :keep do
          unquote(name)(unquote(params), do: unquote(block))
        end
      end
    end
  end

  @doc false
  defmacro make_variadic_style(name, n) do    
    quote location: :keep, bind_quoted: [name: name, n: n] do
      params = for p <- 1..n, do: Macro.var(:"p#{p}", nil)

      defmacro unquote(name)(unquote_splicing(params)) do
        name = unquote(name)
        params = unquote(params)
        quote location: :keep do
          unquote(name)(unquote(params))
        end
      end
    end
  end
end