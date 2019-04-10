#
# Copyright 2019 IBM Corp. and others
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
#

OUTDIR ?= .
WASM_OUTDIR ?= $(OUTDIR)
NATIVE_OUTDIR ?= $(OUTDIR)

CC ?= cc
WASM_CC ?= emcc

BENCHMARKS = \
	mandelbrot

WASM_BENCHMARKS = $(addprefix $(WASM_OUTDIR)/, $(addsuffix .wasm, $(BENCHMARKS)))
NATIVE_BENCHMARKS = $(addprefix $(NATIVE_OUTDIR)/, $(BENCHMARKS))

.PHONY: all clean

all: $(WASM_BENCHMARKS) $(NATIVE_BENCHMARKS)

.SUFFIXES: .wasm

.c.wasm:
	$(WASM_CC) -O3 $< -o $(OUTDIR)/$@

%: %.c
	$(CC) -std=c99 -O3 $< -o $(OUTDIR)/$@

clean:
	rm -f $(WASM_BENCHMARKS) $(NATIVE_BENCHMARKS)
