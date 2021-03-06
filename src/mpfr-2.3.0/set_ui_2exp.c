/* mpfr_set_ui_2exp -- set a MPFR number from a machine unsigned integer with
   a shift

Copyright 2004, 2006, 2007 Free Software Foundation, Inc.
Contributed by the Arenaire and Cacao projects, INRIA.

This file is part of the MPFR Library.

The MPFR Library is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or (at your
option) any later version.

The MPFR Library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public License
along with the MPFR Library; see the file COPYING.LIB.  If not, write to
the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
MA 02110-1301, USA. */

#define MPFR_NEED_LONGLONG_H
#include "mpfr-impl.h"

int
mpfr_set_ui_2exp (mpfr_ptr x, unsigned long i, mp_exp_t e, mp_rnd_t rnd_mode)
{
  MPFR_SET_POS (x);

  if (i == 0)
    {
      MPFR_SET_ZERO (x);
      MPFR_RET (0);
    }
  else
    {
      mp_size_t xn;
      unsigned int cnt, nbits;
      mp_limb_t *xp;
      int inex = 0;

      /* FIXME: support int limbs (e.g. 16-bit limbs on 16-bit proc) */
      MPFR_ASSERTD (i == (mp_limb_t) i);

      /* Position of the highest limb */
      xn = (MPFR_PREC (x) - 1) / BITS_PER_MP_LIMB;
      count_leading_zeros (cnt, (mp_limb_t) i);
      MPFR_ASSERTD (cnt < BITS_PER_MP_LIMB);  /* OK since i != 0 */

      xp = MPFR_MANT(x);
      xp[xn] = ((mp_limb_t) i) << cnt;
      /* Zero the xn lower limbs. */
      MPN_ZERO(xp, xn);

      nbits = BITS_PER_MP_LIMB - cnt;
      e += nbits;  /* exponent _before_ the rounding */

      /* round if MPFR_PREC(x) smaller than length of i */
      if (MPFR_UNLIKELY (MPFR_PREC (x) < nbits) &&
          MPFR_UNLIKELY (mpfr_round_raw (xp + xn, xp + xn, nbits, 0,
                                         MPFR_PREC (x), rnd_mode, &inex)))
        {
          e++;
          xp[xn] = MPFR_LIMB_HIGHBIT;
        }

      MPFR_CLEAR_FLAGS (x);
      MPFR_EXP (x) = e;
      return mpfr_check_range (x, inex, rnd_mode);
    }
}
