# Using multi-stage build to compile in "builder image" and use a slimmer "runtime image" as final artifact
# significant, given the C++ toolchain can add over 1GB

FROM ubuntu:17.10 as builder
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
WORKDIR /root/src
RUN apt-get update \
  && apt-get install -y wget gnupg \
  && echo "deb http://apt.llvm.org/artful/ llvm-toolchain-artful main" >> /etc/apt/sources.list \
  && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
  && apt-get update \
  && apt-get install -y clang-5.0 clang-5.0-doc libclang-common-5.0-dev libclang-5.0-dev \
             libclang1-5.0 libclang1-5.0-dbg libllvm-5.0-ocaml-dev libllvm5.0 libllvm5.0-dbg \
             lldb-5.0 llvm-5.0 llvm-5.0-dev llvm-5.0-doc llvm-5.0-examples llvm-5.0-runtime \
  && rm -rf /var/lib/apt/lists/*
# Install the entire boost-dev package, since YOLO
RUN apt-get update \
  && apt-get install -y libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*
COPY echo.cc .
RUN clang++-5.0 -o echo -std=c++14 -Wall -fvectorize -fslp-vectorize -fcolor-diagnostics -O2 \
    echo.cc -lboost_system -lboost_context -lboost_coroutine \
    -DBOOST_COROUTINE_NO_DEPRECATION_WARNING=1 -DBOOST_COROUTINES_NO_DEPRECATION_WARNING=1

FROM ubuntu:17.10
WORKDIR /root/
# Install just the needed runtime boost libs
RUN apt-get update \
  && apt-get install -y libboost-system1.62.0 libboost-coroutine1.62.0 libboost-context1.62.0 \
  && rm -rf /var/lib/apt/lists/*
# Copy just the compiled binary from the builder image
COPY --from=builder /root/src/echo /usr/bin/
ENTRYPOINT ["echo"]
