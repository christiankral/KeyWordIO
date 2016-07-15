within KeyWordIO;
function getCaseColIndex
  "Extract column of matrix identified by header key"
  extends Modelica.Icons.Function;
  input KeyWordIO.Records.Case case "Input case record";
  input String name "Name of header string be searched";
  input Integer headerRow = 1 "Header row index for searching key";
  output Integer col "Integer index where header equals name";
protected
  Integer index = 0 "Index found of name in header";
  Boolean success =  false "Success of searching name in header";
algorithm
  for column in 1:case.colMax loop
    if Modelica.Utilities.Strings.isEqual(case.headerString[headerRow,column],name) then
      index := column-case.margin;
      success := true;
      break;
    end if;
  end for;
  assert(success,"getCaseColIndex: String "+name+" not found in case.headerString[headerRow,:]");
  col := index;
end getCaseColIndex;
