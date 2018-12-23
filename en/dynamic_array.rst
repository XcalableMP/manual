========================================
Dynamic allocation of distributed array
========================================

This section explains how distributed arrays are allocated at
runtime. The basic procedure is common in XMP/C and XMP/Fortran with a
few specific difference.

.. contents::
   :local:
   :depth: 2

One-dimensional array
----------------------
* XMP/C program

.. code-block:: C

   #pragma xmp nodes p[4]
   #pragma xmp template t[N]
   #pragma xmp distribute t[block] onto p
   float *a;
   #pragma xmp align a[i] with t[i]
     :
   a = xmp_malloc(xmp_desc_of(a), N);

First, declare a pointer of the type of the target distributed array.
Second, align it as if it were an array.
Finally, allocate memory for it with the xmp_malloc() function.
xmp_desc_of() is an intrinsic/builtin function that returns the
descriptor of the XMP object specified by the argument.

* XMP/Fortran program

.. code-block:: Fortran

   !$xmp nodes p(4)
   !$xmp template t(N)
   !$xmp distribute t(block) onto p
   real, allocatable :: a(:)
   !$xmp align a(i) with t(i)

   allocate(a(N))

First, declare an allocatable array of the type of the target
distributed array.
Second, align it. Finally, allocate memory for it with the allocate
statement.

Multi-dimensional array
------------------------
The procedure is the same as that for a one-dimensional array.

* XMP/C program

.. code-block:: C

   #pragma xmp nodes p[2][2]
   #pragma xmp template t[N1][N2]
   #pragma xmp distribute t[block][block] onto p
   float (*a)[N2];
   #pragma xmp align a[i][j] with t[i][j]
     :
   a = (float (*)[N2])xmp_malloc(xmp_desc_of(a), N1, N2);

* XMP/Fortran program

.. code-block:: Fortran

   !$xmp nodes p(2,2)
   !$xmp template t(N2,N1)
   !$xmp distribute t(block,block) onto p
   real, allocatable :: a(:,:)
   !$xmp align a(j,i) with t(j,i)
     :
   allocate(a(N2,N1))

.. note::
  If the size of template is not fixed until runtime, use :doc:`template_fix`.
