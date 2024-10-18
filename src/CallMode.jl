module CallMode

export @call

using ReplMaker
using Setfield

macro call(func, args...)
    quote $(func |> esc)($([arg isa Expr && arg.head == :(=) ? begin @set arg.head = :kw end |> esc : arg |> esc for arg in args]...)) end
end

__init__() = begin @eval Base @isdefined active_repl end &&
    @call initrepl input -> "@call $input" |> Meta.parse prompt_text="@call> " prompt_color=:magenta start_key=')' mode_name="Call Mode"

end