=================================
wait_async directive
=================================

Communication directives (reflect, gmove, reduction, bcast, reduce_shadow) can execute asynchronous communication by attaching the "async" clause.
The wait_async directive is used to guarantee the completion of that asynchronous communication.

* XMP/C program

.. code-block:: C

    #pragma xmp bcast (num) async(1)
        :
    #pragma xmp wait_async (1)

* XMP/Fortran program

.. code-block:: Fortran

    !$xmp bcast (num) async(1)
      	    :
    !$xmp wait_async (1)

Since the bcast directive has an async clause, communication may not be completed immediately after the bcast directive.
Completion of that communication is guaranteed with the wait_async directive whose the same value as the async clause is specified.
Therefore, between the bcast directive and the wait_async directive, you can not operate on the num valiable specified in the bcast directive.

.. hint::
    By performing calculations without a dependency relationship with the variable specified by the bcast directive after the bcast directive, overlap of communication and calculation can be performed, so the total calculation time can be expected to be reduced.

.. note::
   Values that can be specified for async clause are int type in XMP/C, and integer type in XMP/Fortran.







