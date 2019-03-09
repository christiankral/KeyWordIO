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

The library supports the reading of a matrixes from CSV files as well as the writing of matrixes into CSV files. The library also demonstrates how to batch parameterize different cases based on the data of 'case CSV' files. These 'case CSV' files are CSV data files with header rows and left margin columns.

Consider KeyWordIO.Examples.CaseExamples.ElectricalCases which reads the model parameter Vrms, phiv, f, R and L from the CSV file ``case.csv``.

![case.csv](https://github.com/christiankral/KeyWordIO/blob/master/KeyWordIO/Resources/Images/case.png?raw=true)

The parameter are marked in yellow, the result columns are marked in blue and filled with dummy zero values. In the example the original data file ´´case.csv´´ is copied to the result file ´´case_result.csv´´. At the end of the simulation the result columns are overwritten by the results.

![case_result.csv](https://github.com/christiankral/KeyWordIO/blob/master/KeyWordIO/Resources/Images/case_result.png?raw=true)

The number of header rows and left margin columns can be specified (gray color) for each CSV file.

# Development and contribution

The library is developed and maintained by Anton Haumer and Christian Kral.

# Contact

e-mail: dr.christian.kral(at)gmail.com   
