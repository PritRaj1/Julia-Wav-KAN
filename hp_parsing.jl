module hyperparams

export set_hyperparams

using ConfParser

function set_RNO_params()
    conf = ConfParse("Vanilla_RNO/RNO_config.ini")
    parse_conf!(conf)

    ENV["p"] = retrieve(conf, "Loss", "p")
    ENV["step"] = retrieve(conf, "Optimizer", "step_rate")
    ENV["decay"] = retrieve(conf, "Optimizer", "gamma")
    ENV["LR"] = retrieve(conf, "Optimizer", "learning_rate")
    ENV["min_LR"] = retrieve(conf, "Optimizer", "min_lr")
    ENV["activation"] = retrieve(conf, "Architecture", "activation")
    ENV["n_hidden"] = retrieve(conf, "Architecture", "n_hidden")
    ENV["num_layers"] = retrieve(conf, "Architecture", "num_layers")
    ENV["batch_size"] = retrieve(conf, "Dataloader", "batch_size")
    ENV["num_epochs"] = retrieve(conf, "Pipeline", "num_epochs")

    return nothing
end

function set_wavRNO_params()
    conf = ConfParse("wavKAN_RNO/KAN_RNO_config.ini")
    parse_conf!(conf)

    ENV["p"] = retrieve(conf, "Loss", "p")
    ENV["step"] = retrieve(conf, "Optimizer", "step_rate")
    ENV["decay"] = retrieve(conf, "Optimizer", "gamma")
    ENV["LR"] = retrieve(conf, "Optimizer", "learning_rate")
    ENV["min_LR"] = retrieve(conf, "Optimizer", "min_lr")
    ENV["activation"] = retrieve(conf, "Architecture", "activation")
    ENV["n_hidden"] = retrieve(conf, "Architecture", "n_hidden")
    ENV["num_layers"] = retrieve(conf, "Architecture", "num_layers")
    ENV["batch_size"] = retrieve(conf, "Dataloader", "batch_size")
    ENV["num_epochs"] = retrieve(conf, "Pipeline", "num_epochs")

    wavelet_names = [
        retrieve(conf, "Architecture", "wav_one"),
        retrieve(conf, "Architecture", "wav_two"),
        retrieve(conf, "Architecture", "wav_three"),
        retrieve(conf, "Architecture", "wav_four"),
        retrieve(conf, "Architecture", "wav_five")
    ][1:ENV["num_layers"]]
    return wavelet_names
end

function set_Transformer_params()
    conf = ConfParse("Transformer/Transformer_config.ini")
    parse_conf!(conf)

    ENV["p"] = retrieve(conf, "Loss", "p")
    ENV["step"] = retrieve(conf, "Optimizer", "step_rate") 
    ENV["decay"] = retrieve(conf, "Optimizer", "gamma") 
    ENV["LR"] = retrieve(conf, "Optimizer", "learning_rate") 
    ENV["min_LR"] = retrieve(conf, "Optimizer", "min_lr") 
    ENV["activation"] = retrieve(conf, "Architecture", "activation") 
    ENV["d_model"] = retrieve(conf, "Architecture", "d_model") 
    ENV["nhead"] = retrieve(conf, "Architecture", "nhead") 
    ENV["dim_feedforward"] = retrieve(conf, "Architecture", "dim_feedforward")
    ENV["dropout"] = retrieve(conf, "Architecture", "dropout")
    ENV["num_encoder_layers"] = retrieve(conf, "Architecture", "num_encoder_layers")
    ENV["num_decoder_layers"] = retrieve(conf, "Architecture", "num_decoder_layers")
    ENV["max_len"] = retrieve(conf, "Architecture", "max_len")
    ENV["batch_size"] = retrieve(conf, "Dataloader", "batch_size")
    ENV["num_epochs"] = retrieve(conf, "Pipeline", "num_epochs")

    return nothing
end

function set_wavTransformer_params()
    conf = ConfParse("wavKAN_Transformer/KAN_Transformer_config.ini")
    parse_conf!(conf)

    ENV["p"] = retrieve(conf, "Loss", "p")
    ENV["step"] = retrieve(conf, "Optimizer", "step_rate") 
    ENV["decay"] = retrieve(conf, "Optimizer", "gamma") 
    ENV["LR"] = retrieve(conf, "Optimizer", "learning_rate") 
    ENV["min_LR"] = retrieve(conf, "Optimizer", "min_lr") 
    ENV["activation"] = retrieve(conf, "Architecture", "activation") 
    ENV["d_model"] = retrieve(conf, "Architecture", "d_model") 
    ENV["nhead"] = retrieve(conf, "Architecture", "nhead") 
    ENV["dim_feedforward"] = retrieve(conf, "Architecture", "dim_feedforward")
    ENV["dropout"] = retrieve(conf, "Architecture", "dropout")
    ENV["num_encoder_layers"] = retrieve(conf, "Architecture", "num_encoder_layers")
    ENV["num_decoder_layers"] = retrieve(conf, "Architecture", "num_decoder_layers")
    ENV["max_len"] = retrieve(conf, "Architecture", "max_len")
    ENV["batch_size"] = retrieve(conf, "Dataloader", "batch_size")
    ENV["num_epochs"] = retrieve(conf, "Pipeline", "num_epochs")

    encoder_wavelet_names = [
        retrieve(conf, "EncoderWavelets", "wav_one"),
        retrieve(conf, "EncoderWavelets", "wav_two"),
        retrieve(conf, "EncoderWavelets", "wav_three"),
        retrieve(conf, "EncoderWavelets", "wav_four"),
        retrieve(conf, "EncoderWavelets", "wav_five")
    ][1:ENV["num_encoder_layers"]]

    decoder_wavelet_names = [
        retrieve(conf, "DecoderWavelets", "wav_one"),
        retrieve(conf, "DecoderWavelets", "wav_two"),
        retrieve(conf, "DecoderWavelets", "wav_three")
    ][1:ENV["num_decoder_layers"]]

    output_wavelet = retrieve(conf, "OutputWavelet", "wav")

    return encoder_wavelet_names, decoder_wavelet_names, output_wavelet
end


function set_hyperparams(model_name)

    if model_name == "RNO"
        out = set_RNO_params()
    elseif model_name == "wavRNO"
        out = set_wavRNO_params()
    elseif model_name == "Transformer"
        out = set_Transformer_params()
    else
        out = set_wavTransformer_params()
    end

    return out
end

end