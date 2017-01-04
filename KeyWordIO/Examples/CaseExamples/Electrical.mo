within KeyWordIO.Examples.CaseExamples;
model Electrical "Electrical circuit"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Voltage Vrms = 100 "RMS voltage source";
  parameter Modelica.SIunits.Angle phiv = 0 "Angle of voltage source";
  parameter Modelica.SIunits.Frequency f = 50 "Frequency of voltage source";
  parameter Modelica.SIunits.Resistance R = 100 "Resistance";
  parameter Modelica.SIunits.Inductance L = 0.02 "Inductance";
  Modelica.SIunits.Current Irms = currentSensor.abs_i "RMS current";
  Modelica.SIunits.Angle phii = currentSensor.arg_i "Angle of current";

  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-50,-56},{-30,-36}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=
       R) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(L=L)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=f,
    V=Vrms,
    phi=phiv) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
    currentSensor
    annotation (Placement(transformation(extent={{10,-30},{-10,-10}})));
equation
  connect(voltageSource.pin_p, resistor.pin_p) annotation (Line(points={{-40,10},
          {-40,10},{-40,20},{-10,20}}, color={85,170,255}));
  connect(resistor.pin_n, inductor.pin_p) annotation (Line(points={{10,20},{22,20},
          {40,20},{40,10}}, color={85,170,255}));
  connect(inductor.pin_n, currentSensor.pin_p)
    annotation (Line(points={{40,-10},{40,-20},{10,-20}}, color={85,170,255}));
  connect(voltageSource.pin_n, ground.pin) annotation (Line(points={{-40,-10},{-40,-36}},
                           color={85,170,255}));
  connect(currentSensor.pin_n, voltageSource.pin_n) annotation (Line(points={{-10,-20},{-40,-20},{-40,-10}}, color={85,170,255}));
end Electrical;
