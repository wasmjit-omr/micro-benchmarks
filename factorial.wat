(module

  (func (export "factorial") (result i32)
    (local i32)
    ;; iterations:
    i32.const 10000
    set_local 0
    loop
      i64.const 20
      call $fact
      drop
      get_local 0
      i32.const 1
      i32.sub
      tee_local 0
      br_if 0
    end
    get_local 0
  )

  (func $fact (param i64) (result i64)
    (local i64 i64)
    block  ;; label = @1
      block  ;; label = @2
        get_local 0
        i64.eqz
        br_if 0 (;@2;)
        get_local 0
        set_local 1
        i64.const 1
        set_local 2
        loop  ;; label = @3
          get_local 1
          get_local 2
          i64.mul
          set_local 2
          get_local 1
          i64.const -1
          i64.add
          tee_local 1
          i64.eqz
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
        unreachable
      end
      i64.const 1
      set_local 2
    end
    get_local 2
  )

)
