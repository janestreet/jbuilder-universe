
#include "Hacl_Salsa20.h"
#include "ctypes_cstubs_internals.h"
value _1_Hacl_Salsa20_salsa20_encrypt(value x6, value x5, value x4, value x3,
                                      value x2, value x1)
{
   uint32_t x7 = Uint32_val(x6);
   char* x10 = CTYPES_PTR_OF_OCAML_STRING(x5);
   char* x11 = CTYPES_PTR_OF_OCAML_STRING(x4);
   char* x12 = CTYPES_PTR_OF_OCAML_STRING(x3);
   char* x13 = CTYPES_PTR_OF_OCAML_STRING(x2);
   uint32_t x14 = Uint32_val(x1);
   Hacl_Salsa20_salsa20_encrypt(x7, x10, x11, x12, x13, x14);
   return Val_unit;
}
value _1_Hacl_Salsa20_salsa20_encrypt_byte6(value* argv, int argc)
{
   value x18 = argv[5];
   value x19 = argv[4];
   value x20 = argv[3];
   value x21 = argv[2];
   value x22 = argv[1];
   value x23 = argv[0];
   return _1_Hacl_Salsa20_salsa20_encrypt(x23, x22, x21, x20, x19, x18);
}
value _2_Hacl_Salsa20_salsa20_decrypt(value x29, value x28, value x27,
                                      value x26, value x25, value x24)
{
   uint32_t x30 = Uint32_val(x29);
   char* x33 = CTYPES_PTR_OF_OCAML_STRING(x28);
   char* x34 = CTYPES_PTR_OF_OCAML_STRING(x27);
   char* x35 = CTYPES_PTR_OF_OCAML_STRING(x26);
   char* x36 = CTYPES_PTR_OF_OCAML_STRING(x25);
   uint32_t x37 = Uint32_val(x24);
   Hacl_Salsa20_salsa20_decrypt(x30, x33, x34, x35, x36, x37);
   return Val_unit;
}
value _2_Hacl_Salsa20_salsa20_decrypt_byte6(value* argv, int argc)
{
   value x41 = argv[5];
   value x42 = argv[4];
   value x43 = argv[3];
   value x44 = argv[2];
   value x45 = argv[1];
   value x46 = argv[0];
   return _2_Hacl_Salsa20_salsa20_decrypt(x46, x45, x44, x43, x42, x41);
}
value _3_Hacl_Salsa20_salsa20_key_block0(value x49, value x48, value x47)
{
   char* x50 = CTYPES_PTR_OF_OCAML_STRING(x49);
   char* x51 = CTYPES_PTR_OF_OCAML_STRING(x48);
   char* x52 = CTYPES_PTR_OF_OCAML_STRING(x47);
   Hacl_Salsa20_salsa20_key_block0(x50, x51, x52);
   return Val_unit;
}
value _4_Hacl_Salsa20_hsalsa20(value x56, value x55, value x54)
{
   char* x57 = CTYPES_PTR_OF_OCAML_STRING(x56);
   char* x58 = CTYPES_PTR_OF_OCAML_STRING(x55);
   char* x59 = CTYPES_PTR_OF_OCAML_STRING(x54);
   Hacl_Salsa20_hsalsa20(x57, x58, x59);
   return Val_unit;
}
