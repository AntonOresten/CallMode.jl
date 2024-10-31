# CallMode

Tired of calling functions with silly and arbitrary punctuation? Call mode was made for you.

Call mode can be activated with a closing parenthesis, `)`, symbolizing how we close our relationship with the legacy syntax.

```julia
julia> using CallMode

julia> mapreduce(abs2, +, 1:5; init=1) # verbose and ugly
56

@call> mapreduce abs2 Base.:+ 1:5 init=1 # concise and pretty
56
```

`Base.:+` is necessary, as `+` would get parsed to call `+(abs2, 1)`. One could alternatively use `(+)`, at the cost of using parentheses.

CallMode also exports the `@call` macro, in case you don't even want to use `)` to activate Call mode:

```julia
julia> @call mapreduce abs2 Base.:+ 1:5 init=1
56
```
