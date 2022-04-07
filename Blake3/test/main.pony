use ".."
use "ponytest"
use "collections"
actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)
  new make () =>
    None
  fun tag tests(test: PonyTest) =>
    test(_TestBlake3)

primitive U8Array
  fun equal(a: Array[U8] box, b: Array[U8] box) : Bool =>
    try
      if (a.size() != b.size()) then
        return false
      end
      for i in Range(0, a.size()) do
        if a(i)? != b(i)? then
          return false
        end
      end
      true
    else
      false
    end
  fun print(a: Array[U8] box) =>
    let str:  String iso = recover String(a.size() + (a.size() + 1)) end
    str.append("[")
    for i in a.values() do
      if str != "[" then
        str.append(",")
      end
      str.append(i.string())
    end
    str.append("]")
    Println( consume str)


class iso _TestBlake3 is UnitTest
    fun name(): String => "Testing Blake3"
    fun apply(t: TestHelper) =>
        let hasher1 = Blake3
        let data: Array[U8] = [1;2;3;4;5;6;7;8;3;76;4;2;7;3;78;3]
        let key: Array[U8] = [8;6;9;5;89;5;3;74]
        hasher1.update(data)
        let hash1: Array[U8] = hasher1.digest()
        U8Array.print(hash1)
        let hasher2 = Blake3.keyed(key)
        hasher2.update(data)
        let hash2: Array[U8] = hasher2.digest()
        U8Array.print(hash2)
        t.assert_true(hash1.size() == 32)
        t.assert_true(hash2.size() == 32)
        t.assert_false(U8Array.equal(hash1, hash2))
        let hasher3 = Blake3
        let data2: Array[U8] = [1;2;3;4;5;6;7;8;3;76;4;2;7;3;78]
        hasher3.update(data)
        let hash3: Array[U8] = hasher3.digest()
        U8Array.print(hash3)
        t.assert_true(U8Array.equal(hash1, hash3))
