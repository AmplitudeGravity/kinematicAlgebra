# kinematicAlgebra
This project is to generate the kinematic algebra in Yang-Mills amplitude.
We define the algebra product to generate the BCJ numerator. We also construct the hidden symmetry from the algebra. 

## module: vectorDot.jl
The code is using symEngine. 
* Objects: vecSym---you can create an vector symbol by vecSym("name")
* methods: dot   ---the dot function define the dot product of two vectors. The input parameter is two vecSym objects or linear combinations of vecSym. For example dot($p_1+p_2$,$\epsilon_3$). The out put is a symEngine symbol $p_1\cdot\epsilon_3+p_2\cdot\epsilon_3$.  
