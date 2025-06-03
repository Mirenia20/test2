#include <gio/gio.h>

#if defined (__ELF__) && ( __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 6))
# define SECTION __attribute__ ((section (".gresource.raccoon"), aligned (sizeof(void *) > 8 ? sizeof(void *) : 8)))
#else
# define SECTION
#endif

static const SECTION union { const guint8 data[1821]; const double alignment; void * const ptr;}  raccoon_resource_data = {
  "\107\126\141\162\151\141\156\164\000\000\000\000\000\000\000\000"
  "\030\000\000\000\310\000\000\000\000\000\000\050\006\000\000\000"
  "\000\000\000\000\002\000\000\000\004\000\000\000\005\000\000\000"
  "\005\000\000\000\005\000\000\000\012\305\113\011\005\000\000\000"
  "\310\000\000\000\003\000\114\000\314\000\000\000\320\000\000\000"
  "\310\163\011\033\004\000\000\000\320\000\000\000\010\000\114\000"
  "\330\000\000\000\334\000\000\000\071\140\124\367\003\000\000\000"
  "\334\000\000\000\025\000\166\000\370\000\000\000\002\007\000\000"
  "\165\311\075\044\000\000\000\000\002\007\000\000\006\000\114\000"
  "\010\007\000\000\014\007\000\000\324\265\002\000\377\377\377\377"
  "\014\007\000\000\001\000\114\000\020\007\000\000\024\007\000\000"
  "\111\017\350\151\001\000\000\000\024\007\000\000\003\000\114\000"
  "\030\007\000\000\034\007\000\000\170\172\057\000\003\000\000\000"
  "\122\141\143\143\157\157\156\057\005\000\000\000\150\151\163\164"
  "\157\162\171\055\165\156\144\157\055\163\171\155\142\157\154\151"
  "\143\000\000\000\000\000\000\000\372\005\000\000\000\000\000\000"
  "\074\077\170\155\154\040\166\145\162\163\151\157\156\075\042\061"
  "\056\060\042\040\145\156\143\157\144\151\156\147\075\042\125\124"
  "\106\055\070\042\077\076\012\074\163\166\147\040\170\155\154\156"
  "\163\075\042\150\164\164\160\072\057\057\167\167\167\056\167\063"
  "\056\157\162\147\057\062\060\060\060\057\163\166\147\042\040\150"
  "\145\151\147\150\164\075\042\061\066\160\170\042\040\166\151\145"
  "\167\102\157\170\075\042\060\040\060\040\061\066\040\061\066\042"
  "\040\167\151\144\164\150\075\042\061\066\160\170\042\076\074\147"
  "\040\146\151\154\154\075\042\043\062\062\062\062\062\062\042\076"
  "\074\160\141\164\150\040\144\075\042\155\040\070\056\066\060\071"
  "\063\067\065\040\060\056\071\071\066\060\071\064\040\143\040\060"
  "\056\066\061\067\061\070\067\040\060\056\060\060\067\070\061\062"
  "\040\061\056\062\063\070\062\070\061\040\060\056\060\070\071\070"
  "\064\064\040\061\056\070\065\061\065\066\063\040\060\056\062\065"
  "\063\071\060\066\040\143\040\063\056\062\067\063\064\063\067\040"
  "\060\056\070\067\070\071\060\066\040\065\056\065\065\070\065\071"
  "\063\040\063\056\070\065\065\064\066\071\040\065\056\065\065\070"
  "\065\071\063\040\067\056\062\064\066\060\071\064\040\163\040\055"
  "\062\056\062\070\065\061\065\066\040\066\056\063\066\067\061\070"
  "\067\040\055\065\056\065\065\070\065\071\063\040\067\056\062\064"
  "\062\061\070\067\040\143\040\055\063\056\062\067\063\064\063\070"
  "\040\060\056\070\067\070\071\060\067\040\055\066\056\067\064\062"
  "\061\070\070\040\055\060\056\065\065\070\065\071\063\040\055\070"
  "\056\064\063\067\065\040\055\063\056\064\071\062\061\070\067\040"
  "\143\040\055\060\056\062\067\067\063\064\064\040\055\060\056\064"
  "\070\060\064\066\071\040\055\060\056\061\060\071\063\067\066\040"
  "\055\061\056\060\070\071\070\064\064\040\060\056\063\066\067\061"
  "\070\067\040\055\061\056\063\066\067\061\070\070\040\143\040\060"
  "\056\064\067\066\065\066\063\040\055\060\056\062\067\063\064\063"
  "\067\040\061\056\060\070\071\070\064\064\040\055\060\056\061\060"
  "\071\063\067\065\040\061\056\063\066\063\062\070\061\040\060\056"
  "\063\066\067\061\070\070\040\143\040\061\056\062\065\040\062\056"
  "\061\066\060\061\065\066\040\063\056\067\070\061\062\065\040\063"
  "\056\062\060\067\060\063\061\040\066\056\061\070\067\065\040\062"
  "\056\065\066\062\065\040\143\040\062\056\064\061\060\061\065\066"
  "\040\055\060\056\066\064\064\065\063\062\040\064\056\060\067\070"
  "\061\062\065\040\055\062\056\070\062\060\063\061\063\040\064\056"
  "\060\067\070\061\062\065\040\055\065\056\063\061\062\065\040\143"
  "\040\060\040\055\062\056\064\071\066\060\071\064\040\055\061\056"
  "\066\066\067\071\066\071\040\055\064\056\066\066\067\071\066\071"
  "\040\055\064\056\060\067\070\061\062\065\040\055\065\056\063\061"
  "\062\065\040\143\040\055\062\056\064\060\066\062\065\040\055\060"
  "\056\066\064\064\065\063\062\040\055\064\056\071\063\067\065\040"
  "\060\056\064\060\062\063\064\064\040\055\066\056\061\070\067\065"
  "\040\062\056\065\066\062\065\040\143\040\055\060\056\060\065\064"
  "\066\070\067\040\060\056\060\070\065\071\063\067\040\055\060\056"
  "\061\062\061\060\071\064\040\060\056\061\066\064\060\066\062\040"
  "\055\060\056\061\071\071\062\061\070\040\060\056\062\062\066\065"
  "\066\062\040\154\040\060\056\060\061\065\066\062\064\040\060\056"
  "\060\061\065\066\062\065\040\154\040\060\056\060\061\061\067\061"
  "\071\040\060\056\060\060\067\070\061\063\040\154\040\055\062\056"
  "\065\066\062\065\040\061\040\154\040\061\040\055\062\056\063\061"
  "\062\065\040\154\040\060\056\060\061\061\067\061\071\040\060\056"
  "\060\061\061\067\061\070\040\154\040\060\056\060\061\065\066\062"
  "\065\040\060\056\060\061\061\067\061\071\040\143\040\061\056\062"
  "\067\063\064\063\067\040\055\062\056\061\067\071\066\070\067\040"
  "\063\056\065\063\061\062\065\040\055\063\056\065\061\071\065\063"
  "\061\040\065\056\071\065\063\061\062\065\040\055\063\056\066\071"
  "\061\064\060\066\040\143\040\060\056\062\060\063\061\062\065\040"
  "\055\060\056\060\061\065\066\062\065\040\060\056\064\060\066\062"
  "\065\040\055\060\056\060\061\071\065\063\061\040\060\056\066\060"
  "\071\063\067\065\040\055\060\056\060\061\071\065\063\061\040\172"
  "\040\155\040\060\040\060\042\057\076\074\160\141\164\150\040\144"
  "\075\042\155\040\070\056\065\061\071\065\063\061\040\064\056\071"
  "\071\066\060\071\064\040\143\040\055\060\056\062\067\067\063\064"
  "\063\040\060\040\055\060\056\065\040\060\056\062\062\062\066\065"
  "\066\040\055\060\056\065\040\060\056\065\040\166\040\063\056\062"
  "\060\067\060\063\061\040\154\040\062\056\061\064\064\065\063\061"
  "\040\062\056\061\064\070\064\063\067\040\143\040\060\056\061\071"
  "\065\063\061\063\040\060\056\061\071\061\064\060\067\040\060\056"
  "\065\061\061\067\061\071\040\060\056\061\071\061\064\060\067\040"
  "\060\056\067\060\067\060\063\062\040\060\040\143\040\060\056\061"
  "\071\065\063\061\062\040\055\060\056\061\071\065\063\061\062\040"
  "\060\056\061\071\065\063\061\062\040\055\060\056\065\061\065\066"
  "\062\064\040\060\040\055\060\056\067\061\060\071\063\067\040\154"
  "\040\055\061\056\070\065\061\065\066\063\040\055\061\056\070\065"
  "\061\065\066\063\040\166\040\055\062\056\067\071\062\071\066\070"
  "\040\143\040\060\040\055\060\056\062\067\067\063\064\064\040\055"
  "\060\056\062\062\062\066\065\066\040\055\060\056\065\040\055\060"
  "\056\065\040\055\060\056\065\040\172\040\155\040\060\040\060\042"
  "\057\076\074\160\141\164\150\040\144\075\042\155\040\061\056\060"
  "\061\071\065\063\061\040\061\056\071\071\066\060\071\064\040\143"
  "\040\055\060\056\065\065\060\067\070\061\040\060\040\055\060\056"
  "\071\071\071\071\071\071\070\040\060\056\064\064\071\062\061\070"
  "\040\055\060\056\071\071\071\071\071\071\070\040\061\040\166\040"
  "\064\040\143\040\060\040\060\056\065\065\060\067\070\061\040\060"
  "\056\064\064\071\062\061\070\070\040\061\040\060\056\071\071\071"
  "\071\071\071\070\040\061\040\150\040\064\040\143\040\060\056\065"
  "\065\060\067\070\061\040\060\040\061\040\055\060\056\064\064\071"
  "\062\061\071\040\061\040\055\061\040\143\040\060\040\055\060\056"
  "\065\065\060\067\070\062\040\055\060\056\064\064\071\062\061\071"
  "\040\055\061\040\055\061\040\055\061\040\150\040\055\063\040\166"
  "\040\055\063\040\143\040\060\040\055\060\056\065\065\060\067\070"
  "\062\040\055\060\056\064\064\071\062\061\071\040\055\061\040\055"
  "\061\040\055\061\040\172\040\155\040\060\040\060\042\057\076\074"
  "\057\147\076\074\057\163\166\147\076\012\000\000\050\165\165\141"
  "\171\051\151\143\157\156\163\057\002\000\000\000\057\000\000\000"
  "\001\000\000\000\152\150\057\000\000\000\000\000" };

