%MAKE   Compiles the maxflowmex library.
%   
%   (c) 2008 Michael Rubinstein, WDI R&D and IDC
%   $Revision: 130 $
%   $Date: 2008-09-02 17:10:31 -0700 (Tue, 02 Sep 2008) $
%

mex -largeArrayDims maxflowmex.cpp maxflow-v3.01/graph.cpp maxflow-v3.01/maxflow.cpp 
