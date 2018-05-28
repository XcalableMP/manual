=========================
How to use
=========================
This section describes how to compile a code where XcalableMP, XcalableACC, and OpenACC directives exist, and how to execute binary of it. 

How to compile
=========================

XcalableMP/C
----------------------

.. code-block:: bash

    $ xmpcc a.c

XcalableMP/Fortran
----------------------

.. code-block:: bash

    $ xmpf90 a.f90

XcalableACC/C
----------------------

.. code-block:: bash

    $ xmpcc -xacc a.c

OpenACC/C
----------------------

.. code-block:: bash

    $ ompcc -acc a.c

About the compile option
==================================================
A native compiler finally compiles the code translated by Omni Compiler, 
so all compile options except for options specific to Omni Compiler are passed to the native compiler.
For example, when using the optimization option ``-O2`` that is often used, ``-O2`` is passed to the native compiler.

.. code-block:: bash

    $ xmpcc -O2 a.c

Omni Compiler specific options
------------------------------

Classification of options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Omni Compiler specific option is classified into a **"common option"** and a **"unique option."** 
Moreover, the common option is classified into a **"compile driver option"** and a **"process option."**

* Common option is an option for all languages and directives. 

  * Compile driver option is an option applied to all compilation processes. 
  * Process option is an option applied to each compilation process. 

* Unique option is an option for each language and directive. 

.. image:: ../img/flow.png

Common options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* Compile driver option

+-------------------+------------------------------------------------------------------------------+
| Option            | Description                                                                  |
+===================+==============================================================================+
| -o <file>         | place an output into <file>                                                  |
+-------------------+------------------------------------------------------------------------------+
| -I <dir>          | add a list of directories to be searched for header files                    |
+-------------------+------------------------------------------------------------------------------+
| -c                | compile and assemble, but do not link                                        |
+-------------------+------------------------------------------------------------------------------+
| -E                | preprocess only; do not compile, assemble or link                            |
+-------------------+------------------------------------------------------------------------------+
| -v,--verbose      | print processing status                                                      |
+-------------------+------------------------------------------------------------------------------+
| --version         | print version                                                                |
+-------------------+------------------------------------------------------------------------------+
| -h,--help         | print usage                                                                  |
+-------------------+------------------------------------------------------------------------------+
| --show-env        | show environment variables                                                   |
+-------------------+------------------------------------------------------------------------------+
| --tmp             | output a translated code to __omni__tmp__<file>                              |
+-------------------+------------------------------------------------------------------------------+
| --dry             | only print processing status (not compile)                                   |
+-------------------+------------------------------------------------------------------------------+
| --debug           | save intermediate files to ./__omni_tmp__/                                   |
+-------------------+------------------------------------------------------------------------------+
| --stop-pp         | save intermediate files and stop after preprocess                            |
+-------------------+------------------------------------------------------------------------------+
| --stop-frontend   | save intermediate files and stop after frontend                              |
+-------------------+------------------------------------------------------------------------------+
| --stop-translator | save intermediate files and stop after translator                            |
+-------------------+------------------------------------------------------------------------------+
| --stop-backend    | save intermediate files and stop after backend                               |
+-------------------+------------------------------------------------------------------------------+
| --stop-compile    | save intermediate files and stop after compile                               |
+-------------------+------------------------------------------------------------------------------+

* Process option

+-------------------+------------------------------------------+
| Option            | Description                              |
+===================+==========================================+
| --Wp[option]      | add preprocessor option                  |
+-------------------+------------------------------------------+
| --Wf[option]      | add frontend option                      |
+-------------------+------------------------------------------+
| --Wx[option]      | add Xcode translator option              |
+-------------------+------------------------------------------+
| --Wb[option]      | add backend option                       |
+-------------------+------------------------------------------+
| --Wn[option]      | add native compiler option               |
+-------------------+------------------------------------------+
| --Wl[option]      | add linker option                        |
+-------------------+------------------------------------------+

For example, if you want to add the option ``-Ltest`` to only a linker process, you execute it as follows.

.. code-block:: bash

    $ xmpcc --Wl"-Ltest" a.c

Unique option
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* XcalableMP/C

+------------------------------+---------------------------------------------------------------------+
| Option                       | Description                                                         |
+==============================+=====================================================================+
| -omp, --openmp               | enable OpenMP function                                              |
+------------------------------+---------------------------------------------------------------------+
| --profile scalasca           | output results in scalasca format for all directives                |
+------------------------------+---------------------------------------------------------------------+
| --profile tlog               | output results in tlog format for all directives                    |
+------------------------------+---------------------------------------------------------------------+
| --selective-profile scalasca | output results in scalasca format for selected directives           |
+------------------------------+---------------------------------------------------------------------+
| --selective-profile tlog     | output results in tlog format for selected directives               |
+------------------------------+---------------------------------------------------------------------+

* XcalableMP/Fortran

+----------------------+----------------------------------------------------------------+
| Option               | Description                                                    |
+======================+================================================================+
| -omp, --openmp       | enable OpenMP function                                         |
+----------------------+----------------------------------------------------------------+
| -J <dir>             | specify where to put .mod and .xmod files for compiled modules |
+----------------------+----------------------------------------------------------------+
| -cpp                 | enable preprocess                                              |
+----------------------+----------------------------------------------------------------+
| -max_assumed_shape=N | specifies maximum assumed-shape array arguments (default: 16)  |
+----------------------+----------------------------------------------------------------+

* XcalableACC/C

