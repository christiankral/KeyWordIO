within KeyWordIO.Examples;
model ReadCaseCSV "Read case record from CSV file"
  extends Modelica.Icons.Example;
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/case.csv");
  Records.Case case = KeyWordIO.readCaseCSV(fileName=fileName,header=2,margin=2,delimiter="\t",useQuotedStrings=false);
  Real va[:] = KeyWordIO.getCaseCol(case,"va");
initial equation

  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ReadCaseCSV;
