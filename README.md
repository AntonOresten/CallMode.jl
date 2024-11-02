# CallMode

Function calls with commas and parentheses? Over it. Call Mode is here to break free.

Activate Call Mode in the REPL with a closing parenthesis, `)`, marking the end of our bond with legacy syntax.

```julia
julia> using CallMode

julia> mapreduce(abs2, +, 1:5; init=1) # clunky and verbose
56

@call> mapreduce abs2 Base.:+ 1:5 init=1 # clean and pure
56
```

Writing `Base.:+` is necessary because `+` would otherwise run `+(abs2, 1)`. One could alternatively use `(+)`, at the cost of using parentheses.

The package also exports the `@call` macro, in case you don't even want to use `)` to activate Call Mode:

```julia
julia> @call mapreduce abs2 Base.:+ 1:5 init=1
56
```

And you can rest assured knowing that [the package source code uses no parentheses](https://github.com/AntonOresten/CallMode.jl/blob/main/src/CallMode.jl).

**To hell with parentheses!**
