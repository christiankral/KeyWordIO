within KeyWordIO.Examples.CaseExamples;
model ElectricalCases "Read case record from CSV file"
  extends Modelica.Icons.Example;
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/case.csv");
  parameter String fileName_result = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/case_result.csv");
  parameter Integer header = 2 "Number of header rows";
  parameter Integer margin = 2 "Number of left margin columns";
  parameter KeyWordIO.Records.Case case=KeyWordIO.readCaseCSV(
      fileName=fileName,
      header=header,
      margin=margin,
      cache=true);
  parameter Integer cases = KeyWordIO.getCaseNumbers(
      fileName=fileName,
      header=header,
      delimiter="\t",
      cache=true);
  KeyWordIO.Examples.CaseExamples.Electrical electrical[cases](
    Vrms = KeyWordIO.getCaseCol(case,"Vrms"),
    phiv = Modelica.SIunits.Conversions.from_deg(KeyWordIO.getCaseCol(case,"phiv")),
    f = KeyWordIO.getCaseCol(case,"f"),
    R = KeyWordIO.getCaseCol(case,"R"),
    L = KeyWordIO.getCaseCol(case,"L"))
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));


initial algorithm
  Modelica.Utilities.Files.copy(fileName,fileName_result,replace=true);

equation
  when terminal() then
    KeyWordIO.overwriteCaseCSV(fileName_result,header=header,margin=margin,name="Irms",val=electrical.Irms);
    KeyWordIO.overwriteCaseCSV(fileName_result,name="phii",val=Modelica.SIunits.Conversions.to_deg(electrical.phii));
  end when;

  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ElectricalCases;
