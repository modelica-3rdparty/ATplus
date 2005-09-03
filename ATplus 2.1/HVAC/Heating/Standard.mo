package Standard
  "Models of heating system components without transient behavior (due to transport and heat capacity) of water circuit"
  package Controller = ATplus.Controller;
  package Building = ATplus.Building;
  extends ATplus.Icons.Package;
  package Interfaces
    annotation (Coordsys(
        extent=[0, 0; 442, 394],
        grid=[2, 2],
        component=[20, 20]), Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));
    connector therm
      Modelica.SIunits.CelsiusTemperature T;
      flow Modelica.SIunits.HeatFlux j;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-80, 80; 82, -80], style(gradient=3, fillColor=
                  45))),
        Window(
          x=0.35,
          y=0.23,
          width=0.44,
          height=0.65),
        Diagram(Rectangle(extent=[-80, 80; 82, -80], style(gradient=3,
                fillColor=45))));
    end therm;

    connector Hydraulic_Cut_In "Input Interface for Hydraulic Components"
      Modelica.SIunits.Pressure P "Pressure at port";
      Modelica.SIunits.Temperature T "Temperature at port";
      flow Modelica.SIunits.VolumeFlowRate q "Flow rate through port";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100, 100; 100, -100], style(fillColor=73))),
        Diagram(Rectangle(extent=[-100, 100; 100, -100], style(fillColor=73)),
            Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=3))),
        Window(
          x=0.13,
          y=0.08,
          width=0.57,
          height=0.52),
        Documentation(info="
"));
    end Hydraulic_Cut_In;

    connector Hydraulic_Cut_Out
      Modelica.SIunits.Pressure P "Pressure at port";
      Modelica.SIunits.Temperature T "Temperature at port";
      flow Modelica.SIunits.VolumeFlowRate q "Flow rate through port";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100, 100; 100, -100], style(color=73,
                fillPattern=0))),
        Diagram(Rectangle(extent=[-100, 100; 100, -100], style(fillPattern=0)),
             Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=3))),
        Window(
          x=0,
          y=0.13,
          width=0.54,
          height=0.42),
        Documentation(info="
"));
    end Hydraulic_Cut_Out;
  end Interfaces;

  package Base
    annotation (Coordsys(
        extent=[0, 0; 442, 394],
        grid=[2, 2],
        component=[20, 20]), Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));
    model pipebase
      Modelica.SIunits.Area A1 "Nominal cross section area";
      Modelica.SIunits.Area A "Real cross section area";
      Modelica.SIunits.Pressure dP "Pressure drop";
      parameter Modelica.SIunits.Length l=10.00 "Length of pipe";
      parameter Modelica.SIunits.Length d=0.02 "Nominal diameter of pipe";
      constant Real pi=3.1416;
      constant Real nu=0.81e-6 "kinematic viscosity in m2/s";
      constant Real eta=0.81e-3 "dynamic viscosity in Pa s";
      constant Real rho=1000 "mass density in kg/m3";
      constant Real pvapour=-0.999e5
        "vapour pressure relative to atmosphere in Pa";
      constant Real cw=4181.0 "heatcapacity  in J/KgK";
      Heating.Standard.Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In
        annotation (extent=[-100, 0; -80, 20]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-80, 40; 80, -20]),
          Rectangle(extent=[-80, 60; -60, -40]),
          Rectangle(extent=[60, 60; 80, -40])),
        Icon(
          Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
          Rectangle(extent=[60, 60; 80, -40]),
          Rectangle(extent=[-80, 40; 80, -20])),
        Window(
          x=0.28,
          y=0.32,
          width=0.6,
          height=0.6));
      Interfaces.Hydraulic_Cut_Out Hydraulic_Cut_Out
        annotation (extent=[80, 0; 100, 20]);
    equation
      dP = Hydraulic_Cut_Out.P - Hydraulic_Cut_In.P;
      A1 = pi*d*d/4;
      Hydraulic_Cut_Out.q + Hydraulic_Cut_In.q = 0;
      0 = dP + 8*pi*eta*l/A/A*Hydraulic_Cut_In.q;
    end pipebase;

    model TwoConnection
      constant Real pi=3.1416;
      constant Real nu=0.81e-6 "kinematic viscosity in m2/s";
      constant Real eta=0.81e-3 "dynamic viscosity in Pa s";
      constant Real rho=1000 "mass density in kg/m3";
      constant Real pvapour=-0.999e5
        "vapour pressure relative to atmosphere in Pa";
      constant Real cw=4181.0 "heatcapacity  in J/KgK";
      Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In
        annotation (extent=[-100, 0; -80, 20]);
      Interfaces.Hydraulic_Cut_Out Hydraulic_Cut_Out
        annotation (extent=[80, 0; 100, 20]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 40; 80, -20]), Polygon(points=[-66, 20;
                32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0; -66, 18; -66,
                20], style(color=65, fillColor=65))),
        Icon(Rectangle(extent=[-80, 40; 80, -20]), Polygon(points=[-66, 20; 32,
                 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0; -66, 18; -66, 20],
               style(color=65, fillColor=65))),
        Window(
          x=0.17,
          y=0.38,
          width=0.6,
          height=0.6));
    end TwoConnection;

    model OneConnection
      constant Real nu=0.81e-6 "kinematic viscosity in m2/s";
      constant Real rho=1000 "mass density in kg/m3";
      constant Real pvapour=-0.999e5
        "vapour pressure relative to atmosphere in Pa";
      Heating.Standard.Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In
        annotation (extent=[-10, -100; 10, -80], layer="icon");
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-40, 80; 40, -80]), Polygon(points=[-10, 64; 10,
                 64; 10, -40; 26, -40; 0, -72; -26, -40; -10, -40; -10, 64],
              style(color=65, fillColor=65))),
        Window(
          x=0.28,
          y=0.27,
          width=0.6,
          height=0.6));
    end OneConnection;

    model FourConnection
      Interfaces.Hydraulic_Cut_In VLK annotation (extent=[-100, -20; -80, 0]);
      Interfaces.Hydraulic_Cut_Out VL annotation (extent=[0, 80; 20, 100]);
      Interfaces.Hydraulic_Cut_In RL annotation (extent=[80, 0; 100, 20]);
      Interfaces.Hydraulic_Cut_Out RLK annotation (extent=[-18, -100; 2, -80]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80]),
          Line(points=[10, 78; 10, 10; 78, 10]),
          Line(points=[-78, -10; -8, -10; -8, -78]),
          Line(points=[-68, 80; 0, 0], style(pattern=3))),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80]),
          Line(points=[10, 78; 10, 10; 78, 10]),
          Line(points=[-78, -10; -8, -10; -8, -78]),
          Line(points=[-68, 78; 0, 0], style(pattern=3))),
        Window(
          x=0.37,
          y=0.26,
          width=0.6,
          height=0.6));
      Modelica.Blocks.Interfaces.InPort InPort annotation (
        extent=[-78, 80; -58, 100],
        rotation=270,
        layer="icon");
    end FourConnection;

    model UFHeatingBase
      extends TwoConnection;
      Interfaces.therm therm1 annotation (extent=[-60, 80; -40, 100]);
      Interfaces.therm therm2 annotation (extent=[40, 80; 60, 100]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 80; 80, -80])),
        Icon(Rectangle(extent=[-80, 80; 80, -80])),
        Window(
          x=0.33,
          y=0.17,
          width=0.6,
          height=0.6));
      Modelica.Blocks.Interfaces.OutPort OutPort
        annotation (extent=[80, -60; 100, -40]);
    end UFHeatingBase;
  end Base;

  model pipeideal "Ideal pipe, without heat loss"
    extends Base.pipebase;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-58, -30; 58, -40], style(gradient=2, fillColor=83)),
        Rectangle(extent=[-58, 60; 58, 50], style(gradient=2, fillColor=83)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Polygon(points=[-46, 20; 16, 20; 16, 30; 52, 10; 16, -10; 16, 0; -46, 0;
               -46, 20; -46, 20], style(color=65, fillColor=65)),
        Text(extent=[0, -48; 0, -100], string="%name")),
      Window(
        x=0.23,
        y=0.18,
        width=0.6,
        height=0.6),
      Diagram(
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-58, -30; 58, -40], style(gradient=2, fillColor=83)),
        Rectangle(extent=[-58, 60; 58, 50], style(gradient=2, fillColor=83)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-58, -30; 58, -40], style(gradient=2, fillColor=83)),
        Rectangle(extent=[-58, 60; 58, 50], style(gradient=2, fillColor=83)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Polygon(points=[-46, 20; 16, 20; 16, 30; 52, 10; 16, -10; 16, 0; -46, 0;
               -46, 20; -46, 20], style(color=65, fillColor=65))),
      Documentation(info="

"));

  equation
    A = A1;
    Hydraulic_Cut_Out.T = Hydraulic_Cut_In.T;

  end pipeideal;

  model pipesimple
    extends Base.pipebase;
    parameter Real alpha=10.0
      "Heat transfer coefficient from water to pipe in W/m2K";
    Interfaces.therm therm1 annotation (extent=[-10, 40; 10, 60]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Polygon(points=[-46, 20; 16, 20; 16, 30; 52, 10; 16, -10; 16, 0; -46, 0;
               -46, 20; -46, 20], style(color=65, fillColor=65)),
        Polygon(points=[-46, 20; 16, 20; 16, 30; 52, 10; 16, -10; 16, 0; -46, 0;
               -46, 20; -46, 20], style(color=65, fillColor=65)),
        Text(extent=[0, -48; 0, -100], string="%name")),
      Window(
        x=0.11,
        y=0.22,
        width=0.68,
        height=0.6),
      Diagram(
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Polygon(points=[-46, 20; 16, 20; 16, 30; 52, 10; 16, -10; 16, 0; -46, 0;
               -46, 20; -46, 20], style(color=65, fillColor=65))),
      Documentation(info="parameter alpha=10.0   {heattransfercoeff. of water to pipe in W/m2K}
{Return-line-temperature = Storage-temperature}


A=A1
jloss= qIn * rho * cw * (TIn-TOut)
TOut = Tloss
"));
  equation
    A = A1;
    therm1.j = Hydraulic_Cut_In.q*rho*cw*(Hydraulic_Cut_In.T -
      Hydraulic_Cut_Out.T);
    Hydraulic_Cut_Out.T = therm1.T;

  end pipesimple;

  model pipereal "pipe with heat loss, can be used as heat exchanger. "
    extends Base.pipebase;
    parameter Real alpha=10.0
      "Heat transfer coefficient from water to pipe in W/m2K";
    Real expo;
    Interfaces.therm therm1 annotation (extent=[-12, 40; 8, 60]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-80, 40; 80, -20]),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-44, 20; 0, 0], style(color=85, fillColor=41)),
        Polygon(points=[0, 20; 24, 20; 24, 30; 54, 10; 24, -10; 24, 0; 0, 0; 0,
               20], style(fillColor=73)),
        Line(points=[-16, 34; 18, 34], style(color=41)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Line(points=[-16, 24; 18, 24], style(color=41)),
        Line(points=[-16, 28; 18, 28], style(color=41)),
        Text(extent=[0, -48; 0, -100], string="%name")),
      Window(
        x=0,
        y=0.08,
        width=0.99,
        height=0.75),
      Diagram(
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-44, 20; 0, 0], style(color=85, fillColor=41)),
        Polygon(points=[0, 20; 24, 20; 24, 30; 54, 10; 24, -10; 24, 0; 0, 0; 0,
               20], style(fillColor=73)),
        Line(points=[-16, 34; 18, 34], style(color=41)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Line(points=[-16, 24; 18, 24], style(color=41)),
        Line(points=[-16, 28; 18, 28], style(color=41)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-44, 20; 0, 0], style(color=85, fillColor=41)),
        Polygon(points=[0, 20; 24, 20; 24, 30; 54, 10; 24, -10; 24, 0; 0, 0; 0,
               20], style(fillColor=73)),
        Line(points=[-16, 34; 18, 34], style(color=41)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Line(points=[-16, 24; 18, 24], style(color=41)),
        Line(points=[-16, 28; 18, 28], style(color=41))),
      Documentation(info="
"));
  equation
    A = A1;

    expo = if (Hydraulic_Cut_In.q > 1e-9) then 1.0/(2.71828^(alpha*pi*d*l/cw/
      Hydraulic_Cut_In.q/rho)) else 0;

    Hydraulic_Cut_Out.T = therm1.T + (Hydraulic_Cut_In.T - therm1.T)*expo;

    therm1.j = -Hydraulic_Cut_In.q*rho*cw*(Hydraulic_Cut_In.T -
      Hydraulic_Cut_Out.T);

  end pipereal;

  model Two2One
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In1
      annotation (extent=[-60, 80; -40, 100]);
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In2
      annotation (extent=[40, 80; 60, 100]);
    Interfaces.Hydraulic_Cut_Out Hydraulic_Cut_Out
      annotation (extent=[-10, -100; 10, -80]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-60, 80; -40, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[40, 80; 60, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 0; 10, -80], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-40, 20; 40, 0], style(gradient=2, fillColor=65)),
        Rectangle(extent=[40, 20; 60, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-10, 20; 10, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-60, 20; -40, 0], style(gradient=3, fillColor=65))),
      Icon(
        Rectangle(extent=[-60, 80; -40, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[40, 80; 60, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 0; 10, -80], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-40, 20; 40, 0], style(gradient=2, fillColor=65)),
        Rectangle(extent=[40, 20; 60, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-10, 20; 10, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-60, 20; -40, 0], style(gradient=3, fillColor=65))),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  equation
    Hydraulic_Cut_Out.T = if Hydraulic_Cut_Out.q > 0 then (Hydraulic_Cut_In1.q*
      Hydraulic_Cut_In1.T + Hydraulic_Cut_In2.q*Hydraulic_Cut_In2.T)/
      Hydraulic_Cut_Out.q else 0;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In1.P;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In2.P;
    Hydraulic_Cut_Out.q = Hydraulic_Cut_In1.q + Hydraulic_Cut_In2.q;
  end Two2One;

  model Three2One
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-60, 80; -40, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[40, 80; 60, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 0; 10, -80], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-40, 20; 40, 0], style(gradient=2, fillColor=65)),
        Rectangle(extent=[40, 20; 60, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-10, 20; 10, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-60, 20; -40, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-10, 80; 10, 20], style(gradient=1, fillColor=65))),
      Window(
        x=0.09,
        y=0.11,
        width=0.6,
        height=0.6),
      Icon(
        Rectangle(extent=[-60, 80; -40, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[40, 80; 60, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 0; 10, -80], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-40, 20; 40, 0], style(gradient=2, fillColor=65)),
        Rectangle(extent=[40, 20; 60, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-10, 20; 10, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-60, 20; -40, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-10, 80; 10, 20], style(gradient=1, fillColor=65))));
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In1
      annotation (extent=[-60, 80; -40, 100]);
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In2
      annotation (extent=[-10, 80; 10, 100]);
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In3
      annotation (extent=[40, 80; 60, 100]);
    Interfaces.Hydraulic_Cut_Out Hydraulic_Cut_Out
      annotation (extent=[-10, -100; 10, -80]);
  equation
    Hydraulic_Cut_Out.T = if Hydraulic_Cut_Out.q > 0 then (Hydraulic_Cut_In1.q*
      Hydraulic_Cut_In1.T + Hydraulic_Cut_In2.q*Hydraulic_Cut_In2.T +
      Hydraulic_Cut_In3.q*Hydraulic_Cut_In3.T)/Hydraulic_Cut_Out.q else 0;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In1.P;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In2.P;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In3.P;
    Hydraulic_Cut_Out.q = Hydraulic_Cut_In1.q + Hydraulic_Cut_In2.q +
      Hydraulic_Cut_In3.q;
  end Three2One;

  model Five2One
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-90, 80; -70, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 80; 10, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 0; 10, -80], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-88, 20; 90, 0], style(gradient=2, fillColor=65)),
        Rectangle(extent=[30, 20; 50, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-50, 20; -30, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-90, 20; -70, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-50, 80; -30, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[30, 80; 50, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[70, 80; 90, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 20; 10, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[70, 20; 90, 0], style(gradient=3, fillColor=65))),
      Icon(
        Rectangle(extent=[-90, 80; -70, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 80; 10, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 0; 10, -80], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-88, 20; 90, 0], style(gradient=2, fillColor=65)),
        Rectangle(extent=[30, 20; 50, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-50, 20; -30, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-90, 20; -70, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[-50, 80; -30, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[30, 80; 50, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[70, 80; 90, 20], style(gradient=1, fillColor=65)),
        Rectangle(extent=[-10, 20; 10, 0], style(gradient=3, fillColor=65)),
        Rectangle(extent=[70, 20; 90, 0], style(gradient=3, fillColor=65))),
      Window(
        x=0.19,
        y=0.08,
        width=0.6,
        height=0.6));
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In1
      annotation (extent=[-90, 80; -70, 100]);
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In2
      annotation (extent=[-50, 80; -30, 100]);
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In3
      annotation (extent=[-10, 80; 10, 100]);
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In4
      annotation (extent=[30, 80; 50, 100]);
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In5
      annotation (extent=[70, 80; 90, 100]);
    Interfaces.Hydraulic_Cut_Out Hydraulic_Cut_Out
      annotation (extent=[-10, -100; 10, -80]);
  equation
    Hydraulic_Cut_Out.T = if Hydraulic_Cut_Out.q > 0 then (Hydraulic_Cut_In1.q*
      Hydraulic_Cut_In1.T + Hydraulic_Cut_In2.q*Hydraulic_Cut_In2.T +
      Hydraulic_Cut_In3.q*Hydraulic_Cut_In3.T + Hydraulic_Cut_In4.q*
      Hydraulic_Cut_In4.T + Hydraulic_Cut_In5.q*Hydraulic_Cut_In5.T)/
      Hydraulic_Cut_Out.q else 0;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In1.P;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In2.P;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In3.P;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In4.P;
    Hydraulic_Cut_Out.P = Hydraulic_Cut_In5.P;
    Hydraulic_Cut_Out.q = Hydraulic_Cut_In1.q + Hydraulic_Cut_In2.q +
      Hydraulic_Cut_In3.q + Hydraulic_Cut_In4.q + Hydraulic_Cut_In5.q;
  end Five2One;

  model PressureSet "Set Pressure to a fix value"
    extends Base.OneConnection;
    parameter Modelica.SIunits.Pressure Pfix=10E-5 "Fixed Pressure";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-40, 80; 40, -80]),
        Polygon(points=[-10, 64; 10, 64; 10, -40; 26, -40; 0, -72; -26, -40; -10,
               -40; -10, 64]),
        Rectangle(extent=[-80, 80; 82, -80], style(fillColor=8)),
        Ellipse(extent=[-68, 66; 70, -68], style(fillColor=68)),
        Line(points=[70, 0; 32, 0; 36, 0]),
        Line(points=[-32, 0; -70, 0; -66, 0]),
        Line(points=[0, -26; 0, -68]),
        Line(points=[-2, 66; -2, 24]),
        Polygon(points=[-6, -4; -2, 54; 4, -4; -6, -4], style(color=41,
              fillColor=41)),
        Ellipse(extent=[-8, 8; 6, -6], style(gradient=3, fillColor=42)),
        Line(points=[-44, 50; -16, 18]),
        Line(points=[18, -20; 46, -52]),
        Line(points=[18, 16; 48, 48]),
        Line(points=[-48, -50; -18, -18]),
        Polygon(points=[-10, -30; 12, -30; 12, -58; 22, -58; 0, -82; -20, -58;
              -10, -58; -10, -30], style(pattern=0, fillColor=0))),
      Icon(
        Rectangle(extent=[-80, 80; 82, -80], style(fillColor=8)),
        Ellipse(extent=[-68, 66; 70, -68], style(fillColor=68)),
        Line(points=[70, 0; 32, 0; 36, 0]),
        Line(points=[-32, 0; -70, 0; -66, 0]),
        Line(points=[0, -26; 0, -68]),
        Line(points=[-2, 66; -2, 24]),
        Polygon(points=[-6, -4; -2, 54; 4, -4; -6, -4], style(color=41,
              fillColor=41)),
        Ellipse(extent=[-8, 8; 6, -6], style(gradient=3, fillColor=42)),
        Line(points=[-44, 50; -16, 18]),
        Line(points=[18, -20; 46, -52]),
        Line(points=[18, 16; 48, 48]),
        Line(points=[-48, -50; -18, -18]),
        Polygon(points=[-10, -30; 12, -30; 12, -58; 22, -58; 0, -82; -20, -58;
              -10, -58; -10, -30], style(pattern=0, fillColor=0))),
      Window(
        x=0.36,
        y=0.19,
        width=0.6,
        height=0.6));
  equation
    Hydraulic_Cut_In.P = Pfix;
  end PressureSet;

  model TemperatureSet
    extends Base.OneConnection;
    parameter Modelica.SIunits.Temperature Tfix=20 "Fixed Temperature";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-40, 80; 40, -80]),
        Polygon(points=[-10, 64; 10, 64; 10, -40; 26, -40; 0, -72; -26, -40; -10,
               -40; -10, 64]),
        Rectangle(extent=[-80, 80; 80, -80], style(color=73, fillColor=8)),
        Polygon(points=[-10, -34; 12, -34; 12, -52; 22, -52; 0, -76; -20, -52;
              -10, -52; -10, -34], style(pattern=0, fillColor=0)),
        Rectangle(extent=[-40, 74; 42, -34], style(color=0)),
        Ellipse(extent=[-30, 28; 32, -30], style(color=41, fillColor=41)),
        Rectangle(extent=[-8, 40; 12, 22], style(color=41, fillColor=41)),
        Rectangle(extent=[-8, 66; 12, 40], style(
            color=0,
            fillColor=7,
            fillPattern=8))),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(color=73, fillColor=8)),
        Polygon(points=[-10, -34; 12, -34; 12, -52; 22, -52; 0, -76; -20, -52;
              -10, -52; -10, -34], style(pattern=0, fillColor=0)),
        Rectangle(extent=[-40, 74; 42, -34], style(color=0)),
        Ellipse(extent=[-30, 28; 32, -30], style(color=41, fillColor=41)),
        Rectangle(extent=[-8, 40; 12, 22], style(color=41, fillColor=41)),
        Rectangle(extent=[-8, 66; 12, 40], style(
            color=0,
            fillColor=7,
            fillPattern=8))),
      Window(
        x=0.18,
        y=0.29,
        width=0.6,
        height=0.6));
  equation
    Hydraulic_Cut_In.T = Tfix;
  end TemperatureSet;

  model PresTempSet "Set a fix temperature and pressure"
    extends Base.OneConnection;
    parameter Modelica.SIunits.Pressure Pfix=10E-5 "Fixed Pressure";
    parameter Modelica.SIunits.Temperature Tfix=20 "Fixed Temperature";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=8)),
        Rectangle(extent=[-76, 74; -12, -38], style(gradient=3, fillColor=74)),
        Rectangle(extent=[-8, 74; 76, -38], style(gradient=3)),
        Ellipse(extent=[-70, 22; -18, -32], style(color=41, fillColor=41)),
        Rectangle(extent=[-52, 34; -36, 10], style(color=41, fillColor=41)),
        Rectangle(extent=[-52, 62; -36, 34], style(fillColor=7, fillPattern=8)),
        Ellipse(extent=[-4, 56; 72, -22], style(gradient=3, fillColor=73)),
        Ellipse(extent=[2, 48; 64, -14], style(fillColor=68)),
        Polygon(points=[28, 18; 44, 36; 36, 16; 28, 18], style(color=41,
              fillColor=41)),
        Ellipse(extent=[26, 24; 40, 10], style(gradient=3, fillColor=41)),
        Line(points=[34, 36; 34, 48]),
        Line(points=[34, -14; 34, -2]),
        Line(points=[2, 16; 12, 16]),
        Line(points=[56, 16; 66, 16]),
        Line(points=[12, 38; 20, 30]),
        Line(points=[12, 38; 20, 30]),
        Line(points=[48, 4; 56, -4]),
        Line(points=[12, -6; 22, 4]),
        Line(points=[46, 28; 56, 38]),
        Polygon(points=[-60, -42; -38, -42; -38, -54; -28, -54; -50, -78; -70,
              -54; -60, -54; -60, -42], style(pattern=0, fillColor=0)),
        Polygon(points=[22, -42; 44, -42; 44, -54; 54, -54; 32, -78; 12, -54;
              22, -54; 22, -42], style(pattern=0, fillColor=0))),
      Diagram(
        Rectangle(extent=[-40, 80; 40, -80]),
        Polygon(points=[-10, 64; 10, 64; 10, -40; 26, -40; 0, -72; -26, -40; -10,
               -40; -10, 64]),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=8)),
        Rectangle(extent=[-76, 74; -12, -38], style(gradient=3, fillColor=74)),
        Rectangle(extent=[-8, 74; 76, -38], style(gradient=3)),
        Ellipse(extent=[-70, 22; -18, -32], style(color=41, fillColor=41)),
        Rectangle(extent=[-52, 34; -36, 10], style(color=41, fillColor=41)),
        Rectangle(extent=[-52, 62; -36, 34], style(fillColor=7, fillPattern=8)),
        Ellipse(extent=[-4, 56; 72, -22], style(gradient=3, fillColor=73)),
        Ellipse(extent=[2, 48; 64, -14], style(fillColor=68)),
        Polygon(points=[28, 18; 44, 36; 36, 16; 28, 18], style(color=41,
              fillColor=41)),
        Ellipse(extent=[26, 24; 40, 10], style(gradient=3, fillColor=41)),
        Line(points=[34, 36; 34, 48]),
        Line(points=[34, -14; 34, -2]),
        Line(points=[2, 16; 12, 16]),
        Line(points=[56, 16; 66, 16]),
        Line(points=[12, 38; 20, 30]),
        Line(points=[12, 38; 20, 30]),
        Line(points=[48, 4; 56, -4]),
        Line(points=[12, -6; 22, 4]),
        Line(points=[46, 28; 56, 38]),
        Polygon(points=[-60, -42; -38, -42; -38, -54; -28, -54; -50, -78; -70,
              -54; -60, -54; -60, -42], style(pattern=0, fillColor=0)),
        Polygon(points=[22, -42; 44, -42; 44, -54; 54, -54; 32, -78; 12, -54;
              22, -54; 22, -42], style(pattern=0, fillColor=0))),
      Window(
        x=0.35,
        y=0.27,
        width=0.6,
        height=0.6));

  equation
    Hydraulic_Cut_In.P = Pfix;
    Hydraulic_Cut_In.T = Tfix;
  end PresTempSet;

  model PressVolume
    extends Base.OneConnection;
    parameter Modelica.SIunits.Volume V=0.001 "Volume";
    constant Real betapmax=1.8e9 "Pa; bulk modulus at maximum pressure";
    constant Real pbeta1=-0.4 "[]; parameter";
    constant Real pbeta2=-2.e-7 "[1/Pa]; parameter";
    Modelica.SIunits.Pressure Prs "Pressure build up";
    Modelica.SIunits.BulkModulus beta;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(color=8, fillColor=8)),
        Rectangle(extent=[-10, -80; 10, -34], style(gradient=1, fillColor=73)),
        Ellipse(extent=[-60, 60; 56, -52], style(gradient=3, fillColor=74))),
      Diagram(
        Rectangle(extent=[-40, 80; 40, -80]),
        Polygon(points=[-10, 64; 10, 64; 10, -40; 26, -40; 0, -72; -26, -40; -10,
               -40; -10, 64]),
        Rectangle(extent=[-80, 80; 80, -80], style(color=8, fillColor=8)),
        Rectangle(extent=[-10, -80; 10, -34], style(gradient=1, fillColor=73)),
        Ellipse(extent=[-60, 60; 56, -52], style(gradient=3, fillColor=74))),
      Window(
        x=0.35,
        y=0.3,
        width=0.6,
        height=0.6));

  equation
    beta = betapmax*(1 - exp(pbeta1 + pbeta2*Hydraulic_Cut_In.P));
    der(Prs) = Hydraulic_Cut_In.q*beta/V;
    Hydraulic_Cut_In.P = if Prs > pvapour then Prs else pvapour;
  end PressVolume;

  model Pressure_Sensor
    extends Base.OneConnection;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-76, 76; 84, -84], style(gradient=3, fillColor=73)),
        Ellipse(extent=[-62, 62; 64, -62], style(gradient=3, fillColor=41)),
        Ellipse(extent=[-38, 36; 38, -38], style(color=8, fillColor=68)),
        Polygon(points=[-4, 2; 14, 26; 2, -2; -4, 2], style(color=41, fillColor=
               41)),
        Ellipse(extent=[-8, 8; 8, -8], style(gradient=3, fillColor=41)),
        Line(points=[0, 32; 0, 22]),
        Line(points=[0, -26; 0, -36]),
        Line(points=[-36, -2; -26, -2]),
        Line(points=[24, 0; 36, 0]),
        Line(points=[-24, 22; -18, 16]),
        Line(points=[20, -20; 26, -26]),
        Line(points=[-22, -28; -16, -22]),
        Line(points=[18, 10; 26, 18]),
        Rectangle(extent=[68, -2; 72, -28], style(gradient=1, fillColor=49)),
        Rectangle(extent=[72, -32; 80, -28], style(gradient=2, fillColor=49)),
        Rectangle(extent=[64, -2; 68, 2], style(gradient=2, fillColor=49)),
        Rectangle(extent=[68, -2; 72, 2], style(gradient=3, fillColor=49)),
        Rectangle(extent=[68, -32; 72, -28], style(gradient=3, fillColor=49))),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(gradient=3, fillColor=73)),
        Ellipse(extent=[-62, 62; 64, -62], style(gradient=3, fillColor=41)),
        Ellipse(extent=[-38, 36; 38, -38], style(color=8, fillColor=68)),
        Polygon(points=[-4, 2; 14, 26; 2, -2; -4, 2], style(color=41, fillColor=
               41)),
        Ellipse(extent=[-8, 8; 8, -8], style(gradient=3, fillColor=41)),
        Line(points=[0, 32; 0, 22]),
        Line(points=[0, -26; 0, -36]),
        Line(points=[-36, -2; -26, -2]),
        Line(points=[24, 0; 36, 0]),
        Line(points=[-24, 22; -18, 16]),
        Line(points=[20, -20; 26, -26]),
        Line(points=[-22, -28; -16, -22]),
        Line(points=[18, 10; 26, 18]),
        Rectangle(extent=[68, -2; 72, -28], style(gradient=1, fillColor=49)),
        Rectangle(extent=[72, -32; 80, -28], style(gradient=2, fillColor=49)),
        Rectangle(extent=[64, -2; 68, 2], style(gradient=2, fillColor=49)),
        Rectangle(extent=[68, -2; 72, 2], style(gradient=3, fillColor=49)),
        Rectangle(extent=[68, -32; 72, -28], style(gradient=3, fillColor=49))),
      Window(
        x=0.23,
        y=0.2,
        width=0.6,
        height=0.6));

    Modelica.Blocks.Interfaces.OutPort OutPort
      annotation (extent=[82, -40; 102, -20]);
  equation
    Hydraulic_Cut_In.q = 0;
    Hydraulic_Cut_In.P = OutPort.signal[1];
  end Pressure_Sensor;

  model Valve

    extends Base.pipebase;
    Real truepos "actual valveposition 0..1";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-78, 60; -60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[78, 60; 60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-60, 40; 60, -20], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-80, 60; -60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 60; 60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; 60, -22], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 16; 24, 4], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[24, 26; 24, -6; 44, 10; 24, 26], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Ellipse(extent=[-60, 70; 60, -50], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[0, 10; -40, 60; 40, 60; 0, 10], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Polygon(points=[-40, -40; -40, -40; 40, -40; 0, 8; -40, -40], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Rectangle(extent=[-48, 90; -10, 86], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-10, 100; 10, 60], style(
            gradient=1,
            fillColor=5,
            fillPattern=1)),
        Rectangle(extent=[-22, 100; 22, 84], style(
            gradient=1,
            fillColor=5,
            fillPattern=1))),
      Diagram(
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 40; 80, -20]),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-78, 60; -60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[78, 60; 60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-60, 40; 60, -20], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-80, 60; -60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 60; 60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; 60, -22], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 16; 24, 4], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[24, 26; 24, -6; 44, 10; 24, 26], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Ellipse(extent=[-60, 70; 60, -50], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[0, 10; -40, 60; 40, 60; 0, 10], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Polygon(points=[-40, -40; -40, -40; 40, -40; 0, 8; -40, -40], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Rectangle(extent=[-48, 90; -10, 86], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-10, 100; 10, 60], style(
            gradient=1,
            fillColor=5,
            fillPattern=1)),
        Rectangle(extent=[-22, 100; 22, 84], style(
            gradient=1,
            fillColor=5,
            fillPattern=1))),
      Window(
        x=0.2,
        y=0.3,
        width=0.76,
        height=0.6),
      Documentation(info="  Real A0 cross  parameter section area of valve closed in m2;
"));
    Modelica.Blocks.Interfaces.InPort In annotation (extent=[-68, 78; -48, 98]);
  equation

    Hydraulic_Cut_In.T = Hydraulic_Cut_Out.T;
    /*no energy loss*/

    truepos = if In.signal[1] < 0 then 0 else if In.signal[1] > 1 then 1.0 else
            In.signal[1];

    A = (1 - truepos)*(0.001*A1 - A1) + A1;
  end Valve;

  model DisPump_Ideal
    "parameter SIunits.VolumeFlowRate qbias=0.0 \"Bias of flow\";qbias + "
    extends Base.TwoConnection;
    parameter Modelica.SIunits.VolumeFlowRate qbias=0.0 "Bias of flow";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-80, 40; 80, -20]),
        Rectangle(extent=[-80, 60; -60, -40]),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=57)),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=57)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=57)),
        Ellipse(extent=[-50, 60; 50, -40], style(
            color=0,
            gradient=3,
            fillColor=57,
            fillPattern=1)),
        Ellipse(extent=[-30, 40; 30, -20], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[24, 14; -20, 28], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[24, 6; -20, -6], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-24, 10; -4, 10], style(color=0))),
      Icon(
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=57)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=57)),
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-80, 60; -60, -40]),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=57)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=57)),
        Ellipse(extent=[-50, 60; 50, -40], style(
            color=0,
            gradient=3,
            fillColor=57,
            fillPattern=1)),
        Ellipse(extent=[-30, 40; 30, -20], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-18, 10; 6, 10], style(
            color=0,
            arrow=1,
            fillColor=3,
            fillPattern=1)),
        Line(points=[24, 14; -20, 28], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[24, 6; -20, -6], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-80, 60; -60, -40]),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=57)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=57)),
        Ellipse(extent=[-50, 60; 50, -40], style(
            color=0,
            gradient=3,
            fillColor=57,
            fillPattern=1)),
        Ellipse(extent=[-30, 40; 30, -20], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-18, 10; 6, 10], style(
            color=0,
            arrow=1,
            fillColor=3,
            fillPattern=1)),
        Line(points=[24, 14; -20, 28], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[24, 6; -20, -6], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=57)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=57)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=57)),
        Ellipse(extent=[-50, 60; 50, -40], style(
            color=0,
            gradient=3,
            fillColor=57,
            fillPattern=1)),
        Ellipse(extent=[-30, 40; 30, -20], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[24, 14; -20, 28], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[24, 6; -20, -6], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-22, 8; 0, 8])),
      Window(
        x=0.33,
        y=0.35,
        width=0.45,
        height=0.44),
      Documentation(info="

"));

  equation
    Hydraulic_Cut_In.q + Hydraulic_Cut_Out.q = 0;
    Hydraulic_Cut_In.q = qbias;
    Hydraulic_Cut_In.T = Hydraulic_Cut_Out.T;

  end DisPump_Ideal;

  model DisPump
    extends Base.TwoConnection;
    parameter Modelica.SIunits.VolumeFlowRate qbiaspump=0.1 "Bias of flow";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-80, 60; -60, -40]),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=8)),
        Rectangle(extent=[-80, 60; -60, -40], style(fillPattern=0)),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=57)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=57)),
        Ellipse(extent=[-50, 60; 50, -40], style(
            color=0,
            gradient=3,
            fillColor=57,
            fillPattern=1)),
        Ellipse(extent=[-30, 40; 30, -20], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-18, 10; 6, 10], style(
            color=0,
            arrow=1,
            fillColor=3,
            fillPattern=1)),
        Line(points=[24, 14; -20, 28], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[24, 6; -20, -6], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-80, 40; 80, -20], style(gradient=2, fillColor=57)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=57)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=57)),
        Ellipse(extent=[-50, 60; 50, -40], style(
            color=0,
            gradient=3,
            fillColor=57,
            fillPattern=1)),
        Ellipse(extent=[-30, 40; 30, -20], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-18, 10; 6, 10], style(
            color=0,
            arrow=1,
            fillColor=3,
            fillPattern=1)),
        Line(points=[24, 14; -20, 28], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[24, 6; -20, -6], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-80, 60; -60, -40], style(gradient=2, fillColor=57)),
        Rectangle(extent=[60, 60; 80, -40], style(gradient=2, fillColor=57)),
        Ellipse(extent=[-50, 60; 50, -40], style(
            color=0,
            gradient=3,
            fillColor=57,
            fillPattern=1)),
        Ellipse(extent=[-30, 40; 30, -20], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[24, 14; -20, 28], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[24, 6; -20, -6], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-6, 16; 12, 10; -6, 4; -6, 16], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[54, -20; 48, -66], style(fillColor=73)),
        Rectangle(extent=[-48, -20; -54, -66], style(fillColor=73)),
        Rectangle(extent=[-54, -60; 54, -66], style(fillColor=73)),
        Polygon(points=[-26, -64; 12, -50; 12, -76; -26, -62; -26, -64], style(
              fillColor=73)),
        Line(points=[-22, 10; 4, 10])),
      Window(
        x=0.35,
        y=0.37,
        width=0.62,
        height=0.48),
      Documentation(info="
"));

    Standard.DisPump_Ideal DisPump_Ideal(qbias=qbiaspump)
      annotation (extent=[-22, -22; 42, 38]);
    Standard.PressVolume PressVolume1 annotation (extent=[-44, 52; -6, 90]);
    Standard.PressVolume PressVolume2 annotation (extent=[38, 52; 76, 90]);
    Standard.pipeideal pipeideal
      annotation (extent=[-16, -76; 36, -28], rotation=180);
    Standard.Two2One Two2One1
      annotation (extent=[-70, -12; -26, 30], rotation=90);
  equation
    connect(Two2One1.Hydraulic_Cut_Out, DisPump_Ideal.Hydraulic_Cut_In)
      annotation (points=[-26, 10; -20, 10]);
    connect(DisPump_Ideal.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[42, 10; 80, 10]);
    connect(PressVolume2.Hydraulic_Cut_In, DisPump_Ideal.Hydraulic_Cut_Out)
      annotation (points=[58, 52; 58, 10; 42, 10]);
    connect(PressVolume1.Hydraulic_Cut_In, DisPump_Ideal.Hydraulic_Cut_In)
      annotation (points=[-24, 52; -24, 10; -16, 10]);
    connect(DisPump_Ideal.Hydraulic_Cut_Out, pipeideal.Hydraulic_Cut_In)
      annotation (points=[42, 10; 58, 10; 58, -54; 36, -54]);
    connect(pipeideal.Hydraulic_Cut_Out, Two2One1.Hydraulic_Cut_In1)
      annotation (points=[-16, -56; -72, -56; -72, -2; -70, -2]);
    connect(Hydraulic_Cut_In, Two2One1.Hydraulic_Cut_In2)
      annotation (points=[-80, 10; -74, 10; -74, 20; -68, 20]);
  end DisPump;

  model FourWays "Fourways"
    extends Base.FourConnection;
    Real mix;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-80, 80; 80, -80]),
        Line(points=[-78, -10; -12, -10]),
        Line(points=[-10, -74; -10, -12]),
        Line(points=[10, 76; 10, 8]),
        Line(points=[14, 8; 74, 8]),
        Line(points=[-68, 78; 0, 0], style(pattern=3)),
        Rectangle(extent=[-80, 80; 80, -80]),
        Rectangle(extent=[-80, 80; 80, -80]),
        Rectangle(extent=[-80, 80; 80, -80]),
        Ellipse(extent=[-54, 52; 54, -56], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Ellipse(extent=[-30, 28; 30, -32], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-10, 48; 10, 24], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-50, 8; -26, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[26, 8; 50, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-10, -24; 10, -52], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-50, 52; 50, -48], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[-32, 28; 28, -32], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-6, 2; 2, -6], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-12, 48; 8, 24], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-52, 8; -28, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[24, 8; 48, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-12, -24; 8, -52], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-22, -20; 16, 16], style(
            color=0,
            pattern=3,
            thickness=1,
            arrow=0)),
        Line(points=[38, -2; 10, -2; -2, 10; -2, 36], style(
            color=2,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[-2, 36; 0, 36; -2, 40; -4, 36; -2, 36], style(
            color=2,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-42, -2; -18, -2; -2, -20; -2, -40], style(color=1)),
        Polygon(points=[-4, -40; 0, -40; -2, -44; -4, -40], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-22, 16; 18, -20], style(color=0, thickness=2)),
        Line(points=[-68, 80; -68, 40; -22, 16], style(
            color=6,
            pattern=3,
            thickness=2)),
        Rectangle(extent=[-80, 12; -44, -14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-12, -46; 10, -80], style(
            gradient=1,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[46, 8; 80, -14], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-24, -74; 22, -80], style(
            gradient=1,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-80, 22; -74, -24], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-80, 22; -74, -24], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[74, 22; 82, -24], style(
            gradient=2,
            fillColor=4,
            fillPattern=1))),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80]),
        Line(points=[-78, -10; -12, -10]),
        Line(points=[-10, -74; -10, -12]),
        Line(points=[10, 76; 10, 8]),
        Line(points=[14, 8; 74, 8]),
        Line(points=[-68, 78; 0, 0], style(pattern=3)),
        Rectangle(extent=[-80, 80; 80, -80], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-80, 80; 80, -80]),
        Rectangle(extent=[-80, 80; 80, -80]),
        Rectangle(extent=[-80, 80; 80, -80]),
        Ellipse(extent=[-54, 52; 54, -56], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Ellipse(extent=[-30, 28; 30, -32], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-10, 48; 10, 24], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-50, 8; -26, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[26, 8; 50, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-10, -24; 10, -52], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-50, 52; 50, -48], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[-32, 28; 28, -32], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-6, 2; 2, -6], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-12, 48; 8, 24], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-52, 8; -28, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[24, 8; 48, -12], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-12, -24; 8, -52], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-22, -20; 16, 16], style(
            color=0,
            pattern=3,
            thickness=1,
            arrow=0)),
        Line(points=[38, -2; 10, -2; -2, 10; -2, 36], style(
            color=2,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[-2, 36; 0, 36; -2, 40; -4, 36; -2, 36], style(
            color=2,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-42, -2; -18, -2; -2, -20; -2, -40], style(color=1)),
        Polygon(points=[-4, -40; 0, -40; -2, -44; -4, -40], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-22, 16; 18, -20], style(color=0, thickness=2)),
        Line(points=[-68, 80; -68, 40; -22, 16], style(
            color=6,
            pattern=3,
            thickness=2)),
        Rectangle(extent=[-12, 80; 10, 42], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-80, 12; -44, -14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-12, -46; 10, -80], style(
            gradient=1,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[46, 8; 80, -14], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-24, 80; 22, 74], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-24, -74; 22, -80], style(
            gradient=1,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-80, 22; -74, -24], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-80, 22; -74, -24], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[74, 22; 82, -24], style(
            gradient=2,
            fillColor=4,
            fillPattern=1))),
      Window(
        x=0.42,
        y=0.07,
        width=0.6,
        height=0.6),
      Documentation(info="  RLK.P = RL.P;
"));
  equation
    mix = if InPort.signal[1] < 0 then 0 else if InPort.signal[1] > 1 then 1 else
            InPort.signal[1];
    /* Pressure Equation */
    RLK.P = VLK.P;
    RL.P = VL.P;

    /* Mass Flow Equation */
    RLK.q = -VLK.q;
    RL.q = -VL.q;

    /* Heat Flow Equation */
    RLK.T = (1 - mix)*VLK.T + mix*RL.T;
    VL.T = mix*VLK.T + (1 - mix)*RL.T;

  end FourWays;

  model radpipe
    Real expo;
    Real Tcool;
    parameter Real alpha=10.0
      "Heat transfer Coefficient from water to pipe W/m2K";
    Interfaces.therm therm1 annotation (extent=[-14, 80; 6, 100]);
    extends Base.pipebase;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-78, 60; -60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[78, 60; 60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-60, 40; 60, -20], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-60, 40; 42, 60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -60; 40, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 40; 60, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 60; 60, 38], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, -40; 60, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-80, 0; -40, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; -40, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 60; -40, 40], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -40; -40, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-70, 30; -32, -8], style(
            gradient=3,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-30, 10; 0, 10; 0, -76], style(color=1, pattern=3)),
        Rectangle(extent=[-30, 52; 16, 48], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-30, -46; 16, -50], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, -42; 16, -54; 26, -48; 16, -42], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, 56; 16, 44; 26, 50; 16, 56], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Line(points=[-64, 2; -40, 22], style(color=6, thickness=2)),
        Line(points=[-18, 70; 12, 70], style(color=1)),
        Line(points=[-18, 76; 12, 76], style(color=1)),
        Line(points=[-18, 64; 12, 64], style(color=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-60, 40; 42, 60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -60; 40, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 40; 60, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 60; 60, 38], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, -40; 60, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-80, 0; -40, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; -40, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 60; -40, 40], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -40; -40, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-70, 30; -32, -8], style(
            gradient=3,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-34, 10; 0, 10; 0, -84], style(color=1, pattern=3)),
        Rectangle(extent=[-30, 52; 16, 48], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-30, -46; 16, -50], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, -42; 16, -54; 26, -48; 16, -42], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, 56; 16, 44; 26, 50; 16, 56], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Line(points=[-64, 2; -40, 22], style(color=6, thickness=2)),
        Line(points=[-18, 70; 12, 70], style(color=1)),
        Line(points=[-18, 76; 12, 76], style(color=1)),
        Line(points=[-18, 64; 12, 64], style(color=1)),
        Rectangle(extent=[60, 0; 80, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-22, 58; 12, 42], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-20, 56; -20, 44; 10, 44]),
        Line(points=[-20, 56; -18, 52; -16, 50; -12, 48; -4, 46; 10, 44], style(
              color=1))),
      Icon(
        Rectangle(extent=[-80, 40; 80, -20]),
        Rectangle(extent=[-80, 60; -60, -40]),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-78, 60; -60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[78, 60; 60, -40], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-60, 40; 60, -20], style(
            gradient=0,
            fillColor=8,
            fillPattern=0)),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-60, 40; 42, 60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -60; 40, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 40; 60, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 60; 60, 38], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, -40; 60, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-80, 0; -40, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; -40, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 60; -40, 40], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -40; -40, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-70, 30; -32, -8], style(
            gradient=3,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-30, 10; 0, 10; 0, -76], style(color=1, pattern=3)),
        Rectangle(extent=[-30, 52; 16, 48], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-30, -46; 16, -50], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, -42; 16, -54; 26, -48; 16, -42], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, 56; 16, 44; 26, 50; 16, 56], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Line(points=[-64, 2; -40, 22], style(color=6, thickness=2)),
        Line(points=[-18, 70; 12, 70], style(color=1)),
        Line(points=[-18, 76; 12, 76], style(color=1)),
        Line(points=[-18, 64; 12, 64], style(color=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-60, 40; 42, 60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -60; 40, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 40; 60, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 60; 60, 38], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, -40; 60, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-80, 0; -40, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; -40, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 60; -40, 40], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -40; -40, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-70, 30; -32, -8], style(
            gradient=3,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-30, 10; 0, 10; 0, -76], style(color=1, pattern=3)),
        Rectangle(extent=[-30, 52; 16, 48], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-30, -46; 16, -50], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, -42; 16, -54; 26, -48; 16, -42], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, 56; 16, 44; 26, 50; 16, 56], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Line(points=[-64, 2; -40, 22], style(color=6, thickness=2)),
        Line(points=[-18, 70; 12, 70], style(color=1)),
        Line(points=[-18, 76; 12, 76], style(color=1)),
        Line(points=[-18, 64; 12, 64], style(color=1)),
        Rectangle(extent=[60, 0; 80, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-22, 58; 12, 42], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-20, 56; -20, 44; 10, 44]),
        Line(points=[-20, 56; -18, 52; -16, 50; -12, 48; -4, 46; 10, 44], style(
              color=1))),
      Window(
        x=0.12,
        y=0.1,
        width=0.97,
        height=0.74),
      Documentation(info="equation
  A = A1;
  expo = if (InPort.signal[1]*Hydraulic_Cut_In.q) < 0 then 1.0/(2.71828^((
    alpha*pi*d*l)/(cw*InPort.signal[1]*Hydraulic_Cut_In.q*rho))) else 0;

  Tcool = Thermal_Cut_Out.T + (Hydraulic_Cut_In.T - Thermal_Cut_Out.T)*expo;

  Thermal_Cut_Out.j = (InPort.signal[1]*Hydraulic_Cut_In.q)*rho*cw*(
    Hydraulic_Cut_In.T - Tcool);

  Hydraulic_Cut_Out.T = (InPort.signal[1]*Tcool) + (1 - InPort.signal[1])*
    Hydraulic_Cut_In.T;



*Hydraulic_Cut_In.q
"));

    Modelica.Blocks.Interfaces.InPort InPort
      annotation (extent=[-10, -100; 10, -80], rotation=90);
  equation
    A = A1;

    expo = if (InPort.signal[1]) < 0 then 1.0/(2.71828^((alpha*pi*d*l)/(cw*
      InPort.signal[1]*Hydraulic_Cut_In.q*rho)) + 0.000001) else 0;

    Tcool = therm1.T + (Hydraulic_Cut_In.T - therm1.T)*expo;

    therm1.j = -(InPort.signal[1]*Hydraulic_Cut_In.q)*rho*cw*(Hydraulic_Cut_In.
      T - Tcool);

    Hydraulic_Cut_Out.T = (InPort.signal[1]*Tcool) + (1 - InPort.signal[1])*
      Hydraulic_Cut_In.T;

  end radpipe;

  model radpipe_simple
    Interfaces.therm therm1 annotation (extent=[-10, 80; 10, 100]);
    extends Base.pipebase;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10], style(
            color=3,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; -60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 60; 60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; 60, -22], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 16; 24, 4], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[24, 26; 24, -6; 44, 10; 24, 26], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-60, 40; 42, 60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -60; 40, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 40; 60, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 60; 60, 38], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, -40; 60, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-80, 0; -40, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; -40, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 60; -40, 40], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -40; -40, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-70, 30; -32, -8], style(
            gradient=3,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-30, 10; 0, 10; 0, -76], style(color=1, pattern=3)),
        Rectangle(extent=[-30, 52; 16, 48], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-30, -46; 16, -50], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, -42; 16, -54; 26, -48; 16, -42], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, 56; 16, 44; 26, 50; 16, 56], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Line(points=[-64, 2; -40, 22], style(color=6, thickness=2)),
        Line(points=[-18, 70; 12, 70], style(color=1)),
        Line(points=[-18, 76; 12, 76], style(color=1)),
        Line(points=[-18, 64; 12, 64], style(color=1)),
        Rectangle(extent=[60, 0; 80, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-22, 58; 12, 42], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-18, 54; -6, 54; -6, 46; 8, 46], style(color=1))),
      Icon(
        Rectangle(extent=[-80, 40; 80, -20]),
        Rectangle(extent=[-80, 60; -60, -40]),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10], style(
            color=3,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; -60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 60; 60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; 60, -22], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 16; 24, 4], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[24, 26; 24, -6; 44, 10; 24, 26], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, fillPattern=1)),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-60, 40; 42, 60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -60; 40, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 40; 60, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 60; 60, 38], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, -40; 60, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-80, 0; -40, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; -40, -40], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 60; -40, 40], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, -40; -40, -60], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-70, 30; -32, -8], style(
            gradient=3,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-30, 10; 0, 10; 0, -76], style(color=1, pattern=3)),
        Rectangle(extent=[-30, 52; 16, 48], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-30, -46; 16, -50], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, -42; 16, -54; 26, -48; 16, -42], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Polygon(points=[16, 56; 16, 44; 26, 50; 16, 56], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Line(points=[-64, 2; -40, 22], style(color=6, thickness=2)),
        Line(points=[-18, 70; 12, 70], style(color=1)),
        Line(points=[-18, 76; 12, 76], style(color=1)),
        Line(points=[-18, 64; 12, 64], style(color=1)),
        Rectangle(extent=[60, 0; 80, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-22, 58; 12, 42], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-18, 54; -6, 54; -6, 46; 8, 46], style(color=1))),
      Window(
        x=0.15,
        y=0.26,
        width=0.85,
        height=0.6));

    Modelica.Blocks.Interfaces.InPort InPort
      annotation (extent=[-10, -100; 10, -80], rotation=90);
  equation
    A = A1;
    therm1.j = (InPort.signal[1]*Hydraulic_Cut_In.q)*rho*cw*(Hydraulic_Cut_In.T
       - therm1.T);
    Hydraulic_Cut_Out.T = (InPort.signal[1]*therm1.T) + (1 - InPort.signal[1])*
      Hydraulic_Cut_In.T;

  end radpipe_simple;

  model Boiler
    parameter Real Pboil=50000 "Heating power of boiler in W";
    parameter Real mboil=100.0 "Mass of water inside the boiler in kg";
    parameter Real KBoil=0.45
      "Kvalue of the boiler, describes energy loss in W/m2K";
    parameter Real ABoil=2.0 "Surface of boiler in m2";
    Real Tboil(start=16) "actual water temperature of the boiler in C";
    extends Base.pipebase;
    Interfaces.therm therm1 annotation (extent=[-14, 98; 6, 118]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10], style(
            color=3,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; -60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 60; 60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; 60, -22], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 16; 24, 4], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[24, 26; 24, -6; 44, 10; 24, 26], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Rectangle(extent=[80, 100; -80, -80], style(
            color=0,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-64, 0; -44, -26], style(
            gradient=1,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[-8, -68; -10, -58; -4, -50; -8, -40; 6, -52; 6, -62; 0,
               -70; -6, -70; -8, -68], style(
            color=6,
            gradient=3,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-30, -70; 24, -78], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-66, 20; -74, -2], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[50, 60; -12, 38], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-70, -80; 70, -100], style(
            color=0,
            gradient=3,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[74, 30; 80, -12], style(
            color=0,
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-74, 28; -80, -10], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Line(points=[-80, -50; -30, -72], style(color=6, pattern=3)),
        Rectangle(extent=[-80, 100; 80, 96], style(
            gradient=1,
            fillColor=10,
            fillPattern=1)),
        Rectangle(extent=[-66, 20; -44, -2], style(
            gradient=3,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-12, -18; -44, -40], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-66, -18; -44, -40], style(
            gradient=3,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[38, -18; -12, -40], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, -18; 38, -40], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, 4; 38, -18], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, 20; 38, -2], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, 20; -14, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-34, 40; -12, 12], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-34, 60; -12, 38], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[74, 20; 68, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[46, 20; 68, -2], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[46, 60; 68, 38], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[46, 38; 68, 20], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-34, 20; -12, -2], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-24, 84; 16, 84], style(color=1)),
        Line(points=[-24, 76; 16, 76], style(color=1)),
        Line(points=[-24, 92; 16, 92], style(color=1)),
        Line(points=[-24, 68; 16, 68], style(color=1)),
        Line(points=[30, -30; 80, -52], style(color=6, pattern=3))),
      Icon(
        Rectangle(extent=[-80, 40; 80, -20]),
        Rectangle(extent=[-80, 60; -60, -40]),
        Rectangle(extent=[60, 60; 80, -40]),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10], style(
            color=3,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; -60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 60; 60, -40], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 40; 60, -22], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 16; 24, 4], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[24, 26; 24, -6; 44, 10; 24, 26], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Rectangle(extent=[80, 100; -80, -80], style(
            color=0,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-64, 0; -44, -26], style(
            gradient=1,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[-8, -68; -10, -58; -4, -50; -8, -40; 6, -52; 6, -62; 0,
               -70; -6, -70; -8, -68], style(
            color=6,
            gradient=3,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-30, -70; 24, -78], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-66, 20; -74, -2], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[50, 60; -12, 38], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-70, -80; 70, -100], style(
            color=0,
            gradient=3,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[74, 30; 80, -12], style(
            color=0,
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-74, 28; -80, -10], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Line(points=[-80, -50; -30, -72], style(color=6, pattern=3)),
        Rectangle(extent=[-80, 100; 80, 96], style(
            gradient=1,
            fillColor=10,
            fillPattern=1)),
        Rectangle(extent=[-66, 20; -44, -2], style(
            gradient=3,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-12, -18; -44, -40], style(
            gradient=2,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-66, -18; -44, -40], style(
            gradient=3,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[38, -18; -12, -40], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, -18; 38, -40], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, 4; 38, -18], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, 20; 38, -2], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[16, 20; -14, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-34, 40; -12, 12], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-34, 60; -12, 38], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[74, 20; 68, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[46, 20; 68, -2], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[46, 60; 68, 38], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[46, 38; 68, 20], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-34, 20; -12, -2], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-24, 84; 16, 84], style(color=1)),
        Line(points=[-24, 76; 16, 76], style(color=1)),
        Line(points=[-24, 92; 16, 92], style(color=1)),
        Line(points=[-24, 68; 16, 68], style(color=1)),
        Line(points=[30, -30; 80, -52], style(color=6, pattern=3))),
      Window(
        x=0.03,
        y=0.22,
        width=0.95,
        height=0.6),
      Documentation(info="


"));
    Modelica.Blocks.Interfaces.InPort InPort
      annotation (extent=[-100, -60; -80, -40]);
    Modelica.Blocks.Interfaces.OutPort OutPort
      annotation (extent=[80, -64; 100, -44]);
  equation
    A = 0.02;
    Hydraulic_Cut_Out.T = Tboil;
    mboil*cw*der(Tboil) = Pboil*InPort.signal[1] - Hydraulic_Cut_In.q*rho*cw*(
      Hydraulic_Cut_Out.T - Hydraulic_Cut_In.T) - therm1.j;

    /*losses of boiler*/
    therm1.j = KBoil*ABoil*(Tboil - therm1.T);

    OutPort.signal[1] = Hydraulic_Cut_Out.T;

  end Boiler;

  model ValveDriver
    parameter Real v=0.00333 "Velocity of drive in 1/s";
    Real pos "Position of drive, between 0-1";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-80, 40; 80, -40]),
        Rectangle(extent=[-14, 20; 20, -20]),
        Line(points=[28, 0; 60, 0]),
        Line(points=[40, 18; 60, 0]),
        Line(points=[40, -20; 60, 0]),
        Line(points=[-62, 0; -20, 0]),
        Line(points=[-40, 18; -20, 0]),
        Line(points=[-40, -20; -20, 0]),
        Rectangle(extent=[-80, 40; 80, -40], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Rectangle(extent=[-2, -4; 76, -20], style(
            color=10,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[4, -22; 14, -2; 16, -2; 6, -22; 4, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[8, -22; 18, -2; 20, -2; 10, -22; 8, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[12, -22; 22, -2; 24, -2; 14, -22; 12, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[16, -22; 26, -2; 28, -2; 18, -22; 16, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[20, -22; 30, -2; 32, -2; 22, -22; 20, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[24, -22; 34, -2; 36, -2; 26, -22; 24, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[28, -22; 38, -2; 40, -2; 30, -22; 28, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[32, -22; 42, -2; 44, -2; 34, -22; 32, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[36, -22; 46, -2; 48, -2; 38, -22; 36, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[40, -22; 50, -2; 52, -2; 42, -22; 40, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[44, -22; 54, -2; 56, -2; 46, -22; 44, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[48, -22; 58, -2; 60, -2; 50, -22; 48, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[52, -22; 62, -2; 64, -2; 54, -22; 52, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[56, -22; 66, -2; 68, -2; 58, -22; 56, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[60, -22; 70, -2; 72, -2; 62, -22; 60, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[64, -22; 74, -2; 76, -2; 66, -22; 64, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[36, 2; 42, -26], style(
            gradient=2,
            fillColor=9,
            fillPattern=1)),
        Rectangle(extent=[40, 12; 82, 10], style(
            color=1,
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[38, 12; 40, 2], style(
            color=1,
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[4, 0; 12, -24], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[4, 0; 12, -24], style(color=0)),
        Rectangle(extent=[68, 0; 76, -24], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[68, 0; 76, -24], style(color=0)),
        Rectangle(extent=[36, 2; 42, -26], style(color=0)),
        Rectangle(extent=[-2, 8; -62, -32], style(
            gradient=2,
            fillColor=2,
            fillPattern=1)),
        Rectangle(extent=[-74, -22; -62, -2], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-72, -6; -70, 8], style(
            color=0,
            gradient=1,
            fillColor=5,
            fillPattern=1)),
        Rectangle(extent=[-70, 8; -80, 10], style(
            color=6,
            gradient=2,
            fillColor=5,
            fillPattern=1))),
      Icon(
        Rectangle(extent=[-80, 40; 80, -40]),
        Rectangle(extent=[-14, 20; 20, -20]),
        Line(points=[28, 0; 60, 0]),
        Line(points=[40, 18; 60, 0]),
        Line(points=[40, -20; 60, 0]),
        Line(points=[-62, 0; -20, 0]),
        Line(points=[-40, 18; -20, 0]),
        Line(points=[-40, -20; -20, 0]),
        Rectangle(extent=[-80, 40; 80, -40], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Rectangle(extent=[-2, -4; 76, -20], style(
            color=10,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[4, -22; 14, -2; 16, -2; 6, -22; 4, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[8, -22; 18, -2; 20, -2; 10, -22; 8, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[12, -22; 22, -2; 24, -2; 14, -22; 12, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[16, -22; 26, -2; 28, -2; 18, -22; 16, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[20, -22; 30, -2; 32, -2; 22, -22; 20, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[24, -22; 34, -2; 36, -2; 26, -22; 24, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[28, -22; 38, -2; 40, -2; 30, -22; 28, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[32, -22; 42, -2; 44, -2; 34, -22; 32, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[36, -22; 46, -2; 48, -2; 38, -22; 36, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[40, -22; 50, -2; 52, -2; 42, -22; 40, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[44, -22; 54, -2; 56, -2; 46, -22; 44, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[48, -22; 58, -2; 60, -2; 50, -22; 48, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[52, -22; 62, -2; 64, -2; 54, -22; 52, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[56, -22; 66, -2; 68, -2; 58, -22; 56, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[60, -22; 70, -2; 72, -2; 62, -22; 60, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[64, -22; 74, -2; 76, -2; 66, -22; 64, -22], style(
            color=10,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[36, 2; 42, -26], style(
            gradient=2,
            fillColor=9,
            fillPattern=1)),
        Rectangle(extent=[40, 12; 82, 10], style(
            color=1,
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[38, 12; 40, 2], style(
            color=1,
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[4, 0; 12, -24], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[4, 0; 12, -24], style(color=0)),
        Rectangle(extent=[68, 0; 76, -24], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[68, 0; 76, -24], style(color=0)),
        Rectangle(extent=[36, 2; 42, -26], style(color=0)),
        Rectangle(extent=[-2, 8; -62, -32], style(
            gradient=2,
            fillColor=2,
            fillPattern=1)),
        Rectangle(extent=[-74, -22; -62, -2], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-72, -6; -70, 8], style(
            color=0,
            gradient=1,
            fillColor=5,
            fillPattern=1)),
        Rectangle(extent=[-70, 8; -80, 10], style(
            color=6,
            gradient=2,
            fillColor=5,
            fillPattern=1))),
      Window(
        x=0.35,
        y=0.4,
        width=0.6,
        height=0.6));
    Modelica.Blocks.Interfaces.InPort InPort
      annotation (extent=[-100, -2; -80, 18]);
    Modelica.Blocks.Interfaces.OutPort OutPort
      annotation (extent=[80, 0; 100, 20]);
  equation
    der(pos) = if ((pos > 1) and (InPort.signal[1] > 0)) or ((pos < 0) and (
      InPort.signal[1] < 0)) then 0 else (InPort.signal[1]*v);
    /* Calculation of actual mixing position */
    OutPort.signal[1] = if (pos < 0) then 0 else if (pos > 1) then 1 else pos;
  end ValveDriver;

  model Temperature_Sensor2
    Interfaces.therm therm1 annotation (extent=[-4, 80; 16, 100]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Rectangle(extent=[-40, 80; 40, -80]),
        Polygon(points=[-10, 64; 10, 64; 10, -40; 26, -40; 0, -72; -26, -40; -10,
               -40; -10, 64]),
        Rectangle(extent=[-80, 80; 80, -80], style(gradient=3, fillColor=65)),
        Ellipse(extent=[-26, 4; 36, -60], style(color=41, fillColor=41)),
        Rectangle(extent=[-8, 14; 16, -26], style(color=41, fillColor=41)),
        Rectangle(extent=[-8, 56; 16, 14], style(fillColor=7, fillPattern=7)),
        Line(points=[18, 34; 32, 34], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Line(points=[18, 28; 32, 28], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Line(points=[18, 22; 32, 22], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Rectangle(extent=[68, 26; 72, -28], style(gradient=1, fillColor=49)),
        Rectangle(extent=[68, 26; 72, 30], style(gradient=3, fillColor=49)),
        Rectangle(extent=[72, -32; 80, -28], style(gradient=2, fillColor=49)),
        Rectangle(extent=[68, -32; 72, -28], style(gradient=3, fillColor=49)),
        Rectangle(extent=[36, 26; 68, 30], style(gradient=2, fillColor=49))),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(gradient=3, fillColor=65)),
        Ellipse(extent=[-26, 4; 36, -60], style(color=41, fillColor=41)),
        Rectangle(extent=[-8, 14; 16, -26], style(color=41, fillColor=41)),
        Line(points=[18, 34; 32, 34], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Line(points=[18, 28; 32, 28], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Line(points=[18, 22; 32, 22], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Rectangle(extent=[68, 26; 72, -28], style(gradient=1, fillColor=49)),
        Rectangle(extent=[68, 26; 72, 30], style(gradient=3, fillColor=49)),
        Rectangle(extent=[72, -32; 80, -28], style(gradient=2, fillColor=49)),
        Rectangle(extent=[68, -32; 72, -28], style(gradient=3, fillColor=49)),
        Rectangle(extent=[36, 26; 68, 30], style(gradient=2, fillColor=49)),
        Rectangle(extent=[-8, 56; 16, 14], style(fillColor=7, fillPattern=7))),
      Window(
        x=0.16,
        y=0.27,
        width=0.6,
        height=0.6));

    Modelica.Blocks.Interfaces.OutPort OutPort
      annotation (extent=[80, -42; 100, -22]);
  equation
    therm1.j = 0;
    therm1.T = OutPort.signal[1];
  end Temperature_Sensor2;

  model Electric_Heater
    parameter Real U=230.00 "Voltage in V";
    parameter Real R=26.45 "Resistance in Ohm";
    Interfaces.therm therm1 annotation (extent=[-10, 80; 10, 100]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-80, 80; 80, -80], style(fillColor=49)), Line(
            points=[-60, -48; -60, 58; -40, 0; -28, 60; -12, 2; -8, 16; 0, 60;
              14, 2; 26, 58; 42, 0; 60, 58; 60, -50], style(color=41, thickness=
               2))),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(fillColor=49)),
        Line(points=[-60, -48; -60, 58; -40, 0; -28, 60; -12, 2; -8, 16; 0, 60;
               14, 2; 26, 58; 42, 0; 60, 58; 60, -50], style(color=41,
              thickness=2)),
        Ellipse(extent=[-66, -46; -54, -58], style(color=41, fillColor=41)),
        Ellipse(extent=[54, -46; 66, -58], style(color=41, fillColor=41))),
      Window(
        x=0.39,
        y=0.22,
        width=0.6,
        height=0.6));
    Modelica.Blocks.Interfaces.InPort InPort
      annotation (extent=[-100, -10; -80, 10]);
  equation
    therm1.j = -(U*U/R)*InPort.signal[1];
  end Electric_Heater;

  model HeatingFloor
    Building.Layer.layerplus layer1
      annotation (extent=[-20, 6; 20, 46], rotation=90);
    Building.Elements.heatcond heatcond1(d=0.02, lambda=0.13)
      annotation (extent=[-20, -56; 18, -18], rotation=90);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-80, 80; 80, -80])),
      Icon(
        Rectangle(extent=[-80, -52; 80, -80], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 52; 80, -24], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[-40, 30; -10, 0], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-6, 30; 24, 0], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[28, 30; 58, 0], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-2, 26; 20, 4], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[32, 26; 54, 4], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-82, 44; -18, 40], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-36, 26; -14, 4], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-80, -4; 50, -8], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-18, 40; -32, 28], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[50, 2; 36, -8], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[42, 6; 42, -6; -80, -6]),
        Rectangle(extent=[-80, -24; 80, -52], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 80; 80, 52], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Line(points=[-78, 42; -24, 42; -24, 26])),
      Window(
        x=0.07,
        y=0.23,
        width=0.6,
        height=0.6));
    Interfaces.Hydraulic_Cut_In Hydraulic_Cut_In
      annotation (extent=[-100, 30; -80, 50]);
    Interfaces.Hydraulic_Cut_Out Hydraulic_Cut_Out
      annotation (extent=[-100, -50; -80, -30]);
    pipereal pipereal1(l=120)
      annotation (extent=[-68, -24; -30, 22], rotation=270);
    Building.therm therm1 annotation (extent=[-10, 80; 10, 100]);
    Building.therm therm2 annotation (extent=[-10, -102; 10, -82]);
  equation
    connect(Hydraulic_Cut_In, pipereal1.Hydraulic_Cut_In)
      annotation (points=[-80, 40; -47.1, 40; -47.1, 20]);
    connect(pipereal1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[-47.1, -21.7; -47.1, -40; -80, -40]);
    connect(heatcond1.therm2, layer1.therm1)
      annotation (points=[0, -20; 0, 6], style(color=45, thickness=2));
    connect(heatcond1.therm1, therm2)
      annotation (points=[0, -54.1; 0, -84], style(color=45, thickness=2));
    connect(layer1.therm2, therm1)
      annotation (points=[0, 46; 0, 92], style(color=45, thickness=2));
    connect(pipereal1.therm1, layer1.therm3) annotation (points=[-40, -2; -18,
          -2; -18, 24], style(color=45, thickness=2));
  end HeatingFloor;

  model ZPUFHeating1
    extends Base.UFHeatingBase;
    Building.Elements.pipeconduction pipeconduction1(L=10)
      annotation (extent=[-50, 30; -30, 50], rotation=90);
    Building.Elements.pipeconduction pipeconduction2(L=120)
      annotation (extent=[26, 28; 46, 48], rotation=90);
    Building.Elements.heatcond heatcond1(lambda=0.004)
      annotation (extent=[2, 52; 22, 72]);
    Building.Layer.layerplus layer1
      annotation (extent=[26, 52; 46, 72], rotation=180);
    annotation (
      Coordsys(
        extent=[-122, -80; 90, 92],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-78, 60; 78, 0]),
        Line(points=[-56, 30; 60, 30]),
        Line(points=[40, 40; 60, 30; 40, 20]),
        Line(points=[-56, 48; 60, 48]),
        Line(points=[40, 58; 60, 48; 40, 38]),
        Rectangle(extent=[-80, 60; 80, 14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[-80, 58; -40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[0, 58; 40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[40, 58; 80, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-40, 58; 0, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-36, 52; -6, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[-74, 52; -44, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[4, 52; 34, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[44, 52; 74, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-80, 80; 80, 60], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 14; 80, -6], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -6; 80, -26], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Line(points=[-122, 62; -100, 62; -100, 42; -86, 42; -110, 42; -110, 62],
             style(color=1)),
        Rectangle(extent=[-80, -24; 80, -80], style(
            color=4,
            gradient=0,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[54, -60; 60, -36], style(
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[46, -56; 68, -76], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[-60, -26; -80, -44; -40, -44; -60, -26], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-68, -40; -52, -58], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[70, -50; 60, -50], style(color=0)),
        Line(points=[-32, -46; -32, -76], style(color=0)),
        Line(points=[-32, -58; 46, -58], style(color=0)),
        Line(points=[-32, -58; -26, -50; -16, -44; -4, -48; 4, -58; 12, -66; 22,
               -70; 32, -66; 40, -58], style(color=1, thickness=2)),
        Rectangle(extent=[54, -60; 60, -48], style(
            color=1,
            fillColor=1,
            fillPattern=1))),
      Window(
        x=0.25,
        y=0.09,
        width=0.6,
        height=0.87),
      Diagram);
    pipereal pipereal1(l=6) annotation (extent=[-70, -30; -10, 34]);
    radpipe radpipe1(l=120) annotation (extent=[18, -16; 58, 24]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-70, -76; -50, -56]);
    Controller.Conventional.Continuous.Relay Relay1(jp1=-0.5, jp2=0.5)
      annotation (extent=[-8, -72; 18, -46]);
    Modelica.Blocks.Sources.Constant Constant3(k={20})
      annotation (extent=[-68, -52; -52, -36]);
    Modelica.Blocks.Math.Feedback Feedback1
      annotation (extent=[-30, -66; -12, -50]);
    Building.Sources.sinustemp sinustemp1 annotation (extent=[-30, 30; -10, 50]);
    Building.Sources.sinustemp sinustemp2 annotation (extent=[-12, 30; 8, 50]);
  equation
    connect(radpipe1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[58, 6; 80, 6], style(thickness=4));
    connect(pipereal1.Hydraulic_Cut_Out, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-10, 6; 18, 6], style(thickness=4));
    connect(Hydraulic_Cut_In, pipereal1.Hydraulic_Cut_In)
      annotation (points=[-80, 6; -68, 6], style(thickness=4));
    connect(Feedback1.outPort, Relay1.In)
      annotation (points=[-12, -58; -8, -58]);
    connect(Constant3.outPort, Feedback1.inPort1)
      annotation (points=[-51.2, -44; -38, -44; -38, -58; -30, -58]);
    connect(Temperature_Sensor2_1.OutPort, Feedback1.inPort2)
      annotation (points=[-50, -70; -20, -70; -20, -66]);
    connect(Relay1.Out, OutPort) annotation (points=[16, -58; 82, -58]);
    connect(Relay1.Out, radpipe1.InPort)
      annotation (points=[16, -58; 38, -58; 38, -16]);
    connect(therm1, Temperature_Sensor2_1.therm1) annotation (points=[-50, 84;
          -72, 84; -72, -58; -59.4, -58], style(color=45, thickness=2));
    connect(heatcond1.therm2, layer1.therm2)
      annotation (points=[20, 62; 27, 62], style(color=45, thickness=2));
    connect(pipeconduction2.therm2, layer1.therm3)
      annotation (points=[36, 48; 36, 52], style(color=45, thickness=2));
    connect(sinustemp2.therm1, heatcond1.therm1) annotation (points=[-2, 50; -2,
           62; 4, 62], style(color=45, thickness=2));
    connect(pipeconduction1.therm2, sinustemp1.therm1)
      annotation (points=[-40, 50; -20, 50], style(color=45, thickness=2));
    connect(pipeconduction1.therm1, pipereal1.therm1)
      annotation (points=[-40, 30; -40, 18], style(color=45, thickness=2));
    connect(layer1.therm1, therm2) annotation (points=[46, 62; 50, 62; 50, 92],
         style(color=45, thickness=2));
    connect(radpipe1.therm1, pipeconduction2.therm1) annotation (points=[38, 22;
           38, 26; 36, 26; 36, 30], style(color=45, thickness=2));
  end ZPUFHeating1;

  model PIUFHeating1
    extends Base.UFHeatingBase;
    parameter Modelica.SIunits.ThermalConductivity lambdaFloor=2.4;
    parameter Modelica.SIunits.Density rhoFloor=1600;
    parameter Modelica.SIunits.SpecificHeatCapacity cFloor=1000;
    parameter Modelica.SIunits.Thickness dFloor=0.4;
    parameter Modelica.SIunits.Area AFloor=16 "Area of the wall";
    Building.Elements.pipeconduction pipeconduction1(
      Ri=0.1,
      Ra=0.12,
      lambda=1,
      L=10) annotation (extent=[-50, 30; -30, 50], rotation=90);
    Building.Elements.pipeconduction pipeconduction2(
      Ri=0.1,
      Ra=0.12,
      lambda=1,
      L=120) annotation (extent=[26, 30; 46, 50], rotation=90);
    Building.Elements.heatcond heatcond1(
      A=30,
      d=0.15,
      lambda=1) annotation (extent=[4, 52; 24, 72]);
    Building.Layer.layerplus layer1(
      lambdaFloor=lambdaFloor,
      rhoFloor=rhoFloor,
      cFloor=cFloor,
      dFloor=dFloor,
      AFloor=AFloor) annotation (extent=[26, 52; 46, 72], rotation=180);
    Building.Sources.sinustemp sinustemp1 annotation (extent=[-28, 30; -8, 50]);
    Building.Sources.sinustemp sinustemp2 annotation (extent=[-6, 30; 14, 50]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram,
      Icon(
        Rectangle(extent=[-80, 80; 80, 60], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 40; 80, -20]),
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-78, 60; 78, 0]),
        Line(points=[-56, 30; 60, 30]),
        Line(points=[40, 40; 60, 30; 40, 20]),
        Line(points=[-56, 48; 60, 48]),
        Line(points=[40, 58; 60, 48; 40, 38]),
        Rectangle(extent=[-80, 60; 80, 14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[-80, 58; -40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[0, 58; 40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[40, 58; 80, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-40, 58; 0, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-36, 52; -6, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[-74, 52; -44, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[4, 52; 34, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[44, 52; 74, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-80, 14; 80, -6], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -4; 80, -24], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -4; 80, -24], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -24; 80, -80], style(
            color=4,
            gradient=0,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[54, -60; 60, -36], style(
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[46, -56; 68, -76], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[-60, -26; -80, -44; -40, -44; -60, -26], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-68, -40; -52, -58], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[70, -50; 60, -50], style(color=0)),
        Line(points=[-32, -46; -32, -76], style(color=0)),
        Line(points=[-32, -58; 46, -58], style(color=0)),
        Line(points=[-32, -58; -26, -50; -16, -44; -4, -48; 4, -58; 12, -66; 22,
               -70; 32, -66; 40, -58], style(color=1, thickness=2)),
        Rectangle(extent=[54, -60; 60, -48], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-120, 32; -88, 72], string="PI")),
      Window(
        x=0.38,
        y=0.27,
        width=0.6,
        height=0.6));
    pipereal pipereal1(d=0.1, alpha=500) annotation (extent=[-70, -30; -10, 34]);
    radpipe radpipe1(
      l=120,
      d=0.1,
      alpha=500) annotation (extent=[18, -16; 58, 24]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-80, -60; -60, -40]);
    Modelica.Blocks.Sources.Constant Constant1(k={20})
      annotation (extent=[-30, -50; -10, -30]);
    Controller.Conventional.Continuous.Cont_PI Cont_PI1(
      Kp=10,
      Ki=1,
      umin=0) annotation (extent=[0, -60; 20, -40]);
  equation
    connect(pipereal1.Hydraulic_Cut_Out, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-10, 6; 18, 6]);
    connect(radpipe1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[58, 4; 80, 4]);
    connect(Hydraulic_Cut_In, pipereal1.Hydraulic_Cut_In)
      annotation (points=[-80, 6; -70, 6]);
    connect(Constant1.outPort, Cont_PI1.In)
      annotation (points=[-9, -40; 1, -40; 1, -49]);
    connect(Temperature_Sensor2_1.OutPort, Cont_PI1.Act)
      annotation (points=[-61, -53.2; -61, -56; 1, -56]);
    connect(Cont_PI1.Out, radpipe1.InPort)
      annotation (points=[20, -48; 38, -48; 38, -16]);
    connect(Cont_PI1.Out, OutPort) annotation (points=[18, -48; 80, -48]);
    connect(Temperature_Sensor2_1.therm1, therm1) annotation (points=[-69.4, -41;
           -69.4, 84; -50, 84; -50, 82], style(color=45, thickness=2));
    connect(heatcond1.therm2, layer1.therm2)
      annotation (points=[23, 62; 27, 62], style(color=45, thickness=2));
    connect(pipeconduction2.therm2, layer1.therm3)
      annotation (points=[36, 49; 36, 52], style(color=45, thickness=2));
    connect(layer1.therm1, therm2) annotation (points=[46, 62; 50, 62; 50, 82],
         style(color=45, thickness=2));
    connect(pipeconduction1.therm2, sinustemp1.therm1)
      annotation (points=[-40, 49; -19, 49], style(color=45, thickness=2));
    connect(pipeconduction1.therm1, pipereal1.therm1)
      annotation (points=[-40, 30; -40, 20], style(color=45, thickness=2));
    connect(pipeconduction2.therm1, radpipe1.therm1)
      annotation (points=[36, 30; 36, 20], style(color=45, thickness=2));
    connect(pipereal1.Hydraulic_Cut_Out, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-12, 6; 20, 6]);
    connect(sinustemp2.therm1, heatcond1.therm1)
      annotation (points=[4, 50; 4, 62], style(color=45, thickness=2));
  end PIUFHeating1;

  model PIdisUFHeating1
    extends Base.UFHeatingBase;
    Building.Elements.pipeconduction pipeconduction1
      annotation (extent=[-50, 30; -30, 50], rotation=90);
    Building.Elements.pipeconduction pipeconduction2
      annotation (extent=[26, 28; 46, 48], rotation=90);
    Building.Elements.heatcond heatcond1 annotation (extent=[2, 52; 22, 72]);
    Building.Layer.layerplus layer1
      annotation (extent=[26, 52; 46, 72], rotation=180);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram,
      Icon(
        Rectangle(extent=[-80, 80; 80, 60], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 40; 80, -20]),
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-78, 60; 78, 0]),
        Line(points=[-56, 30; 60, 30]),
        Line(points=[40, 40; 60, 30; 40, 20]),
        Line(points=[-56, 48; 60, 48]),
        Line(points=[40, 58; 60, 48; 40, 38]),
        Rectangle(extent=[-80, 60; 80, 14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[-80, 58; -40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[0, 58; 40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[40, 58; 80, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-40, 58; 0, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-36, 52; -6, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[-74, 52; -44, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[4, 52; 34, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[44, 52; 74, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-80, 14; 80, -6], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -4; 80, -24], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -4; 80, -24], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -24; 80, -80], style(
            color=4,
            gradient=0,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[54, -60; 60, -36], style(
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[46, -56; 68, -76], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[-60, -26; -80, -44; -40, -44; -60, -26], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-68, -40; -52, -58], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[70, -50; 60, -50], style(color=0)),
        Line(points=[-32, -46; -32, -76], style(color=0)),
        Line(points=[-32, -58; 46, -58], style(color=0)),
        Line(points=[-32, -58; -26, -50; -16, -44; -4, -48; 4, -58; 12, -66; 22,
               -70; 32, -66; 40, -58], style(color=1, thickness=2)),
        Rectangle(extent=[54, -60; 60, -48], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-120, 32; -88, 72], string="PI"),
        Text(extent=[-80, 94; 90, 54], string="discrete")),
      Window(
        x=0.1,
        y=0.26,
        width=0.6,
        height=0.6));
    pipereal pipereal1 annotation (extent=[-70, -30; -10, 34]);
    radpipe radpipe1 annotation (extent=[18, -16; 58, 24]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-64, -70; -44, -50]);
    Modelica.Blocks.Sources.Constant Constant1(k={20})
      annotation (extent=[-50, -50; -34, -34]);
    Controller.Conventional.Discrete.Dis_PI1 Dis_PI1_1
      annotation (extent=[-10, -66; 10, -46]);
    Modelica.Blocks.Sources.Constant Constant2(k={20})
      annotation (extent=[18, -36; 34, -20], rotation=180);
    Modelica.Blocks.Sources.BooleanStep BooleanStep1
      annotation (extent=[-28, -40; -12, -24]);
    Building.Sources.sinustemp sinustemp1 annotation (extent=[-30, 30; -10, 50]);
    Building.Sources.sinustemp sinustemp2 annotation (extent=[-6, 30; 14, 50]);
  equation
    connect(pipereal1.Hydraulic_Cut_Out, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-10, 6; 18, 6]);
    connect(radpipe1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[58, 4; 80, 4]);
    connect(Hydraulic_Cut_In, pipereal1.Hydraulic_Cut_In)
      annotation (points=[-80, 6; -70, 6]);
    connect(Constant1.outPort, Dis_PI1_1.In)
      annotation (points=[-33.2, -42; -16, -42; -16, -56.2; -9, -56.2]);
    connect(Dis_PI1_1.Out, OutPort) annotation (points=[10, -56; 84, -56]);
    connect(Dis_PI1_1.Out, radpipe1.InPort)
      annotation (points=[8, -56; 38, -56; 38, -12]);
    connect(Temperature_Sensor2_1.OutPort, Dis_PI1_1.Act) annotation (points=[-45,
           -63.2; -26, -63.2; -26, -74; 18, -74; 18, -60; 10, -60]);
    connect(Constant2.outPort, Dis_PI1_1.uhand)
      annotation (points=[18, -28; 4, -28; 4, -46]);
    connect(BooleanStep1.outPort, Dis_PI1_1.uL)
      annotation (points=[-11.2, -32; -4, -32; -4, -47], style(color=81));
    connect(therm1, Temperature_Sensor2_1.therm1) annotation (points=[-54, 84;
          -70, 84; -70, -52; -53.4, -52], style(color=45, thickness=2));
    connect(heatcond1.therm2, layer1.therm2)
      annotation (points=[20, 62; 27, 62], style(color=45, thickness=2));
    connect(pipeconduction2.therm2, layer1.therm3)
      annotation (points=[36, 48; 36, 52], style(color=45, thickness=2));
    connect(sinustemp1.therm1, pipeconduction1.therm2) annotation (points=[-20,
           49; -20, 50; -40, 50], style(color=45, thickness=2));
    connect(sinustemp2.therm1, heatcond1.therm1)
      annotation (points=[3, 50; 3, 62; 4, 62], style(color=45, thickness=2));
    connect(pipeconduction1.therm1, pipereal1.therm1)
      annotation (points=[-40, 30; -40, 20], style(color=45, thickness=2));
    connect(pipeconduction2.therm1, radpipe1.therm1)
      annotation (points=[36, 28; 36, 22], style(color=45, thickness=2));
    connect(layer1.therm1, therm2) annotation (points=[46, 62; 48, 62; 48, 92],
         style(color=45, thickness=2));
  end PIdisUFHeating1;

  model ZPUFHeating2
    extends Base.UFHeatingBase;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.32,
        y=0.13,
        width=0.6,
        height=0.6),
      Icon(
        Rectangle(extent=[-80, 80; 80, 60], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 40; 80, -20]),
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-78, 60; 78, 0]),
        Line(points=[-56, 30; 60, 30]),
        Line(points=[40, 40; 60, 30; 40, 20]),
        Line(points=[-56, 48; 60, 48]),
        Line(points=[40, 58; 60, 48; 40, 38]),
        Rectangle(extent=[-80, 60; 80, 14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[0, 58; 40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[40, 58; 80, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-40, 58; 0, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-36, 52; -6, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[4, 52; 34, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[44, 52; 74, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-80, 14; 80, -6], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -4; 80, -24], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -6; 80, -26], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -24; 80, -80], style(
            color=4,
            gradient=0,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[54, -60; 60, -36], style(
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[46, -56; 68, -76], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[-60, -26; -80, -44; -40, -44; -60, -26], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-68, -40; -52, -58], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[70, -50; 60, -50], style(color=0)),
        Line(points=[-32, -46; -32, -76], style(color=0)),
        Line(points=[-32, -58; 46, -58], style(color=0)),
        Line(points=[-32, -58; -26, -50; -16, -44; -4, -48; 4, -58; 12, -66; 22,
               -70; 32, -66; 40, -58], style(color=1, thickness=2)),
        Rectangle(extent=[54, -60; 60, -48], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-122, 62; -100, 62; -100, 42; -86, 42; -110, 42; -110, 62],
             style(color=1)),
        Rectangle(extent=[-80, 60; -42, 14], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-76, 28; -48, 46; -48, 28; -76, 46; -76, 28], style(
              fillColor=2, fillPattern=1))));
    Valve Valve1 annotation (extent=[-36, 42; -2, 78], rotation=180);
    HeatingFloor HeatingFloor1 annotation (extent=[10, 44; 36, 70]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-66, -60; -46, -40]);
    Controller.Conventional.Continuous.Relay Relay1
      annotation (extent=[-28, -72; 2, -40]);
    Building.Sources.sinustemp sinustemp1 annotation (extent=[52, 42; 72, 62]);
  equation
    connect(Valve1.Hydraulic_Cut_In, HeatingFloor1.Hydraulic_Cut_In)
      annotation (points=[-2, 58; 5, 58; 5, 62; 12, 62]);
    connect(HeatingFloor1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[10, 52; 4, 52; 4, 30; 76, 30; 76, 10; 82, 10]);
    connect(Hydraulic_Cut_In, Valve1.Hydraulic_Cut_Out)
      annotation (points=[-80, 10; -52, 10; -52, 58; -36, 58]);
    connect(Relay1.Out, OutPort) annotation (points=[0, -54; 80, -54]);
    connect(Relay1.Out, Valve1.In)
      annotation (points=[0, -54; 14, -54; 14, -22; -8, -22; -8, 44.16]);
    connect(HeatingFloor1.therm1, therm2)
      annotation (points=[24, 68; 24, 88; 44, 88]);
    connect(HeatingFloor1.therm2, sinustemp1.therm1) annotation (points=[24, 46;
           42.5, 46; 42.5, 62; 61, 62], style(color=45));
    connect(Temperature_Sensor2_1.therm1, therm1) annotation (points=[-56, -41;
           -70, -41; -70, 92; -54, 92], style(color=45, thickness=2));
    connect(Temperature_Sensor2_1.OutPort, Relay1.In)
      annotation (points=[-46, -54; -26, -54]);
  end ZPUFHeating2;

  model PIUFHeating2
    extends Base.UFHeatingBase;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-80, 40; 80, -20]), Rectangle(extent=[-80, 80;
              80, -80])),
      Icon(
        Rectangle(extent=[-80, 40; 80, -20]),
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-80, 80; 80, -80]),
        Rectangle(extent=[-80, 80; 80, 60], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 40; 80, -20]),
        Polygon(points=[-66, 20; 32, 20; 32, 34; 74, 10; 32, -14; 32, 0; -66, 0;
               -66, 18; -66, 20]),
        Rectangle(extent=[-78, 60; 78, 0]),
        Line(points=[-56, 30; 60, 30]),
        Line(points=[40, 40; 60, 30; 40, 20]),
        Line(points=[-56, 48; 60, 48]),
        Line(points=[40, 58; 60, 48; 40, 38]),
        Rectangle(extent=[-80, 60; 80, 14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[0, 58; 40, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[40, 58; 80, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-40, 58; 0, 18], style(
            color=8,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-36, 52; -6, 22], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Ellipse(extent=[4, 52; 34, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[44, 52; 74, 22], style(
            color=1,
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-80, 14; 80, -6], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -4; 80, -24], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -6; 80, -26], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, -24; 80, -80], style(
            color=4,
            gradient=0,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[54, -60; 60, -36], style(
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[46, -56; 68, -76], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[-60, -26; -80, -44; -40, -44; -60, -26], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-68, -40; -52, -58], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[70, -50; 60, -50], style(color=0)),
        Line(points=[-32, -46; -32, -76], style(color=0)),
        Line(points=[-32, -58; 46, -58], style(color=0)),
        Line(points=[-32, -58; -26, -50; -16, -44; -4, -48; 4, -58; 12, -66; 22,
               -70; 32, -66; 40, -58], style(color=1, thickness=2)),
        Rectangle(extent=[54, -60; 60, -48], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-80, 60; -42, 14], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-76, 28; -48, 46; -48, 28; -76, 46; -76, 28], style(
              fillColor=2, fillPattern=1)),
        Text(extent=[-120, 32; -88, 72], string="PI")),
      Window(
        x=0.25,
        y=0.35,
        width=0.6,
        height=0.6));
    Valve Valve1 annotation (extent=[-36, 42; -2, 78], rotation=180);
    HeatingFloor HeatingFloor1 annotation (extent=[10, 44; 36, 70]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-66, -60; -46, -40]);
    Modelica.Blocks.Sources.Constant Constant1(k={20})
      annotation (extent=[-42, -46; -22, -26]);
    Controller.Conventional.Continuous.Cont_PI Cont_PI1
      annotation (extent=[2, -58; 22, -38]);
    Building.Sources.sinustemp sinustemp1 annotation (extent=[52, 40; 72, 60]);
  equation
    connect(Valve1.Hydraulic_Cut_In, HeatingFloor1.Hydraulic_Cut_In)
      annotation (points=[-2, 58; 5, 58; 5, 62; 12, 62]);
    connect(Hydraulic_Cut_In, Valve1.Hydraulic_Cut_Out)
      annotation (points=[-82, 8; -52, 8; -52, 58; -36, 58]);
    connect(HeatingFloor1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[10, 52; 4, 52; 4, 30; 76, 30; 76, 10; 82, 10]);
    connect(Temperature_Sensor2_1.OutPort, Cont_PI1.Act)
      annotation (points=[-46, -53.2; 4, -53]);
    connect(Constant1.outPort, Cont_PI1.In)
      annotation (points=[-21, -36; -9, -36; -9, -47; 3, -47]);
    connect(Cont_PI1.Out, OutPort) annotation (points=[22, -48; 80, -48]);
    connect(Temperature_Sensor2_1.therm1, therm1)
      annotation (points=[-56, -42; -56, 84], style(color=45, thickness=2));
    connect(HeatingFloor1.therm2, sinustemp1.therm1) annotation (points=[22, 44;
           42, 44; 42, 58; 62, 58], style(color=45, thickness=2));
    connect(HeatingFloor1.therm1, therm2) annotation (points=[22, 70; 22, 92;
          50, 92], style(color=45, thickness=2));
    connect(Valve1.In, Cont_PI1.Out)
      annotation (points=[-9.14, 44.16; -9.14, -10; 22, -10; 22, -48]);
  end PIUFHeating2;

  model ZPRadHeating
    extends Base.TwoConnection;
    Building.Elements.heattrans heattrans1 annotation (extent=[-40, 44; -2, 82]);
    Building.Elements.radiatorload radiatorload1
      annotation (extent=[8, 40; 52, 80]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Polygon(points=[-62, 60; -30, 60; -46, 80; -62, 60], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; 80, -100], style(
            color=7,
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-66, -58; 100, -80], style(
            gradient=2,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-100, 40; 60, 20], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-10, 60; 10, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 60; -20, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[50, 60; 70, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[20, 60; 40, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 0; 100, -58], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[80, -58; 100, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-54, -12; 26, -30], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[26, -2; 26, -42; 68, -22; 26, -2], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-68, 22; -48, -76], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-68, -58; -48, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[-74, 44; -44, 14], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-68, 36; -50, 22], style(color=0)),
        Rectangle(extent=[-100, 40; -80, 20], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-104, -10; -86, -10; -86, -28; -76, -28], style(color=1)),
        Line(points=[-86, -28; -96, -28; -96, -10], style(color=1))),
      Window(
        x=0.3,
        y=0.15,
        width=0.6,
        height=0.6),
      Documentation(info="equation
  Hydraulic_Cut_Out.q = -Hydraulic_Cut_In.q;
"));

    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-60, -78; -42, -60]);
    Controller.Conventional.Continuous.Relay Relay1(jp1=-0.25, jp2=0.25)
      annotation (extent=[16, -64; 36, -44]);
    Modelica.Blocks.Sources.Constant Constant1(k={20})
      annotation (extent=[-40, -60; -24, -44]);
    Modelica.Blocks.Math.Feedback Feedback1
      annotation (extent=[-8, -64; 12, -44]);
    radpipe radpipe1 annotation (extent=[24, -18; 70, 32]);
    Interfaces.therm therm1 annotation (extent=[-62, 72; -42, 92]);
  equation
    connect(Feedback1.outPort, Relay1.In)
      annotation (points=[11, -54; 17, -54]);
    connect(Constant1.outPort, Feedback1.inPort1)
      annotation (points=[-23.2, -52; -25.2, -54; -8, -54]);
    connect(Temperature_Sensor2_1.OutPort, Feedback1.inPort2)
      annotation (points=[-42.9, -71.88; 2, -71.88; 2, -64]);
    connect(Hydraulic_Cut_In, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-80, 10; 26.3, 9.5], style(color=41, thickness=4));
    connect(radpipe1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[67.9, 9.5; 80, 10], style(thickness=4));
    connect(Relay1.Out, radpipe1.InPort)
      annotation (points=[35, -54; 47, -54; 47, -15.5]);
    connect(heattrans1.therm2, radiatorload1.therm1)
      annotation (points=[-2, 64; 6, 64; 6, 88; 28, 88; 28, 78]);
    connect(radpipe1.therm1, radiatorload1.therm1)
      annotation (points=[46.24, 29.5; 72, 46; 72, 88; 28, 88; 28, 80]);
    connect(heattrans1.therm1, therm1)
      annotation (points=[-40, 62; -50, 62; -50, 82]);
    connect(Temperature_Sensor2_1.therm1, therm1)
      annotation (points=[-50, -60; -50, 80]);
  end ZPRadHeating;

  model PIRadHeating
    extends Base.TwoConnection;
    Building.Elements.radiatorload radiatorload1
      annotation (extent=[8, 40; 52, 80]);
    Building.Elements.heattrans heattrans1 annotation (extent=[-40, 44; -2, 82]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Polygon(points=[-64, 60; -32, 60; -48, 80; -64, 60], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; 80, -100], style(
            color=7,
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-66, -58; 100, -80], style(
            gradient=2,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-100, 40; 60, 20], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-10, 60; 10, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 60; -20, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[50, 60; 70, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[20, 60; 40, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 0; 100, -58], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[80, -58; 100, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-54, -12; 26, -30], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[26, -2; 26, -42; 68, -22; 26, -2], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-68, 22; -48, -76], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-68, -58; -48, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[-74, 44; -44, 14], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-68, 36; -50, 22], style(color=0)),
        Rectangle(extent=[-100, 40; -80, 20], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-110, -46; -78, -6], string="PI")),
      Window(
        x=0.09,
        y=0.01,
        width=0.6,
        height=0.6));
    radpipe radpipe1 annotation (extent=[24, -16; 70, 30]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-60, -64; -40, -44]);
    Modelica.Blocks.Sources.Constant Constant1(k={20})
      annotation (extent=[-36, -50; -16, -30]);
    Controller.Conventional.Continuous.Cont_PI Cont_PI1
      annotation (extent=[4, -62; 24, -42]);
    Interfaces.therm therm1 annotation (extent=[-58, 80; -38, 100]);
  equation
    connect(Hydraulic_Cut_In, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-80, 10; 26, 10], style(color=41, thickness=4));
    connect(radpipe1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[68, 10; 80, 10], style(thickness=4));
    connect(Temperature_Sensor2_1.OutPort, Cont_PI1.Act)
      annotation (points=[-40, -57.2; 4, -57]);
    connect(Constant1.outPort, Cont_PI1.In)
      annotation (points=[-15, -40; -2, -40; -2, -50; 4, -50]);
    connect(Cont_PI1.Out, radpipe1.InPort)
      annotation (points=[22, -52; 46, -52; 46, -14]);
    connect(Temperature_Sensor2_1.therm1, therm1)
      annotation (points=[-50, -45; -50, 82]);
    connect(heattrans1.therm1, therm1)
      annotation (points=[-38.1, 63; -50, 63; -50, 94]);
    connect(radpipe1.therm1, radiatorload1.therm1)
      annotation (points=[48, 30; 72, 46; 72, 88; 28, 88; 28, 80]);
    connect(heattrans1.therm2, radiatorload1.therm1)
      annotation (points=[-2, 64; 6, 64; 6, 88; 28, 88; 28, 78]);
  end PIRadHeating;

  model PIdisRadHeating
    extends Base.TwoConnection;
    Building.Elements.radiatorload radiatorload1
      annotation (extent=[8, 40; 52, 80]);
    Building.Elements.heattrans heattrans1 annotation (extent=[-40, 44; -2, 82]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Polygon(points=[-64, 60; -32, 60; -48, 80; -64, 60], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; 80, -100], style(
            color=7,
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-66, -58; 100, -80], style(
            gradient=2,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-100, 40; 60, 20], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-10, 60; 10, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 60; -20, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[50, 60; 70, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[20, 60; 40, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 0; 100, -58], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[80, -58; 100, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-54, -12; 26, -30], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[26, -2; 26, -42; 68, -22; 26, -2], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-68, 22; -48, -76], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-68, -58; -48, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[-74, 44; -44, 14], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-68, 36; -50, 22], style(color=0)),
        Rectangle(extent=[-100, 40; -80, 20], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-110, -46; -78, -6], string="PI"),
        Text(extent=[-60, 94; 110, 54], string="discrete")),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
    radpipe radpipe1 annotation (extent=[24, -16; 70, 30]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-60, -84; -40, -64]);
    Modelica.Blocks.Sources.Constant Constant1(k={20})
      annotation (extent=[-42, -52; -26, -36]);
    Modelica.Blocks.Sources.BooleanStep BooleanStep1
      annotation (extent=[-14, -40; 2, -24]);
    Modelica.Blocks.Sources.Constant Constant2(k={20})
      annotation (extent=[18, -40; 34, -24], rotation=180);
    Controller.Conventional.Discrete.Dis_PI1 Dis_PI1_1
      annotation (extent=[0, -68; 20, -48]);
    Interfaces.therm therm1 annotation (extent=[-60, 78; -40, 98]);
  equation
    connect(Hydraulic_Cut_In, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-80, 10; 26, 10], style(color=41, thickness=4));
    connect(radpipe1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[68, 10; 80, 10], style(thickness=4));
    connect(BooleanStep1.outPort, Dis_PI1_1.uL)
      annotation (points=[2, -32; 6, -32; 6, -48], style(color=81));
    connect(Constant2.outPort, Dis_PI1_1.uhand)
      annotation (points=[18, -32; 14, -32; 14, -48]);
    connect(Temperature_Sensor2_1.OutPort, Dis_PI1_1.Act)
      annotation (points=[-42, -77.2; 28, -77.2; 28, -64; 20, -64]);
    connect(Constant1.outPort, Dis_PI1_1.In)
      annotation (points=[-26, -44; -20, -44; -20, -58; 0, -58]);
    connect(Dis_PI1_1.Out, radpipe1.InPort)
      annotation (points=[18, -58; 48, -58; 48, -16]);
    connect(Temperature_Sensor2_1.therm1, therm1)
      annotation (points=[-49.8, -65; -50, 88]);
    connect(heattrans1.therm1, therm1)
      annotation (points=[-40, 62; -50, 62; -50, 82]);
    connect(radpipe1.therm1, radiatorload1.therm1)
      annotation (points=[48, 30; 72, 46; 72, 88; 28, 88; 28, 80]);
    connect(heattrans1.therm2, radiatorload1.therm1)
      annotation (points=[-2, 64; 6, 64; 6, 88; 28, 88; 28, 78]);
  end PIdisRadHeating;

  model PIRadHeating2
    extends Base.TwoConnection;
    Building.Elements.radiatorload radiatorload1
      annotation (extent=[8, 40; 52, 80]);
    Building.Elements.heattrans heattrans1 annotation (extent=[-40, 44; -2, 82]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Polygon(points=[-62, 60; -30, 60; -46, 80; -62, 60], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-78, 40; 78, -20]),
        Line(points=[-56, 10; 60, 10]),
        Line(points=[40, 20; 60, 10; 40, 0]),
        Rectangle(extent=[-80, 60; 80, -100], style(
            color=7,
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-66, -58; 100, -80], style(
            gradient=2,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-100, 40; 60, 20], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-10, 60; 10, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 60; -20, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[50, 60; 70, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[20, 60; 40, -100], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[80, 0; 100, -58], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[80, -58; 100, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-54, -12; 26, -30], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Polygon(points=[26, -2; 26, -42; 68, -22; 26, -2], style(
            color=4,
            fillColor=4,
            fillPattern=1)),
        Rectangle(extent=[-68, 22; -48, -76], style(
            gradient=1,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-68, -58; -48, -80], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Ellipse(extent=[-74, 44; -44, 14], style(
            color=0,
            fillColor=2,
            fillPattern=1)),
        Line(points=[-68, 36; -50, 22], style(color=0)),
        Rectangle(extent=[-100, 40; -80, 20], style(
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-110, -46; -78, -6], string="PI")),
      Window(
        x=0.36,
        y=0.3,
        width=0.6,
        height=0.6));
    radpipe radpipe1 annotation (extent=[24, -16; 70, 30]);
    Temperature_Sensor2 Temperature_Sensor2_1
      annotation (extent=[-62, -64; -40, -42]);
    Modelica.Blocks.Sources.Constant Constant1(k={20})
      annotation (extent=[-40, -42; -20, -22]);
    ValveDriver ValveDriver1 annotation (extent=[16, -70; 52, -30]);
    Controller.Conventional.Continuous.Cont_PI Cont_PI1
      annotation (extent=[-12, -58; 8, -38]);
    Interfaces.therm therm1 annotation (extent=[-60, 78; -40, 98]);
  equation
    connect(Hydraulic_Cut_In, radpipe1.Hydraulic_Cut_In)
      annotation (points=[-80, 10; 26, 10], style(color=41, thickness=4));
    connect(radpipe1.Hydraulic_Cut_Out, Hydraulic_Cut_Out)
      annotation (points=[68, 10; 80, 10], style(thickness=4));
    connect(ValveDriver1.OutPort, radpipe1.InPort)
      annotation (points=[52, -50; 62, -50; 62, -32; 48, -32; 48, -16]);
    connect(Cont_PI1.Out, ValveDriver1.InPort)
      annotation (points=[8, -46; 18, -48]);
    connect(Temperature_Sensor2_1.OutPort, Cont_PI1.Act)
      annotation (points=[-40, -56; -11, -54]);
    connect(Constant1.outPort, Cont_PI1.In)
      annotation (points=[-20, -32; -10, -46]);
    connect(Temperature_Sensor2_1.therm1, therm1)
      annotation (points=[-50, -43; -50, 82]);
    connect(heattrans1.therm1, therm1)
      annotation (points=[-40, 62; -50, 62; -50, 82]);
    connect(radpipe1.therm1, radiatorload1.therm1)
      annotation (points=[48, 30; 72, 46; 72, 88; 28, 88; 28, 80]);
    connect(heattrans1.therm2, radiatorload1.therm1)
      annotation (points=[-2, 64; 6, 64; 6, 88; 28, 88; 28, 78]);
  end PIRadHeating2;

  model UnheatedCellar
    Building.Elements.heatcond heatcond2 annotation (extent=[20, 20; 40, 40]);
    Building.Elements.heatcond heatcond3 annotation (extent=[-40, 20; -20, 40]);
    Building.Elements.load load1 annotation (extent=[-10, 0; 12, 20]);
    Building.Elements.heatcond heatcond1
      annotation (extent=[40, -20; 60, 0], rotation=90);
    Building.therm therm1 annotation (extent=[-10, 78; 10, 98]);
    Building.Sources.sinustemp sinustemp1 annotation (extent=[40, -58; 60, -38]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
        Rectangle(extent=[-80, 80; 80, 60], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 60; 80, 40], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-80, 40; 80, 20], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-80, 20; 80, -2], style(
            gradient=2,
            fillColor=6,
            fillPattern=1)),
        Line(points=[-66, -8; -66, -64], style(color=0)),
        Rectangle(extent=[-80, -2; 80, -80], style(pattern=0, fillColor=66)),
        Rectangle(extent=[44, -40; 56, -10], style(
            gradient=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[32, -38; 68, -72], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[6, -4; -14, -22; 26, -22; 6, -4], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-2, -22; 14, -40], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[64, -30; 54, -30], style(color=0)),
        Line(points=[-70, -18; -70, -78], style(color=0)),
        Line(points=[-76, -52; 26, -52], style(color=0)),
        Line(points=[-70, -52; -64, -44; -54, -38; -42, -42; -34, -52; -26, -60;
               -16, -64; -6, -60; 2, -52], style(color=1, thickness=2)),
        Rectangle(extent=[44, -56; 56, -22], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Line(points=[64, -34; 54, -34], style(color=0)),
        Line(points=[64, -26; 54, -26], style(color=0))),
      Diagram(Rectangle(extent=[-80, 80; 80, -80])),
      Window(
        x=0.16,
        y=0.17,
        width=0.78,
        height=0.6));
  equation
    connect(sinustemp1.therm1, heatcond1.therm1)
      annotation (points=[50, -40; 50, -20]);
    connect(heatcond1.therm2, heatcond2.therm2)
      annotation (points=[50, 0; 50, 30; 38, 30]);
    connect(heatcond2.therm1, heatcond3.therm2)
      annotation (points=[20, 30; -22, 30]);
    connect(heatcond2.therm1, load1.therm1)
      annotation (points=[20, 30; 0, 30; 0, 18]);
    connect(heatcond3.therm1, therm1)
      annotation (points=[-40, 30; -50, 30; -50, 60; 0, 60; 0, 80]);
  end UnheatedCellar;
  annotation (Coordsys(
      extent=[0, 0; 442, 394],
      grid=[2, 2],
      component=[20, 20]), Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65,
      library=1,
      autolayout=1));
end Standard;