static GStaticResource static_resource = { raccoon_resource_data.data, sizeof (raccoon_resource_data.data) - 1 /* nul terminator */, NULL, NULL, NULL };

G_MODULE_EXPORT
GResource *raccoon_get_resource (void);
GResource *raccoon_get_resource (void)
{
  return g_static_resource_get_resource (&static_resource);
}
/* GLIB - Library of useful routines for C programming
 * Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
 *
 * SPDX-License-Identifier: LGPL-2.1-or-later
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Modified by the GLib Team and others 1997-2000.  See the AUTHORS
 * file for a list of people on the GLib Team.  See the ChangeLog
 * files for a list of changes.  These files are distributed with
 * GLib at ftp://ftp.gtk.org/pub/gtk/.
 */

#ifndef __G_CONSTRUCTOR_H__
#define __G_CONSTRUCTOR_H__

/*
  If G_HAS_CONSTRUCTORS is true then the compiler support *both* constructors and
  destructors, in a usable way, including e.g. on library unload. If not you're on
  your own.

  Some compilers need #pragma to handle this, which does not work with macros,
  so the way you need to use this is (for constructors):

  #ifdef G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA
  #pragma G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(my_constructor)
  #endif
  G_DEFINE_CONSTRUCTOR(my_constructor)
  static void my_constructor(void) {
   ...
  }

*/

