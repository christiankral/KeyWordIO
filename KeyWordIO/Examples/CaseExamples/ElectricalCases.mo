within KeyWordIO.Examples.CaseExamples;
model ElectricalCases "Read case record from CSV file"
  extends Modelica.Icons.Example;
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/case.csv");
  parameter String fileName_result = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/case_result.csv");
  parameter Integer header = 2 "Number of header rows";
  parameter Integer margin = 2 "Number of left margin columns";
  parameter Integer cases=KeyWordIO.readCaseNumbersCSV(
      fileName=fileName,
      header=header,
      delimiter="\t",
      cache=true) "Number of cases";
  KeyWordIO.Examples.CaseExamples.Electrical electrical[cases](
    Vrms=KeyWordIO.readCaseColCSV(
        fileName=fileName,
        header=header,
        margin=margin,
        cache=true,
        name="Vrms"),
    phiv=Modelica.Units.Conversions.from_deg(KeyWordIO.readCaseColCSV(
        fileName=fileName,
        header=header,
        margin=margin,
        cache=true,
        name="phiv")),
    f=KeyWordIO.readCaseColCSV(
        fileName=fileName,
        header=header,
        margin=margin,
        cache=true,
        name="f"),
    R=KeyWordIO.readCaseColCSV(
        fileName=fileName,
        header=header,
        margin=margin,
        cache=true,
        name="R"),
    L=KeyWordIO.readCaseColCSV(
        fileName=fileName,
        header=header,
        margin=margin,
        cache=true,
        name="L"))
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));

initial algorithm
  Modelica.Utilities.Files.copy(fileName,fileName_result,replace=true);

equation
  when terminal() then
    KeyWordIO.overwriteCaseCSV(fileName_result,header=header,margin=margin,name="Irms",val=electrical.Irms);
    KeyWordIO.overwriteCaseCSV(
      fileName_result,
      name="phii",
      val=Modelica.Units.Conversions.to_deg(electrical.phii));
  end when;

  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ElectricalCases;
