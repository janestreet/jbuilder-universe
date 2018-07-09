#ifndef CHECKSUM_ADLER32_H
#define CHECKSUM_ADLER32_H

#ifdef SYS16BIT
#  if defined(M_I86SM) || defined(M_I86MM)
/* MSC small or medium model */
#    ifdef _MSC_VER
#      define FAR _far
#    else
#      define FAR far
#    endif
#  endif
#  if (defined(__SMALL__) || defined(__MEDIUM__))
/* Turbo C small or medium model */
#    ifdef __BORLANDC__
#      define FAR _far
#    else
#      define FAR far
#    endif
#  endif
#endif

#ifndef FAR
#  define FAR
#endif

#include "size_t.h"
#include <stdint.h>

typedef unsigned long uLong;
typedef unsigned int  uInt;
typedef unsigned char Byte;
typedef Byte FAR Bytef;

uLong adler32(uLong adler, const Bytef *buf, uInt len);

#endif
