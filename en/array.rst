=================================
array construct
=================================

The array construct is for work mapping of array assignment statements.

* XMP/C program

.. code-block:: C

   #pragma xmp align a[i] with t[i]
     :
   #pragma xmp array on t[0:N]
   a[0:N] = 1.0;

* XMP/Fortran program

.. code-block:: Fortran

   !$xmp align a(i) with t(i)
     :
   !$xmp array on t(1:N)
   a(1:N) = 1.0

The above is equivalent to the below.

* XMP/C program

.. code-block:: C

   #pragma xmp align a[i] with t[i]
     :
   #pragma xmp loop on t[i]
   for(int i=0;i<N;i++)
     a[i] = 1.0;

* XMP/Fortran program

.. code-block:: Fortran

   !$xmp align a(i) with t(i)
     :
   !$xmp loop on t(i)
   do i=1, N
     a(i) = 1.0
   enddo

This construct can also be applied to multi-dimensional arrays.
The triplet notation enables specifying operations for all elements of
the array.

* XMP/C program

.. code-block:: C

   #pragma xmp align a[i][j] with t[i][j]
     :
   #pragma xmp array on t[:][:]
   a[:][:] = 1.0;

* XMP/Fortran program

.. code-block:: Fortran

   !$xmp align a(j,i) with t(j,i)
     :
   !$xmp array on t(:,:)
   a(:,:) = 1.0

.. note::
   The template appearing in the on clause must have the same shape of
   arrays in the following statement. The right-hand-side value must be identical
   among all nodes because the array construct is a collective operation.
