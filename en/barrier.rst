=================================
barrier指示文
=================================

バリア同期を発生させます．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp barrier

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp barrier

on節を使って，バリアの範囲を設定することもできます．
下記の例では，ノード集合pの最初の2ノードだけでバリア同期が発生します．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp barrier on p[0:2]

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp barrier on p(1:2)







