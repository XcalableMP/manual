=================================
template Construct
=================================

The template construct declares the name of a template and its shape.
Templates are virtual arrays which used for data and work mapping.
They can have multi-dimensional shapes.

.. contents::
   :local:
   :depth: 2

1-dimensional Template
---------------------
* XMP/C program

.. code-block:: C

    #pragma xmp template t[10]

* XMP/Fortran program

.. code-block:: Fortran

    !$xmp template t(10)

The template construct declares 1-dimensional template t which has 10 elements.
In XMP/C, each element has an unique index from t[0] to t[9].
Likewise, in XMP/Fortran, the index starts from t(1) to t(10).

.. hint::
   In general, the user declare temaplates which has the same size with the target data array where data/work mapping is done.

In XMP/Fortran, the start index of the template can be given by an arbitrary number to match the starting array index in the base language.

* XMP/Fortran program

.. code-block:: Fortran

    !$xmp template t(-5:4)

The template construct declares 1-dimensional template t starting from t(-5) to t(4).

.. note::
   In XMP/C, templates should start from 0 since array indices start from 0 in the C language.

Multi-dimensional Template
---------------------
* XMP/C program

.. code-block:: C

    #pragma xmp template t[10][20]

* XMP/Fortran program

.. code-block:: Fortran

    !$xmp template t(20,10)

The template construct declares 2-dimensional template t which has 10x20 elements.
In XMP/C, the template has elements starting from t[0][0] to t[9][19]．
Likewise, the template has elements starting from t(1,1) to t(20,10) in XMP/Fortran.

Dynamic Template
-------------------
* XMP/C program

.. code-block:: C

    #pragma xmp template t[:]

* XMP/Fortran program

.. code-block:: Fortran

    !$xmp template t(:)

A colon symbol is used instead of a number to declare 1-dimensional dynamic template t.
The colon symbol indicates that the size of the template is undefined.
The size of the template is determined at runtime by :doc:`template_fix`．
