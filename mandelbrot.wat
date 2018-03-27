(module

  (type $t0 (func (param i32 i32 i32) (result i32)))
  (type $t1 (func (param f64 f64 i32) (result i32)))
  (type $t2 (func (param f64 f64 i32 i32) (result f64)))
  (type $t3 (func (param i32 f64 f64 f64)))
  (type $t4 (func (result i32)))

  (func (export "mandel")
    ;; iterations:
    i32.const 10000
    ;; x:
    f64.const -0.7436447860
    ;; y:
    f64.const 0.1318252536
    ;; d:
    f64.const 0.00029336
    call $mandelbrot
  )

  (func $colour (type $t0) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    block $B0
      block $B1
        get_local $p2
        get_local $p0
        i32.mul
        get_local $p1
        i32.add
        i32.const 1024
        i32.rem_s
        tee_local $p1
        i32.const 255
        i32.gt_s
        br_if $B1
        get_local $p1
        set_local $p2
        br $B0
      end
      i32.const 0
      set_local $p2
      get_local $p1
      i32.const 511
      i32.gt_s
      br_if $B0
      i32.const 254
      get_local $p1
      i32.sub
      set_local $p2
    end
    get_local $p2
    i32.const 255
    i32.and)

  (func $iterateEquation (type $t1) (param $p0 f64) (param $p1 f64) (param $p2 i32) (result i32)
    (local $l0 f64) (local $l1 f64) (local $l2 f64) (local $l3 f64) (local $l4 f64) (local $l5 i32)
    block $B0
      get_local $p2
      i32.const 1
      i32.lt_s
      br_if $B0
      f64.const 0x0p+0 (;=0;)
      set_local $l3
      i32.const 0
      set_local $l5
      f64.const 0x0p+0 (;=0;)
      set_local $l4
      block $B1
        loop $L2
          get_local $l4
          get_local $l4
          f64.mul
          tee_local $l0
          get_local $l3
          get_local $l3
          f64.mul
          tee_local $l1
          f64.add
          tee_local $l2
          f64.const 0x1p+2 (;=4;)
          f64.gt
          get_local $l2
          get_local $l2
          f64.ne
          i32.or
          br_if $B1
          get_local $l4
          get_local $l4
          f64.add
          get_local $l3
          f64.mul
          get_local $p1
          f64.add
          set_local $l3
          get_local $l0
          get_local $l1
          f64.sub
          get_local $p0
          f64.add
          set_local $l4
          get_local $l5
          i32.const 1
          i32.add
          tee_local $l5
          get_local $p2
          i32.lt_s
          br_if $L2
        end
      end
      get_local $l5
      return
    end
    i32.const 0)

  (func $scale (type $t2) (param $p0 f64) (param $p1 f64) (param $p2 i32) (param $p3 i32) (result f64)
    get_local $p3
    get_local $p2
    i32.sub
    f64.convert_s/i32
    get_local $p2
    f64.convert_s/i32
    f64.div
    get_local $p1
    f64.mul
    get_local $p0
    f64.add)

  (func $mandelbrot (type $t3) (param $p0 i32) (param $p1 f64) (param $p2 f64) (param $p3 f64)
    (local $l0 f64) (local $l1 f64) (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32)
    get_local $p3
    f64.const 0x1.9p+9 (;=800;)
    f64.mul
    f64.const 0x1.2cp+10 (;=1200;)
    f64.div
    set_local $l0
    i32.const 32
    set_local $l3
    i32.const 0
    set_local $l4
    loop $L0
      get_local $p1
      get_local $p3
      i32.const 1200
      get_local $l4
      call $scale
      set_local $l1
      i32.const 0
      set_local $l5
      i32.const 0
      set_local $l6
      loop $L1
        block $B2
          block $B3
            get_local $l1
            get_local $p2
            get_local $l0
            i32.const 800
            get_local $l6
            call $scale
            get_local $p0
            call $iterateEquation
            tee_local $l2
            get_local $p0
            i32.ne
            br_if $B3
            i32.const 0
            set_local $l7
            get_local $l3
            get_local $l5
            i32.add
            i32.const 0
            i32.store16
            br $B2
          end
          get_local $l3
          get_local $l5
          i32.add
          tee_local $l7
          get_local $l2
          i32.const 0
          i32.const 4
          call $colour
          i32.store8
          get_local $l7
          i32.const 1
          i32.add
          get_local $l2
          i32.const 128
          i32.const 4
          call $colour
          i32.store8
          get_local $l2
          i32.const 356
          i32.const 4
          call $colour
          set_local $l7
        end
        get_local $l3
        get_local $l5
        i32.add
        tee_local $l2
        i32.const 3
        i32.add
        i32.const 255
        i32.store8
        get_local $l2
        i32.const 2
        i32.add
        get_local $l7
        i32.store8
        get_local $l6
        i32.const 1
        i32.add
        set_local $l6
        get_local $l5
        i32.const 4800
        i32.add
        tee_local $l5
        i32.const 3840000
        i32.ne
        br_if $L1
      end
      get_local $l3
      i32.const 4
      i32.add
      set_local $l3
      get_local $l4
      i32.const 1
      i32.add
      tee_local $l4
      i32.const 1200
      i32.ne
      br_if $L0
    end)

  (func $getImage (type $t4) (result i32)
    i32.const 32)

  (table $T0 0 anyfunc)
  (memory $memory 59)
  (data (i32.const 12) "\b0\04\00\00")
  (data (i32.const 16) " \03\00\00"))
