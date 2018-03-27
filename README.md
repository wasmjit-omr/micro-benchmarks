# Micro-benchmarks
Small performance benchmarking scripts to test the JIT. Values in the exported functions can be adjusted to test a range of calls/iterations/number of elements. 
## Factorial
This script is adapted from [this blog post](https://www.hellorust.com/demos/factorial/index.html) on generating WebAssembly from Rust. 
## Mandelbrot

The Mandelbrot script is adapted from a `wasm` file found in [this repo](https://github.com/ColinEberhardt/wasm-mandelbrot), converted back to text using `wasm2wat`, with some additional manual edits.
## Bubblesort
This script was compiled from C, array size is limited to 100000 elements. 
