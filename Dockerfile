FROM ghcr.io/evshiron/rocm_lab:rocm5.6-ub22.04-base

RUN apt update && apt install -y git python3-pip python3-venv python3-dev libstdc++-12-dev

WORKDIR /app

# clone repos in advance to reduce initial launch time
RUN git clone https://github.com/Stability-AI/stablediffusion /app/repositories/stable-diffusion-stability-ai \
  && git clone https://github.com/CompVis/taming-transformers /app/repositories/taming-transformers \
  && git clone https://github.com/crowsonkb/k-diffusion /app/repositories/k-diffusion \
  && git clone https://github.com/sczhou/CodeFormer /app/repositories/CodeFormer \
  && git clone https://github.com/salesforce/BLIP /app/repositories/BLIP

ADD . .

RUN echo can_run_as_root=1 > webui-user.sh \
  && echo export COMMANDLINE_ARGS=\'--listen --insecure\' >> webui-user.sh

CMD bash
