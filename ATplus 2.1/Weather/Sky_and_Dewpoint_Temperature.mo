package Sky_and_Dewpoint_Temperature
  import Modelica.Math.*;
  package SIunits = Modelica.SIunits;
  package Constants = Modelica.Constants;
  extends ATplus.Icons.Package;

  class DewPointTemp "calculate dew point temperature"
    Real Ta;
    Real Ts;
    Real Pw;
    Real Ps;
    Real phi;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-81, 80; 79, -80], style(color=0, fillColor=7))),
      Window(
        x=0.24,
        y=0.09,
        width=0.72,
        height=0.75),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=68)),
        Ellipse(extent=[-65, 66; -58, 59], style(color=7, fillColor=7)),
        Ellipse(extent=[-35, 52; -28, 45], style(color=7, fillColor=7)),
        Ellipse(extent=[14, 63; 21, 56], style(color=7, fillColor=7)),
        Ellipse(extent=[43, 8; 50, 1], style(color=7, fillColor=7)),
        Ellipse(extent=[52, 66; 59, 59], style(color=7, fillColor=7)),
        Ellipse(extent=[-26, 73; -19, 66], style(color=7, fillColor=7)),
        Ellipse(extent=[5, 29; 12, 22], style(color=7, fillColor=7)),
        Ellipse(extent=[19, 4; 26, -3], style(color=7, fillColor=7)),
        Ellipse(extent=[65, 19; 72, 12], style(color=7, fillColor=7)),
        Ellipse(extent=[58, -8; 65, -15], style(color=7, fillColor=7)),
        Ellipse(extent=[-5, 4; 2, -3], style(color=7, fillColor=7)),
        Ellipse(extent=[29, -30; 36, -37], style(color=7, fillColor=7)),
        Ellipse(extent=[55, -33; 62, -40], style(color=7, fillColor=7)),
        Ellipse(extent=[58, -59; 65, -66], style(color=7, fillColor=7)),
        Ellipse(extent=[17, -56; 24, -63], style(color=7, fillColor=7)),
        Ellipse(extent=[-11, -59; -4, -66], style(color=7, fillColor=7)),
        Ellipse(extent=[-54, -60; -47, -67], style(color=7, fillColor=7)),
        Ellipse(extent=[-41, -34; -34, -41], style(color=7, fillColor=7)),
        Ellipse(extent=[-9, -31; -2, -38], style(color=7, fillColor=7)),
        Ellipse(extent=[-33, -3; -26, -10], style(color=7, fillColor=7)),
        Ellipse(extent=[-34, 21; -27, 14], style(color=7, fillColor=7)),
        Ellipse(extent=[-67, 33; -60, 26], style(color=7, fillColor=7)),
        Ellipse(extent=[-67, 3; -60, -4], style(color=7, fillColor=7)),
        Ellipse(extent=[-68, -22; -61, -29], style(color=7, fillColor=7)),
        Text(
          extent=[-80, 80; 80, -3],
          string="Dew",
          style(color=0, fillColor=67)),
        Text(
          extent=[-80, 4; 81, -80],
          string="Point",
          style(color=0, fillColor=0)),
        Text(
          extent=[-117, -60; -83, -104],
          style(
            color=0,
            fillColor=0,
            fillPattern=1),
          string="/"),
        Text(
          extent=[-106, -78; -81, -105],
          style(
            color=0,
            fillColor=0,
            fillPattern=1),
          string="o"),
        Text(
          extent=[-123, -53; -87, -80],
          style(
            color=0,
            fillColor=0,
            fillPattern=1),
          string="o")));

    Modelica.Blocks.Interfaces.InPort relhum
      annotation (extent=[-100, -60; -80, -40], layer="icon");
    Modelica.Blocks.Interfaces.InPort Tamb
      annotation (extent=[-100, 40; -80, 60], layer="icon");
    Modelica.Blocks.Interfaces.OutPort OutPort
      annotation (extent=[80, -10; 100, 10], layer="icon");
  equation
    //Pressure of saturated air
    Ta = Tamb.signal[1];
    Ps = if (Ta >= 0 and Ta <= 100) then 611*exp(1.91275/10^4 + 7.258/10^2*Ta
       - 2.939/10^4*Ta^2 + 9.841/10^7*Ta^3 - 1.92/10^9*Ta^4) else 611*exp(-4.909965
      /10^4 + 8.183197/10^2*Ta - 5.552967/10^4*Ta^2 - 2.228376/10^5*Ta^3 -
      6.211808/10^7*Ta^4);

    //Tsaturated or wet bulb temperature
    phi = relhum.signal[1]/100;

    Pw = phi*Ps;
    Ts = -63.16113 + 5.36859*log(Pw) + 0.973587*(log(Pw))^2 - 0.0738636*(log(Pw))
      ^3 + 0.00481832*(log(Pw))^4;
    OutPort.signal[1] = Ts;
  end DewPointTemp;

  class skytemperatur "calculate fictive sky temperature"
    parameter SIunits.Height h=20 "the height of the place";
    constant SIunits.Pressure Po=1013;
    Real Ccov;
    Real Cc;
    Real Itotal;
    Real Tsa;
    Real Tsky;
    Real Epso;
    Real Eps;
    Real Patm;
    constant Real konstanta=8005;
    constant Real pi=2*Modelica.Math.asin(1.0);
    Real help(start=0.5);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
      Window(
        x=0.29,
        y=0.19,
        width=0.69,
        height=0.7),
      Icon(
        Rectangle(extent=[-80, 80; 80, -84], style(color=0, fillColor=68)),
        Polygon(points=[16, -40; 64, -40; 40, -16; 16, -40], style(color=0,
              fillColor=43)),
        Rectangle(extent=[26, -40; 56, -70], style(color=0, fillColor=43)),
        Rectangle(extent=[36, -54; 48, -70], style(color=0, fillColor=49)),
        Polygon(points=[-80, -36; -80, 80; 80, 80; 80, -14; 62, 10; 48, 24; 36,
               26; 14, 14; -2, 22; -16, 16; -26, -12; -44, 0; -60, -2; -72, -16;
               -80, -36], style(color=69, fillColor=69)),
        Text(
          extent=[0, 84; 0, 14],
          string="sky",
          style(color=7))));
    Modelica.Blocks.Interfaces.InPort Tdb "Dry bulb temperature"
      annotation (extent=[-100, -30; -80, -10]);
    Modelica.Blocks.Interfaces.InPort Tdp "Dew Point temperature"
      annotation (extent=[-100, -68; -80, -48]);
    t_and_sl_rad.CUTS.ic_beam_rad ic_beam_rad1
      annotation (extent=[-100, 50; -80, 70]);
    t_and_sl_rad.CUTS.ic_diff_rad ic_diff_rad1
      annotation (extent=[-100, 10; -80, 30]);
    Modelica.Blocks.Interfaces.OutPort OutPort
      annotation (extent=[80, -10; 100, 10]);
  algorithm
    //Solidity ratio of the sky
    help := if noEvent(Itotal < 41.67) then help else ((1.4286*ic_diff_rad1.I/
      Itotal) - 0.3);
  equation
    Tsa = Tdp.signal[1];
    Itotal = ic_diff_rad1.I + ic_beam_rad1.I;

    Cc = if noEvent(help < 0) then 0.001^0.5 else help^0.5;
    Ccov = if noEvent(Cc > 1) then 1 else Cc;
    Patm = Po*exp(-h/konstanta);

    //Emissionsgrad des klaren Himmels
    Epso = 0.711 + 0.0056*Tsa + 0.000073*Tsa^2 + 0.013*cos(2*pi*time/86400) + (
      Patm - Po)*12/10^5;
    Eps = Epso + (1 - Epso)*Ccov*0.8;

    //Sky Temperature
    Tsky = ((Tdb.signal[1] + 273.15)*Eps^0.25) - 273.15;
    OutPort.signal[1] = Tsky;
  end skytemperatur;

  class Tfsky
    "calculate environment temperatur for long wave radiation between building and environment"

    parameter Real Fsky=0.5;
    Real Tfsky;
    therm therm1 annotation (extent=[80, -10; 100, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-80, 80; 80, -80])),
      Icon(Rectangle(extent=[-80, 80; 80, -80], style(
            color=0,
            gradient=2,
            fillColor=71)), Text(
          extent=[-4, 44; -4, -38],
          string="Tfsky",
          style(color=0))),
      Window(
        x=0.15,
        y=0.03,
        width=0.6,
        height=0.6));
    Modelica.Blocks.Interfaces.InPort Tdb
      annotation (extent=[-100, 30; -80, 50]);
    Modelica.Blocks.Interfaces.InPort Tsky
      annotation (extent=[-100, -50; -80, -30]);
  equation
    Tfsky = (1 - Fsky)*Tdb.signal[1] + Fsky*Tsky.signal[1];
    therm1.T = Tfsky;
  end Tfsky;
  annotation (
    Coordsys(
      extent=[0, 0; 442, 394],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65,
      library=1,
      autolayout=1),
    Icon(
      Rectangle(extent=[-100, 50; 80, -100], style(gradient=2, fillColor=74)),
      Ellipse(extent=[-114, 104; -114, 104], style(fillColor=74, fillPattern=1)),
      Polygon(points=[-32, 0; -22, -18; -12, 0; -32, 0], style(fillColor=7,
            fillPattern=1)),
      Polygon(points=[-20, 6; -32, -12; -12, -12; -20, 6], style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[14.1, -36.3; 2.1, -54.3; 22.1, -54.3; 14.1, -36.3], style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[2.1, -40.3; 12.1, -58.3; 22.1, -40.3; 2.1, -40.3], style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[8.1, -6.3; -3.9, -24.3; 16.1, -24.3; 8.1, -6.3], style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[-3.9, -12.3; 6.1, -30.3; 16.1, -12.3; -3.9, -12.3], style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[58.1, -8.3; 46.1, -26.3; 66.1, -26.3; 58.1, -8.3], style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[46.1, -12.3; 56.1, -30.3; 66.1, -12.3; 46.1, -12.3],
          style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[52.1, -38.3; 40.1, -56.3; 60.1, -56.3; 52.1, -38.3],
          style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[40.1, -44.3; 50.1, -62.3; 60.1, -44.3; 40.1, -44.3],
          style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[-67.9, -4.3; -57.9, -22.3; -47.9, -4.3; -67.9, -4.3],
          style(fillColor=7, fillPattern=1)),
      Polygon(points=[-89.9, -24.3; -79.9, -42.3; -69.9, -24.3; -89.9, -24.3],
          style(fillColor=7, fillPattern=1)),
      Polygon(points=[-77.9, -20.3; -89.9, -38.3; -70, -38; -77.9, -20.3],
          style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Polygon(points=[-55.9, -0.3; -67.9, -18.3; -47.9, -18.3; -55.9, -0.3],
          style(
          color=7,
          fillColor=7,
          fillPattern=1)),
      Ellipse(extent=[-100, -96; -100, -100], style(
          color=7,
          gradient=2,
          fillColor=7))));

  model Examplesky

    annotation (Diagram(Polygon(points=[-10, 16; -22, -2; -2, -2; -10, 16],
            style(
            color=7,
            fillColor=7,
            fillPattern=1))), Icon(
        Rectangle(extent=[-70, 90; 90, -74], style(color=0, fillColor=68)),
        Polygon(points=[26, -30; 74, -30; 50, -6; 26, -30], style(color=0,
              fillColor=43)),
        Rectangle(extent=[36, -30; 66, -60], style(color=0, fillColor=43)),
        Rectangle(extent=[46, -44; 58, -60], style(color=0, fillColor=49)),
        Polygon(points=[-70, -26; -70, 90; 90, 90; 90, -4; 72, 20; 58, 34; 46,
              36; 24, 24; 8, 32; -6, 26; -16, -2; -34, 10; -50, 8; -62, -6; -70,
               -26], style(color=69, fillColor=69)),
        Text(
          extent=[10, 94; 10, 24],
          string="sky",
          style(color=7))));
    DewPointTemp DewPointTemp1 annotation (extent=[-80, -8; -60, 12]);
    skytemperatur skytemperatur1 annotation (extent=[-34, 0; -14, 20]);
    Tfsky Tfsky1 annotation (extent=[12, 6; 32, 26]);
    ModelicaAdditions.Tables.CombiTableTime HumidityTable(
      tableName="humid",
      fileName="humid.txt",
      table=[0, 0; 1440, 1]) annotation (extent=[-100, -8; -84, 4]);
    ATplus.Weather.Sky_and_Dewpoint_Temperature.therm therm1
      annotation (extent=[94, 6; 114, 26]);
  protected
    ATplus.Weather.t_and_sl_rad.CUTS.ic_beam_rad ic_beam_rad1
      annotation (extent=[-126, 48; -101, 63]);
  protected
    ATplus.Weather.t_and_sl_rad.CUTS.ic_diff_rad ic_diff_rad1
      annotation (extent=[-124, 24; -99, 45]);
  protected
    Modelica.Blocks.Interfaces.InPort Tdb1
      annotation (extent=[-112, 70; -88, 92]);
  equation
    connect(skytemperatur1.OutPort, Tfsky1.Tsky) annotation (points=[-16, 10; -2,
           10; -2, 12; 12, 12], style(
        color=3,
        gradient=2,
        fillColor=7));
    connect(HumidityTable.outPort, DewPointTemp1.relhum)
      annotation (points=[-83.2, -2; -79, -3], style(color=61));
    connect(DewPointTemp1.OutPort, skytemperatur1.Tdp)
      annotation (points=[-62, 2; -47, 2; -47, 4; -32, 4], style(color=3));
    connect(Tfsky1.therm1, therm1)
      annotation (points=[32, 16; 68, 16; 68, 10; 104, 10]);
    connect(skytemperatur1.ic_beam_rad1, ic_beam_rad1) annotation (points=[-32,
           16; -72, 16; -72, 62; -102, 62], style(color=45));
    connect(skytemperatur1.Tdb, Tdb1)
      annotation (points=[-33, 8; -42, 8; -42, 76; -104, 76], style(color=3));
    connect(Tfsky1.Tdb, Tdb1)
      annotation (points=[14, 20; -26, 20; -26, 82; -100, 82], style(color=3));
    connect(DewPointTemp1.Tamb, Tdb1)
      annotation (points=[-78, 8; -88, 8; -88, 82], style(color=3));
    connect(skytemperatur1.ic_diff_rad1, ic_diff_rad1) annotation (points=[-32,
           12; -62, 12; -62, 38; -102, 38], style(color=45));
  end Examplesky;

  connector therm
    Modelica.SIunits.CelsiusTemperature T;
    flow Modelica.SIunits.HeatFlux j;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Rectangle(extent=[-80, 80; 82, -80], style(gradient=3, fillColor=45))),
      Window(
        x=0.35,
        y=0.23,
        width=0.44,
        height=0.65),
      Diagram(Rectangle(extent=[-80, 80; 82, -80], style(gradient=3, fillColor=
                45))));

  end therm;

  model Skytemp

    annotation (Diagram(Polygon(points=[-10, 16; -22, -2; -2, -2; -10, 16],
            style(
            color=7,
            fillColor=7,
            fillPattern=1))), Icon(
        Rectangle(extent=[-70, 90; 90, -74], style(color=0, fillColor=68)),
        Polygon(points=[26, -30; 74, -30; 50, -6; 26, -30], style(color=0,
              fillColor=43)),
        Rectangle(extent=[36, -30; 66, -60], style(color=0, fillColor=43)),
        Rectangle(extent=[46, -44; 58, -60], style(color=0, fillColor=49)),
        Polygon(points=[-70, -26; -70, 90; 90, 90; 90, -4; 72, 20; 58, 34; 46,
              36; 24, 24; 8, 32; -6, 26; -16, -2; -34, 10; -50, 8; -62, -6; -70,
               -26], style(color=69, fillColor=69)),
        Text(
          extent=[10, 94; 10, 24],
          string="sky",
          style(color=7))));
    DewPointTemp DewPointTemp1 annotation (extent=[-80, -8; -60, 12]);
    skytemperatur skytemperatur1 annotation (extent=[-34, 0; -14, 20]);
    Tfsky Tfsky1 annotation (extent=[12, 6; 32, 26]);
    ModelicaAdditions.Tables.CombiTableTime HumidityTable(table=[0, 0; 1440, 1])
      annotation (extent=[-100, -8; -84, 4]);
    ATplus.Weather.Sky_and_Dewpoint_Temperature.therm therm1
      annotation (extent=[94, 6; 114, 26]);
    ATplus.Weather.t_and_sl_rad.CUTS.ic_beam_rad ic_beam_rad1
      annotation (extent=[-130, 8; -100, 40]);

    ATplus.Weather.t_and_sl_rad.CUTS.ic_diff_rad ic_diff_rad1
      annotation (extent=[-132, -58; -96, -22]);

    Modelica.Blocks.Interfaces.InPort Tdb1
      annotation (extent=[-122, 70; -98, 92]);
  equation

    connect(skytemperatur1.OutPort, Tfsky1.Tsky) annotation (points=[-16, 10; -2,
           10; -2, 12; 12, 12], style(
        color=3,
        gradient=2,
        fillColor=7));
    connect(HumidityTable.outPort, DewPointTemp1.relhum)
      annotation (points=[-83.2, -2; -79, -3], style(color=61));
    connect(DewPointTemp1.OutPort, skytemperatur1.Tdp)
      annotation (points=[-62, 2; -47, 2; -47, 4; -32, 4], style(color=3));
    connect(Tfsky1.therm1, therm1)
      annotation (points=[32, 16; 68, 16; 68, 10; 104, 10]);
    connect(skytemperatur1.ic_beam_rad1, ic_beam_rad1)
      annotation (points=[-33, 16; -100, 16; -100, 17.5], style(color=45));
    connect(skytemperatur1.Tdb, Tdb1)
      annotation (points=[-33, 8; -42, 8; -42, 76; -104, 76], style(color=3));
    connect(Tfsky1.Tdb, Tdb1)
      annotation (points=[14, 20; -26, 20; -26, 82; -100, 82], style(color=3));
    connect(DewPointTemp1.Tamb, Tdb1)
      annotation (points=[-78, 8; -102, 8; -102, 82], style(color=3));
    connect(skytemperatur1.ic_diff_rad1, ic_diff_rad1)
      annotation (points=[-33, 12; -33, -46; -112, -46], style(color=45));
  end Skytemp;
end Sky_and_Dewpoint_Temperature;
