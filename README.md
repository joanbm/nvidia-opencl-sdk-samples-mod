# nvidia-opencl-sdk-samples-mod

Dockerfile for the NVIDIA OpenCL SDK Samples, including a modified version of the bandwidth measurement tool (`oclBandwidthTest`) that can fill the memory with various patterns (e.g. all zeros, periodic patterns, pseudorandom data, data from a file, etc. - see the `--pattern` option), for benchmarking I/O link compression bandwidth on various scenarios.
