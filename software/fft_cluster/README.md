# FFT test
This test performs a FFT (Fast Fourier Tranform).
In this folder you can find pre-generated golden models for FP32, FP16 and FP16ALT formats.

~~~~~shell
make clean all [platform=rtl] run
~~~~~

If you want to run this test on RTL, remember to specify the platform which is gvsoc by default.
There are several flags useful to activate some functionalities:

- `cores=N_CORES` set the number of cores used for the execution to `N_CORES`, by default `cores=1`
- `fmt=FP_FMT` specifies the floating-point format for data, by deafult it is set to `FP32` but you can also choose `FP16` and `FP16ALT` format
- `vec=1` activates vectorial format **only for half-precision floating point (FP16 and FP16ALT)**
- `check=1` activates results checking
- `verbose=1` activates wrong results printing

** WARNING: don't deactivate statistics!! ** Without statistics on, the correct functional behaviour is not guaranteed.

** [TODO]: writing a golden model generator script **