+----------------------------------+-------------------------------------------------------------------------------------------------------+
| Option                           | Description                                                                                           |
+==================================+=======================================================================================================+
| -xacc[=pgi], --xcalableacc[=pgi] | enable XcalableACC function. When aading ``=pgi``, PGI compiler is used as a backend OpenACC compiler |
+----------------------------------+-------------------------------------------------------------------------------------------------------+
| --no-ldg                         | disable use of read-only data cache                                                                   |
+----------------------------------+-------------------------------------------------------------------------------------------------------+
| --default-veclen=LENGTH          | specify default vector length (default: 256)                                                          |
+----------------------------------+-------------------------------------------------------------------------------------------------------+
| --platform=PLATFORM              | specify platform (CUDA or OpenCL) (default: CUDA)                                                     |
+----------------------------------+-------------------------------------------------------------------------------------------------------+
| --device=DEVICE                  | specify device (Fermi or Kepler) (default: Fermi)                                                     |
+----------------------------------+-------------------------------------------------------------------------------------------------------+

* XcalableACC/Fortran

+----------------------------------+-------------------------------------------------------------------------------------------------------+
| Option                           | Description                                                                                           |
+==================================+=======================================================================================================+
| -xacc[=pgi], --xcalableacc[=pgi] | enable XcalableACC function. When aading ``=pgi``, PGI compiler is used as a backend OpenACC compiler |
+----------------------------------+-------------------------------------------------------------------------------------------------------+

* OpenACC/C

+-------------------------+---------------------------------------------------+
| Option                  | Description                                       |
+=========================+===================================================+
| -acc, --openacc         | enable OpenACC function                           |
+-------------------------+---------------------------------------------------+
| --no-ldg                | disable use of read-only data cache               |
+-------------------------+---------------------------------------------------+
| --default-veclen=LENGTH | specify default vector length (default: 256)      |
+-------------------------+---------------------------------------------------+
| --platform=PLATFORM     | specify platform (CUDA or OpenCL) (default: CUDA) |
+-------------------------+---------------------------------------------------+
| --device=DEVICE         | specify device (Fermi or Kepler) (default: Fermi) |
+-------------------------+---------------------------------------------------+

How to execute
================

XcalableMP and XcalableACC
----------------------------
Because the runtime libraries of XcalableMP and XcalableACC use MPI,
you execute a program by using an MPI execution command, for example, the ``mpiexec`` or ``mpirun`` command.
Except when the runtime library uses GASNet, you execute a program by using the GASNet execution command (``gasnetrun_XXX``. ``XXX`` is a conduit name).

* Not using GASNet

.. code-block:: bash

    $ mpiexec -n 2 ./a.out

* Using GASNet with ibv-conduit

.. code-block:: bash

    $ gasnetrun_ibv -n 2 ./a.out

OpenACC
----------

.. code-block:: bash

    $ ./a.out

Environmental variables
========================

XMP_NODE_SIZEn
---------------------------
In the XcalableMP specification, ``*`` is available in the last dimension of the definition of a node set. 

* C language

.. code-block:: C

    #pragma xmp nodes p[*][2]

* Fortran

.. code-block:: Fortran

    !$xmp nodes p(2,*)

Omni Compiler extends the XcalableMP specification to use ``*`` except for the last dimension. 

* C language

.. code-block:: C

    #pragma xmp nodes p[*][*]

* Fortran

.. code-block:: Fortran

    !$xmp nodes p(*,*)

The valule of the n'th dimension node set is set by using 
the environmental valiable ``XMP_NODE_SIZEn``. The ``n`` is the 0-origin integer number.
For example, assume ``XMP_NODE_SIZE0`` and ``XMP_NODE_SIZE1`` are set as follows. 

.. code-block:: bash

    $ export XMP_NODE_SIZE0=2
    $ export XMP_NODE_SIZE1=4
    $ mpirun -np 8 ./a.out

The above example code is the same as follows. 

* C language

.. code-block:: C

    #pragma xmp nodes p[4][2]

* Fortran

.. code-block:: Fortran

    !$xmp nodes p(2,4)

XMP_ONESIDED_HEAP_SIZE (Only GASNet and MPI version 3)
-----------------------------------------------------------
The ``XMP_ONESIDED_HEAP_SIZE`` must be set when the following execution error occurs. 

.. code-block:: bash

    [ERROR] Cannot allocate coarray. Heap memory size of coarray is too small.
            Please set the environmental variable "XMP_ONESIDED_HEAP_SIZE"

The ``XMP_ONESIDED_HEAP_SIZE`` specifies the memory size that is allocated at the program start for a onesided function.
The above error message indicates that the allocated memory size is too small.
The default size is **16 Mbytes**.
If you set a new value, execute as follows. 

.. code-block:: bash

    $ export XMP_ONESIDED_HEAP_SIZE=32M

XMP_ONESIDED_STRIDE_SIZE (Only GASNet)
------------------------------------------
The ``XMP_ONESIDED_STRIDE_SIZE`` must be set when the following execution error occurs. 

.. code-block:: bash

    [ERROR] Memory size for coarray stride transfer is too small.
            Please set the environmental variable "XMP_COARRAY_STRIDE_SIZE"

The ``XMP_ONESIDED_STRIDE_SIZE`` specifies the memory size that is allocated at the program start for stride access via coarray (for example, ``a(1:N:2) = b(1:N:2)[2]``).
The above error message indicates that the allocated memory size is too small. 
The default size is **1 Mbyte**. 
If you set a new value, execute an example as follows. 

.. code-block:: bash

    $ export XMP_ONESIDED_STRIDE_SIZE=2M

When using GASNet as a onesided communication library, 
the program allocates the memory size of the value by adding ``XMP_ONESIDED_HEAP_SIZE`` to ``XMP_ONESIDED_STRIDE_SIZE`` at the program start. 


