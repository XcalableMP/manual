=================================
barrier construct
=================================

Execute barrier synchronization.

* XMP/C program

.. code-block:: C

   #pragma xmp barrier

* XMP/Fortran program

.. code-block:: Fortran

    !$xmp barrier

You can set the barrier range by using the on clause.
In the below example, barrier synchronization occurs only in the first two nodes of p.

* XMP/C program

.. code-block:: C

   #pragma xmp barrier on p[0:2]

* XMP/Fortran program

.. code-block:: Fortran

    !$xmp barrier on p(1:2)







