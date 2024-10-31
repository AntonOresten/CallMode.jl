module CallMode

export @call

using ReplMaker
using Setfield

call = arguments -> begin
    _, _, func, args... = arguments
    begin
        :call, func |> esc,
        begin
            begin
                :call, map,
                arg -> arg isa Expr && arg.head == "=" |> Symbol ? begin @set arg.head = :kw end |> esc : arg |> esc,
                args
            end |> begin Expr |> splat end |> eval
        end...
    end |> begin Expr |> splat end
end

var"@call" = call ∘ tuple

__init__ = begin end -> begin @eval Base @isdefined active_repl end &&
    @call initrepl input -> "@call $input" |> Meta.parse prompt_text="@call> " prompt_color=:magenta start_key=')' mode_name="Call Mode"

end