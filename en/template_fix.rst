=================================
template_fix construct
=================================

The template_fix construct defines the size and distribution of an
unfixed template. It is also used when a distributed array is
allocated at runtime.

* XMP/C program

.. code-block:: C

   #pragma xmp nodes p[4]
   #pragma xmp template t[:]
   #pragma xmp distribute t[block] onto p
   double *a;
   #pragma xmp align a[i] with t[i]
   
   int n = 100;
   #pragma xmp template_fix t[n]
   a = xmp_malloc(xmp_desc_of(a), n);
   
* XMP/Fortran program

.. code-block:: Fortran
   
   !$xmp nodes p(4)
   !$xmp template t(:)
   !$xmp distribute t(block) onto p
   real, allocatable :: a(:)
   integer :: n
   !$xmp align a(i) with t(i)

   n = 100
   !$xmp template_fix t(n)
   allocate(a(n))

First, declare a template the size of which is undefined using the ":" notation.
Second, align a pointer in XMP/C and an allocatable array in
XMP/Fortran with the template.
Third, fix the size of the template with a template_fix construct.
Finally, allocate the array with the xmp_malloc() builtin function in
XMP/C and the allocate statement in XMP/Fortran.

.. note::
   template_fix constructs can be applied to a template only once.

The template_fix construct can also be used to define a mapping array of a
template that is distributed in "gblock(*)" at declaration.

* XMP/C program

.. code-block:: C

   #pragma xmp nodes p[4]
   #pragma xmp template t[:]
   #pragma xmp distribute t[gblock(*)] onto p
   double *a;
   #pragma xmp align a[i] with t[i]

   int n = 100;
   int m[] = {40,30,20,10};

   #pragma xmp template_fix[gblock(m)] t[n]
   a = xmp_malloc(xmp_desc_of(a), n);

* XMP/Fortran program

.. code-block:: Fortran

   !$xmp nodes p(4)
   !$xmp template t(:)
   !$xmp distribute t(gblock) onto p
   real, allocatable :: a(:)
   integer :: n, m(4)
   !$xmp align a(i) with t(i)

   n = 100
   m(:) = (/40,30,20,10/)
   !$xmp template_fix(gblock(m)) t(n)
   allocate(a(n))
