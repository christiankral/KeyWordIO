within KeyWordIO.Examples;
model ReadCaseCSV "Read case record from CSV file"
  extends Modelica.Icons.Example;
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/case.csv");
  parameter Records.Case case=KeyWordIO.readCaseCSV(
      fileName=fileName,
      header=2,
      margin=2,
      delimiter="\t",
      useQuotedStrings=false);
  parameter Integer iva = KeyWordIO.getCaseColIndex(case,"va");
  parameter Real va1[:] = case.matrix[:,iva];
  parameter Real va2[:] = KeyWordIO.getCaseCol(case,"va");

  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ReadCaseCSV;
