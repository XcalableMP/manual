=================================
MPIとの連携
=================================

.. contents::
   :local:
   :depth: 2

MPIプログラムの呼び出し
--------------------------
下記の関数を用いることで，XMPプログラムからMPIプログラムを呼び出せます．

* MPI環境の初期化

+-------------+--------------+-----------------------------+
| Language    | Retrun Value | Function                    |
+=============+==============+=============================+
| XMP/C       | void         | xmp_init_mpi(int*, char***) |
+-------------+--------------+-----------------------------+
| XMP/Fortran | (None)       | xmp_init_mpi()              |
+-------------+--------------+-----------------------------+

* ノード集合に対するMPIコミュニケータの取得

+-------------+--------------+-----------------------------+
| Language    |	Retrun Value | Function                    |
+=============+==============+=============================+
| XMP/C       | MPI_Comm     | xmp_get_mpi_comm(void)      |
+-------------+--------------+-----------------------------+
| XMP/Fortran | integer      | xmp_get_mpi_comm()          |
+-------------+--------------+-----------------------------+

* MPI環境の完了処理

+-------------+--------------+-----------------------------+
| Language    | Retrun Value | Function                    |
+=============+==============+=============================+
| XMP/C       | void         | xmp_finalize_mpi(void)      |
+-------------+--------------+-----------------------------+
| XMP/Fortran | (None)       | xmp_finalize_mpi()          |
+-------------+--------------+-----------------------------+

* XMP/Cプログラム

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

* XMP/Fortranプログラム

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

xmp_init_mpi()はMPI環境の初期化をXMPプログラムで行い，
xmp_finalize_mpi()はMPI環境の完了処理をXMPプログラムで行います．
その2つの関数の間で，任意のMPI関数とxmp_get_mpi_comm()を呼び出すことができます．
xmp_get_mpi_comm()は，現在実行されているノード集合（上のXMP/Cではp[1:2]，XMP/Fortranではp(2:3)で構成される2ノード）のMPIコミュニケータを取得できます．


MPIプログラムからの呼び出し
----------------------------
下記の関数を用いることで，MPIプログラムからXMPプログラムを呼び出せます．

* XMP環境の初期化

+-------------+--------------+--------------------+
| Language    | Retrun Value | Function           |
+=============+==============+====================+
| XMP/C       | void         | xmp_init(MPI_Comm) |
+-------------+--------------+--------------------+
| XMP/Fortran | (None)       | xmp_init(Integer)  |
+-------------+--------------+--------------------+

* XMP環境の完了処理

+-------------+--------------+-------------------------+
| Language    | Retrun Value | Function                |
+=============+==============+=========================+
| XMP/C       | void         | xmp_finalize(void)      |
+-------------+--------------+-------------------------+
| XMP/Fortran | (None)       | xmp_finalize()          |
+-------------+--------------+-------------------------+

* MPI/Cプログラム

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

* XMP/Cプログラム

.. code-block:: C

   void sub_xmp() {
   #pragma xmp nodes p[4]
      :
   }

* MPI/Fortranプログラム

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

* XMP/Fortranプログラム

.. code-block:: Fortran

   subroutine sub_xmp()
   !$xmp nodes p(4)
      :
   end subroutine hoge


xmp_init()はXMP環境の初期化をMPIプログラムで行い，
xmp_finalize()はXMP環境の完了処理をMPIプログラムで行います．
2つの関数の間で，任意のXMP関数を呼び出すことができます．
なお，xmp_init()はMPI_Init()の後，xmp_finalize()はMPI_Finalize()の前に実行する必要があります．