/*
 * Copyright 2019 IBM Corp. and others
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 */

#include <time.h>

typedef double FP_t;

__attribute__((noinline))
void mandelbrot(int x_pixels, int y_pixels, int* out_table, int max_iterations) {
    FP_t x_scale_factor = 3.5 / (FP_t) x_pixels;
    FP_t y_scale_factor = 2.0 / (FP_t) y_pixels;

    for (int py = 0; py < y_pixels; ++py) {
        for (int px = 0; px < x_pixels; ++px) {
            FP_t x0 = px * x_scale_factor - 2.5;
            FP_t y0 = py * y_scale_factor - 1.0;

            FP_t x = 0.0;
            FP_t y = 0.0;
            int iteration = 0;
            while (x*x + y*y <= 2*2 && iteration < max_iterations) {
                FP_t x_temp = x*x - y*y + x0;
                y = 2*x*y + y0;
                x = x_temp;
                iteration += 1;
            }

            out_table[py*x_pixels + px] = iteration;
        }
    }
}

int main(void) {
    // force JIT compilation
    int small_table [3][4] = {0};
    mandelbrot(4, 3, (int*)small_table, 10);

    // run and time the benchmark
    int table[34][80] = {0};
    time_t time_diff = time(NULL);
    mandelbrot(80, 34, (int*)table, 300000);
    time_diff = time(NULL) - time_diff;

    return time_diff;
}
