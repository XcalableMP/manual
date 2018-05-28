=================================
template_fix指示文
=================================

template_fix指示文は，サイズ未定義のテンプレートに対してそのサイズと分散の形状を定義します．
分散配列のサイズも動的に決定する場合に用います．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[4]
   #pragma xmp template t[:]
   #pragma xmp distribute t[block] onto p
   double *a;
   #pragma xmp align a[i] with t[i]
   
   int n = 100;
   #pragma xmp template_fix t[n]
   a = xmp_malloc(xmp_desc_of(a), n);
   
* XMP/Fortranプログラム

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

まず，template指示文は，サイズが未定義のテンプレートをコロンを用いて宣言します．
次に，align指示文は，XMP/Cの場合はポインタを配列と仮定して整列し，XMP/Fortranの場合はallocatable配列を整列します．
template_fix指示文は，テンプレートのサイズを定義します．
最後に，XMP/Cの場合はxmp_malloc()，XMP/Fortranの場合はallocate文を使って，分散配列のサイズを決定します．

.. note::
   template_fix指示文によるサイズ未定義のテンプレートに対する定義は1回だけ行うことができます．

distribute指示文において「gblock(*)」を指定した場合は，template_fix指示文において，下記のようにgblockにおける分散の形状も決定することができます．

* XMP/Cプログラム

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

* XMP/Fortranプログラム

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