#ifndef __GTK_DOC_IGNORE__

#if  __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 7)

#define G_HAS_CONSTRUCTORS 1

#define G_DEFINE_CONSTRUCTOR(_func) static void __attribute__((constructor)) _func (void);
#define G_DEFINE_DESTRUCTOR(_func) static void __attribute__((destructor)) _func (void);

#elif defined (_MSC_VER)

/*
 * Only try to include gslist.h if not already included via glib.h,
 * so that items using gconstructor.h outside of GLib (such as
 * GResources) continue to build properly.
 */
#ifndef __G_LIB_H__
#include "gslist.h"
#endif

#include <stdlib.h>

#define G_HAS_CONSTRUCTORS 1

/* We do some weird things to avoid the constructors being optimized
 * away on VS2015 if WholeProgramOptimization is enabled. First we
 * make a reference to the array from the wrapper to make sure its
 * references. Then we use a pragma to make sure the wrapper function
 * symbol is always included at the link stage. Also, the symbols
 * need to be extern (but not dllexport), even though they are not
 * really used from another object file.
 */

/* We need to account for differences between the mangling of symbols
 * for x86 and x64/ARM/ARM64 programs, as symbols on x86 are prefixed
 * with an underscore but symbols on x64/ARM/ARM64 are not.
 */
