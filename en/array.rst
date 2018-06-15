=================================
array指示文
=================================

array指示文は，配列代入文を並列実行するために用います．


* XMP/Cプログラム

.. code-block:: C

   #pragma xmp align a[i] with t[i]
     :
   #pragma xmp array on t[0:N]
   a[0:N] = 1.0;

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp align a(i) with t(i)
     :
   !$xmp array on t(1:N)
   a(1:N) = 1.0

上の例は，下記と同じ意味です．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp align a[i] with t[i]
     :
   #pragma xmp loop on t[i]
   for(int i=0;i<N;i++)
     a[i] = 1.0;

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp align a(i) with t(i)
     :
   !$xmp loop on t(i)
   do i=1, N
     a(i) = 1.0
   enddo

また，多次元配列も表現可能です．さらに，tripletを使うと，全要素に対する処理が簡単に表現できます．

* XMP/Cプログラム

.. code-block:: C

   #pragma xmp align a[i][j] with t[i][j]
     :
   #pragma xmp array on t[:][:]
   a[:][:] = 1.0;

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$xmp align a(j,i) with t(j,i)
     :
   !$xmp array on t(:,:)
   a(:,:) = 1.0

.. note::
   on節で指定するテンプレートは，代入文中の分散配列と同じ形状である必要があります．
   また，右辺の値は全ノードで同じである必要があります．
   さらに，array指示文は全ノードが実行する必要があります．

