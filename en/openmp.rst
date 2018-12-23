=================================
Cooperation with OpenMP
=================================

You can write OpenMP directives in XMP programs.
In other words, you can do the hybrid programming with the XMP parallelized on the distributed memory system, and the OpenMP parallelized on the shared memory system.

However, there is a precondition that "a single thread must invoke XMP directive, Coarray notation excluding loop directive, a function provided by XMP, etc."
You can write the XMP loop directive as long as it is just before or after OpenMP/C parallel for directive or OpenMP/Fortran parallel do directive.

* XMP/C program

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

* XMP/Fortran program

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

The order of the XMP directive and the OpenMP directive does not matter in this case.
In the above example, the XMP directive first divides the loop statement into each node, and then the OpenMP directive divides the loop statement into the multiple CPU cores in each node.

