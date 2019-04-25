A suite of micro-benchmarks for measuring the performance of the
[wasmjit-omr](https://github.com/wasmjit-omr/wasmjit-omr) JIT compiler.

## Building and running

Simply running `make` will build two versions of every benchmark, one in
WebAssembly and the other as a native binary. A file name can also be
specified as an argument to `make` to only build that file.

To run the WebAssembly code, use [em-interp](https://github.com/wasmjit-omr/em-interp).
For example:

```
$ make
$ ./em-interp mandelbrot.wasm
```

## License

The code is distributed under the terms of the
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
