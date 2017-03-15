within KeyWordIO.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation(preferredView = "info", Documentation(info="<html>
<h5>Version 0.8.0, 2017-XX-XX</h5>
<ul>
<li>Moved CSV files to subdirectory csv</li>
<li>Moved TXT file to subdirectory txt</li>
<li>Added subdirectory Images</li>
</ul>

<h5>Version 0.7.0, 2017-03-15</h5>
<ul>
<li>Changed maximum string length from 255 to 512 characters</li>
<li>Changed equation to algorithm to better support OpenModelica</li>
</ul>

<h5>Version 0.6.0, 2017-01-05</h5>
<ul>
<li>This version supports large CSV case files handled by low level C file writing functions</li>
<li>Function 
    <a href=modelica://KeyWordIO.Strings.quoteString>writeString</a> renamed by 
    <a href=modelica://KeyWordIO.Strings.quoteString>quoteString</a>; this is a non backwards compatible change</li>
<li>Removed function
    <a href=modelica://KeyWordIO.writeCaseCSV>writeCaseCSV</a>; this is a non backwards compatible change</li>
<li>The following classes are removed since they are obsolete and not needed any more; this is a non-backwards compatible change</li>
<ul>
    <li>getCaseCol</li>
    <li>getCaseColIndex</li>
    <li>readCaseCSV</li>
    <li>Examples.ReadCaseCSV</li>
    <li>Records.Case<li>
    <li>Records<li>
</ul>
<li>Added low level C functions 
    <a href=modelica://KeyWordIO.Strings.writeString>writeString</a> to write a string to a file</li>
<li>Added low level C functions 
    <a href=modelica://KeyWordIO.Strings.writeLine>writeLine</a> to write a line to a file</li>
</ul>

<h5>Version 0.5.0, 2017-01-04</h5>
<ul>
<li>The following functions are renamed due inconsistent naming; however, this is a non backwards compatible change</li>
    <ul>
    <li><a href=modelica://KeyWordIO.readCaseNumbers>getCaseNumbers</a> renamed by 
        <a href=modelica://KeyWordIO.readCaseNumbers>readCaseNumbersCSV</a></li>
    <li><a href=modelica://KeyWordIO.readCSVRows>getCSVRows</a> renamed by 
        <a href=modelica://KeyWordIO.readCSVRows>readRowsCSV</a></li>
    <li><a href=modelica://KeyWordIO.readCSVCols>getCSVCols</a> renamed by 
        <a href=modelica://KeyWordIO.readCSVCols>readColsCSV</a></li>
    <li><a href=modelica://KeyWordIO.readCSVSize>getCSVSize</a> renamed by 
        <a href=modelica://KeyWordIO.readCSVSize>readSizeCSV</a></li>
    </ul>
<li>Alternative implementation of chaching now allows reading of large CSV files</li>
</ul>

<h5>Version 0.4.0, 2016-07-29</h5>
<ul>
<li>Added option to enable cache when reading</li>
<li>Added support for unquoted strings of CSV files</li>
<li>Added functions to read 'case CSV' files containing headers and left margin columns</li>
<li>Added further examples</li>
</ul>

<h5>Version 0.3.0, 2016-03-12</h5>
<ul>
<li>Reading of CSV files now correctly considers delimiter such that CSV file may also contain strings</li>
<li>Function <a href=\"modelica://KeyWordIO.Strings.expression\">expression</a> is moved to package Strings; this a non-backwards compatible change; this may not affect user models since this function is used internally, only</li>
<li>Added new function <a href=\"modelica://KeyWordIO.Strings.findAll\">findAll</a> to find all instances of 'searchStings' within 'string'
</ul>

<h5>Version 0.2.0, 2016-03-11</h5>
<ul>
<li>Added functions for reading and writing of CSV files</li>
</ul>

<h5>Version 0.1.0, 2016-03-07</h5>
<ul>
<li>First release version</li>
</ul>
</html>"));
end ReleaseNotes;