#ifdef _M_IX86
#define G_MSVC_SYMBOL_PREFIX "_"
#else
#define G_MSVC_SYMBOL_PREFIX ""
#endif

#define G_DEFINE_CONSTRUCTOR(_func) G_MSVC_CTOR (_func, G_MSVC_SYMBOL_PREFIX)
#define G_DEFINE_DESTRUCTOR(_func) G_MSVC_DTOR (_func, G_MSVC_SYMBOL_PREFIX)

#define G_MSVC_CTOR(_func,_sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void);              \
  int _func ## _wrapper(void);              \
  int _func ## _wrapper(void) { _func(); g_slist_find (NULL,  _array ## _func); return 0; } \
  __pragma(comment(linker,"/include:" _sym_prefix # _func "_wrapper")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _wrapper;

#define G_MSVC_DTOR(_func,_sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void);              \
  int _func ## _constructor(void);              \
  int _func ## _constructor(void) { atexit (_func); g_slist_find (NULL,  _array ## _func); return 0; } \
   __pragma(comment(linker,"/include:" _sym_prefix # _func "_constructor")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _constructor;

#elif defined(__SUNPRO_C)

/* This is not tested, but i believe it should work, based on:
 * http://opensource.apple.com/source/OpenSSL098/OpenSSL098-35/src/fips/fips_premain.c
 */

#define G_HAS_CONSTRUCTORS 1

#define G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA 1
#define G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA 1

#define G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(_func) \
  init(_func)
#define G_DEFINE_CONSTRUCTOR(_func) \
  static void _func(void);

#define G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(_func) \
  fini(_func)
#define G_DEFINE_DESTRUCTOR(_func) \
  static void _func(void);

#else

/* constructors not supported for this compiler */

#endif

#endif /* __GTK_DOC_IGNORE__ */
#endif /* __G_CONSTRUCTOR_H__ */

#ifdef G_HAS_CONSTRUCTORS

#ifdef G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA
#pragma G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(raccoonresource_constructor)
#endif
G_DEFINE_CONSTRUCTOR(raccoonresource_constructor)
#ifdef G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA
#pragma G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(raccoonresource_destructor)
#endif
G_DEFINE_DESTRUCTOR(raccoonresource_destructor)

#else
#warning "Constructor not supported on this compiler, linking in resources will not work"
#endif

static void raccoonresource_constructor (void)
{
  g_static_resource_init (&static_resource);
}

static void raccoonresource_destructor (void)
{
  g_static_resource_fini (&static_resource);
}
