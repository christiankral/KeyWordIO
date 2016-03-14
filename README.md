# KeyWordIO

Modelica library supports the reading from files and writing to files of variables and parameters. Currently text files in key word oriented format and CSV files are supported.

# Library description

The main objective of the library is to read and write variables and paramters in key word oriented format.

```
R0 = 2
R1 = 2.2
R2 = 2*3 
```

The file reading is performed by means of a C function. Therefore, the reading of a parameter into Modelica is actually always carried out when a simulation is performed. Consequently, the parameters shall not be treated as constant variables in the C code which is going to be compiled. The KeyWordIO libray is an alternative implementation to Modelica.Utilites.Examples.readRealParameter, which can be used to perform batch simulations, parameter studies and optimizations. 

The library also supports the reading of a matrixes from CSV files as well as the writing of matrixes into CSV files.  
  
# License

This Modelica library is free software and the use is completely at your own
risk. The library is released under [Modelica License 1.1](https://www.modelica.org/licenses/ModelicaLicense1.1)

# Development and contribution

The library is developed and maintained by Anton Haumer and Christian Kral.

# Contact

e-mail: dr.christian.kral(at)gmail.com   
