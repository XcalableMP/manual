=================================
OpenMPとの連携
=================================

XMPプログラム中にOpenMP指示文を書くことが可能です．
すなわち，XMPプログラムは分散メモリシステム上の並列化を行い，OpenMP指示文は共有メモリシステム上の並列化を行う，
いわゆるハイブリッド並列をプログラミングできます．

ただし，制約条件として「loop指示文を除くXMP指示文・Coarray記法・XMPが提供する関数などは，シングルスレッドが呼び出さないといけない」があります．
XMPのloop指示文は，OpenMP/Cのparallel for指示文もしくはOpenMP/Fortranのparallel do指示文の直前か直後であれば記述できます．

* XMP/Cプログラム

.. code-block:: C

   #pragma omp parallel for
   #pragma xmp loop on t[i]
   for(int i=0;i<N;i++)
      a[i] = i;

.. code-block:: C

   #pragma xmp loop on t[i]
   #pragma omp parallel for
   for(int i=0;i<N;i++)
      a[i] = i;

* XMP/Fortranプログラム

.. code-block:: Fortran

   !$omp parallel do
   !$xmp loop on t(i)
   do i=1, N
     a(i) = i
   enddo

.. code-block:: Fortran

   !$xmp loop on t(i)
   !$omp parallel do
   do i=1, N
     a(i) = i
   enddo

XMP指示文とOpenMP指示文の順序はどちらが先でも構いません．
上の例では，まずXMP指示文がループ文を各ノードに分割し，その後にOpenMP指示文が各ノードが持つ（複数の）CPUコアにループ文を分割します．
