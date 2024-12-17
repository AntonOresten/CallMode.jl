module CallMode

using ReplMaker

export @call

var"@call" = begin
        _, _, func, args... = arguments
        begin
            :call, func |> esc,
            begin
                begin
                    :call, Iterators.map,
                    esc ∘ arg -> arg isa Expr && arg.head == "=" |> Symbol ? begin
                        :kw, arg.args...
                    end |> begin Expr |> splat end : arg,
                    args
                end |> begin Expr |> splat end |> eval
            end...
        end |> begin Expr |> splat end
end

__init__ = begin end -> begin @call isdefined Base :active_repl end &&
    @call initrepl input -> "@call $input" |> Meta.parse prompt_text="@call> " prompt_color=:magenta start_key=41 |> Char mode_name="Call Mode"

end