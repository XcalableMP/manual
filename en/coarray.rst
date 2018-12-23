=================================
coarray notation
=================================

An overview of Coarray has described in :doc:`tutorial-local`.
This page explains details of the synchronization statements that have not been explained yet.

.. contents::
   :local:
   :depth: 2

Synchronization statements
--------------------------
sync all
^^^^^^^^^^^^^^^^^^
* XMP/C program

.. code-block:: C

    void xmp_sync_all(int *status)

* XMP/Fortran program

.. code-block:: Fortran

   sync all

Barrier synchronization is performed among all images after completing all one side communications.
For details, see :doc:`tutorial-local`.

sync images
^^^^^^^^^^^^^^^^^^
* XMP/C program

.. code-block:: C

    void xmp_sync_images(int num, int *image-set, int *status)

* XMP/Fortran program

.. code-block:: Fortran

   sync images (image-set)

Barrier synchronization is performed among the specified images after completing all one side communications.

* XMP/C program

.. code-block:: C

   int image_set[3] = {0,1,2};
   xmp_sync_images(3, image_set, NULL);

* XMP/Fortran program

.. code-block:: Fortran

   integer :: image_set(3) = (/ 1, 2, 3/)
   sync images (image_set)


sync memory
^^^^^^^^^^^^^^^^^^
.. code-block:: C

    void xmp_sync_memory(int *status)

* XMP/Fortran program

.. code-block:: Fortran

   sync memory

Wait for completion of all one side communications.
This function does not include barrier synchronization unlike sync all and sync images, so it is executed only locally.

About arguments
----------------

* XMP/C program

.. code-block:: C

    void xmp_sync_all(int *status)
    void xmp_sync_images(int *status)
    void xmp_sync_memory(int *status)

* XMP/Fortran program

.. code-block:: Fortran

   sync all [stat=..] [errmsg=..]
   sync images (image-set) [stat=..] [errmsg=..]
   sync memory [stat=..] [errmsg=..]

In XMP/C, if synchronization is successful, "XMP_STAT_SUCCESS" which is the constant defined in xmp.h is assigned to status.
If any of the images have already ended, "XMP_STAT_STOPPED_IMAGE" is substituted to status.
In case of other errors, a value other than the above two values is assigned to status.


Similarly, if synchronization is successful in XMP/Fortran, "STAT_STOPPED_IMAGE" is assigned to the variable on the right hand side of stat=, and if any image has already ended, "STAT_STOPPED_IMAGE" is assigned.
In case of other errors, a value other than the above two values is assigned.


.. hint::
   In XMP/Fortran, if you omit stat= and errmsg=, synchronization speed will be faster.
   In XMP/C, assignment of status can be omitted by using NULL like xmp_sync_all (NULL);






