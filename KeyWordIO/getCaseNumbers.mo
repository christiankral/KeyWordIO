within KeyWordIO;
function getCaseNumbers "Extract number of cases of case record"
  extends Modelica.Icons.Function;
  input KeyWordIO.Records.Case case "Input case record";
  output Integer numbers "Number of cases of case record";
algorithm
  numbers := size(case.matrix,1);
end getCaseNumbers;
