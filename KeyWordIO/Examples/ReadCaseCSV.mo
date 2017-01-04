within KeyWordIO.Examples;
model ReadCaseCSV "Read case record from CSV file"
  extends Modelica.Icons.Example;
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/case.csv");
  parameter Records.Case case=KeyWordIO.readCaseCSV(
      fileName=fileName,
      header=2,
      margin=2,
      delimiter="\t",
      useQuotedStrings=false,
      cache=true);
  parameter Real va[:] = KeyWordIO.getCaseCol(case,"Vrms");

end ReadCaseCSV;
