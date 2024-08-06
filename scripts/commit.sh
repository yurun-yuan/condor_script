#!/bin/bash

huggingface-cli login --token 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

# huggingface-cli repo create bt-rm
git clone https://huggingface.co/RyanYr/bt-rm

cd bt-rm

git lfs track "*.safetensors"
git add .gitattributes

mv -f $MODEL_OUTPUT_PATH/* .

retry_command "git add ." 5
retry_command "git commit -m 'Initial commit'" 5
retry_command "git push" 5

