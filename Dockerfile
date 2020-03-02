FROM nvidia/opencl

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        wget ca-certificates unzip \
        make gcc g++ freeglut3-dev libglew-dev libxmu-dev \
 && rm -rf /var/lib/apt/lists/*

RUN wget "https://streamcomputing.eu/downloads/?Nvidia_OpenCL_SDK_4_2_Linux.zip" -O Nvidia_OpenCL_SDK_4_2_Linux.zip \
 && echo "e7f2368069230d41d5ec58abc24876c1744e0f22479a37f5679c51a89c6fe509  Nvidia_OpenCL_SDK_4_2_Linux.zip" | sha256sum -c \
 && unzip Nvidia_OpenCL_SDK_4_2_Linux.zip -d Nvidia_OpenCL_SDK_4_2_Linux

WORKDIR /Nvidia_OpenCL_SDK_4_2_Linux

# Fix 1: The ZIP includes some pre-built objects and libraries, and also
#        some headers which should be provided by the system
#        Remove them to avoid compilation and/or linking errors
# Fix 2: Fix the name of the GLEW library to match the one provided by the package
RUN rm -Rf shared/inc/GL OpenCL/common/inc/CL shared/lib shared/obj \
 && find . -name "*.mk" -exec sed -i 's/lGLEW_x86_64/lGLEW/g' {} \; \
 && make -j$(nproc) -C OpenCL

WORKDIR OpenCL/bin/linux/release
