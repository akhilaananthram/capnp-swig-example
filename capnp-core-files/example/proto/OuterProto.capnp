@0x89cb617d4ed5f859;

using import "InnerProto.capnp".InnerProto;

struct OuterProto {
  fieldA @0 :Float32;
  inner @1 :InnerProto;
}
