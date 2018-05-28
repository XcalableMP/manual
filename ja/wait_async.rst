=================================
wait_async指示文
=================================

通信指示文（reflect，gmove，reduction，bcast，reduce_shadow）には，「async」節をつけることで，非同期に通信を行うことができます．
その非同期通信の完了を保証するのにwait_async指示文は用いられます．

* XMP/Cプログラム

.. code-block:: C

    #pragma xmp bcast (num) async(1)
        :
    #pragma xmp wait_async (1)

* XMP/Fortranプログラム

.. code-block:: Fortran

    !$xmp bcast (num) async(1)
      	    :
    !$xmp wait_async (1)

bcast指示文はasync節があるので，bcast指示文の直後では通信は終わっていないかもしれません．
その通信の完了は，async節と同じ値が指定されているwait_async指示文で保証されます．
そのため，bcast指示文とwait_async指示文の間では，bcast指示文で指定してある変数numに関する操作を行うことはできません．

.. hint::
    bcast指示文の後に，bcast指示文で指定した変数と依存関係のない計算を行うことにより，
    いわゆる通信と計算のオーバラップを行うことができるため，全体の計算時間の削減が見込めます．

.. note::
   async節に指定できる値は，XMP/Cではint型であり，XMP/Fortranではinteger型です．







