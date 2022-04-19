use "lib:blake3"
use @blake3_hasher_allocate[Pointer[None]]()
use @blake3_hasher_deallocate[None](self: Pointer[None])
use @blake3_hasher_init[None](self: Pointer[None])
use @blake3_hasher_init_keyed[None](self: Pointer[None], key: Pointer[U8] tag)
use @blake3_hasher_update[None](self: Pointer[None], input: Pointer[None] tag, input_len: USize)
use @blake3_hasher_finalize[None](self: Pointer[None], output: Pointer[U8], out_len: USize)
use @pony_alloc[Pointer[U8]](ctx: Pointer[None], size: USize)
use @pony_ctx[Pointer[None]]()
use @printf[I32](fmt: Pointer[U8] tag, ...)

primitive Println
  fun apply(text: String val) =>
    @printf((text + "\n").cstring())

class Blake3
  let _hasher: Pointer[None]
  let _digestSize: USize
  new create(digestSize: USize = 32) =>
    _digestSize = digestSize
    _hasher = @blake3_hasher_allocate()
    @blake3_hasher_init(_hasher)

  new keyed(key: Array[U8] box, digestSize: USize = 32) =>
    _digestSize = digestSize
    _hasher = @blake3_hasher_allocate()
    @blake3_hasher_init_keyed(_hasher, key.cpointer())

  fun ref update(data: Array[U8] box) =>
    @blake3_hasher_update(_hasher, data.cpointer(), data.size())

  fun ref digest(): Array[U8] iso^ =>
    let digest': Pointer[U8] = @pony_alloc(@pony_ctx(), _digestSize)
    @blake3_hasher_finalize(_hasher, digest',_digestSize)
    let digest'' = Array[U8].from_cpointer(digest', _digestSize)
    let digest''': Array[U8] iso = recover Array[U8](digest''.size()) end
    for value in digest''.values() do
      digest'''.push(value)
    end
    consume digest'''

  fun _final() =>
    @blake3_hasher_deallocate(_hasher)
