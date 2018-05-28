=================================
reduction指示文
=================================

集約演算を行います．
:doc:`loop` のreduction節と意味は同じですが，reduction指示文は任意の箇所に記述することができます．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[4]
     :
   sum = xmpc_node_num() + 1;
   #pragma xmp reduction (+:sum)

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp nodes p(4)
      :
    sum = xmp_node_num()
    !$xmp reduction (+:sum)

.. image:: ../img/reduction/reduction.png

on節を伴ってノード集合の範囲を指定することもできます．
下記の例では，4ノード中の後半の2ノードの値のみが集約演算の対象となります．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp nodes p[4]
     :
   sum = xmpc_node_num() + 1;
   #pragma xmp reduction (+:sum) on p[2:2]

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp nodes p(4)
     :
    sum = xmp_node_num()
    !$xmp reduction (+:sum) on p(3:4)

.. image:: ../img/reduction/reduction_on.png

指定できる演算子は下記の通りです．

* XMP/Cプログラム

.. code-block:: bash

    +
    *
    -
    &
    |
    ^
    &&
    ||
    max
    min

* XMP/Fortranプログラム

.. code-block:: bash

    +
    *
    -
    .and.
    .or.
    .eqv.
    .neqv.
    max
    min
    iand
    ior
    ieor

.. note::
   reduction節はループ文を伴うため，firstmax・firstmin・lastmax・lastminの演算子が必要ですが，
   reduction指示文はループ文を伴わないため，それらの演算子はありません．

.. note::
   reduction指示文はreduction節と同様に，集約変数が浮動小数点型の場合は，計算順序の違いにより，逐次実行と並列実行で結果がわずかに異なる場合があります．


