module Meyer

export MeyerWavelet

include("../wavelets/meyer_utils.jl")

using Flux, CUDA, KernelAbstractions, Tullio
using .MeyerUtils: MeyerAux

struct MeyerWavelet
    σ
    b
    pi
    norm
    weights
    aux
end

function MeyerWavelet(σ, b, weights)
    normalisation = Float32.([1 / sqrt(σ)])
    bias = Float32.([b])
    return MeyerWavelet(Float32.([σ]), bias, Float32.([π]), normalisation, weights, MeyerAux())
end

function (w::MeyerWavelet)(x)
    ω = abs.((x .- w.b) ./ w.σ)
    sin_term = sin.(ω .* w.pi)
    meyer_term = w.aux(ω)
    y = @tullio out[i, o, b] := sin_term[i, o, b] * meyer_term[i, o, b]
    y = y .* w.norm

    return @tullio out[o, b] := w.weights[i, o] * y[i, o, b]
end

Flux.@functor MeyerWavelet

end