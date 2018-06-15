=================================
分散配列の動的生成
=================================

分散配列を動的に生成する方法について説明します．
基本的な手順はXMP/CとXMP/Fortranで同じですが，各ベース言語に沿った方法を採用しています．

.. contents::
   :local:
   :depth: 2

1次元配列の場合
-------------------
* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[4]
   #pragma xmp template t[N]
   #pragma xmp distribute t[block] onto p
   float *a;
   #pragma xmp align a[i] with t[i]
     :
   a = xmp_malloc(xmp_desc_of(a), N);

まず，分散配列で用いる型のポインタを宣言します．
次に，そのポインタを配列と仮定して，align指示文を使って整列させます．
最後に，xmp_malloc()を用いて，分散配列のメモリ空間を確保します．
xmp_desc_of()は引数に指定されたXMPオブジェクトのディスクリプタを返す関数です．

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(4)
   !$xmp template t(N)
   !$xmp distribute t(block) onto p
   real, allocatable :: a(:)
   !$xmp align a(i) with t(i)

   allocate(a(N))

まず，分散配列で用いる型のallocatable配列を宣言します．
次に，align指示文を使ってそのallocatable配列を整列させます．
最後に，allocate文を用いて，分散配列のメモリ空間を確保します．

多次元配列の場合
-----------------
1次元配列と同様の手順で多次元配列も動的に生成することができます．


* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[2][2]
   #pragma xmp template t[N1][N2]
   #pragma xmp distribute t[block][block] onto p
   float (*a)[N2];
   #pragma xmp align a[i][j] with t[i][j]
     :
   a = (float (*)[N2])xmp_malloc(xmp_desc_of(a), N1, N2);

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(2,2)
   !$xmp template t(N2,N1)
   !$xmp distribute t(block,block) onto p
   real, allocatable :: a(:,:)
   !$xmp align a(j,i) with t(j,i)
     :
   allocate(a(N2,N1))

.. note::
  テンプレートのサイズも動的に決定したい場合は，:doc:`template_fix` を併用します．
