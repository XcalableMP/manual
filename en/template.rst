=================================
template指示文
=================================

template指示文はテンプレートの名前と形状を宣言します．形状は多次元が可能です．
テンプレートは，データマッピングとワークマッピングを行うために使われる仮想的な配列です．

.. contents::
   :local:
   :depth: 2

1次元テンプレート
---------------------
* XMP/Cプログラム

.. code-block:: C

    #pragma xmp template t[10]

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp template t(10)

10要素からなる1次元テンプレートtを宣言しています，
XMP/Cでは，t[0]からt[9]が宣言されます．
同様に，XMP/Fortranでは，t(1)からt(10)が宣言されます．

.. hint::
   テンプレートのサイズはデータマッピングされる配列のサイズと同じが良いでしょう．

また，XMP/Fortranについてのみ，ベース言語であるFortranの配列と対応するために，テンプレートの開始番号を任意に定義できます．

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp template t(-5:4)

t(-5)からt(4)を要素に持つ1次元テンプレートtを宣言しています，

.. note::
   C言語では，配列のインデックスは必ず0から始まるためテンプレートの開始番号も0であり，変更はできません．

多次元テンプレート
---------------------
* XMP/Cプログラム

.. code-block:: C

    #pragma xmp template t[10][20]

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp template t(20,10)

10x20要素からなる2次元テンプレートtを宣言しています，
XMP/Cでは，t[0][0]からt[9][19]が宣言されます．
同様に，XMP/Fortranでは，t(1,1)からt(20,10)が宣言されます．

動的テンプレート
-------------------
* XMP/Cプログラム

.. code-block:: C

    #pragma xmp template t[:]

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp template t(:)

数字の代わりにコロンを指定した1次元テンプレートtを宣言しています．
コロンはテンプレートのサイズは未定義であることを示します．
このテンプレートのサイズは，:doc:`template_fix` によって動的に設定できます．
