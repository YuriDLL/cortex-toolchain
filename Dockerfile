FROM ubuntu:20.04
RUN apt update \
    && apt install -y make \
    && apt install -y srecord \
#    && apt install -y gcc-arm-none-eabi \
    && apt install -y git \
    && apt install -y wget
#fix ocrlf
RUN git config --global core.autocrlf input

ARG TOOLCHAIN_TARBALL_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2"
ARG TOOLCHAIN_PATH=${TOOLS_PATH}/toolchain
RUN wget ${TOOLCHAIN_TARBALL_URL} \
   && export TOOLCHAIN_TARBALL_FILENAME=$(basename "${TOOLCHAIN_TARBALL_URL}") \
   && tar -xvf ${TOOLCHAIN_TARBALL_FILENAME} \
   && mv $(dirname `tar -tf ${TOOLCHAIN_TARBALL_FILENAME} | head -1`) ${TOOLCHAIN_PATH} \
   && rm -rf ${TOOLCHAIN_PATH}/share/doc \
   && rm ${TOOLCHAIN_TARBALL_FILENAME}
ENV PATH="${TOOLCHAIN_PATH}/bin:${PATH}"
RUN apt install -y libncurses5