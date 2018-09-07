=================================
Cooperation with MPI
=================================

.. contents::
   :local:
   :depth: 2

Calling MPI program
--------------------------
You can call the MPI program from the XMP program by using following functions.

* Initialization of MPI environment

+-------------+--------------+-----------------------------+
| Language    | Retrun Value | Function                    |
+=============+==============+=============================+
| XMP/C       | void         | xmp_init_mpi(int*, char***) |
+-------------+--------------+-----------------------------+
| XMP/Fortran | (None)       | xmp_init_mpi()              |
+-------------+--------------+-----------------------------+

* Acquisition of MPI Communicator for node set

+-------------+--------------+-----------------------------+
| Language    |	Retrun Value | Function                    |
+=============+==============+=============================+
| XMP/C       | MPI_Comm     | xmp_get_mpi_comm(void)      |
+-------------+--------------+-----------------------------+
| XMP/Fortran | integer      | xmp_get_mpi_comm()          |
+-------------+--------------+-----------------------------+

* Finalization process of MPI environment

+-------------+--------------+-----------------------------+
| Language    | Retrun Value | Function                    |
+=============+==============+=============================+
| XMP/C       | void         | xmp_finalize_mpi(void)      |
+-------------+--------------+-----------------------------+
| XMP/Fortran | (None)       | xmp_finalize_mpi()          |
+-------------+--------------+-----------------------------+

* XMP/C program

.. code-block:: C

   #include <mpi.h>
   #include <xmp.h>
   #pragma xmp nodes p[4]
   
   int main(int argc, char **argv) {
     xmp_init_mpi(&argc, &argv);
     int rank, size;
     MPI_Comm_rank(MPI_COMM_WORLD, &rank);
     MPI_Comm_size(MPI_COMM_WORLD, &size);
   
   #pragma xmp task on p[1:2]
   {
     MPI_Comm comm = xmp_get_mpi_comm();
     MPI_Bcast(..., comm);
   }
     xmp_finalize_mpi();
   
     return 0;
   }

* XMP/Fortran program

.. code-block:: Fortran

   program main
     include 'mpif.h'
     integer rank, irank, isize, ierr
     integer xmp_get_mpi_comm
     integer comm
   
   !$xmp nodes p(4)
     call xmp_init_mpi()
   
   !$xmp task on p(2:3)
     comm = xmp_get_mpi_comm()
     call MPI_Bcast(..., comm, ...)
   !$xmp end task
   
     call xmp_finalize_mpi()
   end program

xmp_init_mpi() initializes the MPI environment with the XMP program, and xmp_finalize_mpi() performs the completion processing of the MPI environment with the XMP program.
You can call any MPI functions and xmp_get_mpi_comm() between the above two functions.
xmp_get_mpi_comm() can acquire the MPI communicator of the node set (p[1: 2] in the above XMP/C and p(2: 3) in the XMP/Fortran) currently being executed.

Calling from MPI program
----------------------------
By using following functions, you can call XMP program from MPI program.

* Initialization of XMP environment

+-------------+--------------+--------------------+
| Language    | Retrun Value | Function           |
+=============+==============+====================+
| XMP/C       | void         | xmp_init(MPI_Comm) |
+-------------+--------------+--------------------+
| XMP/Fortran | (None)       | xmp_init(Integer)  |
+-------------+--------------+--------------------+

* Finalization process of XMP environment

+-------------+--------------+-------------------------+
| Language    | Retrun Value | Function                |
+=============+==============+=========================+
| XMP/C       | void         | xmp_finalize(void)      |
+-------------+--------------+-------------------------+
| XMP/Fortran | (None)       | xmp_finalize()          |
+-------------+--------------+-------------------------+

* MPI/C program

.. code-block:: C

   #include <mpi.h>
   #include <xmp.h>
   extern void xmp_sub();
   
   int main(int argc, char **argv)
   {
     MPI_Init(&argc, &argv);
     xmp_init(MPI_COMM_WORLD);
   
     sub_xmp();
   
     xmp_finalize();
     MPI_Finalize();
   
     return 0;
   }

* XMP/C program

.. code-block:: C

   void sub_xmp() {
   #pragma xmp nodes p[4]
      :
   }

* MPI/Fortran program

.. code-block:: Fortran

   program test
     include 'mpif.h'
     integer ierror
   
     call MPI_INIT(ierror)
     call xmp_init(MPI_COMM_WORLD)
     call xmp_sub()
     call xmp_finalize()
     call MPI_FINALIZE(ierror)
   
   end program test

* XMP/Fortran program

.. code-block:: Fortran

   subroutine sub_xmp()
   !$xmp nodes p(4)
      :
   end subroutine hoge


xmp_init() initializes the XMP environment with the MPI program, and xmp_finalize() completes the XMP environment with the MPI program.
You can call any XMP functions can be called between the above two functions.
Note that, xmp_init() must be executed after MPI_Init() and xmp_finalize() must be executed before MPI_Finalize().
