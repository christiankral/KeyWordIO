within KeyWordIO.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation(preferredView = "info", Documentation(info="<html>
<h5>Version 0.5.0, 2016-XX-XX</h5>
<ul>
<li>The following functions are renamed due inconsistent naming; however, this is a non backwards compatible change</li>
    <ul>
    <li><a href=modelica://KeyWordIO.readCaseNumbers>getCaseNumbers</a> renamed by 
        <a href=modelica://KeyWordIO.readCaseNumbers>readCaseNumbers</a></li>
    <li><a href=modelica://KeyWordIO.readCSVRows>getCSVRows</a> renamed by 
        <a href=modelica://KeyWordIO.readCSVRows>readCSVRows</a></li>
    <li><a href=modelica://KeyWordIO.readCSVCols>getCSVColss</a> renamed by 
        <a href=modelica://KeyWordIO.readCSVCols>readCSVCols</a></li>
    <li><a href=modelica://KeyWordIO.readCSVSize>getCSVSize</a> renamed by 
        <a href=modelica://KeyWordIO.readCSVSize>readCSVSize</a></li>
    </ul>
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
