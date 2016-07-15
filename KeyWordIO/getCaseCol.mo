within KeyWordIO;
function getCaseCol "Extract column of matrix identified by header key"
  extends Modelica.Icons.Function;
  input KeyWordIO.Records.Case case "Input case record";
  input String name "Name of header string be searched";
  input Integer headerRow = 1 "Header row index for searching key";
  output Real val[case.rowMax-case.header] "Real vector extracted from data matrix";
protected
  Integer index = 0 "Index found of name in header";
  Boolean success =  false "Success of searching name in header";
algorithm
  for col in 1:case.colMax loop
    if Modelica.Utilities.Strings.isEqual(case.headerString[headerRow,col],name) then
      index := col-case.margin;
      success := true;
      break;
    end if;
  end for;
  assert(success,"String "+name+" not found in case.headerString[headerRow,:]");
  val := case.matrix[:,index];
end getCaseCol;
