within KeyWordIO.Examples;
model ReadStringCSVUnquoted
  "Read string matrix from CSV file with unquoted strings"
  extends Modelica.Icons.Example;
  parameter Integer colHeader = 1 "Column index of header";
  parameter Integer colUnits = 2 "Column index of units";
  parameter String csvTabFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/tab2.csv");
  parameter String header[1,:] = KeyWordIO.readStringCSV(csvTabFileName,colHeader,colHeader,1,4,"\t",useQuotedStrings=false);
  parameter String units[1,:] = KeyWordIO.readStringCSV(csvTabFileName,colUnits,colUnits,1,4,"\t",useQuotedStrings=false);
algorithm
  when terminal() then
    Modelica.Utilities.Streams.print("HEADER:");
    for k in 1:size(header,2) loop
      Modelica.Utilities.Streams.print(header[1,k]);
    end for;
    Modelica.Utilities.Streams.print("UNITS:");
    for k in 1:size(units,2) loop
      Modelica.Utilities.Streams.print(units[1,k]);
    end for;
  end when;
  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ReadStringCSVUnquoted;
