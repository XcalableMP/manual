=========================
What is Omni Compiler ?
=========================
Omni Compiler is a compiler for code including `XcalableMP <http://xcalablemp.org>`_, `XcalableACC <http://xcalablemp.org/XACC.html>`_, and `OpenACC <http://www.openacc.org>`_ directives.
The base languages supported by Omni Compiler are C language (C90) and Fortran 90 in XcalableMP, and C language (C90) in XcalableACC and OpenACC. 

Omni Compiler is one of source-to-source compilers that translate from code including directives to code including runtime calls. 
In Omni Compiler,  `XcodeML <http://omni-compiler.org/xcodeml.html>`_ is used to analyze code in an intermediate code format of XML expression.
The following figure shows the operation flow of Omni Compiler. 

.. image:: ../img/flow.png

Omni Compiler uses a native compiler, for example ``mpicc`` or ``nvcc``, 
to create an execution file from translated code including runtime calls. 
The runtime library provided by Omni Compiler uses MPI in XcalableMP, 
and CUDA in OpenACC, and both MPI and CUDA in XcalableACC. 

In XcalableMP, 
Omni Compiler may create better runtime libraries by adding one of the onesided communication libraries to MPI.
We describe these in detail in Section "Use of onesided library on XcalableMP" of :doc:`install`.

