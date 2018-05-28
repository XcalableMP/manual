=================================
coarray記法
=================================

Coarrayの概要は :doc:`tutorial-local` で説明しました．
本ページでは，まだ説明していなった同期文の詳細について説明します．

.. contents::
   :local:
   :depth: 2

同期文の種類
-------------
sync all
^^^^^^^^^^^^^^^^^^
* XMP/Cプログラム

.. code-block:: C

    void xmp_sync_all(int *status)

* XMP/Fortranプログラム

.. code-block:: Fortran

   sync all

発行中の片側通信の完了後に全イメージでバリア同期を行います．
詳細は :doc:`tutorial-local` を参照してください．

sync images
^^^^^^^^^^^^^^^^^^
* XMP/Cプログラム

.. code-block:: C

    void xmp_sync_images(int num, int *image-set, int *status)

* XMP/Fortranプログラム

.. code-block:: Fortran

   sync images (image-set)

発行中の片側通信の完了後に指定したイメージ間でバリア同期を行います．

* XMP/Cプログラム

.. code-block:: C

   int image_set[3] = {0,1,2};
   xmp_sync_images(3, image_set, NULL);

* XMP/Fortranプログラム

.. code-block:: Fortran

   integer :: image_set(3) = (/ 1, 2, 3/)
   sync images (image_set)


sync memory
^^^^^^^^^^^^^^^^^^
.. code-block:: C

    void xmp_sync_memory(int *status)

* XMP/Fortranプログラム

.. code-block:: Fortran

   sync memory

発行中の片側通信の完了を待ちます．
この文は，sync allやsync imagesと異なりバリア同期を含まないため，ローカルのみで実行されます．

引数について
--------------

* XMP/Cプログラム

.. code-block:: C

    void xmp_sync_all(int *status)
    void xmp_sync_images(int *status)
    void xmp_sync_memory(int *status)

* XMP/Fortranプログラム

.. code-block:: Fortran

   sync all [stat=..] [errmsg=..]
   sync images (image-set) [stat=..] [errmsg=..]
   sync memory [stat=..] [errmsg=..]

XMP/Cにおいて，同期が成功した場合は，statusにはxmp.hで定義された定数である「XMP_STAT_SUCCESS」が代入されます．
いずれかのイメージがすでに終了していた場合は，「XMP_STAT_STOPPED_IMAGE」が代入されます．
それ以外のエラーの場合は，上記2つ以外の値が代入されます．

同様に，XMP/Fortranにおいて，同期が成功した場合は，stat=の右辺の変数に「STAT_STOPPED_IMAGE」が代入され，
いずれかのイメージがすでに終了していた場合は，「STAT_STOPPED_IMAGE」が代入されます．
それ以外のエラーの場合は，上記2つ以外の値が代入されます．

.. hint::
   XMP/Fortranにおいて，stat＝やerrmsg=を省略した方が同期の速度は早いでしょう．
   XMP/Cにおいても，xmp_sync_all(NULL); のようにNULLを用いることにより，statusの代入を省略することができます．





