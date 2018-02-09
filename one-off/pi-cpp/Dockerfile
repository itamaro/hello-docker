# Using multi-stage build to compile in "builder image" and use a slimmer "runtime image" as final artifact
# significant, given the C++ toolchain can add over 1GB

FROM ubuntu:18.04 as builder
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
WORKDIR /root/src
RUN apt-get update \
  && apt-get install -y wget gnupg \
  && echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-5.0 main" >> /etc/apt/sources.list \
  && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
  && apt-get update \
  && apt-get install -y clang-5.0 libclang-common-5.0-dev libclang-5.0-dev \
             libllvm5.0 lldb-5.0 llvm-5.0 llvm-5.0-dev llvm-5.0-runtime \
  && rm -rf /var/lib/apt/lists/*
COPY calcpi.cc .
RUN clang++-5.0 -o calcpi -std=c++14 -Wall -fvectorize -fslp-vectorize -fcolor-diagnostics -O2 calcpi.cc

FROM ubuntu:18.04
WORKDIR /root/
# Copy just the compiled binary from the builder image
COPY --from=builder /root/src/calcpi /usr/bin/
ENTRYPOINT ["calcpi"]
