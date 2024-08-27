within ;
package KeyWordIO "Read and write data files with key words"
extends Modelica.Icons.Package;

  annotation (
    version="0.13.x", versionDate = "202x-xx-xx",
    uses(Modelica(version="4.0.0")),
    conversion(from(version={"0.9.0", "0.8.0", "0.7.0", "0.6.0"},
      script="modelica://KeyWordIO/Resources/Scripts/Conversion/ConvertFromKeyWordIO_before_0.9.0.mos")));
end KeyWordIO;
