=================================
distribute Construct
=================================

The distribute construct specifies a distribution of the target template.
The user can specify block, cyclic, block-cyclic, gblock (irregular data distribution) distribution, which can be chosen by the target application.

.. contents::
   :local:
   :depth: 2

block Distribution
----------

* XMP/C program

.. code-block:: C

   #pragma xmp distribute t[block] onto p

* XMP/Fortran program

.. code-block:: Fortran

   !$xmp distribute t(block) onto p

各ノードにブロック状に要素が割り当てられます．
テンプレートのサイズをN，ノード数をKとした場合，
ブロック幅はceil(N/K)で計算されます．
差分法の計算など，近傍の要素の参照が多い場合に適します．

.. note:: 

   関数ceil(x)は，x以上の最小の整数を返します．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[3]
   #pragma xmp template t[22]
   #pragma xmp distribute t[block] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(3)
   !$xmp template t(22)
   !$xmp distribute t(block) onto p

.. image:: ../img/distribute/block.png

ceil(22/3)=8なので，最初の2ノードは8要素が割り当てられ，最後のノードは余りの6要素が割り当てられます．

また，下記のように，ブロック幅を指定することができます．
この場合も，最後のノードは余りの要素が割り当てられます．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[3]
   #pragma xmp template t[22]
   #pragma xmp distribute t[block(7)] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(3)
   !$xmp template t(22)
   !$xmp distribute t(block(7)) onto p

.. image:: ../img/distribute/block2.png

最初の2ノードは指定した7要素が割り当てられ，最後のノードは余りの8要素が割り当てられます．

cyclic分散
----------

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp distribute t[cyclic] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp distribute t(cyclic) onto p

各ノードに1要素ずつ割り当てられます．
計算負荷に偏りや不規則なばらつきがある場合に適します．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[3]
   #pragma xmp template t[22]
   #pragma xmp distribute t[cyclic] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(3)
   !$xmp template t(22)
   !$xmp distribute t(cyclic) onto p

.. image:: ../img/distribute/cyclic.png

block-cyclic分散
-------------------

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp distribute t[cyclic(w)] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp distribute t(cyclic(w)) onto p

各ノードにw要素ずつ割り当てられます．
block分散では負荷が不均等になるが，
近傍要素の参照があるためcyclicでは性能が悪くなるような場合に適します．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[3]
   #pragma xmp template t[22]
   #pragma xmp distribute t[cyclic(3)] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(3)
   !$xmp template t(22)
   !$xmp distribute t(cyclic(3)) onto p

.. image:: ../img/distribute/block-cyclic.png

gblock分散
-----------

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp distribute t[gblock(W)] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp distribute t(gblock(W)) onto p

Wはマッピング配列であり，W[k]/W(k)はp(k)に割り当てる要素数になります．
三角行列など，負荷の偏りがわかっている場合に適します．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[3]
   #pragma xmp template t[22]
   int W[3] = {6, 11, 5};
   #pragma xmp distribute t[gblock(W)] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(3)
   !$xmp template t(22)
   integer, parameter :: W(3) = (/6,11,5/)
   !$xmp distribute t(gblock(W)) onto p

.. image:: ../img/distribute/gblock.png

「gblock(*)」のように，マッピング配列の代わりにアスタリスクを用いることもできます．
この場合の分散の形状は :doc:`template_fix` を用いて，動的に決定できます．

多次元テンプレートの分散
--------------------------
ここからは，多次元のノード集合とテンプレートを用いた分散について説明します．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[2][2]
   #pragma xmp template t[10][10]
   #pragma xmp distribute t[block][block] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(2,2)
   !$xmp template t(10,10)
   !$xmp distribute t(block,block) onto p

2次元ノード集合を2次元テンプレートに分散させています．
ノード集合の各次元は，共にテンプレートにblock分散させています．

.. image:: ../img/distribute/multi.png

下記のように，次元毎に異なる分散を行うこともできます．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[2][2]
   #pragma xmp template t[10][10]
   #pragma xmp distribute t[block][cyclic] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(2,2)
   !$xmp template t(10,10)
   !$xmp distribute t(cyclic,block) onto p

.. image:: ../img/distribute/multi2.png


distribute指示文の分散の形状の箇所にアスタリスクを用いると「非分散」という意味になります．
下記の例では，テンプレートの1次元目だけをブロック分散しています．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[4]
   #pragma xmp template t[10][10]
   #pragma xmp distribute t[block][*] onto p

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(4)
   !$xmp template t(10,10)
   !$xmp distribute t(*,block) onto p

.. image:: ../img/distribute/multi3.png
