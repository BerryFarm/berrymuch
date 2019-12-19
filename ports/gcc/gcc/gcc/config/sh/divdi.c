typedef long long DItype;
typedef unsigned long long UDItype;
typedef long SItype;
typedef unsigned long USItype;
typedef long word_type;
typedef unsigned char UQItype;

extern UDItype __udivmoddi4(UDItype, UDItype, UDItype *);

#ifdef __BIGENDIAN__
  struct DIstruct {SItype high, low;};
#else
  struct DIstruct {SItype low, high;};
#endif
typedef struct DIstruct DIstruct;

typedef union { DIstruct s; DItype ll; } DIunion;

DItype
__divdi3_i4 (DItype u, DItype v)
{
  word_type c = 0;
  DIunion uu, vv;
  DItype w;

  uu.ll = u;
  vv.ll = v;

  if (uu.s.high < 0)
    c = ~c,
    uu.ll = -uu.ll;
  if (vv.s.high < 0)
    c = ~c,
    vv.ll = -vv.ll;

  w = __udivmoddi4 (uu.ll, vv.ll, (UDItype *)0);
  if (c)
    w = -w;

  return w;
}

UDItype
__udivdi3_i4 (UDItype n, UDItype d)
{
  return __udivmoddi4 (n, d, (UDItype *) 0);
}
