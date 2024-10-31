module CallMode

using ReplMaker
using Setfield

export @call

var"@call" = begin
    arguments -> begin
        _, _, func, args... = arguments
        begin
            :call, func |> esc,
            begin
                begin
                    :call, Iterators.map,
                    esc ∘ arg -> arg isa Expr && arg.head == "=" |> Symbol ? begin @set arg.head = :kw end : arg,
                    args
                end |> begin Expr |> splat end |> eval
            end...
        end |> begin Expr |> splat end
    end
end ∘ tuple

__init__ = begin end -> begin @eval Base @isdefined active_repl end &&
    @call initrepl input -> "@call $input" |> Meta.parse prompt_text="@call> " prompt_color=:magenta start_key=')' mode_name="Call Mode"

end