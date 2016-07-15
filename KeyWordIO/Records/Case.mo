within KeyWordIO.Records;
record Case
  "Case CSV record containing header string, margin string and numerical data array"
  extends Modelica.Icons.Record;
  parameter Integer rowMax "Maximum number of rows";
  parameter Integer colMax "Maximum number of columns";
  parameter Integer header "Number of header rows";
  parameter Integer margin "Number of margin columns";
  parameter String headerString[header,colMax] = fill("",header,colMax) "Header string array";
  parameter String marginString[rowMax-header,margin] = fill("",rowMax-header,margin) "Margin string array";
  Real matrix[rowMax-header,colMax-margin] "Numerical data array";
end Case;
