using CallMode
using Test

@testset "CallMode" begin

    @testset "single argument" begin
        @test begin
            @call atan 1/2
        end == 0.4636476090008061
    end

    @testset "multiple arguments" begin
        @test begin
            @call atan 1 2
        end == 0.4636476090008061
    end

    @testset "keyword arguments" begin
        @test begin
            @call mapreduce abs2 Base.:+ 1:5 init=1
        end == 56
    end

    @testset "escape" begin
        f = sin

        @test begin
            @call f 1
        end == 0.8414709848078965

        @test begin
            @call identity f
        end == f
    end

end
