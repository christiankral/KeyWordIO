within KeyWordIO.Examples.CaseExamples;
model ElectricalCases "Read case record from CSV file"
  extends Modelica.Icons.Example;
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/case.csv");
  parameter String fileName_result = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/case_result.csv");
  parameter Records.Case case=KeyWordIO.readCaseCSV(
      fileName=fileName_result,
      header=2,
      margin=2,
      delimiter="\t",
      useQuotedStrings=false);
  constant Integer numbers = 6;
  KeyWordIO.Examples.CaseExamples.Electrical electrical[6](
    Vrms = KeyWordIO.getCaseCol(case,"Vrms"),
    phiv = Modelica.SIunits.Conversions.from_deg(KeyWordIO.getCaseCol(case,"phiv")));
  // parameter Real Vrms[:] = KeyWordIO.getCaseCol(case,"Vrms");
initial algorithm
  Modelica.Utilities.Files.copy(fileName,fileName_result,replace=true);
equation
  when terminal() then
    // KeyWordIO.overwriteCaseCSV(fileName_result,name="Irms",val={1,2,3,4,5,6});
  end when;

  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ElectricalCases;
