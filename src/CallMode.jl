module CallMode

export @call

using ReplMaker

macro call(func, args...)
    positional_args = []
    keyword_args = []
    
    for arg in args
        if isa(arg, Expr) && arg.head == :(=)
            push!(keyword_args, Expr(:kw, arg.args[1], arg.args[2]))
        else
            push!(positional_args, arg)
        end
    end
    
    return :($(esc(func))($(map(esc, positional_args)...); $(map(esc, keyword_args)...)))
end

function init_call_mode()
    initrepl(input -> Meta.parse("CallMode.@call $input"), # only flaw of this package. `CallMode` isn't necessarily accessible
             prompt_text="@call> ",
             prompt_color = :magenta,
             start_key = ')',
             mode_name = "Call Mode")
end

__init__() = isdefined(Base, :active_repl) && init_call_mode()

end