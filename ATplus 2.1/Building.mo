package Building
  type AirExchangeRate = Real (final quantity="AirExchange", final unit="m2/h");
  import Modelica.Constants;
  extends Icons.Package;
  package Weather = ATplus.Weather;
  package t_and_sl_rad = ATplus.Weather.t_and_sl_rad;
  package Controller = ATplus.Controller;
  package SIunits = Modelica.SIunits;
  package Constants = Modelica.Constants;
  connector water_gas
    flow Real water(final unit="kg water/kg dry air");
    flow Real carbdiox(final unit="m3/h");
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(
            color=0,
            pattern=0,
            thickness=2)),
        Ellipse(extent=[-52, 70; -66, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[-32, 70; -46, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[-12, 70; -26, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[8, 70; -6, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[26, 70; 12, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[48, 70; 34, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[68, 70; 54, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[-52, -22; -66, -60], style(
            color=0,
            thickness=2,
            fillColor=76)),
        Ellipse(extent=[-32, -22; -46, -60], style(
            color=0,
            thickness=2,
            fillColor=76)),
        Ellipse(extent=[-12, -22; -26, -60], style(
            color=0,
            thickness=2,
            fillColor=76)),
        Ellipse(extent=[8, -22; -6, -60], style(
            color=0,
            thickness=2,
            fillColor=76)),
        Ellipse(extent=[26, -22; 12, -60], style(
            color=0,
            thickness=2,
            fillColor=76)),
        Ellipse(extent=[48, -22; 34, -60], style(
            color=0,
            thickness=2,
            fillColor=76)),
        Ellipse(extent=[68, -22; 54, -60], style(
            color=0,
            thickness=2,
            fillColor=76)),
        Text(
          extent=[-30, 30; 38, 8],
          style(
            color=0,
            thickness=2,
            fillColor=76,
            fillPattern=1),
          string="H2O"),
        Text(
          extent=[-24, -60; 28, -82],
          style(
            color=0,
            thickness=2,
            fillColor=76,
            fillPattern=1),
          string="CO2")),
      Window(
        x=0.35,
        y=0.23,
        width=0.44,
        height=0.65),
      Diagram(
        Rectangle(extent=[-80, 80; 80, -80], style(
            color=0,
            thickness=2,
            fillColor=75)),
        Ellipse(extent=[-52, 70; -66, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[-32, 70; -46, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[-12, 70; -26, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[8, 70; -6, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[26, 70; 12, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[48, 70; 34, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[68, 70; 54, 32], style(
            color=0,
            thickness=2,
            fillColor=3)),
        Ellipse(extent=[-52, -22; -66, -60], style(
            color=0,
            thickness=2,
            fillColor=7)),
        Ellipse(extent=[-32, -22; -46, -60], style(
            color=0,
            thickness=2,
            fillColor=7)),
        Ellipse(extent=[-12, -22; -26, -60], style(
            color=0,
            thickness=2,
            fillColor=7)),
        Ellipse(extent=[8, -22; -6, -60], style(
            color=0,
            thickness=2,
            fillColor=7)),
        Ellipse(extent=[28, -22; 14, -60], style(
            color=0,
            thickness=2,
            fillColor=7)),
        Ellipse(extent=[48, -22; 34, -60], style(
            color=0,
            thickness=2,
            fillColor=7)),
        Ellipse(extent=[68, -22; 54, -60], style(
            color=0,
            thickness=2,
            fillColor=7)),
        Text(
          extent=[-30, 30; 38, 8],
          style(
            color=0,
            thickness=2,
            fillColor=76,
            fillPattern=1),
          string="H2O"),
        Text(
          extent=[-24, -60; 28, -82],
          style(
            color=0,
            thickness=2,
            fillColor=76,
            fillPattern=1),
          string="CO2")));

  end water_gas;

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

  package Icons = ATplus.Icons;

  partial class twotherm
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
      Icon(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
      Window(
        x=0.3,
        y=0.41,
        width=0.6,
        height=0.6));
    therm therm1 annotation (extent=[-100, -10; -80, 10]);
    therm therm2 annotation (extent=[80, -10; 100, 10]);
  end twotherm;

  partial class onetherm
    parameter Modelica.SIunits.CelsiusTemperature T0=16 "initial temperature";
    Modelica.SIunits.CelsiusTemperature T(start=T0) "initial temperature";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
      Icon(Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillPattern=0))),
      Window(
        x=0.13,
        y=0.22,
        width=0.72,
        height=0.6),
      Documentation(info="
"));

    therm therm1 annotation (extent=[-10, 80; 10, 100]);
  equation
    T = therm1.T;
  end onetherm;

  annotation (
    Coordsys(
      extent=[0, 0; 443, 453],
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
      Rectangle(extent=[-36, 24; 10, -46], style(color=77, fillColor=76)),
      Polygon(points=[10, 24; 16, 32; 16, -38; 10, -46; 10, 24], style(color=77,
             fillColor=76)),
      Polygon(points=[-36, 24; 10, 24; 16, 32; -28, 32; -36, 24], style(color=
              77, fillColor=76)),
      Rectangle(extent=[-8, 16; 2, 6], style(color=0, fillColor=0)),
      Rectangle(extent=[-28, 16; -18, 6], style(color=0, fillColor=0)),
      Rectangle(extent=[-28, -4; -18, -14], style(color=0, fillColor=0)),
      Rectangle(extent=[-28, -24; -18, -34], style(color=0, fillColor=0)),
      Rectangle(extent=[-8, -24; 2, -34], style(pattern=0, fillColor=0)),
      Rectangle(extent=[-8, -4; 2, -14], style(color=0, fillColor=0))));
  package Layer
    extends Icons.Package;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-50, 38; -22, -52], style(gradient=1, fillColor=49)),
        Rectangle(extent=[-22, 38; 16, -52], style(gradient=1, fillColor=43)),
        Rectangle(extent=[16, 38; 42, -52], style(gradient=1, fillColor=49))),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));

    class layer "one layer model"
      extends Building.twotherm;
      parameter SIunits.Area A=16;
      parameter SIunits.Thickness d=0.1;
      parameter SIunits.ThermalConductivity lambda=2.4 "Thermal conductivity";
      parameter SIunits.Density rho=1600;
      parameter SIunits.SpecificHeatCapacity c=1000 "Specific heat capacity";
      parameter Modelica.SIunits.CelsiusTemperature T0=16 "initial temperature";
      Building.Elements.heatcond heatcond1(
        A=A,
        d=d/2,
        lambda=lambda) annotation (extent=[-56, -16; -22, 16]);
      Building.Elements.load load1(
        T0=T0,
        rho=rho,
        c=c,
        d=d,
        A=A) annotation (extent=[-12, -52; 20, -22]);
      Building.Elements.heatcond heatcond2(
        A=A,
        d=d/2,
        lambda=lambda) annotation (extent=[30, -16; 64, 16]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; -30, -80], style(gradient=1, fillColor=49)),
          Rectangle(extent=[-30, 80; 30, -80], style(gradient=1, fillColor=43)),
          Rectangle(extent=[30, 80; 80, -80], style(gradient=1, fillColor=49)),
          Text(extent=[-62, 120; 62, 84], string="%name")),
        Window(
          x=0.16,
          y=0.39,
          width=0.6,
          height=0.6));

    equation
      connect(heatcond2.therm2, therm2) annotation (points=[62.3, 0; 90, 0]);
      connect(heatcond1.therm2, heatcond2.therm1)
        annotation (points=[-23.7, 0; 31.7, 0]);
      connect(therm1, heatcond1.therm1) annotation (points=[-90, 0; -54.3, 0]);
      connect(heatcond1.therm2, load1.therm1)
        annotation (points=[-23.7, 0; 4, 0; 4, -23.5]);
    end layer;

    class twolayer "two layers model"
      extends Building.twotherm;
      parameter SIunits.Area A=16;
      parameter SIunits.Thickness d1=0.1;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; -30, -80], style(gradient=1, fillColor=49)),
          Rectangle(extent=[-30, 80; 30, -80], style(gradient=1, fillColor=43)),
          Rectangle(extent=[30, 80; 80, -80], style(gradient=1, fillColor=49)),
          Text(extent=[-62, 120; 62, 84], string="%name"),
          Text(
            extent=[-46, 42; 48, -48],
            string="2",
            style(color=0, thickness=2))),
        Window(
          x=0.14,
          y=0.19,
          width=0.6,
          height=0.6),
        Documentation(info="
"));

      layer layer1(
        A=A,
        d=d1,
        lambda=lambda1,
        rho=rho1,
        c=c1) annotation (extent=[-42, -16; -8, 16]);
      layer layer2(
        A=A,
        d=d2,
        lambda=lambda2,
        rho=rho2,
        c=c2) annotation (extent=[22, -16; 56, 16]);
    equation
      connect(layer2.therm1, layer1.therm2)
        annotation (points=[23.7, 0; -9.7, 0]);
      connect(layer1.therm1, therm1) annotation (points=[-40.3, 0; -90, 0]);
      connect(layer2.therm2, therm2) annotation (points=[54, 0; 92, 0]);
    end twolayer;

    class threelayer "three layers model"
      extends Building.twotherm;
      parameter SIunits.Area A=16;
      parameter SIunits.Thickness d1=0.1;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      parameter SIunits.Thickness d3=0.1;
      parameter SIunits.ThermalConductivity lambda3=2.4;
      parameter SIunits.Density rho3=1600;
      parameter SIunits.SpecificHeatCapacity c3=1000;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; -30, -80], style(gradient=1, fillColor=49)),
          Rectangle(extent=[-30, 80; 30, -80], style(gradient=1, fillColor=43)),
          Rectangle(extent=[30, 80; 80, -80], style(gradient=1, fillColor=49)),
          Text(
            extent=[-46, 42; 48, -48],
            string="3",
            style(color=0, thickness=2)),
          Text(extent=[-62, 120; 62, 84], string="%name")),
        Window(
          x=0.35,
          y=0.2,
          width=0.6,
          height=0.6),
        Diagram);

      twolayer twolayer1(
        A=A,
        d1=d1,
        lambda1=lambda1,
        rho1=rho1,
        c1=c1,
        d2=d2,
        lambda2=lambda2,
        rho2=rho2,
        c2=c2) annotation (extent=[-46, -18; -8, 18]);
      layer layer1(
        A=A,
        d=d3,
        lambda=lambda3,
        rho=rho3,
        c=c3) annotation (extent=[16, -18; 54, 18]);
    equation
      connect(twolayer1.therm1, therm1) annotation (points=[-44.1, 0; -90, 0]);
      connect(layer1.therm2, therm2) annotation (points=[52.1, 0; 92, 0]);
      connect(layer1.therm1, twolayer1.therm2)
        annotation (points=[17.9, 0; -9.9, 0]);
    end threelayer;

    class fourlayer "four layers model"
      extends Building.twotherm;
      parameter SIunits.Area A=16;
      parameter SIunits.Thickness d1=0.1;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      parameter SIunits.Thickness d3=0.1;
      parameter SIunits.ThermalConductivity lambda3=2.4;
      parameter SIunits.Density rho3=1600;
      parameter SIunits.SpecificHeatCapacity c3=1000;
      parameter SIunits.Thickness d4=0.1;
      parameter SIunits.ThermalConductivity lambda4=2.4;
      parameter SIunits.Density rho4=1600;
      parameter SIunits.SpecificHeatCapacity c4=1000;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; -30, -80], style(gradient=1, fillColor=49)),
          Rectangle(extent=[-30, 80; 30, -80], style(gradient=1, fillColor=43)),
          Rectangle(extent=[30, 80; 80, -80], style(gradient=1, fillColor=49)),
          Text(
            extent=[-46, 42; 48, -48],
            string="4",
            style(color=0, thickness=2)),
          Text(extent=[-62, 120; 62, 84], string="%name")),
        Window(
          x=0.24,
          y=0.16,
          width=0.6,
          height=0.6),
        Diagram);

      twolayer twolayer1(
        A=A,
        d1=d1,
        lambda1=lambda1,
        rho1=rho1,
        c1=c1,
        d2=d2,
        lambda2=lambda2,
        rho2=rho2,
        c2=c2) annotation (extent=[-52, -22; -8, 22]);
      twolayer twolayer2(
        A=A,
        d1=d3,
        lambda1=lambda3,
        rho1=rho3,
        c1=c3,
        d2=d4,
        lambda2=lambda4,
        rho2=rho4,
        c2=c4) annotation (extent=[20, -22; 64, 22]);
    equation
      connect(twolayer2.therm2, therm2) annotation (points=[61.8, 0; 90, 0]);
      connect(twolayer1.therm2, twolayer2.therm1)
        annotation (points=[-10.2, 0; 22.2, 0]);
      connect(twolayer1.therm1, therm1) annotation (points=[-49.8, 0; -90, 0]);
    end fourlayer;

    class nlayer
      extends Building.twotherm;
      parameter Integer n(min=1) = 5
        "number of heat capacity elements (= number of states)";
      parameter SIunits.Thickness d=0.2 "thickness of wall";
      parameter SIunits.Area A(min=0) = 16 "area of wall";
      parameter SIunits.Density rho(min=0) = 1600 "density of wall material";
      parameter SIunits.ThermalConductivity lambda(min=0) = 2.4
        "thermal conductivity of material";
      parameter SIunits.SpecificHeatCapacity c(min=0) = 1000
        "specific heat capacity";
      SIunits.Temp_C T[n + 2]
        "Temperature at the grid points (of the heat capacity elements and the borders)";
    protected
      parameter SIunits.Thickness delem=d/n "length of a HeatCapacity element";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; -30, -80], style(gradient=1, fillColor=49)),
          Rectangle(extent=[-30, 80; 30, -80], style(gradient=1, fillColor=43)),
          Rectangle(extent=[30, 80; 80, -80], style(gradient=1, fillColor=49)),
          Text(extent=[-62, 120; 62, 84], string="%n%name"),
          Text(
            extent=[-46, 42; 48, -48],
            string="%n",
            style(color=0, thickness=2))),
        Window(
          x=0.14,
          y=0,
          width=0.62,
          height=0.66));

    public
      Elements.heatcond heatcond0(
        A=A,
        d=delem/2,
        lambda=lambda) annotation (extent=[-62, -14; -34, 14]);
      Elements.load load[n](
        rho=fill(rho, n),
        c=fill(c, n),
        d=fill(delem, n),
        A=fill(A, n)) annotation (extent=[-14, -60; 14, -34]);
      Elements.heatcond heatcond[n - 1](
        A=fill(A, n - 1),
        d=fill(delem, n - 1),
        lambda=fill(lambda, n - 1)) annotation (extent=[-14, -14; 14, 14]);
      Elements.heatcond heatcondn(
        A=A,
        d=delem/2,
        lambda=lambda) annotation (extent=[34, -14; 62, 14]);
    equation
      connect(therm1, heatcond0.therm1) annotation (points=[-88, 0; -60, 0]);
      connect(heatcondn.therm2, therm2) annotation (points=[60, 0; 90, 0]);
      // connect heatcond0 and heatcondn
      connect(heatcond0.therm2, load[1].therm1);
      connect(heatcondn.therm1, load[n].therm1);

      // connect heatcond[i] and load[i]
      for i in 1:n - 1 loop
        connect(load[i].therm1, heatcond[i].therm1);
        connect(heatcond[i].therm2, load[i + 1].therm1);
      end for;

      // determine temperature
      T[1] = therm1.T;
      T[n + 2] = therm2.T;
      for i in 1:n loop
        T[i + 1] = load[i].therm1.T;
      end for;
    end nlayer;

    class halfwall
      extends Building.twotherm;
      parameter SIunits.ThermalConductivity lambdaWall=2.4;
      parameter SIunits.CoefficientOfHeatTransfer alphaWall=2.0;
      parameter SIunits.Density rhoWall=1600;
      parameter SIunits.SpecificHeatCapacity cWall=1000;
      parameter SIunits.Thickness dWall=0.4;
      parameter SIunits.Area AWall=16 "Area of the wall";
      parameter Modelica.SIunits.CelsiusTemperature T0=16 "initial temperature";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43))),
        Window(
          x=0.26,
          y=0.29,
          width=0.6,
          height=0.6));

      Building.Elements.heatcond heatcond1(
        A=AWall,
        d=dWall/2,
        lambda=lambdaWall) annotation (extent=[14, -10; 34, 10]);
      Building.Elements.heattrans heattrans1(alpha=alphaWall, A=AWall)
        annotation (extent=[-52, -10; -32, 10]);
      Building.Elements.heatcond heatcond2(
        A=AWall,
        d=dWall/2,
        lambda=lambdaWall) annotation (extent=[48, -10; 68, 10]);
      Building.Elements.load load1(
        T0=T0,
        rho=rhoWall,
        c=cWall,
        d=dWall,
        A=AWall) annotation (extent=[34, -30; 54, -10]);
    equation
      connect(heatcond1.therm2, load1.therm1)
        annotation (points=[33, 0; 44, 0; 44, -11], style(color=0));
      connect(load1.therm1, heatcond2.therm1)
        annotation (points=[44, -11; 44, 0; 49, 0], style(color=0));
      connect(heatcond2.therm2, therm2)
        annotation (points=[67, 0; 90, 0], style(color=0));
      connect(heatcond1.therm1, heattrans1.therm2)
        annotation (points=[15, 0; -33, 0], style(color=0));
      connect(therm1, heattrans1.therm1)
        annotation (points=[-90, 0; -51, 0], style(color=0));
    end halfwall;

    class chalfwall
      "Half wall with heat exchange convection and radiation to environment"
      extends halfwall;
      Building.therm therm3 annotation (extent=[-10, 80; 10, 100]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Window(
          x=0.1,
          y=0.33,
          width=0.6,
          height=0.62));
    equation
      connect(therm3, heattrans1.therm2)
        annotation (points=[0, 90; 0, 0; -33, 0], style(color=0));
    end chalfwall;

    class layerplus
      extends twotherm;
      parameter SIunits.ThermalConductivity lambdaFloor=2.4;
      parameter SIunits.Density rhoFloor=1600;
      parameter SIunits.SpecificHeatCapacity cFloor=1000;
      parameter SIunits.Thickness dFloor=0.4;
      parameter SIunits.Area AFloor=16 "Area of the wall";
      Elements.heatcond heatcond1(
        A=AFloor,
        d=dFloor/2,
        lambda=lambdaFloor) annotation (extent=[-52, -16; -22, 14]);
      Elements.heatcond heatcond2(
        A=AFloor,
        d=dFloor/2,
        lambda=lambdaFloor) annotation (extent=[24, -16; 54, 14]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-78, 78; 78, -78]),
          Rectangle(extent=[-80, 76; 76, -80]),
          Rectangle(extent=[26, 80; 80, -80], style(
              gradient=1,
              fillColor=6,
              fillPattern=1)),
          Rectangle(extent=[-28, 80; 26, -80], style(
              gradient=1,
              fillColor=1,
              fillPattern=1)),
          Rectangle(extent=[-80, 80; -28, -80], style(
              gradient=1,
              fillColor=6,
              fillPattern=1)),
          Ellipse(extent=[-12, 6; 4, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-4, 2; -4, 78], style(color=0))),
        Window(
          x=0.31,
          y=0.14,
          width=0.6,
          height=0.6),
        Diagram);
      Elements.load load1(
        rho=rhoFloor,
        c=cFloor,
        d=dFloor,
        A=AFloor) annotation (extent=[-20, -54; 14, -24]);
      therm therm3 annotation (extent=[-12, 80; 8, 100]);
    equation
      connect(load1.therm1, therm3) annotation (points=[-6, -26; -6, 86]);
      connect(therm1, heatcond1.therm1) annotation (points=[-82, -2; -52, -2]);
      connect(load1.therm1, heatcond1.therm2)
        annotation (points=[-6, -24; -6, -2; -22, -2]);
      connect(load1.therm1, heatcond2.therm1)
        annotation (points=[-6, -26; -6, -2; 26, -2]);
      connect(heatcond2.therm2, therm2) annotation (points=[54, -2; 84, -2]);
      connect(heatcond2.therm1, therm3)
        annotation (points=[24, -2; -6, -2; -6, 84]);
    end layerplus;

    partial class bShalfwall
      parameter Real Abskoeff=0.6 "weight coefficient";
      parameter SIunits.Area AWall=6 "Area of Surface";
      parameter SIunits.CoefficientOfHeatTransfer alphaWall=2.0;
      Weather.t_and_sl_rad.CUTS.ic_total_rad ic_total_rad1
        annotation (extent=[-100, 50; -80, 70]);
      Building.therm therm3 annotation (extent=[-10, 80; 10, 100]);
      Building.therm therm1 annotation (extent=[-100, -10; -80, 10]);
      Building.therm therm2 annotation (extent=[80, -10; 100, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillPattern=
                 0))),
        Icon(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
        Window(
          x=0.31,
          y=0.21,
          width=0.6,
          height=0.6));
    end bShalfwall;

    class Shalfwall2
      extends bShalfwall;
      parameter SIunits.Thickness d1=0.4;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      Elements.Ijadapt Ijadapt1(koeff=Abskoeff, Area=AWall)
        annotation (extent=[-66, 46; -38, 74]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Text(
            extent=[-32, 46; 76, -44],
            string="2",
            style(
              color=0,
              pattern=0,
              fillColor=0)),
          Text(
            extent=[-82, 74; -40, 44],
            string="rad",
            style(color=41))),
        Window(
          x=0.13,
          y=0.1,
          width=0.6,
          height=0.6));

      Building.Layer.layer layer1(
        A=AWall,
        d=d2,
        lambda=lambda2,
        rho=rho2,
        c=c2) annotation (extent=[44, -14; 72, 14]);
      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambda1,
        alphaWall=alphaWall,
        rhoWall=rho1,
        cWall=c1,
        dWall=d1,
        AWall=AWall) annotation (extent=[-16, -16; 14, 14]);
    equation
      connect(layer1.therm1, chalfwall1.therm2) annotation (points=[45.4,
            1.77636e-015; 37.175, 1.77636e-015; 37.175, -1; 12.5, -1]);
      connect(layer1.therm2, therm2)
        annotation (points=[70.6, 1.77636e-015; 90, 0]);
      connect(chalfwall1.therm1, therm1)
        annotation (points=[-14.5, -1; -90, 0]);
      connect(Ijadapt1.ic_total_rad1, ic_total_rad1)
        annotation (points=[-64.6, 60; -90, 60]);
      connect(Ijadapt1.therm1, therm3)
        annotation (points=[-39.4, 60; 0, 60; 0, 90]);
      connect(chalfwall1.therm3, therm3)
        annotation (points=[-1, 12.5; -1, 51.25; 0, 51.25; 0, 90]);
    end Shalfwall2;

    class Shalfwall3
      extends bShalfwall;
      parameter SIunits.Thickness d1=0.4;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      parameter SIunits.Thickness d3=0.1;
      parameter SIunits.ThermalConductivity lambda3=2.4;
      parameter SIunits.Density rho3=1600;
      parameter SIunits.SpecificHeatCapacity c3=1000;
      Elements.Ijadapt Ijadapt1(koeff=Abskoeff, Area=AWall)
        annotation (extent=[-68, 46; -40, 74]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Icon(
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Text(
            extent=[-32, 46; 76, -44],
            string="3",
            style(
              color=0,
              pattern=0,
              fillColor=0)),
          Text(
            extent=[-84, 74; -38, 44],
            string="rad",
            style(color=41))),
        Window(
          x=0.31,
          y=0.22,
          width=0.6,
          height=0.6));

      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambda1,
        alphaWall=alphaWall,
        rhoWall=rho1,
        cWall=c1,
        dWall=d1,
        AWall=AWall) annotation (extent=[-16, -16; 16, 14]);
      twolayer twolayer1(
        A=AWall,
        d1=d2,
        lambda1=lambda2,
        rho1=rho2,
        c1=c2,
        d2=d3,
        lambda2=lambda3,
        rho2=rho3,
        c2=c3) annotation (extent=[42, -14; 70, 14]);
    equation
      connect(chalfwall1.therm1, therm1)
        annotation (points=[-14.4, -1; -52.2, -1; -52.2, 0; -90, 0]);
      connect(twolayer1.therm2, therm2) annotation (points=[68.6, 1.77636e-015;
             78.3, 1.77636e-015; 78.3, 0; 90, 0]);
      connect(twolayer1.therm1, chalfwall1.therm2) annotation (points=[43.4,
            1.77636e-015; 36.15, 1.77636e-015; 36.15, -1; 14.4, -1]);
      connect(chalfwall1.therm3, therm3) annotation (points=[0, 12.5; 0, 90]);
      connect(Ijadapt1.ic_total_rad1, ic_total_rad1)
        annotation (points=[-66.6, 60; -90, 60]);
      connect(Ijadapt1.therm1, chalfwall1.therm3)
        annotation (points=[-41.4, 60; 0, 60; 0, 12.5]);
    end Shalfwall3;

    class Shalfwall4
      extends bShalfwall;
      parameter SIunits.Thickness d1=0.1;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      parameter SIunits.Thickness d3=0.1;
      parameter SIunits.ThermalConductivity lambda3=2.4;
      parameter SIunits.Density rho3=1600;
      parameter SIunits.SpecificHeatCapacity c3=1000;
      parameter SIunits.Thickness d4=0.1;
      parameter SIunits.ThermalConductivity lambda4=2.4;
      parameter SIunits.Density rho4=1600;
      parameter SIunits.SpecificHeatCapacity c4=1000;
      Elements.Ijadapt Ijadapt1(koeff=Abskoeff, Area=AWall)
        annotation (extent=[-68, 46; -40, 74]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Text(
            extent=[-84, 74; -38, 44],
            string="rad",
            style(color=41)),
          Text(
            extent=[-32, 46; 76, -44],
            string="4",
            style(
              color=0,
              pattern=0,
              fillColor=0))),
        Window(
          x=0.12,
          y=0.05,
          width=0.6,
          height=0.6));

      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambda1,
        alphaWall=alphaWall,
        rhoWall=rho1,
        cWall=c1,
        dWall=d1,
        AWall=AWall) annotation (extent=[-14, -14; 14, 14]);
      threelayer threelayer1(
        A=AWall,
        d1=d2,
        lambda1=lambda2,
        rho1=rho2,
        c1=c2,
        d2=d3,
        lambda2=lambda3,
        rho2=rho3,
        c2=c3,
        d3=d4,
        lambda3=lambda4,
        rho3=rho4,
        c3=c4) annotation (extent=[42, -14; 70, 14]);
    equation
      connect(chalfwall1.therm2, threelayer1.therm1) annotation (points=[12.6,
            1.77636e-015; 20.3, 1.77636e-015; 20.3, 3.55272e-015; 28,
            3.55272e-015; 28, 0; 43.4, 0]);
      connect(threelayer1.therm2, therm2) annotation (points=[68.6,
            1.77636e-015; 80.3, 1.77636e-015; 80.3, 0; 88, 0]);
      connect(chalfwall1.therm1, therm1) annotation (points=[-12.6,
            1.77636e-015; -51.3, 1.77636e-015; -51.3, 0; -90, 0]);
      connect(chalfwall1.therm3, therm3)
        annotation (points=[1.77636e-015, 12.6; 0, 90]);
      connect(Ijadapt1.ic_total_rad1, ic_total_rad1)
        annotation (points=[-66.6, 60; -90, 60]);
      connect(Ijadapt1.therm1, therm3)
        annotation (points=[-41.4, 60; 0, 60; 0, 90]);
    end Shalfwall4;

    class bSorienthalfwall
      parameter Real Abskoeff=0.6 "weight coefficient";
      parameter SIunits.Area AWall=6 "Area of Surface";
      parameter SIunits.CoefficientOfHeatTransfer alphaWall=2.0;

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
        Icon(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
        Window(
          x=0.31,
          y=0.21,
          width=0.6,
          height=0.6));
    public
      Building.therm therm3 annotation (extent=[-12, 80; 8, 100]);
      Building.therm therm1 annotation (extent=[-100, -10; -80, 10]);
      Building.therm therm2 annotation (extent=[80, -10; 100, 10]);
      Weather.t_and_sl_rad.CUTS.ic_total_rad_v ic_total_rad_v1(final n=
            t_and_sl_rad.n_of_surf_orient_def)
        annotation (extent=[-100, 50; -80, 70]);
    end bSorienthalfwall;

    class Sorienthalfwall2

      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      extends bSorienthalfwall;
      parameter SIunits.Thickness d1=0.4;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Text(
            extent=[-32, 46; 76, -44],
            string="2",
            style(
              color=0,
              pattern=0,
              fillColor=0)),
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Line(points=[-60, 76; -60, 44], style(color=10)),
          Line(points=[-68, 68; -52, 52], style(color=10)),
          Line(points=[-76, 60; -44, 60], style(color=10)),
          Line(points=[-52, 68; -68, 52], style(color=10))),
        Window(
          x=0.13,
          y=0.1,
          width=0.6,
          height=0.6),
        Diagram);

      Building.Layer.layer layer1(
        A=AWall,
        d=d2,
        lambda=lambda2,
        rho=rho2,
        c=c2) annotation (extent=[44, -14; 72, 14]);
      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambda1,
        alphaWall=alphaWall,
        rhoWall=rho1,
        cWall=c1,
        dWall=d1,
        AWall=AWall) annotation (extent=[-18, -16; 12, 14]);
      Building.Elements.Ijadapt Ijadapt1(koeff=Abskoeff, Area=AWall)
        annotation (extent=[-44, 46; -16, 74]);

      Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_aggregable_sel
        surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
            comp_surf_orient_alias) annotation (extent=[-72, 50; -52, 70]);
    equation
      connect(layer1.therm1, chalfwall1.therm2) annotation (points=[45.4,
            1.77636e-015; 36.675, 1.77636e-015; 36.675, -1; 10.5, -1]);
      connect(layer1.therm2, therm2)
        annotation (points=[70.6, 1.77636e-015; 90, 0]);
      connect(chalfwall1.therm1, therm1)
        annotation (points=[-16.5, -1; -90, 0]);
      connect(chalfwall1.therm3, therm3)
        annotation (points=[-3, 12.5; -3, 52.25; -2, 52.25; -2, 90]);
      connect(Ijadapt1.therm1, therm3)
        annotation (points=[-17.4, 60; -2, 60; -2, 90]);
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1, Ijadapt1.
        ic_total_rad1)
        annotation (points=[-50.4, 60.1; -46.8, 60.1; -46.8, 60; -42.6, 60]);
      connect(ic_total_rad_v1, surf_orient_alias_aggregable_sel1.
        ic_total_rad_v1) annotation (points=[-90, 60; -73.4, 60]);
    end Sorienthalfwall2;

    class Sorienthalfwall3

      extends bSorienthalfwall;
      parameter SIunits.Thickness d1=0.4;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      parameter SIunits.Thickness d3=0.1;
      parameter SIunits.ThermalConductivity lambda3=2.4;
      parameter SIunits.Density rho3=1600;
      parameter SIunits.SpecificHeatCapacity c3=1000;
      Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_aggregable_sel
        surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
            comp_surf_orient_alias) annotation (extent=[-74, 50; -54, 70]);
      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Icon(
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Text(
            extent=[-32, 46; 76, -44],
            string="3",
            style(
              color=0,
              pattern=0,
              fillColor=0)),
          Line(points=[-76, 60; -44, 60], style(color=10)),
          Line(points=[-52, 68; -68, 52], style(color=10)),
          Line(points=[-60, 76; -60, 44], style(color=10)),
          Line(points=[-68, 68; -52, 52], style(color=10))),
        Window(
          x=0.31,
          y=0.22,
          width=0.6,
          height=0.6));

      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambda1,
        alphaWall=alphaWall,
        rhoWall=rho1,
        cWall=c1,
        dWall=d1,
        AWall=AWall) annotation (extent=[-18, -16; 14, 14]);
      twolayer twolayer1(
        A=AWall,
        d1=d2,
        lambda1=lambda2,
        rho1=rho2,
        c1=c2,
        d2=d3,
        lambda2=lambda3,
        rho2=rho3,
        c2=c3) annotation (extent=[42, -14; 70, 14]);
      Elements.Ijadapt Ijadapt1(koeff=Abskoeff, Area=AWall)
        annotation (extent=[-40, 46; -12, 74]);
    equation
      connect(chalfwall1.therm1, therm1) annotation (points=[-16.4, 0; -90, 0]);
      connect(twolayer1.therm2, therm2) annotation (points=[68.6, 0; 92, 0]);
      connect(twolayer1.therm1, chalfwall1.therm2)
        annotation (points=[43.4, 0; 12.4, 0]);
      connect(chalfwall1.therm3, therm3) annotation (points=[-2, 14; -2, 90]);
      connect(Ijadapt1.therm1, chalfwall1.therm3)
        annotation (points=[-13.4, 60; -2, 60; -2, 12]);
      connect(ic_total_rad_v1, surf_orient_alias_aggregable_sel1.
        ic_total_rad_v1) annotation (points=[-82, 60; -76, 60]);
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1, Ijadapt1.
        ic_total_rad1) annotation (points=[-52, 60; -38, 60]);
    end Sorienthalfwall3;

    class Sorienthalfwall4

      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      extends bSorienthalfwall;
      parameter SIunits.Thickness d1=0.1;
      parameter SIunits.ThermalConductivity lambda1=2.4;
      parameter SIunits.Density rho1=1600;
      parameter SIunits.SpecificHeatCapacity c1=1000;
      parameter SIunits.Thickness d2=0.1;
      parameter SIunits.ThermalConductivity lambda2=2.4;
      parameter SIunits.Density rho2=1600;
      parameter SIunits.SpecificHeatCapacity c2=1000;
      parameter SIunits.Thickness d3=0.1;
      parameter SIunits.ThermalConductivity lambda3=2.4;
      parameter SIunits.Density rho3=1600;
      parameter SIunits.SpecificHeatCapacity c3=1000;
      parameter SIunits.Thickness d4=0.1;
      parameter SIunits.ThermalConductivity lambda4=2.4;
      parameter SIunits.Density rho4=1600;
      parameter SIunits.SpecificHeatCapacity c4=1000;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Text(
            extent=[-32, 46; 76, -44],
            string="4",
            style(
              color=0,
              pattern=0,
              fillColor=0)),
          Line(points=[-76, 60; -44, 60], style(color=10)),
          Line(points=[-52, 68; -68, 52], style(color=10)),
          Line(points=[-60, 76; -60, 44], style(color=10)),
          Line(points=[-68, 68; -52, 52], style(color=10))),
        Window(
          x=0.12,
          y=0.05,
          width=0.6,
          height=0.6));

      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambda1,
        alphaWall=alphaWall,
        rhoWall=rho1,
        cWall=c1,
        dWall=d1,
        AWall=AWall) annotation (extent=[-16, -14; 12, 14]);
      threelayer threelayer1(
        A=AWall,
        d1=d2,
        lambda1=lambda2,
        rho1=rho2,
        c1=c2,
        d2=d3,
        lambda2=lambda3,
        rho2=rho3,
        c2=c3,
        d3=d4,
        lambda3=lambda4,
        rho3=rho4,
        c3=c4) annotation (extent=[42, -14; 70, 14]);
      Elements.Ijadapt Ijadapt1(koeff=Abskoeff, Area=AWall)
        annotation (extent=[-46, 46; -18, 74]);

      Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_aggregable_sel
        surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
            comp_surf_orient_alias) annotation (extent=[-74, 50; -54, 70]);
    equation
      connect(chalfwall1.therm2, threelayer1.therm1) annotation (points=[10.6,
            1.77636e-015; 19.15, 1.77636e-015; 19.15, 3.55272e-015; 27.7,
            3.55272e-015; 27.7, 1.77636e-015; 43.4, 1.77636e-015]);
      connect(threelayer1.therm2, therm2) annotation (points=[68.6,
            1.77636e-015; 80.3, 1.77636e-015; 80.3, 0; 90, 0]);
      connect(chalfwall1.therm1, therm1) annotation (points=[-14.6,
            1.77636e-015; -52.3, 1.77636e-015; -52.3, 0; -90, 0]);
      connect(chalfwall1.therm3, therm3)
        annotation (points=[-2, 12.6; -2, 51.3; -2, 51.3; -2, 90]);
      connect(Ijadapt1.therm1, therm3)
        annotation (points=[-19.4, 60; -2, 60; -2, 90]);
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1, Ijadapt1.
        ic_total_rad1)
        annotation (points=[-52.4, 60.1; -48.8, 60.1; -48.8, 60; -44.6, 60]);
      connect(surf_orient_alias_aggregable_sel1.ic_total_rad_v1,
        ic_total_rad_v1) annotation (points=[-75.4, 60; -90, 60]);
    end Sorienthalfwall4;

    class Sorientchalfwall
      "Half wall with heat exchange convection, radiation to environment and solar radiation"

      extends bSorienthalfwall;
      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      parameter SIunits.ThermalConductivity lambdaWall=2.4;
      parameter SIunits.Density rhoWall=1600;
      parameter SIunits.SpecificHeatCapacity cWall=1000;
      parameter SIunits.Thickness dWall=0.4;
      parameter Modelica.SIunits.CelsiusTemperature T0=16 "initial temperature";

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Window(
          x=0.1,
          y=0.33,
          width=0.6,
          height=0.62),
        Icon(
          Rectangle(extent=[-80, 80; -40, -80], style(color=65, fillColor=65)),
          Rectangle(extent=[-40, 80; 0, -80], style(
              color=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, 80; 42, -80], style(
              color=0,
              gradient=1,
              fillColor=43)),
          Rectangle(extent=[40, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=49))));

      Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_aggregable_sel
        surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
            comp_surf_orient_alias) annotation (extent=[-70, 50; -50, 70]);
      Elements.Ijadapt Ijadapt1(koeff=Abskoeff, Area=AWall)
        annotation (extent=[-40, 46; -12, 74]);
      Elements.heattrans heattrans1(alpha=alphaWall, A=AWall)
        annotation (extent=[-54, -10; -34, 10]);
      Elements.heatcond heatcond1(
        A=AWall,
        d=dWall/2,
        lambda=lambdaWall) annotation (extent=[6, -10; 26, 10]);
      Elements.heatcond heatcond2(
        A=AWall,
        d=dWall/2,
        lambda=lambdaWall) annotation (extent=[40, -10; 60, 10]);
      Elements.load load1(
        T0=T0,
        rho=rhoWall,
        c=cWall,
        d=dWall,
        A=AWall) annotation (extent=[24, -30; 44, -10]);
    equation
      connect(ic_total_rad_v1, surf_orient_alias_aggregable_sel1.
        ic_total_rad_v1)
        annotation (points=[-90, 60; -71.4, 60], style(color=3));
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1, Ijadapt1.
        ic_total_rad1) annotation (points=[-48.4, 60.1; -46.2, 60.1; -46.2, 60;
             -38.6, 60], style(color=3));
      connect(therm1, heattrans1.therm1) annotation (points=[-90, 0; -53, 0]);
      connect(heattrans1.therm2, heatcond1.therm1)
        annotation (points=[-35, 0; 7, 0]);
      connect(heatcond1.therm2, heatcond2.therm1)
        annotation (points=[25, 0; 41, 0]);
      connect(heatcond2.therm2, therm2) annotation (points=[59, 0; 90, 0]);
      connect(load1.therm1, heatcond2.therm1)
        annotation (points=[34, -11; 34, 0; 41, 0]);
      connect(Ijadapt1.therm1, heatcond1.therm1)
        annotation (points=[-13.4, 60; -2, 60; -2, 0; 7, 0]);
      connect(heatcond1.therm1, therm3)
        annotation (points=[7, 0; -2, 0; -2, 90]);
      if cardinality(ic_total_rad_v1) == 1 then
        for i in 1:ic_total_rad_v1.n loop
          ic_total_rad_v1.I[i] = 0;
        end for;
      end if;
    end Sorientchalfwall;
  end Layer;

  package Gain
    extends Icons.Package;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Ellipse(extent=[-42, 38; 24, -24], style(color=0, fillColor=49)),
        Rectangle(extent=[-22, -22; 6, -52], style(color=0, fillColor=8)),
        Ellipse(extent=[-20, 10; -10, -2], style(color=0)),
        Ellipse(extent=[-14, 10; -2, -2], style(color=0)),
        Ellipse(extent=[-6, 10; 4, -2], style(color=0)),
        Line(points=[-18, 0; -14, -22], style(color=0)),
        Line(points=[2, 0; -2, -22], style(color=0)),
        Line(points=[-22, -46; 6, -46], style(
            color=0,
            thickness=2,
            fillColor=9)),
        Line(points=[-22, -38; 6, -38], style(
            color=0,
            thickness=2,
            fillColor=9)),
        Line(points=[-22, -30; 6, -30], style(
            color=0,
            thickness=2,
            fillColor=9))),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));
    class Gain
      "describes internal gain in one room for example lamp, animal, etc"
      extends onetherm;
      parameter Modelica.SIunits.HeatFlux J=200;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=7)),
          Ellipse(extent=[-42, 56; 38, -20], style(color=0, fillColor=49)),
          Rectangle(extent=[-18, -16; 16, -52], style(color=0, fillColor=8)),
          Ellipse(extent=[-14, 20; -4, 8], style(color=0)),
          Ellipse(extent=[-8, 20; 4, 8], style(color=0)),
          Ellipse(extent=[0, 20; 10, 8], style(color=0)),
          Line(points=[-14, 12; -8, -16], style(color=0)),
          Line(points=[10, 12; 4, -16], style(color=0)),
          Line(points=[-18, -46; 16, -46], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-18, -38; 16, -38], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-18, -30; 16, -30], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-18, -22; 16, -22], style(
              color=0,
              thickness=2,
              fillColor=9))),
        Diagram(
          Ellipse(extent=[-42, 56; 38, -20], style(color=0, fillColor=49)),
          Rectangle(extent=[-18, -16; 16, -52], style(color=0, fillColor=8)),
          Ellipse(extent=[-14, 20; -4, 8], style(color=0)),
          Ellipse(extent=[-8, 20; 4, 8], style(color=0)),
          Ellipse(extent=[0, 20; 10, 8], style(color=0)),
          Line(points=[-14, 12; -8, -16], style(color=0)),
          Line(points=[10, 12; 4, -16], style(color=0)),
          Line(points=[-18, -46; 16, -46], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-18, -38; 16, -38], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-18, -30; 16, -30], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-18, -22; 16, -22], style(
              color=0,
              thickness=2,
              fillColor=9))),
        Window(
          x=0.05,
          y=0.07,
          width=0.6,
          height=0.64));
    equation
      therm1.j = -J;
    end Gain;

    class vargain
      extends onetherm;
      parameter Real k=1 "Weight factor";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=7)),
          Ellipse(extent=[-36, 52; 44, -24], style(color=0, fillColor=49)),
          Rectangle(extent=[-12, -20; 22, -56], style(color=0, fillColor=8)),
          Ellipse(extent=[-8, 16; 2, 4], style(color=0)),
          Ellipse(extent=[-2, 16; 10, 4], style(color=0)),
          Ellipse(extent=[6, 16; 16, 4], style(color=0)),
          Line(points=[-8, 8; -2, -20], style(color=0)),
          Line(points=[16, 8; 10, -20], style(color=0)),
          Line(points=[-12, -50; 22, -50], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -42; 22, -42], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -34; 22, -34], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -26; 22, -26], style(
              color=0,
              thickness=2,
              fillColor=9))),
        Window(
          x=0.36,
          y=0.17,
          width=0.6,
          height=0.6),
        Diagram(
          Ellipse(extent=[-36, 52; 44, -24], style(color=0, fillColor=49)),
          Rectangle(extent=[-12, -20; 22, -56], style(color=0, fillColor=8)),
          Ellipse(extent=[-8, 16; 2, 4], style(color=0)),
          Ellipse(extent=[-2, 16; 10, 4], style(color=0)),
          Ellipse(extent=[6, 16; 16, 4], style(color=0)),
          Line(points=[-8, 8; -2, -20], style(color=0)),
          Line(points=[16, 8; 10, -20], style(color=0)),
          Line(points=[-12, -50; 22, -50], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -42; 22, -42], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -34; 22, -34], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -26; 22, -26], style(
              color=0,
              thickness=2,
              fillColor=9))));
      Modelica.Blocks.Interfaces.InPort InPort
        annotation (extent=[-100, -10; -80, 10]);
    equation
      therm1.j = -InPort.signal[1]*k;
    end vargain;

    class gainplus
      "describes an internal gain in one room for example lamp, animal, etc"
      extends onetherm;
      parameter String tableName="NoName"
        "table name on file or in function usertab(optional)";
      parameter String fileName="NoName"
        "file where matrix is stored (optional)";
      parameter Real k=1 "Weight factor";
      RoomAttribute.DailyTable DailyTableInternalGain(
        tableName=tableName,
        fileName=fileName,
        interval=3600) annotation (extent=[22, -60; -20, -20]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-84, 80; 76, -80], style(color=0, fillColor=7)),
          Ellipse(extent=[-30, 64; 34, 0], style(color=0, fillColor=49)),
          Rectangle(extent=[-12, 4; 16, -26], style(color=0, fillColor=8)),
          Ellipse(extent=[-12, 38; 0, 26], style(color=0)),
          Ellipse(extent=[-4, 38; 8, 26], style(color=0)),
          Ellipse(extent=[6, 38; 16, 26], style(color=0)),
          Line(points=[-10, 28; -4, 4], style(color=0)),
          Line(points=[14, 28; 8, 4], style(color=0)),
          Line(points=[-12, -18; 16, -18], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -10; 16, -10], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-12, -4; 16, -4], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Rectangle(extent=[-62, -30; 66, -74], style(color=0, fillColor=41)),
          Text(extent=[-56, -38; 54, -70], string="Gain Plus")),
        Window(
          x=0.2,
          y=0.11,
          width=0.6,
          height=0.6),
        Diagram,
        Documentation(info="This model is connected with a daily internal gain table.

For example:
hour    (watt)
6       0
6       200
22      200
22      0
24      0

"));
      vargain vargain1(k=k) annotation (extent=[-24, -4; 26, 44]);
    equation
      connect(vargain1.therm1, therm1)
        annotation (points=[1, 41.6; 1, 64.8; 0, 64.8; 0, 90]);
      connect(DailyTableInternalGain.outPort, vargain1.InPort)
        annotation (points=[-22.1, -40; -48, -40; -48, 20; -21.5, 20]);
    end gainplus;
  end Gain;

  package Rooms
    extends Icons.Package;
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
        Text(extent=[-30, 28; 28, -24], string="6"),
        Text(extent=[-40, -22; 42, -42], string="%name"),
        Rectangle(extent=[-60, 36; 44, -50], style(color=0, fillColor=52)),
        Rectangle(extent=[-62, -16; -58, -44], style(color=0)),
        Ellipse(extent=[-48, -20; -24, -44], style(color=0, fillColor=61)),
        Rectangle(extent=[-30, 30; 32, 2], style(fillColor=79)),
        Rectangle(extent=[18, 30; 32, 2], style(fillColor=7))));
    partial class broom6zones
      parameter Modelica.SIunits.Area AreaWalls[:]={16,16,16,16,16,16}
        "Area of Walls: #1...6"
        annotation (Dialog(group="Walls (geometry, materials, heat transfer)"));
      parameter Real Abs[:]={0.6,0.6,0.6,0.6,0.6,0.6}
        "Absorptance coefficient Wall #1...6"
        annotation (Dialog(group="Walls (geometry, materials, heat transfer)"));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Polygon(points=[46, 72; -50, 72; -90, 0; -50, -72; 46, -72; 86, 0;
                 46, 72], style(
              color=0,
              thickness=2,
              fillColor=7))),
        Diagram(Polygon(points=[48, 72; -48, 72; -88, 0; -48, -72; 48, -72; 88,
                 0; 48, 72], style(color=0, thickness=2))),
        Window(
          x=0.3,
          y=0.12,
          width=0.6,
          height=0.6));
      therm therm2 annotation (extent=[-10, 72; 10, 92]);
      therm therm3 annotation (extent=[62, 42; 82, 62]);
      therm therm4 annotation (extent=[62, -62; 82, -42]);
      therm therm1 annotation (extent=[-82, 42; -62, 62]);
      therm therm6 annotation (extent=[-82, -62; -62, -42]);
      therm therm5 annotation (extent=[-10, -92; 10, -72]);
      therm therm7 annotation (extent=[-110, -10; -90, 10]);
    end broom6zones;

    partial class broom7zones
      parameter Modelica.SIunits.Area AreaWalls[:]={16,16,16,16,16,16,16}
        "Area of Wall: #1...7";
      parameter Real Abs[:]={0.6,0.6,0.6,0.6,0.6,0.6,0.6}
        "Absorptance coefficient Wall #1...7";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Polygon(points=[-66, 48; -2, 82; 66, 48; 80, -24; 40, -80; -44, -80;
                 -82, -24; -66, 48], style(color=0)), Polygon(points=[-66, 48;
                -2, 82; 66, 48; 80, -24; 40, -80; -44, -80; -82, -24; -66, 48],
               style(color=0, thickness=2))),
        Diagram(Polygon(points=[-66, 48; -2, 82; 66, 48; 80, -24; 40, -80; -44,
                 -80; -82, -24; -66, 48], style(color=0)), Polygon(points=[-66,
                 48; -2, 82; 66, 48; 80, -24; 40, -80; -44, -80; -82, -24; -66,
                 48], style(color=0, thickness=2))),
        Window(
          x=0.34,
          y=0.23,
          width=0.6,
          height=0.6));
      therm therm7 annotation (extent=[-58, 62; -38, 82]);
      therm therm8 annotation (extent=[-12, 82; 8, 102]);
      therm therm6 annotation (extent=[-96, 6; -76, 26]);
      therm therm2 annotation (extent=[74, 6; 94, 26]);
      therm therm3 annotation (extent=[66, -68; 86, -48]);
      therm therm1 annotation (extent=[38, 62; 58, 82]);
      therm therm4 annotation (extent=[-12, -100; 8, -80]);
      therm therm5 annotation (extent=[-86, -68; -66, -48]);
    end broom7zones;

    partial class broom9zones
      parameter Modelica.SIunits.Area AreaWalls[:]={16,16,16,16,16,16,16,16,16}
        " Area of Wall: 1...9 ";
      parameter Real Abs[:]={0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6}
        "Absorbance coefficient Wall : # 1...9";
      parameter Modelica.SIunits.Area WindowArea=6;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Polygon(points=[0, 94; -60, 64; -90, 20; -80, -40; -30, -80; 30,
                 -80; 80, -40; 90, 20; 60, 64; 0, 94], style(color=0)), Polygon(
              points=[0, 94; -60, 64; -90, 20; -80, -40; -30, -80; 30, -80; 80,
                 -40; 90, 20; 60, 64; 0, 94], style(color=0, thickness=2))),
        Icon(Polygon(points=[0, 94; -60, 64; -90, 20; -80, -40; -30, -80; 30, -80;
                 80, -40; 90, 20; 60, 64; 0, 94], style(color=0)), Polygon(
              points=[0, 94; -60, 64; -90, 20; -80, -40; -30, -80; 30, -80; 80,
                 -40; 90, 20; 60, 64; 0, 94], style(color=0, thickness=2))),
        Window(
          x=0.23,
          y=0.24,
          width=0.6,
          height=0.6));
      therm therm8 annotation (extent=[-98, 38; -78, 58]);
      therm therm9 annotation (extent=[-70, 68; -50, 88]);
      therm therm1 annotation (extent=[50, 68; 70, 88]);
      therm therm2 annotation (extent=[78, 38; 98, 58]);
      therm therm3 annotation (extent=[86, -24; 106, -4]);
      therm therm4 annotation (extent=[58, -78; 78, -58]);
      therm therm5 annotation (extent=[-10, -100; 10, -80]);
      therm therm6 annotation (extent=[-78, -78; -58, -58]);
      therm therm7 annotation (extent=[-106, -24; -86, -4]);
      therm therm10 annotation (extent=[-10, 94; 10, 114]);
    end broom9zones;

    partial class sixtherm
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Polygon(points=[-80, 40; -40, 80; 40, 80; 80, 40; 80, -40; 40,
                -80; -40, -80; -80, -40; -80, 40], style(color=0))),
        Icon(Polygon(points=[-80, 40; -40, 80; 40, 80; 80, 40; 80, -40; 40, -80;
                 -40, -80; -80, -40; -80, 40], style(color=0))));
      therm therm1 annotation (extent=[-80, 60; -60, 80]);
      therm therm2 annotation (extent=[-8, 80; 12, 100]);
      therm therm3 annotation (extent=[60, 60; 80, 80]);
      therm therm4 annotation (extent=[60, -80; 80, -60]);
      therm therm5 annotation (extent=[-10, -100; 10, -80]);
      therm therm6 annotation (extent=[-80, -80; -60, -60]);
    end sixtherm;

    partial class roomconnect

      extends sixtherm;
      parameter Modelica.SIunits.ThermalConductivity lambdaWalls[:]={2.4,2.4,
          2.4,2.4,2.4,2.4} "Thermal Conductiovity: Walls # 1...6";
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaWalls[:]={2.0,
          2.0,2.0,2.0,2.0,2.0} "Heat Transfer coefficient: Wall #1...6";
      parameter Modelica.SIunits.Density rhoWalls[:]={1600,1600,1600,1600,1600,
          1600} "Density Wall: # 1...6";
      parameter Modelica.SIunits.SpecificHeatCapacity cWalls[:]={1000,1000,1000,
          1000,1000,1000} "Specific Heat capacity: Wall # 1...6";
      parameter SIunits.Thickness dWalls[:]={0.1,0.1,0.1,0.1,0.1,0.1}
        "Thickness: Wall #1...6";
      parameter Modelica.SIunits.Area AreaWalls[:]={16,16,16,16,16,16}
        "Area of Wall # 1...6";

      constant Modelica.SIunits.Density rhoAir=1.19;
      constant Modelica.SIunits.SpecificHeatCapacity cAir=1007;
      parameter Modelica.SIunits.Emissivity eps=0.94
        "emissions coeffizient wall";
      parameter Modelica.SIunits.Thickness d=0.4;
      parameter Modelica.SIunits.Length Length=4.0 "length of the room";
      parameter Modelica.SIunits.Length Width=4.0 "width of the room";
      parameter Modelica.SIunits.Length Heigth=4.0 "heigth of the room";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-40, 40; 40, -40], style(
              color=8,
              pattern=0,
              fillPattern=0)),
          Rectangle(extent=[-40, 40; 40, -40], style(color=49, pattern=0)),
          Line(points=[-74, -4; 8, -4], style(color=0)),
          Line(points=[-42, 36; -26, 46; 52, 46; 38, 36; -42, 36; -42, -44; -28,
                 -34; -28, 46; -28, -34; 52, -34; 38, -44; -42, -44; 38, -44;
                52, -34; 52, 46], style(color=0)),
          Line(points=[38, 36; 38, -44], style(color=0))),
        Window(
          x=0.13,
          y=0.32,
          width=0.6,
          height=0.6));
      Layer.chalfwall chalfwallwest(
        lambdaWall=lambdaWalls[1],
        alphaWall=alphaWalls[1],
        rhoWall=rhoWalls[1],
        cWall=cWalls[1],
        dWall=dWalls[1],
        AWall=AreaWalls[1]) annotation (extent=[-40, 40; -60, 60], rotation=90);
      Layer.chalfwall chalfwallceiling(
        lambdaWall=lambdaWalls[2],
        alphaWall=alphaWalls[2],
        rhoWall=rhoWalls[2],
        cWall=cWalls[2],
        dWall=dWalls[2],
        AWall=AreaWalls[2]) annotation (extent=[-8, 40; 12, 60], rotation=90);
      Layer.chalfwall chalfwallnorth(
        lambdaWall=lambdaWalls[3],
        alphaWall=alphaWalls[3],
        rhoWall=rhoWalls[3],
        cWall=cWalls[3],
        dWall=dWalls[3],
        AWall=AreaWalls[3]) annotation (extent=[40, 40; 60, 60], rotation=90);
      Layer.chalfwall chalfwalleast(
        lambdaWall=lambdaWalls[4],
        alphaWall=alphaWalls[4],
        rhoWall=rhoWalls[4],
        cWall=cWalls[4],
        dWall=dWalls[4],
        AWall=AreaWalls[4]) annotation (extent=[60, -56; 40, -36], rotation=-90);
      Layer.chalfwall chalfwallfloor(
        lambdaWall=lambdaWalls[5],
        alphaWall=alphaWalls[5],
        rhoWall=rhoWalls[5],
        cWall=cWalls[5],
        dWall=dWalls[5],
        AWall=AreaWalls[5]) annotation (extent=[12, -56; -8, -36], rotation=-90);
      Layer.chalfwall chalfwallsouth(
        lambdaWall=lambdaWalls[6],
        alphaWall=alphaWalls[6],
        rhoWall=rhoWalls[6],
        cWall=cWalls[6],
        dWall=dWalls[6],
        AWall=AreaWalls[6])
        annotation (extent=[-60, -56; -40, -36], rotation=-90);
      Elements.airload airload1(
        rho=rhoAir,
        c=cAir,
        V=Length*Width*Heigth) annotation (extent=[56, -40; 76, -20]);
      therm therm7 annotation (extent=[-100, -14; -80, 6]);
    equation
      connect(chalfwalleast.therm1, airload1.therm1) annotation (points=[50, -37;
             50, -4; 66, -4; 66, -21], style(color=65, thickness=2));
      connect(chalfwallnorth.therm1, airload1.therm1) annotation (points=[50,
            41; 50, -3; 66, -3; 66, -21], style(color=65, thickness=2));
      connect(chalfwallceiling.therm1, airload1.therm1) annotation (points=[2,
            41; 2, -3; 66, -3; 66, -21], style(color=65, thickness=2));
      connect(chalfwallfloor.therm1, airload1.therm1) annotation (points=[2, -37;
             2, -3; 66, -3; 66, -21], style(color=65, thickness=2));
      connect(chalfwallsouth.therm1, airload1.therm1) annotation (points=[-50,
            -37; -50, -3; 66, -3; 66, -21], style(color=65, thickness=2));
      connect(chalfwallwest.therm1, airload1.therm1) annotation (points=[-50,
            41; -50, -3; 66, -3; 66, -21], style(color=65, thickness=2));
      connect(chalfwallwest.therm2, therm1) annotation (points=[-50, 59; -50,
            70; -70, 70], style(color=45, thickness=2));
      connect(chalfwallceiling.therm2, therm2) annotation (points=[2, 59; 2,
            74.5; 2, 74.5; 2, 90], style(color=45, thickness=2));
      connect(chalfwallnorth.therm2, therm3) annotation (points=[50, 59; 50, 70;
             70, 70], style(color=45, thickness=2));
      connect(chalfwalleast.therm2, therm4) annotation (points=[50, -55; 50, -70;
             70, -70], style(color=45, thickness=2));
      connect(chalfwallfloor.therm2, therm5) annotation (points=[2, -55; 2, -90;
             0, -90], style(color=45, thickness=2));
      connect(chalfwallsouth.therm2, therm6) annotation (points=[-50, -55; -50,
             -70; -70, -70], style(color=45, thickness=2));
      connect(airload1.therm1, therm7) annotation (points=[66, -21; 66, -4; -90,
             -4], style(color=65, thickness=2));
    end roomconnect;

    class room6zones "model of a room which connected with other 6 zones."
      extends broom6zones;
      constant SIunits.Density rhoair=1.204 "Density of air";
      constant SIunits.SpecificHeatCapacity cair=1012
        "Specific heat capacity of air";
      parameter SIunits.Volume V=50 "Volume of room";
      parameter SIunits.HeatCapacity C=1007
        "Additional (absolute) heat capacity";
      parameter SIunits.Emissivity eps[:]={0.93,0.93,0.93,0.93,0.93,0.93}
        "emissions coeffizient: Wall #1...6";
      parameter SIunits.Density rhoWalls[:]={1600,1600,1600,1600,1600,1600}
        "Density: Wall #1...6";

      parameter SIunits.SpecificHeatCapacity cWalls[:]={1000,1000,1000,1000,
          1000,1000} "Specific heat capacity: Wall #1...1";

      parameter SIunits.ThermalConductivity lambdaWalls[:]={2.4,2.4,2.4,2.4,2.4,
          2.4} "Thermal conductivity: Wall #1...6";

      parameter SIunits.Thickness dWalls[:]={0.1,0.1,0.1,0.1,0.1,0.1}
        "Thickness: Wall #1...6";
      parameter SIunits.CoefficientOfHeatTransfer alphaWalls[:]={2.0,2.0,2.0,
          2.0,2.0,2.0} "Heat Transfer Coefficients: Walls #1...6";
      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambdaWalls[1],
        alphaWall=alphaWalls[1],
        rhoWall=rhoWalls[1],
        cWall=cWalls[1],
        dWall=dWalls[1],
        AWall=AreaWalls[1]) annotation (extent=[-44, 34; -56, 46], rotation=90);
      Building.Layer.chalfwall chalfwall4(
        lambdaWall=lambdaWalls[4],
        alphaWall=alphaWalls[4],
        rhoWall=rhoWalls[4],
        cWall=cWalls[4],
        dWall=dWalls[4],
        AWall=AreaWalls[4]) annotation (extent=[54, -46; 42, -34], rotation=-90);
      Building.Layer.chalfwall chalfwall6(
        lambdaWall=lambdaWalls[6],
        alphaWall=alphaWalls[6],
        rhoWall=rhoWalls[6],
        cWall=cWalls[6],
        dWall=dWalls[6],
        AWall=AreaWalls[6])
        annotation (extent=[-56, -46; -44, -34], rotation=-90);
      Building.Layer.chalfwall chalfwall5(
        lambdaWall=lambdaWalls[5],
        alphaWall=alphaWalls[5],
        rhoWall=rhoWalls[5],
        cWall=cWalls[5],
        dWall=dWalls[5],
        AWall=AreaWalls[5]) annotation (extent=[6, -46; -6, -34], rotation=-90);
      Building.Layer.chalfwall chalfwall3(
        lambdaWall=lambdaWalls[3],
        alphaWall=alphaWalls[3],
        rhoWall=rhoWalls[3],
        cWall=cWalls[3],
        dWall=dWalls[3],
        AWall=AreaWalls[3]) annotation (extent=[42, 34; 54, 46], rotation=90);
      Building.Layer.chalfwall chalfwall2(
        lambdaWall=lambdaWalls[2],
        alphaWall=alphaWalls[2],
        rhoWall=rhoWalls[2],
        cWall=cWalls[2],
        dWall=dWalls[2],
        AWall=AreaWalls[2]) annotation (extent=[-6, 34; 6, 46], rotation=90);
      Building.Elements.airload airload1(
        rho=rhoair,
        c=cair,
        V=V) annotation (extent=[62, -8; 78, 8], rotation=90);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Text(extent=[-90, 72; -78, 60], string="1"),
          Text(extent=[-22, 90; -8, 76], string="2"),
          Text(extent=[76, 72; 90, 58], string="3"),
          Text(extent=[84, -34; 96, -48], string="4"),
          Text(extent=[12, -78; 30, -92], string="5"),
          Text(extent=[-82, -64; -68, -78], string="6")),
        Icon(
          Rectangle(extent=[-48, 46; 48, -44], style(
              color=0,
              thickness=2,
              fillColor=52)),
          Line(points=[-100, 0; -50, 0; -50, 0], style(
              color=65,
              thickness=4,
              fillColor=65)),
          Text(extent=[-30, 28; 28, -24], string="6"),
          Text(extent=[-2, -22; -2, -40], string="%name"),
          Text(extent=[-94, 78; -78, 60], string="1"),
          Text(extent=[-32, 94; -12, 76], string="2"),
          Text(extent=[72, 78; 90, 58], string="3"),
          Text(extent=[84, -34; 102, -52], string="4"),
          Text(extent=[12, -78; 36, -98], string="5"),
          Text(extent=[-82, -64; -64, -82], string="6")),
        Window(
          x=0.16,
          y=0.17,
          width=0.68,
          height=0.65));
      Building.Elements.twostar twostar5(eps=eps[5], A=AreaWalls[5])
        annotation (extent=[-20, -34; -8, -22], rotation=90);
      Building.Elements.twostar twostar6(eps=eps[6], A=AreaWalls[6])
        annotation (extent=[-42, -34; -30, -22], rotation=90);
      Building.Elements.twostar twostar4(eps=eps[4], A=AreaWalls[4])
        annotation (extent=[26, -32; 38, -20], rotation=90);
      Building.Elements.twostar twostar2(eps=eps[2], A=AreaWalls[2])
        annotation (extent=[-20, 34; -8, 22], rotation=90);
      Building.Elements.twostar twostar1(eps=eps[1], A=AreaWalls[1])
        annotation (extent=[-42, 34; -30, 22], rotation=90);
      Building.Elements.twostar twostar3(eps=eps[3], A=AreaWalls[3])
        annotation (extent=[26, 34; 38, 22], rotation=90);
      Building.Elements.loadplus loadplus1(C=C)
        annotation (extent=[62, 8; 78, 24], rotation=90);
      therm therm8 annotation (extent=[-98, -38; -78, -18]);
    equation

      connect(chalfwall1.therm1, therm7) annotation (points=[-50, 34.6; -50, 0;
             -100, 0], style(color=65, thickness=2));
      connect(chalfwall6.therm1, therm7) annotation (points=[-50, -34.6; -50, 0;
             -100, 0], style(color=65, thickness=2));
      connect(chalfwall6.therm2, therm6)
        annotation (points=[-50, -45.4; -50, -52; -72, -52], style(color=73));
      connect(chalfwall2.therm2, therm2)
        annotation (points=[3.30644e-016,45.4; 0,82]);
      connect(chalfwall5.therm2, therm5)
        annotation (points=[-3.30644e-016,-45.4; 0,-82]);
      connect(chalfwall4.therm2, therm4)
        annotation (points=[48, -45.4; 48, -52; 72, -52]);
      connect(chalfwall6.therm3, twostar6.therm1)
        annotation (points=[-44.6, -40; -36, -40; -36, -33.4]);
      connect(twostar5.therm1, chalfwall5.therm3)
        annotation (points=[-14,-33.4; -14,-40; -5.4,-40]);
      connect(chalfwall1.therm3, twostar1.therm1)
        annotation (points=[-44.6, 40; -36, 40; -36, 33.4]);
      connect(chalfwall2.therm3, twostar2.therm1)
        annotation (points=[-5.4,40; -14,40; -14,33.4]);
      connect(chalfwall3.therm3, twostar3.therm1)
        annotation (points=[42.6, 40; 32, 40; 32, 33.4]);
      connect(chalfwall4.therm3, twostar4.therm1)
        annotation (points=[42.6, -40; 32, -40; 32, -31.4]);
      connect(twostar1.therm2, twostar6.therm2) annotation (points=[-36, 22.6;
            -36, -22.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar2.therm2) annotation (points=[-36, -22.6;
             -36, -6; -14, -6; -14, 22.6], style(color=41, thickness=2));
      connect(twostar2.therm2, twostar5.therm2) annotation (points=[-14, 22.6;
            -14, -22.6], style(color=41, thickness=2));
      connect(twostar5.therm2, twostar4.therm2) annotation (points=[-14, -22.6;
             -14, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
      connect(twostar4.therm2, twostar3.therm2) annotation (points=[32, -20.6;
            32, 22.6], style(color=41, thickness=2));
      connect(chalfwall1.therm2, therm1)
        annotation (points=[-50, 45.4; -50, 52; -72, 52]);
      connect(therm7, airload1.therm1) annotation (points=[-100,0; 62.8,
            4.40858e-016], style(color=65, thickness=2));
      connect(chalfwall5.therm1, therm7) annotation (points=[3.30644e-016,-34.6;
            0,0; -100,0],    style(color=65, thickness=2));
      connect(chalfwall2.therm1, therm7) annotation (points=[-3.30644e-016,34.6;
            -1.66534e-016,17.3; 0,0; -100,0],          style(color=65,
            thickness=2));
      connect(chalfwall3.therm1, therm7) annotation (points=[48, 34.6; 48, 0; -100,
             0], style(color=65, thickness=2));
      connect(chalfwall4.therm1, therm7) annotation (points=[48, -34.6; 48, 0;
            -100, 0], style(color=65, thickness=2));
      connect(twostar1.therm2, twostar2.therm2) annotation (points=[-36, 22.6;
            -36, -6; -14, -6; -14, 22.6], style(color=41, thickness=2));
      connect(twostar1.therm2, twostar5.therm2) annotation (points=[-36, 22.6;
            -36, -6; -14, -6; -14, -22.6], style(color=41, thickness=2));
      connect(twostar1.therm2, twostar4.therm2) annotation (points=[-36, 22.6;
            -36, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
      connect(twostar1.therm2, twostar3.therm2) annotation (points=[-36, 22.6;
            -36, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar5.therm2) annotation (points=[-36, -22.6;
             -36, -6; -14, -6; -14, -22.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar4.therm2) annotation (points=[-36, -22.6;
             -36, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar3.therm2) annotation (points=[-36, -22.6;
             -36, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
      connect(twostar2.therm2, twostar3.therm2) annotation (points=[-14, 22.6;
            -14, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
      connect(twostar2.therm2, twostar4.therm2) annotation (points=[-14, 22.6;
            -14, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
      connect(twostar5.therm2, twostar3.therm2) annotation (points=[-14, -22.6;
             -14, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
      connect(chalfwall3.therm2, therm3)
        annotation (points=[48, 45.4; 48, 52; 72, 52]);
      connect(therm8, twostar6.therm2) annotation (points=[-88, -28; -60, -28;
            -60, -8; -36, -8; -36, -22.6], style(color=41, thickness=2));
      connect(loadplus1.therm1, airload1.therm1) annotation (points=[62.8,16;
            48,16; 48,4.40858e-016; 62.8,4.40858e-016],    style(color=65,
            thickness=2));
    end room6zones;

    class room7zones "model of a room which is connected with 7 other rooms."
      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      extends broom7zones;
      Real Mean;
      Real S;
      Real[8] Temp;
      Real[8] A;
      SIunits.Temperature EmpfTem;
      parameter Real FFrame=0.2 "Ratio of frame area to window area";
      parameter SIunits.CoefficientOfHeatTransfer alphai=2
        "convective heat transfer coefficient (inside)";
      parameter SIunits.CoefficientOfHeatTransfer alphao=2
        "convective heat transfer coefficient (outside)";
      parameter SIunits.ThermalConductivity lambdawindow=2.4
        "Thermal conductivity of glass";
      constant SIunits.Density rhoair=1.204;
      constant SIunits.SpecificHeatCapacity cair=1012;
      parameter SIunits.Volume V=50 " Volume of Room";
      parameter SIunits.HeatCapacity C=1007 "Additonal capacitance";
      parameter SIunits.Emissivity eps[:]={0.93,0.93,0.93,0.93,0.93,0.93,0.93}
        "emissions coefficient: Wall # 1...7";
      parameter SIunits.Emissivity epsw=0.93 "emissions coeffizient window";
      parameter SIunits.Density rhoWalls[:]={1600,1600,1600,1600,1600,1600,1600}
        "Density: Wall #1...7";

      parameter SIunits.SpecificHeatCapacity cWalls[:]={1000,1000,1000,1000,
          1000,1000,1000} "Specific heat capacity: Wall #1...7";

      parameter SIunits.ThermalConductivity lambdaWalls[:]={2.4,2.4,2.4,2.4,2.4,
          2.4,2.4} "Thermal conductivity: Wall #1...7";

      parameter SIunits.Thickness dWalls[:]={0.1,0.1,0.1,0.1,0.1,0.1,0.1}
        "Thickness: Wall #1...7";
      parameter SIunits.CoefficientOfHeatTransfer alphaWalls[:]={2.0,2.0,2.0,
          2.0,2.0,2.0,2.0} "Heat Transfer Coefficients: Walls #1...7";
      Building.RoomAttribute.raddistributor7 raddistributor7_1(
        Area1=AreaWalls[1],
        Abs1=Abs[1],
        Area2=AreaWalls[2],
        Abs2=Abs[2],
        Area3=AreaWalls[3],
        Abs3=Abs[3],
        Abs4=Abs[4],
        Area5=AreaWalls[5],
        Abs5=Abs[5],
        Area6=AreaWalls[6],
        Abs6=Abs[6],
        Area7=AreaWalls[7],
        Abs7=Abs[7],
        Area4=AreaWalls[4]) annotation (extent=[-10, 2; 6, 18]);
      Building.Layer.chalfwall chalfwall7(
        lambdaWall=lambdaWalls[7],
        alphaWall=alphaWalls[7],
        rhoWall=rhoWalls[7],
        cWall=cWalls[7],
        dWall=dWalls[7],
        AWall=AreaWalls[7]) annotation (extent=[-32, 52; -44, 40]);
      Building.Layer.chalfwall chalfwall6(
        lambdaWall=lambdaWalls[6],
        alphaWall=alphaWalls[6],
        rhoWall=rhoWalls[6],
        cWall=cWalls[6],
        dWall=dWalls[6],
        AWall=AreaWalls[6]) annotation (extent=[-44, 22; -56, 10]);
      Building.Layer.chalfwall chalfwall3(
        lambdaWall=lambdaWalls[3],
        alphaWall=alphaWalls[3],
        rhoWall=rhoWalls[3],
        cWall=cWalls[3],
        dWall=dWalls[3],
        AWall=AreaWalls[3]) annotation (extent=[50, -58; 38, -46], rotation=-90);
      Building.Layer.chalfwall chalfwall5(
        lambdaWall=lambdaWalls[5],
        alphaWall=alphaWalls[5],
        rhoWall=rhoWalls[5],
        cWall=cWalls[5],
        dWall=dWalls[5],
        AWall=AreaWalls[5])
        annotation (extent=[-30, -46; -42, -58], rotation=90);
      Building.Layer.chalfwall chalfwall4(
        lambdaWall=lambdaWalls[4],
        alphaWall=alphaWalls[4],
        rhoWall=rhoWalls[4],
        cWall=cWalls[4],
        dWall=dWalls[4],
        AWall=AreaWalls[4]) annotation (extent=[-8, -68; 4, -56], rotation=-90);
      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambdaWalls[1],
        alphaWall=alphaWalls[1],
        rhoWall=rhoWalls[1],
        cWall=cWalls[1],
        dWall=dWalls[1],
        AWall=AreaWalls[1]) annotation (extent=[32, 52; 44, 40]);
      Building.Layer.chalfwall chalfwall2(
        lambdaWall=lambdaWalls[2],
        alphaWall=alphaWalls[2],
        rhoWall=rhoWalls[2],
        cWall=cWalls[2],
        dWall=dWalls[2],
        AWall=AreaWalls[2]) annotation (extent=[44, 22; 56, 10]);
      Building.Elements.airload airload1(
        rho=rhoair,
        c=cair,
        V=V) annotation (extent=[74, -4; 56, -20], rotation=-90);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Diagram(
          Text(extent=[-70, 76; -58, 64], string="7"),
          Text(extent=[-110, 24; -96, 10], string="6"),
          Text(extent=[-100, -52; -84, -64], string="5"),
          Text(extent=[-8, -100; 6, -112], string="4"),
          Text(extent=[86, -52; 98, -64], string="3"),
          Text(extent=[94, 22; 106, 10], string="2"),
          Text(extent=[58, 76; 70, 64], string="1")),
        Icon(
          Rectangle(extent=[-50, 42; 48, -48], style(
              color=0,
              thickness=2,
              fillColor=52)),
          Text(extent=[-20, 22; 16, -26], string="7"),
          Rectangle(extent=[-54, -6; -46, -40], style(color=0)),
          Line(points=[-2, 86; -2, 44], style(color=65, thickness=4)),
          Text(extent=[-40, -26; 44, -48], string="%name")),
        Window(
          x=0.13,
          y=0.06,
          width=0.6,
          height=0.6));
      Building.therm therm9 annotation (extent=[-102, -20; -82, 0]);
      Building.RoomAttribute.sglasswjoint2 glasswjoint1(
        comp_surf_orient_alias=comp_surf_orient_alias,
        WindowArea=WindowArea,
        cair=cair,
        rhoair=rhoair,
        V=V,
        alphai=alphai,
        alphao=alphao,
        d=0.01,
        lambda=lambdawindow,
        Abskoeff=0.3,
        Transkoeff=0.4) annotation (extent=[-61, -20.6; -45, -4.6]);
      Building.Elements.twostar twostar4(A=AreaWalls[4], eps=eps[4])
        annotation (extent=[4, -46; 16, -34], rotation=90);
      Building.Elements.twostar twostar3(A=AreaWalls[3], eps=eps[3])
        annotation (extent=[20, -46; 32, -34], rotation=90);
      Building.Elements.twostar twostar5(A=AreaWalls[5], eps=eps[5])
        annotation (extent=[-18, -47; -6, -35], rotation=90);
      Building.Elements.twostar twostar6(A=AreaWalls[6], eps=eps[6])
        annotation (extent=[-34, -8; -22, 4]);
      Building.Elements.twostar twostar7(A=AreaWalls[7], eps=eps[7])
        annotation (extent=[-34, 20; -22, 32]);
      Building.Elements.twostar twostar1(eps=eps[1], A=AreaWalls[1])
        annotation (extent=[30, 20; 18, 32]);
      Building.Elements.twostar twostar2(A=AreaWalls[2], eps=eps[2])
        annotation (extent=[30, -8; 18, 4]);
      Building.Elements.loadplus loadplus1(C=C)
        annotation (extent=[56, -36; 74, -20], rotation=90);
      Building.therm therm10 annotation (extent=[16, 72; 36, 92]);
      Building.Elements.twostar twostar8(A=WindowArea, eps=epsw)
        annotation (extent=[-34, -30; -22, -18]);
      Building.therm therm11 annotation (extent=[-96, -48; -76, -28]);
      Weather.t_and_sl_rad.CUTS.ic_total_rad_v ic_total_rad_v1(final n=Weather.
            t_and_sl_rad.n_of_surf_orient_def)
        annotation (extent=[-92, 32; -72, 52]);
      Modelica.Blocks.Interfaces.InPort ic_heat_gain
        annotation (extent=[80, 32; 71, 40]);
      Modelica.Blocks.Interfaces.InPort ic_air_change
        annotation (extent=[80, 43; 70, 52]);
      Building.Gain.vargain vargain1(k=0.2)
        annotation (extent=[6, 32; 18, 43], rotation=90);
      Building.Gain.vargain vargain2(k=0.8)
        annotation (extent=[-47, -43; -59, -32], rotation=90);
      parameter Modelica.SIunits.Area WindowArea=6 "Area of window";
    equation
      connect(chalfwall6.therm2, therm6)
        annotation (points=[-55.4, 16; -86, 16]);
      connect(chalfwall4.therm2, therm4)
        annotation (points=[-2, -67.4; -2, -78.7; -2, -78.7; -2, -90]);
      connect(twostar3.therm1, chalfwall3.therm3)
        annotation (points=[26, -45.4; 26, -52; 38.6, -52]);
      connect(twostar4.therm1, chalfwall4.therm3)
        annotation (points=[10, -45.4; 10, -62; 3.4, -62]);
      connect(chalfwall5.therm3, twostar5.therm1)
        annotation (points=[-30.6, -52; -12, -52; -12, -46.4]);
      connect(chalfwall6.therm3, twostar6.therm1)
        annotation (points=[-50, 10.6; -50, -2; -33.4, -2]);
      connect(chalfwall7.therm3, twostar7.therm1)
        annotation (points=[-38, 40.6; -38, 26; -33.4, 26]);
      connect(twostar1.therm1, chalfwall1.therm3)
        annotation (points=[29.4, 26; 38, 26; 38, 40.6]);
      connect(twostar2.therm1, chalfwall2.therm3)
        annotation (points=[29.4, -2; 50, -2; 50, 10.6]);
      connect(chalfwall7.therm1, therm8) annotation (points=[-32.6, 46; -2, 46;
             -2, 92], style(color=65, thickness=2));
      connect(chalfwall1.therm1, therm8) annotation (points=[32.6, 46; -2, 46;
            -2, 92], style(color=65, thickness=2));
      connect(chalfwall6.therm1, therm8) annotation (points=[-44.6, 16; -2, 16;
             -2, 92], style(color=65, thickness=2));
      connect(chalfwall2.therm1, therm8) annotation (points=[44.6, 16; -2, 16;
            -2, 92], style(color=65, thickness=2));
      connect(twostar7.therm2, twostar6.therm2) annotation (points=[-22.6, 26;
            -12, 26; -12, -2; -22.6, -2], style(color=41, thickness=2));
      connect(twostar7.therm2, twostar1.therm2) annotation (points=[-22.6, 26;
            18.6, 26], style(color=41, thickness=2));
      connect(chalfwall5.therm1, therm8) annotation (points=[-36, -46.6; -36, -12;
             -2, -12; -2, 92], style(color=65, thickness=2));
      connect(glasswjoint1.therm2, therm8) annotation (points=[-45.8, -12.6; -2,
             -12.6; -2, 92], style(color=65, thickness=2));
      connect(chalfwall3.therm1, therm8) annotation (points=[44, -46.6; 44, -12;
             -2, -12; -2, 92], style(color=65, thickness=2));
      connect(chalfwall4.therm1, therm8) annotation (points=[-2, -56.6; -2,
            17.7; -2, 17.7; -2, 92], style(color=65, thickness=2));
      connect(chalfwall2.therm2, therm2) annotation (points=[55.4, 16; 84, 16]);
      connect(therm1, chalfwall1.therm2)
        annotation (points=[48, 72; 48, 46; 43.4, 46]);
      connect(chalfwall7.therm2, therm7)
        annotation (points=[-43.4, 46; -48, 46; -48, 72]);
      connect(twostar2.therm2, twostar7.therm2) annotation (points=[18.6, -2; -12,
             -2; -12, 26; -22.6, 26], style(color=41, thickness=2));
      connect(twostar5.therm2, twostar7.therm2) annotation (points=[-12, -35.6;
             -12, 26; -22.6, 26], style(color=41, thickness=2));
      connect(twostar4.therm2, twostar7.therm2) annotation (points=[10, -34.6;
            10, -24; -12, -24; -12, 26; -22.6, 26], style(color=41, thickness=2));
      connect(twostar3.therm2, twostar7.therm2) annotation (points=[26, -34.6;
            26, -24; -12, -24; -12, 26; -22.6, 26], style(color=41, thickness=2));
      connect(chalfwall4.therm1, airload1.therm1) annotation (points=[-2, -56.6;
             -2, -12; 56.9, -12], style(color=65, thickness=2));
      connect(loadplus1.therm1, airload1.therm1) annotation (points=[56.9, -28;
             44, -28; 44, -12; 56.9, -12], style(color=65, thickness=2));
      connect(twostar8.therm2, twostar5.therm2) annotation (points=[-22.6, -24;
             -12, -24; -12, -35.6], style(color=41, thickness=2));
      connect(airload1.therm1, therm8) annotation (points=[56.9, -12; -2, -12;
            -2, 92], style(color=65, thickness=2));
      connect(glasswjoint1.therm2, airload1.therm1) annotation (points=[-45.8,
            -12.6; 5.55, -12.6; 5.55, -12; 56.9, -12], style(color=65,
            thickness=2));
      connect(glasswjoint1.therm2, chalfwall5.therm1) annotation (points=[-45.8,
             -12.6; -36, -12.6; -36, -46.6], style(color=65, thickness=2));
      connect(twostar5.therm2, twostar6.therm2) annotation (points=[-12, -35.6;
             -12, -2; -22.6, -2], style(color=41, thickness=2));
      connect(glasswjoint1.therm3, twostar8.therm1)
        annotation (points=[-45.8, -17.4; -40, -17.4; -40, -24; -33.4, -24]);
      connect(glasswjoint1.therm1, therm9) annotation (points=[-60.2, -12.6; -68.15,
             -12.6; -68.15, -10.6; -76.1, -10.6; -76.1, -10; -92, -10]);
      connect(glasswjoint1.therm5, therm11)
        annotation (points=[-60.2, -17.4; -60.2, -38; -86, -38]);
      connect(twostar2.therm2, twostar6.therm2) annotation (points=[18.6, -2; -22.6,
             -2], style(color=41, thickness=2));
      connect(chalfwall3.therm2, therm3)
        annotation (points=[44, -57.4; 59, -57.4; 59, -58; 76, -58]);
      connect(chalfwall5.therm2, therm5)
        annotation (points=[-36, -57.4; -56, -57.4; -56, -58; -76, -58]);
      connect(ic_total_rad_v1, glasswjoint1.ic_total_rad_v1)
        annotation (points=[-82, 42; -63, 42; -63, -7.8; -60.2, -7.8]);
      connect(vargain2.therm1, chalfwall5.therm1) annotation (points=[-47.6, -37.5;
             -36, -37.5; -36, -46.6], style(color=65, thickness=2));
      connect(ic_air_change, glasswjoint1.InPort1) annotation (points=[75, 47.5;
             65, 47.5; -2, 81; -65, 47; -81, -24; -53, -24; -53, -19.496]);
      connect(ic_heat_gain, vargain2.InPort) annotation (points=[75.5, 36; 67,
            36; 79, -24; 39, -79; -43, -79; -67, -45; -53, -45; -53, -42.45]);
      connect(ic_heat_gain, vargain1.InPort)
        annotation (points=[75.5, 36; 20, 36; 20, 32.55; 12, 32.55]);
      connect(raddistributor7_1.therm1, chalfwall1.therm3)
        annotation (points=[3.6, 14; 38, 14; 38, 40.6], style(color=45));
      connect(raddistributor7_1.therm7, chalfwall7.therm3)
        annotation (points=[-7.6, 14; -38, 14; -38, 40.6], style(color=45));
      connect(raddistributor7_1.therm2, chalfwall2.therm3) annotation (points=[
            3.6, 10; 26.8, 10; 26.8, 10.6; 50, 10.6], style(color=45));
      connect(raddistributor7_1.therm6, chalfwall6.therm3) annotation (points=[
            -7.6, 10; -28.8, 10; -28.8, 10.6; -50, 10.6], style(color=45));
      connect(raddistributor7_1.therm3, chalfwall3.therm3) annotation (points=[
            3.6, 6; 3.6, -18; 38.6, -18; 38.6, -52], style(color=45));
      connect(raddistributor7_1.therm5, chalfwall5.therm3) annotation (points=[
            -7.6, 6; -20, 6; -20, -52; -30.6, -52], style(color=45));
      connect(raddistributor7_1.therm4, chalfwall4.therm3) annotation (points=[
            -2, 2.8; -2, -50; 10, -50; 10, -62; 3.4, -62], style(color=45));
      connect(therm10, raddistributor7_1.therm8) annotation (points=[26, 82; 26,
             58; -2, 58; -2, 17.2], style(color=41, thickness=2));
      connect(vargain1.therm1, raddistributor7_1.therm8) annotation (points=[
            6.6, 37.5; -2, 37.5; -2, 17.2], style(color=41, thickness=2));
      connect(glasswjoint1.therm4, raddistributor7_1.therm8) annotation (points=
           [-45.8, -7.8; -20, -7.8; -20, 38; -2, 38; -2, 17.2], style(color=45));
      //Summe von Area*Wandtemperatur
      Temp = {chalfwall1.therm3.T,chalfwall2.therm3.T,chalfwall3.therm3.T,
        chalfwall4.therm3.T,chalfwall5.therm3.T,chalfwall6.therm3.T,chalfwall7.
        therm3.T,glasswjoint1.therm3.T};
      A = {AreaWalls[1],AreaWalls[2],AreaWalls[3],AreaWalls[4],AreaWalls[5],
        AreaWalls[6],AreaWalls[7],WindowArea};
      S = vector(Temp)*vector(A);
      Mean = S/sum(A);
      EmpfTem = (Mean + airload1.therm1.T)/2;

      if cardinality(ic_total_rad_v1) == 1 then
        for i in 1:ic_total_rad_v1.n loop
          ic_total_rad_v1.I[i] = 0;
        end for;
      end if;
    end room7zones;

    class room9zones "model of a room which is connected with 7 other rooms."
      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      extends broom9zones;
      Real Mean;
      Real S;
      Real[10] Temp;
      Real[10] A;
      SIunits.Temperature EmpfTem;
      parameter SIunits.Area FFrame=0.2 "Ratio of frame area to window area";
      parameter SIunits.CoefficientOfHeatTransfer alphai=2
        "convective heat transfer coefficient (inside)";
      parameter SIunits.CoefficientOfHeatTransfer alphao=2
        "convective heat transfer coefficient (outside)";
      parameter SIunits.ThermalConductivity lambdawindow=2.4
        "Thermal conductivity of glass";
      constant SIunits.Density rhoair=1.204;
      constant SIunits.SpecificHeatCapacity cair=1012;
      parameter SIunits.Volume V=50;
      parameter SIunits.HeatCapacity C=1007 "Additional capacitance";
      parameter SIunits.Emissivity eps[:]={0.93,0.93,0.93,0.93,0.93,0.93,0.93,
          0.93,0.93} "emissions coefficient: Wall # 1...9";
      parameter SIunits.Emissivity epsw=0.93 "emissions coeffizient window";
      parameter SIunits.Density rhoWalls[:]={1600,1600,1600,1600,1600,1600,1600,
          1600,1600} "Density: Wall #1...9";

      parameter SIunits.SpecificHeatCapacity cWalls[:]={1000,1000,1000,1000,
          1000,1000,1000,1000,1000} "Specific heat capacity: Wall #1...9";

      parameter SIunits.ThermalConductivity lambdaWalls[:]={2.4,2.4,2.4,2.4,2.4,
          2.4,2.4,2.4,2.4} "Thermal conductivity: Wall #1...9";

      parameter SIunits.Thickness dWalls[:]={0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,
          0.1} "Thickness: Wall #1...9";
      parameter SIunits.CoefficientOfHeatTransfer alphaWalls[:]={2.0,2.0,2.0,
          2.0,2.0,2.0,2.0,2.0,2.0} "Heat Transfer Coefficients: Walls #1...9";
      Building.RoomAttribute.raddistributor9 raddistributor9_1(
        Area1=AreaWalls[1],
        Abs1=Abs[1],
        Area2=AreaWalls[2],
        Abs2=Abs[2],
        Area3=AreaWalls[3],
        Abs3=Abs[3],
        Area4=AreaWalls[4],
        Abs4=Abs[4],
        Area5=AreaWalls[5],
        Abs5=Abs[5],
        Area6=AreaWalls[6],
        Abs6=Abs[6],
        Area7=AreaWalls[7],
        Abs7=Abs[7],
        Area8=AreaWalls[8],
        Abs8=Abs[8],
        Area9=AreaWalls[9],
        Abs9=Abs[9]) annotation (extent=[-10, 0; 10, 20]);
      Building.Layer.chalfwall chalfwall6(
        lambdaWall=lambdaWalls[6],
        alphaWall=alphaWalls[6],
        rhoWall=rhoWalls[6],
        cWall=cWalls[6],
        dWall=dWalls[6],
        AWall=AreaWalls[6] - WindowArea)
        annotation (extent=[-42, -56; -54, -44]);
      Building.Layer.chalfwall chalfwall4(
        lambdaWall=lambdaWalls[4],
        alphaWall=alphaWalls[4],
        rhoWall=rhoWalls[4],
        cWall=cWalls[4],
        dWall=dWalls[4],
        AWall=AreaWalls[4]) annotation (extent=[42, -56; 54, -44]);
      Building.Layer.chalfwall chalfwall3(
        lambdaWall=lambdaWalls[3],
        alphaWall=alphaWalls[3],
        rhoWall=rhoWalls[3],
        cWall=cWalls[3],
        dWall=dWalls[3],
        AWall=AreaWalls[3]) annotation (extent=[44, -24; 56, -12]);
      Building.Layer.chalfwall chalfwall7(
        lambdaWall=lambdaWalls[7],
        alphaWall=alphaWalls[7],
        rhoWall=rhoWalls[7],
        cWall=cWalls[7],
        dWall=dWalls[7],
        AWall=AreaWalls[7]) annotation (extent=[-44, -24; -56, -12]);
      Building.Layer.chalfwall chalfwall8(
        lambdaWall=lambdaWalls[8],
        alphaWall=alphaWalls[8],
        rhoWall=rhoWalls[8],
        cWall=cWalls[8],
        dWall=dWalls[8],
        AWall=AreaWalls[8]) annotation (extent=[-44, 8; -56, 20]);
      Building.Layer.chalfwall chalfwall9(
        lambdaWall=lambdaWalls[9],
        alphaWall=alphaWalls[9],
        rhoWall=rhoWalls[9],
        cWall=cWalls[9],
        dWall=dWalls[9],
        AWall=AreaWalls[9]) annotation (extent=[-44, 60; -56, 48]);
      Building.Layer.chalfwall chalfwall1(
        lambdaWall=lambdaWalls[1],
        alphaWall=alphaWalls[1],
        rhoWall=rhoWalls[1],
        cWall=cWalls[1],
        dWall=dWalls[1],
        AWall=AreaWalls[1]) annotation (extent=[40, 60; 52, 48]);
      Building.Layer.chalfwall chalfwall2(
        lambdaWall=lambdaWalls[2],
        alphaWall=alphaWalls[2],
        rhoWall=rhoWalls[2],
        cWall=cWalls[2],
        dWall=dWalls[2],
        AWall=AreaWalls[2]) annotation (extent=[42, 8; 54, 20]);
      Building.Layer.chalfwall chalfwall5(
        lambdaWall=lambdaWalls[5],
        alphaWall=alphaWalls[5],
        rhoWall=rhoWalls[5],
        cWall=cWalls[5],
        dWall=dWalls[5],
        AWall=AreaWalls[5]) annotation (extent=[-6, -58; 6, -70], rotation=90);
      Building.Elements.airload airload1(
        rho=rhoair,
        c=cair,
        V=V) annotation (extent=[-30, 68; -14, 84], rotation=-90);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.22,
          y=0.13,
          width=0.6,
          height=0.6),
        Icon(
          Rectangle(extent=[-50, 48; 52, -46], style(
              color=0,
              thickness=2,
              fillColor=52)),
          Text(extent=[-22, 26; 22, -24], string="9"),
          Text(extent=[42, 102; 66, 94], string="%Window"),
          Text(extent=[-28, 108; -10, 96], string="%Air"),
          Rectangle(extent=[10, 64; 48, 44], style(
              color=73,
              pattern=0,
              thickness=2)),
          Rectangle(extent=[10, 52; 46, 44], style(color=0)),
          Line(points=[0, 96; 0, 48], style(color=65, thickness=4)),
          Line(points=[-8, -16; 8, -16], style(thickness=2)),
          Text(extent=[-38, -20; 44, -42], string="%name")),
        Diagram(
          Text(extent=[72, 80; 84, 70], string="1"),
          Text(extent=[100, 54; 112, 44], string="2"),
          Text(extent=[108, -14; 120, -24], string="3"),
          Text(extent=[14, -88; 26, -98], string="5"),
          Text(extent=[84, -68; 96, -78], string="4"),
          Text(extent=[-92, -66; -80, -76], string="6"),
          Text(extent=[-118, -14; -106, -24], string="7"),
          Text(extent=[-84, 84; -72, 74], string="9"),
          Text(extent=[-112, 54; -100, 44], string="8")));
      Building.RoomAttribute.sglasswjoint2 glasswjoint1(
        comp_surf_orient_alias=comp_surf_orient_alias,
        WindowArea=WindowArea,
        cair=cair,
        rhoair=rhoair,
        V=V,
        alphai=alphai,
        alphao=alphao,
        d=0.01,
        lambda=lambdawindow,
        Abskoeff=0.3,
        Transkoeff=0.4) annotation (extent=[23, 84; 7, 68]);
      Building.therm therm11 annotation (extent=[30, 77; 50, 97]);
      Building.Elements.twostar twostar1(A=AreaWalls[1], eps=eps[1])
        annotation (extent=[28, 36; 16, 48]);
      Building.Elements.twostar twostar2(A=AreaWalls[2], eps=eps[2])
        annotation (extent=[28, 20; 16, 32]);
      Building.Elements.twostar twostar3(A=AreaWalls[3], eps=eps[3])
        annotation (extent=[28, -8; 16, 4]);
      Building.Elements.twostar twostar4(A=AreaWalls[4], eps=eps[4])
        annotation (extent=[28, -34; 16, -22]);
      Building.Elements.twostar twostar5(A=AreaWalls[5], eps=eps[5])
        annotation (extent=[-6, -30; -18, -42], rotation=-90);
      Building.Elements.twostar twostar6(A=AreaWalls[6], eps=eps[6])
        annotation (extent=[-24, -22; -36, -34], rotation=-180);
      Building.Elements.twostar twostar7(A=AreaWalls[7], eps=eps[7])
        annotation (extent=[-24, 4; -36, -8], rotation=-180);
      Building.Elements.twostar twostar8(A=AreaWalls[8], eps=eps[8])
        annotation (extent=[-24, 32; -36, 20], rotation=-180);
      Building.Elements.twostar twostar9(A=AreaWalls[9], eps=eps[9])
        annotation (extent=[-24, 48; -36, 36], rotation=-180);
      Building.Elements.loadplus loadplus1(C=C)
        annotation (extent=[-30, 54; -14, 70], rotation=-90);
      Building.therm therm12 annotation (extent=[-42, 82; -22, 102]);
      Building.Elements.twostar twostar10(A=WindowArea, eps=epsw)
        annotation (extent=[19, 59; 7, 47], rotation=90);
      Building.therm therm13 annotation (extent=[10, 88; 30, 108]);
      Weather.t_and_sl_rad.CUTS.ic_total_rad_v ic_total_rad_v1(final n=Weather.
            t_and_sl_rad.n_of_surf_orient_def)
        annotation (extent=[108, 8; 90, 28]);
      Building.Gain.vargain vargain1(k=0.8)
        annotation (extent=[13, -78; 28, -64]);
      Building.Gain.vargain vargain2(k=0.2)
        annotation (extent=[-14, 91; -2, 80]);
      Modelica.Blocks.Interfaces.InPort ic_air_change
        annotation (extent=[-99, 17; -92, 26]);
      Modelica.Blocks.Interfaces.InPort ic_heat_gain
        annotation (extent=[-99, 6; -92, 14]);
    equation
      connect(therm8, chalfwall8.therm2)
        annotation (points=[-88, 48; -68, 48; -68, 14; -55.4, 14]);
      connect(chalfwall7.therm2, therm7)
        annotation (points=[-55.4, -18; -75.7, -18; -75.7, -14; -96, -14]);
      connect(chalfwall6.therm2, therm6)
        annotation (points=[-53.4, -50; -68, -50; -68, -68]);
      connect(therm10, chalfwall5.therm1) annotation (points=[0, 104; -3.30644e-016,
             -58.6], style(color=65, thickness=2));
      connect(chalfwall8.therm1, therm10) annotation (points=[-44.6, 14; 0, 14;
             0, 104], style(color=65, thickness=2));
      connect(chalfwall2.therm1, therm10) annotation (points=[42.6, 14; 0, 14;
            0, 104], style(color=65, thickness=2));
      connect(chalfwall9.therm1, therm10) annotation (points=[-44.6, 54; 0, 54;
             0, 104], style(color=65, thickness=2));
      connect(chalfwall1.therm1, therm10) annotation (points=[40.6, 54; 0, 54;
            0, 104], style(color=65, thickness=2));
      connect(chalfwall9.therm2, therm9)
        annotation (points=[-55.4, 54; -60, 54; -60, 78]);
      connect(chalfwall5.therm2, therm5)
        annotation (points=[3.30644e-016, -69.4; 0, -90]);
      connect(chalfwall1.therm2, therm1)
        annotation (points=[51.4, 54; 60, 54; 60, 78]);
      connect(chalfwall2.therm2, therm2)
        annotation (points=[53.4, 14; 70, 14; 70, 48; 88, 48]);
      connect(twostar5.therm1, chalfwall5.therm3)
        annotation (points=[-12, -41.4; -12, -64; -5.4, -64]);
      connect(twostar6.therm1, chalfwall6.therm3)
        annotation (points=[-35.4, -28; -48, -28; -48, -44.6]);
      connect(twostar7.therm1, chalfwall7.therm3)
        annotation (points=[-35.4, -2; -50, -2; -50, -12.6]);
      connect(twostar8.therm1, chalfwall8.therm3)
        annotation (points=[-35.4, 26; -50, 26; -50, 19.4]);
      connect(twostar9.therm1, chalfwall9.therm3)
        annotation (points=[-35.4, 42; -50, 42; -50, 48.6]);
      connect(twostar1.therm1, chalfwall1.therm3)
        annotation (points=[27.4, 42; 46, 42; 46, 48.6]);
      connect(twostar2.therm1, chalfwall2.therm3)
        annotation (points=[27.4, 26; 48, 26; 48, 19.4]);
      connect(twostar3.therm1, chalfwall3.therm3)
        annotation (points=[27.4, -2; 50, -2; 50, -12.6]);
      connect(twostar4.therm1, chalfwall4.therm3)
        annotation (points=[27.4, -28; 48, -28; 48, -44.6]);
      connect(twostar9.therm2, twostar1.therm2) annotation (points=[-24.6, 42;
            16.6, 42], style(color=41, thickness=2));
      connect(twostar9.therm2, twostar8.therm2) annotation (points=[-24.6, 42;
            -12, 42; -12, 26; -24.6, 26], style(color=41, thickness=2));
      connect(twostar8.therm2, twostar2.therm2) annotation (points=[-24.6, 26;
            16.6, 26], style(color=41, thickness=2));
      connect(twostar2.therm2, twostar3.therm2) annotation (points=[16.6, 26; -12,
             26; -12, -2; 16.6, -2], style(color=41, thickness=2));
      connect(twostar7.therm2, twostar3.therm2) annotation (points=[-24.6, -2;
            -4, -2; -4, -2; 16.6, -2], style(color=41, thickness=2));
      connect(twostar7.therm2, twostar5.therm2) annotation (points=[-24.6, -2;
            -12, -2; -12, -30.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar5.therm2) annotation (points=[-24.6, -28;
             -12, -28; -12, -30.6], style(color=41, thickness=2));
      connect(twostar4.therm2, twostar5.therm2) annotation (points=[16.6, -28;
            -12, -28; -12, -30.6], style(color=41, thickness=2));
      connect(chalfwall7.therm1, therm10) annotation (points=[-44.6, -18; 0, -18;
             0, 104], style(color=65, thickness=2));
      connect(chalfwall3.therm1, therm10) annotation (points=[44.6, -18; 0, -18;
             0, 104], style(color=65, thickness=2));
      connect(chalfwall4.therm2, therm4)
        annotation (points=[53.4, -50; 68, -50; 68, -68]);
      connect(chalfwall3.therm2, therm3)
        annotation (points=[55.4, -18; 75.7, -18; 75.7, -14; 96, -14]);
      connect(airload1.therm1, therm10) annotation (points=[-14.8, 76; 0, 76; 0,
             104], style(color=65, thickness=2));
      connect(airload1.therm1, glasswjoint1.therm2)
        annotation (points=[-14.8, 76; 7.8, 76], style(color=65, thickness=2));
      connect(chalfwall4.therm1, therm10) annotation (points=[42.6, -50; 0, -50;
             0, 104], style(color=65, thickness=2));
      connect(chalfwall6.therm1, therm10) annotation (points=[-42.6, -50; 0, -50;
             0, 104], style(color=65, thickness=2));
      connect(twostar9.therm2, twostar2.therm2) annotation (points=[-24.6, 42;
            -12, 42; -12, 26; 16.6, 26], style(color=41, thickness=2));
      connect(twostar9.therm2, twostar7.therm2) annotation (points=[-24.6, 42;
            -12, 42; -12, -2; -24.6, -2], style(color=41, thickness=2));
      connect(twostar9.therm2, twostar3.therm2) annotation (points=[-24.6, 42;
            -12, 42; -12, -2; 16.6, -2], style(color=41));
      connect(twostar9.therm2, twostar5.therm2)
        annotation (points=[-24.6, 42; -12, 42; -12, -30.6], style(color=41));
      connect(twostar9.therm2, twostar6.therm2) annotation (points=[-24.6, 42;
            -12, 42; -12, -28; -24.6, -28], style(color=41));
      connect(twostar9.therm2, twostar4.therm2) annotation (points=[-24.6, 42;
            -12, 42; -12, -28; 16.6, -28], style(color=41));
      connect(twostar1.therm2, twostar2.therm2) annotation (points=[16.6, 42; -12,
             42; -12, 26; 16.6, 26], style(color=41));
      connect(twostar1.therm2, twostar8.therm2) annotation (points=[16.6, 42; -12,
             42; -12, 26; -24.6, 26], style(color=41));
      connect(twostar8.therm2, twostar7.therm2) annotation (points=[-24.6, 26;
            -12, 26; -12, -2; -24.6, -2], style(color=41));
      connect(twostar8.therm2, twostar3.therm2) annotation (points=[-24.6, 26;
            -12, 26; -12, -2; 16.6, -2], style(color=41));
      connect(twostar8.therm2, twostar5.therm2)
        annotation (points=[-24.6, 26; -12, 26; -12, -30.6], style(color=41));
      connect(twostar8.therm2, twostar6.therm2) annotation (points=[-24.6, 26;
            -12, 26; -12, -28; -24.6, -28], style(color=41));
      connect(twostar8.therm2, twostar4.therm2) annotation (points=[-24.6, 26;
            -12, 26; -12, -28; 16.6, -28], style(color=41));
      connect(twostar2.therm2, twostar7.therm2) annotation (points=[16.6, 26; -12,
             26; -12, -2; -24.6, -2], style(color=41));
      connect(twostar2.therm2, twostar4.therm2) annotation (points=[16.6, 26; -12,
             26; -12, -28; 16.6, -28], style(color=41));
      connect(twostar2.therm2, twostar6.therm2) annotation (points=[16.6, 26; -12,
             26; -12, -28; -24.6, -28], style(color=41));
      connect(twostar3.therm2, twostar5.therm2)
        annotation (points=[16.6, -2; -12, -2; -12, -30.6], style(color=41));
      connect(twostar7.therm2, twostar6.therm2) annotation (points=[-24.6, -2;
            -12, -2; -12, -28; -24.6, -28], style(color=41));
      connect(twostar7.therm2, twostar4.therm2) annotation (points=[-24.6, -2;
            -12, -2; -12, -28; 16.6, -28], style(color=41));
      connect(twostar6.therm2, twostar4.therm2)
        annotation (points=[-24.6, -28; 16.6, -28], style(color=41));
      connect(loadplus1.therm1, therm10) annotation (points=[-14.8, 62; 0, 62;
            0, 104], style(color=65, thickness=2));
      connect(twostar10.therm2, twostar1.therm2) annotation (points=[13, 47.6;
            13, 42; 16.6, 42], style(color=41, thickness=2));
      connect(twostar10.therm2, twostar9.therm2) annotation (points=[13, 47.6;
            13, 42; -24.6, 42], style(color=41, thickness=2));
      connect(glasswjoint1.therm1, therm11)
        annotation (points=[22.2, 76; 40, 76; 40, 87]);
      connect(glasswjoint1.therm5, therm13)
        annotation (points=[22.2, 80.8; 20, 98]);
      connect(glasswjoint1.therm3, twostar10.therm1)
        annotation (points=[7.8, 80.8; 3, 80.8; 3, 67; 13, 67; 13, 58.4]);
      connect(glasswjoint1.ic_total_rad_v1, ic_total_rad_v1) annotation (points=
           [22.2, 71.2; 39, 71.2; 39, 64; 57, 64; 57, 18; 99, 18], style(color=
              45, thickness=2));
      connect(vargain1.therm1, chalfwall5.therm1) annotation (points=[20.5, -64.7;
             20.5, -50; -3.30644e-016, -50; -3.30644e-016, -58.6], style(color=
              65, thickness=2));
      connect(ic_air_change, glasswjoint1.InPort1) annotation (points=[-95.5,
            21.5; -87, 21.5; -59, 63; 0, 92; 15, 85; 15, 82.896]);
      connect(ic_heat_gain, vargain2.InPort) annotation (points=[-95.5, 10; -87,
             10; -88, 20; -59, 63; -13.4, 85.5]);
      connect(ic_heat_gain, vargain1.InPort) annotation (points=[-95.5, 10; -87,
             10; -79, -39; -30, -78; 10, -78; 10, -71; 13.75, -71]);
      connect(raddistributor9_1.therm1, chalfwall1.therm3)
        annotation (points=[7, 16; 7, 36; 46, 36; 46, 48.6], style(color=45));
      connect(chalfwall9.therm3, raddistributor9_1.therm9) annotation (points=[
            -50, 48.6; -50, 36; -7, 36; -7, 16], style(color=45));
      connect(chalfwall8.therm3, raddistributor9_1.therm8) annotation (points=[
            -50, 19.4; -50, 24; -40, 24; -40, 12; -7, 12], style(color=45));
      connect(raddistributor9_1.therm7, chalfwall7.therm3)
        annotation (points=[-7, 8; -50, 8; -50, -12.6], style(color=45));
      connect(raddistributor9_1.therm6, chalfwall6.therm3) annotation (points=[
            -7, 4; -7, -22; -42, -22; -42, -44.6; -48, -44.6], style(color=45));
      connect(chalfwall2.therm3, raddistributor9_1.therm2) annotation (points=[
            48, 19.4; 34, 19.4; 34, 12; 7, 12], style(color=45));
      connect(raddistributor9_1.therm3, chalfwall3.therm3)
        annotation (points=[7, 8; 50, 8; 50, -12.6], style(color=45));
      connect(raddistributor9_1.therm4, chalfwall4.therm3) annotation (points=[
            7, 4; 7, -22; 42, -22; 42, -44.6; 48, -44.6], style(color=45));
      connect(raddistributor9_1.therm5, chalfwall5.therm3) annotation (points=[
            0, 1; 0, -54; -5.4, -54; -5.4, -64], style(color=45));
      connect(glasswjoint1.therm4, raddistributor9_1.therm10)
        annotation (points=[7.8, 71.2; 0, 71.2; 0, 19], style(color=45));
      connect(therm12, raddistributor9_1.therm10) annotation (points=[-32, 92;
            -32, 51; 0, 51; 0, 19], style(color=41, thickness=2));
      connect(vargain2.therm1, raddistributor9_1.therm10) annotation (points=[-8,
             80.55; -8, 71; 0, 71; 0, 19], style(color=41, thickness=2));
      if cardinality(ic_total_rad_v1) == 1 then
        for i in 1:ic_total_rad_v1.n loop
          ic_total_rad_v1.I[i] = 0;
        end for;
      end if;
      //Summe von Area*Wandtemperatur
      Temp = {chalfwall1.therm3.T,chalfwall2.therm3.T,chalfwall3.therm3.T,
        chalfwall4.therm3.T,chalfwall5.therm3.T,chalfwall6.therm3.T,chalfwall7.
        therm3.T,chalfwall8.therm3.T,chalfwall9.therm3.T,glasswjoint1.therm3.T};
      A = {AreaWalls[1],AreaWalls[2],AreaWalls[3],AreaWalls[4],AreaWalls[5],
        AreaWalls[6],AreaWalls[7],AreaWalls[8],AreaWalls[9],WindowArea};
      S = vector(Temp)*vector(A);
      Mean = S/sum(A);
      EmpfTem = (Mean + airload1.therm1.T)/2;
    end room9zones;

    class roomA
      extends sixtherm;
      parameter Modelica.SIunits.ThermalConductivity lambdaStone=2.4;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaStone=2.0;
      parameter Modelica.SIunits.Density rhoStone=1600;
      parameter Modelica.SIunits.SpecificHeatCapacity cStone=1000;
      constant Modelica.SIunits.Density rhoAir=1.19;
      constant Modelica.SIunits.SpecificHeatCapacity cAir=1007;
      parameter Modelica.SIunits.Thickness d=0.4;
      parameter Modelica.SIunits.Length Width=4.0 "width of the room";
      parameter Modelica.SIunits.Length Length=4.0 "length of the room";
      parameter Modelica.SIunits.Length Heigth=4.0 "heigth of the room";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-60, 40; 40, -60], style(
              color=0,
              pattern=0,
              fillColor=47)),
          Rectangle(extent=[-56, 34; 36, -56]),
          Polygon(points=[-56, -56; -40, -40; 36, -40; 36, -56; -56, -56],
              style(color=0, fillColor=48)),
          Polygon(points=[-56, -56; -40, -40; -40, 34; -56, 34; -56, -56],
              style(color=0, fillColor=46)),
          Rectangle(extent=[-40, 34; 36, -40], style(color=0, fillColor=68)),
          Polygon(points=[40, 40; 60, 60; 60, -38; 40, -60; 40, 40], style(
                color=0, fillColor=45)),
          Rectangle(extent=[-60, 40; 40, -60], style(color=0)),
          Polygon(points=[-60, 40; -40, 60; 60, 60; 40, 40; -60, 40], style(
                color=0, fillColor=46)),
          Line(points=[-56, 56; -40, 70; -10, 70], style(color=8)),
          Polygon(points=[-20, 74; -20, 66; -8, 70; -20, 74], style(color=8,
                fillColor=8)),
          Ellipse(extent=[-58, 58; -54, 54], style(color=8, fillColor=8)),
          Rectangle(extent=[-82, 2; -60, -6], style(color=0, fillColor=68)),
          Ellipse(extent=[-52, 4; -46, -6], style(color=0, fillColor=68)),
          Ellipse(extent=[-24, 22; -10, -8]),
          Ellipse(extent=[-24, 22; -10, -8]),
          Ellipse(extent=[-24, 22; -10, -8]),
          Ellipse(extent=[-24, 22; -10, -8], style(color=7, fillColor=7)),
          Ellipse(extent=[-16, 14; 6, -18], style(color=7, fillColor=7)),
          Ellipse(extent=[-26, -6; -6, -28], style(color=7, fillColor=7)),
          Ellipse(extent=[-10, 12; 12, -20], style(color=7, fillColor=7)),
          Ellipse(extent=[0, 22; 22, -10], style(color=7, fillColor=7)),
          Ellipse(extent=[-2, -4; 20, -36], style(color=7, fillColor=7)),
          Ellipse(extent=[-34, 4; 30, -14], style(color=7, fillColor=7))),
        Window(
          x=0.22,
          y=0.28,
          width=0.6,
          height=0.6));
      Elements.airload airload1(
        rho=rhoAir,
        c=cAir,
        V=Length*Heigth*Width) annotation (extent=[46, -26; 66, -6]);
      Layer.halfwall wallwest(
        lambdaWall=lambdaStone,
        alphaWall=alphaStone,
        rhoWall=rhoStone,
        cWall=cStone,
        dWall=d,
        AWall=Length*Heigth) annotation (extent=[-50, 40; -30, 60], rotation=90);
      Layer.halfwall ceiling(
        lambdaWall=lambdaStone,
        alphaWall=alphaStone,
        rhoWall=rhoStone,
        cWall=cStone,
        dWall=d,
        AWall=Width*Length) annotation (extent=[-6, 40; 14, 60], rotation=90);
      Layer.halfwall wallnorth(
        lambdaWall=lambdaStone,
        alphaWall=alphaStone,
        rhoWall=rhoStone,
        cWall=cStone,
        dWall=d,
        AWall=Width*Heigth) annotation (extent=[30, 40; 50, 60], rotation=90);
      Layer.halfwall walleast(
        lambdaWall=lambdaStone,
        alphaWall=alphaStone,
        rhoWall=rhoStone,
        cWall=cStone,
        dWall=d,
        AWall=Length*Heigth)
        annotation (extent=[30, -60; 50, -40], rotation=-90);
      Layer.halfwall floor(
        lambdaWall=lambdaStone,
        alphaWall=alphaStone,
        rhoWall=rhoStone,
        cWall=cStone,
        dWall=d,
        AWall=Length*Width) annotation (extent=[-6, -60; 14, -40], rotation=-90);
      Layer.halfwall wallsouth(
        lambdaWall=lambdaStone,
        alphaWall=alphaStone,
        rhoWall=rhoStone,
        cWall=cStone,
        dWall=d,
        AWall=Width*Heigth)
        annotation (extent=[-52, -60; -32, -40], rotation=-90);
      therm therm7 annotation (extent=[-100, -12; -80, 8]);
    equation
      connect(wallnorth.therm2, therm3) annotation (points=[40, 59; 40, 70; 70,
             70], style(color=45, thickness=2));
      connect(ceiling.therm2, therm2) annotation (points=[4, 59; 4, 92; 2, 92;
            2, 90], style(color=45, thickness=2));
      connect(wallwest.therm2, therm1) annotation (points=[-40, 59; -40, 70; -70,
             70], style(color=45, thickness=2));
      connect(therm6, wallsouth.therm2) annotation (points=[-70, -70; -42, -70;
             -42, -59], style(color=45, thickness=2));
      connect(floor.therm2, therm5) annotation (points=[4, -59; 4, -88; 0, -88;
             0, -90], style(color=45, thickness=2));
      connect(walleast.therm2, therm4) annotation (points=[40, -59; 40, -70; 70,
             -70], style(color=45, thickness=2));
      connect(wallnorth.therm1, airload1.therm1) annotation (points=[40, 41; 40,
             18; 56, 18; 56, -7], style(color=65, thickness=2));
      connect(ceiling.therm1, airload1.therm1) annotation (points=[4, 41; 4, 18;
             56, 18; 56, -7], style(color=65, thickness=2));
      connect(wallwest.therm1, airload1.therm1) annotation (points=[-40, 41; -42,
             41; -42, 18; 56, 18; 56, -7], style(color=65, thickness=2));
      connect(walleast.therm1, airload1.therm1) annotation (points=[40, -41; 40,
             18; 56, 18; 56, -7], style(color=65, thickness=2));
      connect(floor.therm1, airload1.therm1) annotation (points=[4, -41; 4, 18;
             56, 18; 56, -7], style(color=65, thickness=2));
      connect(wallsouth.therm1, airload1.therm1) annotation (points=[-42, -41;
            -42, 18; 56, 18; 56, -7], style(color=65, thickness=2));
      connect(airload1.therm1, therm7) annotation (points=[56, -7; 56, 18; -90,
             18; -90, -2], style(color=65, thickness=2));
    end roomA;

    class twostarroom
      extends roomconnect;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-60, 40; 40, -60], style(
              color=0,
              pattern=0,
              fillColor=47)),
          Rectangle(extent=[-56, 34; 36, -56]),
          Polygon(points=[-56, -56; -40, -40; 36, -40; 36, -56; -56, -56],
              style(color=0, fillColor=48)),
          Polygon(points=[-56, -56; -40, -40; -40, 34; -56, 34; -56, -56],
              style(color=0, fillColor=46)),
          Rectangle(extent=[-40, 34; 36, -40], style(color=0, fillColor=68)),
          Polygon(points=[40, 40; 60, 60; 60, -38; 40, -60; 40, 40], style(
                color=0, fillColor=45)),
          Rectangle(extent=[-60, 40; 40, -60], style(color=0)),
          Polygon(points=[-60, 40; -40, 60; 60, 60; 40, 40; -60, 40], style(
                color=0, fillColor=46)),
          Line(points=[-56, 56; -40, 70; -10, 70], style(color=8)),
          Polygon(points=[-20, 74; -20, 66; -8, 70; -20, 74], style(color=8,
                fillColor=8)),
          Ellipse(extent=[-58, 58; -54, 54], style(color=8, fillColor=8)),
          Rectangle(extent=[-82, 2; -60, -6], style(color=0, fillColor=68)),
          Ellipse(extent=[-52, 4; -46, -6], style(color=0, fillColor=68)),
          Ellipse(extent=[14, 18; 28, 2], style(color=7, fillColor=7)),
          Ellipse(extent=[6, 8; 22, -8], style(color=7, fillColor=7)),
          Ellipse(extent=[14, 8; 32, -26], style(color=7, fillColor=7)),
          Ellipse(extent=[8, -12; 24, -28], style(color=7, fillColor=7)),
          Ellipse(extent=[4, 0; 20, -16], style(color=7, fillColor=7)),
          Polygon(points=[-18, 4; -32, 22; -24, 2; -36, 2; -26, -10; -34, -28;
                -16, -14; -12, -34; -8, -10; 0, -16; -6, -2; 4, 12; -6, 4; -14,
                 0; -12, 18; -16, 4; -18, 4], style(color=41, fillColor=41))),
        Window(
          x=0.33,
          y=0.21,
          width=0.6,
          height=0.6));
      Elements.twostar twostar1(A=Length*Heigth, eps=eps)
        annotation (extent=[-46, 20; -26, 40], rotation=-90);
      Elements.twostar twostar2(A=Length*Width, eps=eps)
        annotation (extent=[-24, 20; -4, 40], rotation=-90);
      Elements.twostar twostar3(A=Width*Heigth, eps=eps)
        annotation (extent=[16, 20; 36, 40], rotation=-90);
      Elements.twostar twostar4(A=Length*Heigth, eps=eps)
        annotation (extent=[16, -30; 36, -10], rotation=90);
      Elements.twostar twostar5(A=Length*Width, eps=eps)
        annotation (extent=[-24, -30; -4, -10], rotation=90);
      Elements.twostar twostar6(A=Width*Heigth, eps=eps)
        annotation (extent=[-46, -30; -26, -10], rotation=90);
    equation
      connect(chalfwallwest.therm3, twostar1.therm1) annotation (points=[-41,
            50; -36, 50; -36, 39], style(color=41, thickness=2));
      connect(twostar2.therm1, chalfwallceiling.therm3) annotation (points=[-14,
             39; -14, 50; -7, 50], style(color=41, thickness=2));
      connect(twostar3.therm1, chalfwallnorth.therm3) annotation (points=[26,
            39; 26, 50; 41, 50], style(color=41, thickness=2));
      connect(chalfwalleast.therm3, twostar4.therm1) annotation (points=[41, -46;
             26, -46; 26, -29], style(color=41, thickness=2));
      connect(chalfwallfloor.therm3, twostar5.therm1) annotation (points=[-7, -46;
             -14, -46; -14, -29], style(color=41, thickness=2));
      connect(chalfwallsouth.therm3, twostar6.therm1) annotation (points=[-41,
            -46; -36, -46; -36, -29], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar4.therm2) annotation (points=[-36, -11; -36,
             8; 26, 8; 26, -11], style(color=41, thickness=2));
      connect(twostar1.therm2, twostar6.therm2)
        annotation (points=[-36, 21; -36, -11], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar5.therm2) annotation (points=[-36, -11; -36,
             8; -14, 8; -14, -11], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar2.therm2) annotation (points=[-36, -11; -36,
             8; -14, 8; -14, 21], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar3.therm2) annotation (points=[-36, -11; -36,
             8; 26, 8; 26, 21], style(color=41, thickness=2));
    end twostarroom;

    class radroom
      extends roomconnect;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-60, 40; 40, -60], style(
              color=0,
              pattern=0,
              fillColor=47)),
          Rectangle(extent=[-56, 34; 36, -56]),
          Polygon(points=[-56, -56; -40, -40; 36, -40; 36, -56; -56, -56],
              style(color=0, fillColor=48)),
          Polygon(points=[-56, -56; -40, -40; -40, 34; -56, 34; -56, -56],
              style(color=0, fillColor=46)),
          Rectangle(extent=[-40, 34; 36, -40], style(color=0, fillColor=68)),
          Polygon(points=[40, 40; 60, 60; 60, -38; 40, -60; 40, 40], style(
                color=0, fillColor=45)),
          Rectangle(extent=[-60, 40; 40, -60], style(color=0)),
          Line(points=[-56, 56; -40, 70; -10, 70], style(color=8)),
          Polygon(points=[-20, 74; -20, 66; -8, 70; -20, 74], style(color=8,
                fillColor=8)),
          Ellipse(extent=[-58, 58; -54, 54], style(color=8, fillColor=8)),
          Ellipse(extent=[-52, 4; -46, -6], style(color=0, fillColor=68)),
          Rectangle(extent=[-82, 2; -60, -6], style(color=0, fillColor=68)),
          Polygon(points=[-60, 40; -40, 60; 60, 60; 40, 40; -60, 40], style(
                color=0, fillColor=46)),
          Ellipse(extent=[-34, 4; 30, -14], style(color=7, fillColor=7)),
          Ellipse(extent=[-18, 14; 30, -14], style(color=7, fillColor=7)),
          Ellipse(extent=[-26, 22; 0, -30], style(color=7, fillColor=7)),
          Ellipse(extent=[-34, 12; 14, -24], style(color=7, fillColor=7)),
          Line(points=[10, -4; 10, 34; -26, 10; 10, 34; 28, 8], style(color=41)),
          Line(points=[-48, -16; -16, 8; -48, -16; 0, -16; -48, -16; -18, -30]),
          Line(points=[-28, -28; -4, -50; -4, -8; -4, -50; 18, -32], style(
                color=0, fillColor=54)),
          Line(points=[34, -10; 8, 18; 34, -10; -18, -10; 34, -10; 8, -30],
              style(color=81))),
        Diagram,
        Window(
          x=0.38,
          y=0.15,
          width=0.6,
          height=0.6));

      Elements.radexchange radexchange1(
        Length=Length,
        Width=Width,
        Heigth=Heigth,
        eps=eps) annotation (extent=[-30, -30; -10, -10]);
    equation
      connect(chalfwallwest.therm3, radexchange1.therm1) annotation (points=[-41,
             50; -32, 50; -32, -13; -27, -13], style(color=85, thickness=2));
      connect(radexchange1.therm2, chalfwallceiling.therm3) annotation (points=
            [-19.8, -11; -19.8, 50; -7, 50], style(color=85, thickness=2));
      connect(radexchange1.therm3, chalfwallnorth.therm3) annotation (points=[-13,
             -13; 32, -13; 32, 50; 41, 50], style(color=85, thickness=2));
      connect(radexchange1.therm4, chalfwalleast.therm3) annotation (points=[-13,
             -27; 32, -27; 32, -46; 41, -46], style(color=85, thickness=2));
      connect(radexchange1.therm5, chalfwallfloor.therm3) annotation (points=[-20,
             -29; -20, -46; -7, -46], style(color=85, thickness=2));
      connect(chalfwallsouth.therm3, radexchange1.therm6) annotation (points=[-41,
             -46; -32, -46; -32, -27; -27, -27], style(color=85, thickness=2));
    end radroom;

    class room6zonesA
      extends room6zones;
      parameter Real FFrame=0.2 "Ratio of frame area to window area";
      parameter SIunits.CoefficientOfHeatTransfer alphai=2
        "convective heat transfer coefficient (inside)";
      parameter SIunits.CoefficientOfHeatTransfer alphao=2
        "convective heat transfer coefficient (outside)";
      parameter SIunits.ThermalConductivity lambdawindow=2.4
        "Thermal conductivity of glass";
      constant SIunits.Density rhoair=1.204;
      constant SIunits.SpecificHeatCapacity cair=1012;
      parameter SIunits.Volume V=50;
      parameter SIunits.HeatCapacity C=1007 "Additonal capacitance";
      //  parameter SIunits.Emissivity eps=0.93 "emissions coeffizient wall";
      parameter SIunits.Emissivity epsw=0.93 "emissions coeffizient window";
      parameter Modelica.SIunits.Area WindowArea=6;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.09,
          y=0.08,
          width=0.75,
          height=0.6),
        Diagram,
        Icon(
          Rectangle(extent=[-52, -4; -44, -38], style(color=0)),
          Line(points=[-52, -28; -84, -28], style(color=0)),
          Text(
            extent=[-50, -52; -14, -76],
            string="Rad win",
            style(color=41)),
          Text(extent=[52, -68; 86, -86], string="air ex."),
          Text(extent=[-6, -56; 30, -72], string="int. gain")));
      RoomAttribute.sglasswjoint2 sglasswjoint2_1
        annotation (extent=[-72, -26; -52, -6]);
      Weather.t_and_sl_rad.CUTS.ic_total_rad_v ic_total_rad_v1(final n=Weather.
            t_and_sl_rad.n_of_surf_orient_def)
        annotation (extent=[-100, 16; -80, 36]);
      RoomAttribute.raddistributor6 raddistributor6_1(
        Area1=AreaWalls[1],
        Abs1=Abs[1],
        Area2=AreaWalls[2],
        Abs2=Abs[2],
        Area3=AreaWalls[3],
        Abs3=Abs[3],
        Area4=AreaWalls[4],
        Abs4=Abs[4],
        Area5=AreaWalls[5],
        Abs5=Abs[5],
        Area6=AreaWalls[6],
        Abs6=Abs[6]) annotation (extent=[-22, -6; -6, 10], rotation=90);
      therm therm10 annotation (extent=[-54, 72; -34, 92]);
      Gain.vargain vargain1(k=0.2)
        annotation (extent=[-66, 2; -54, 14], rotation=-90);
      Gain.vargain vargain2(k=0.8)
        annotation (extent=[-66, 30; -54, 18], rotation=-90);
      Modelica.Blocks.Interfaces.InPort ic_heat_gain
        annotation (extent=[24.6, -83.6; 35.4, -72.8], rotation=90);
      Modelica.Blocks.Interfaces.InPort ic_air_change
        annotation (extent=[38.6, -83.6; 49.4, -72.8], rotation=90);
      therm therm9 annotation (extent=[-40, -92; -20, -72]);
    equation
      connect(sglasswjoint2_1.therm2, chalfwall6.therm1) annotation (points=[-53,
             -16; -50, -16; -50, -34.6], style(color=65, thickness=2));
      connect(ic_total_rad_v1, sglasswjoint2_1.ic_total_rad_v1)
        annotation (points=[-90, 26; -90, -10; -71, -10]);
      connect(raddistributor6_1.therm5, chalfwall5.therm3)
        annotation (points=[-14,-3.6; -14,-40; -5.4,-40],    style(color=45));
      connect(raddistributor6_1.therm2, chalfwall2.therm3)
        annotation (points=[-14,7.6; -14,40; -5.4,40],    style(color=45));
      connect(raddistributor6_1.therm4, chalfwall4.therm3)
        annotation (points=[-10,-3.6; -10,-40; 42.6,-40],    style(color=45));
      connect(raddistributor6_1.therm3, chalfwall3.therm3)
        annotation (points=[-10,7.6; -10,40; 42.6,40],    style(color=45));
      connect(raddistributor6_1.therm6, chalfwall6.therm3)
        annotation (points=[-18,-3.6; -18,-40; -44.6,-40],    style(color=45));
      connect(raddistributor6_1.therm1, chalfwall1.therm3)
        annotation (points=[-18,7.6; -18,40; -44.6,40],    style(color=45));
      connect(sglasswjoint2_1.therm4, raddistributor6_1.therm7) annotation (
          points=[-53,-10; -44,-10; -44,2; -21.2,2],     style(color=45));
      connect(vargain1.therm1, raddistributor6_1.therm7) annotation (points=[-54.6,8;
            -33.6,8; -33.6,2; -21.2,2],        style(color=41, thickness=2));
      connect(vargain2.therm1, chalfwall1.therm1) annotation (points=[-54.6, 24;
             -50, 24; -50, 34.6], style(color=65, thickness=2));
      connect(ic_heat_gain, vargain1.InPort) annotation (points=[30,-78.2; 30,
            -70; -46,-70; -86,0; -76,16; -60,16; -60,13.4]);
      connect(vargain1.InPort, vargain2.InPort)
        annotation (points=[-60,13.4; -60,18.6]);
      connect(ic_air_change, sglasswjoint2_1.InPort1)
        annotation (points=[44,-78.2; 44,-70; -62,-70; -62,-24.62]);
      connect(sglasswjoint2_1.therm5, therm10)
        annotation (points=[-71, -22; -71, 82; -44, 82]);
      connect(sglasswjoint2_1.therm1, therm9) annotation (points=[-71, -16; -74,
             -16; -44, -68; -30, -68; -30, -82], style(color=41, thickness=2));
      if cardinality(ic_total_rad_v1) == 1 then
        for i in 1:ic_total_rad_v1.n loop
          ic_total_rad_v1.I[i] = 0;
        end for;
      end if;
    end room6zonesA;

    class room6zones_pipes
      extends broom6zones;
      constant SIunits.Density rhoair=1.204 "Density of air";
      constant SIunits.SpecificHeatCapacity cair=1012
        "Specific heat capacity of air";
      parameter SIunits.Volume V=50 "Volume of room";
      parameter SIunits.HeatCapacity C=1007
        "Additional (absolute) heat capacity";
      parameter SIunits.Emissivity eps[:]={0.93,0.93,0.93,0.93,0.93,0.93}
        "emissions coefficient wall # 1...6";
      parameter SIunits.Density rhoWalls[:]={1600,1600,1600,1600,1600,1600}
        "Density of wall: # 1...6";
      parameter SIunits.SpecificHeatCapacity cWalls[:]={1000,1000,1000,1000,
          1000,1000} "Specific heat capacity of wall #1...6";
      parameter SIunits.ThermalConductivity lambdaWalls[:]={2.4,2.4,2.4,2.4,2.4,
          2.4} "Thermal conductivity of wall #1...6";
      parameter SIunits.CoefficientOfHeatTransfer alphaWalls[:]={2.0,2.0,2.0,
          2.0,2.0,2.0} "Heat Transfer Coefficients: Walls #1...6";
      parameter SIunits.Thickness dWalls[:]={0.1,0.1,0.1,0.1,0.1,0.1}
        "Thickness of wall # 1...6";
      constant Real pi=3.1415927;
      parameter SIunits.Length Lpipe=0.02 "Length of pipe";
      parameter SIunits.Diameter dI=0.02 "Inner diameter of pipe";
      parameter SIunits.Diameter dO=0.023 "Outer diameter of pipe";
      parameter SIunits.Temp_C T0pipe=16 "Initial temperature of pipe";
      parameter SIunits.ThermalConductivity lambdaPipe=373
        "Heat conductivity of pipe";
      parameter SIunits.SpecificHeatCapacity cPipe=1000
        "Specific Heat Capacity of pipe";
      parameter SIunits.Density rhoPipe=1600 "Density of pipe";
      parameter Integer n=2;
      Hvac.Heating.Advanced.npipe npipe1 annotation (extent=[-14, -56; 14, -24]);
      Hvac.Heating.Advanced.Cuts.ThermoFlow Out
        annotation (extent=[48, -92; 68, -72]);
      Hvac.Heating.Advanced.Cuts.ThermoFlow In
        annotation (extent=[-68, -92; -48, -72]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Polygon(points=[48, 72; -48, 72; -88, 0; -48, -72; 48, -72; 88, 0; 48,
                 72], style(color=0, thickness=2)),
          Rectangle(extent=[-48, 46; 48, -44], style(
              color=0,
              thickness=2,
              fillColor=52)),
          Line(points=[-100, 0; -50, 0; -50, 0], style(
              color=65,
              thickness=4,
              fillColor=65)),
          Text(extent=[-30, 28; 28, -24], string="6"),
          Text(extent=[-94, 78; -78, 60], string="1"),
          Text(extent=[-32, 94; -12, 76], string="2"),
          Text(extent=[72, 78; 90, 58], string="3"),
          Text(extent=[84, -34; 102, -52], string="4"),
          Text(extent=[12, -78; 36, -98], string="5"),
          Text(extent=[-82, -64; -64, -82], string="6"),
          Text(extent=[-36, -16; 32, -40], string="room6zones with pipes")),
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
        Diagram);
      therm therm8 annotation (extent=[-10, 72; 10, 92], layer="icon");
      therm therm9 annotation (extent=[62, 42; 82, 62], layer="icon");
      therm therm10 annotation (extent=[62, -62; 82, -42], layer="icon");
      therm therm11 annotation (extent=[-82, 42; -62, 62], layer="icon");
      therm therm12 annotation (extent=[-82, -62; -62, -42], layer="icon");
      therm therm13 annotation (extent=[-10, -92; 10, -72], layer="icon");
      therm therm14 annotation (extent=[-98, -38; -78, -18], layer="icon");
      Layer.chalfwall chalfwall1(
        lambdaWall=lambdaWalls[1],
        alphaWall=alphaWalls[1],
        rhoWall=rhoWalls[1],
        cWall=cWalls[1],
        dWall=dWalls[1],
        AWall=AreaWalls[1]) annotation (extent=[-44, 34; -56, 46], rotation=90);
      Layer.chalfwall chalfwall4(
        lambdaWall=lambdaWalls[4],
        alphaWall=alphaWalls[4],
        rhoWall=rhoWalls[4],
        cWall=cWalls[4],
        dWall=dWalls[4],
        AWall=AreaWalls[4]) annotation (extent=[54, -46; 42, -34], rotation=-90);
      Layer.chalfwall chalfwall6(
        lambdaWall=lambdaWalls[6],
        alphaWall=alphaWalls[6],
        rhoWall=rhoWalls[6],
        cWall=cWalls[6],
        dWall=dWalls[6],
        AWall=AreaWalls[6])
        annotation (extent=[-56, -48; -44, -36], rotation=-90);
      Layer.chalfwall chalfwall5(
        lambdaWall=lambdaWalls[5],
        alphaWall=alphaWalls[5],
        rhoWall=rhoWalls[5],
        cWall=cWalls[5],
        dWall=dWalls[5],
        AWall=AreaWalls[5]) annotation (extent=[6, -28; -6, -16], rotation=-90);
      Layer.chalfwall chalfwall3(
        lambdaWall=lambdaWalls[3],
        alphaWall=alphaWalls[3],
        rhoWall=rhoWalls[3],
        cWall=cWalls[3],
        dWall=dWalls[3],
        AWall=AreaWalls[3]) annotation (extent=[42, 34; 54, 46], rotation=90);
      Layer.chalfwall chalfwall2(
        lambdaWall=lambdaWalls[2],
        alphaWall=alphaWalls[2],
        rhoWall=rhoWalls[2],
        cWall=cWalls[2],
        dWall=dWalls[2],
        AWall=AreaWalls[2]) annotation (extent=[-6, 34; 6, 46], rotation=90);
      Elements.twostar twostar5(eps=eps[5], A=AreaWalls[5])
        annotation (extent=[-20, -20; -8, -8], rotation=90);
      Elements.twostar twostar6(eps=eps[6], A=AreaWalls[6])
        annotation (extent=[-42, -34; -30, -22], rotation=90);
      Elements.twostar twostar4(eps=eps[4], A=AreaWalls[4])
        annotation (extent=[24, -32; 36, -20], rotation=90);
      Elements.twostar twostar2(eps=eps[2], A=AreaWalls[2])
        annotation (extent=[-20, 34; -8, 22], rotation=90);
      Elements.twostar twostar1(eps=eps[1], A=AreaWalls[1])
        annotation (extent=[-42, 34; -30, 22], rotation=90);
      Elements.twostar twostar3(eps=eps[3], A=AreaWalls[3])
        annotation (extent=[24, 34; 36, 22], rotation=90);
      Elements.loadplus loadplus1(T0=27, C=C)
        annotation (extent=[62, 8; 78, 24], rotation=90);
      Elements.airload airload1(
        T0=27,
        rho=rhoair,
        c=cair,
        V=V) annotation (extent=[62, -8; 78, 8], rotation=90);
      Layer.chalfwall chalfwall7(
        lambdaWall=lambdaWalls[5],
        alphaWall=alphaWalls[5],
        rhoWall=rhoWalls[5],
        cWall=cWalls[5],
        dWall=dWalls[5],
        AWall=AreaWalls[5]) annotation (extent=[6, -70; -6, -58], rotation=-90);
    equation
      connect(chalfwall1.therm3, twostar1.therm1)
        annotation (points=[-44.6, 40; -36, 40; -36, 33.4]);
      connect(chalfwall2.therm3, twostar2.therm1)
        annotation (points=[-5.4,40; -14,40; -14,33.4]);
      connect(chalfwall3.therm3, twostar3.therm1)
        annotation (points=[42.6, 40; 32, 40; 30, 33.4]);
      connect(chalfwall4.therm3, twostar4.therm1)
        annotation (points=[42.6, -40; 30, -40; 30, -31.4]);
      connect(twostar1.therm2, twostar6.therm2) annotation (points=[-36, 22.6;
            -36, -22.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar2.therm2) annotation (points=[-36, -22.6;
             -36, -6; -14, -6; -14, 22.6], style(color=41, thickness=2));
      connect(twostar2.therm2, twostar5.therm2) annotation (points=[-14,22.6;
            -14,-8.6],  style(color=41, thickness=2));
      connect(twostar5.therm2, twostar4.therm2) annotation (points=[-14,-8.6;
            -14,-6; 32,-6; 30,-20.6],    style(color=41, thickness=2));
      connect(twostar4.therm2, twostar3.therm2) annotation (points=[30, -20.6;
            30, 22.6], style(color=41, thickness=2));
      connect(twostar1.therm2, twostar2.therm2) annotation (points=[-36, 22.6;
            -36, -6; -14, -6; -14, 22.6], style(color=41, thickness=2));
      connect(twostar1.therm2, twostar5.therm2) annotation (points=[-36,22.6;
            -36,-6; -14,-6; -14,-8.6],    style(color=41, thickness=2));
      connect(twostar1.therm2, twostar4.therm2) annotation (points=[-36, 22.6;
            -36, -6; 32, -6; 30, -20.6], style(color=41, thickness=2));
      connect(twostar1.therm2, twostar3.therm2) annotation (points=[-36, 22.6;
            -36, -6; 32, -6; 30, 22.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar5.therm2) annotation (points=[-36,-22.6;
            -36,-6; -14,-6; -14,-8.6],     style(color=41, thickness=2));
      connect(twostar6.therm2, twostar4.therm2) annotation (points=[-36, -22.6;
             -36, -6; 32, -6; 30, -20.6], style(color=41, thickness=2));
      connect(twostar6.therm2, twostar3.therm2) annotation (points=[-36, -22.6;
             -36, -6; 32, -6; 30, 22.6], style(color=41, thickness=2));
      connect(twostar2.therm2, twostar3.therm2) annotation (points=[-14, 22.6;
            -14, -6; 30, -6; 30, 22.6], style(color=41, thickness=2));
      connect(twostar2.therm2, twostar4.therm2) annotation (points=[-14, 22.6;
            -14, -8; 30, -8; 30, -20.6], style(color=41, thickness=2));
      connect(twostar5.therm2, twostar3.therm2) annotation (points=[-14,-8.6;
            -14,-6; 30,-6; 30,22.6],    style(color=41, thickness=2));
      connect(chalfwall6.therm1, therm7) annotation (points=[-50, -36.6; -50, 0;
             -100, 0], style(color=65, thickness=2));
      connect(chalfwall1.therm1, therm7) annotation (points=[-50, 34.6; -50, 0;
             -100, 0], style(color=65, thickness=2));
      connect(chalfwall1.therm2, therm11)
        annotation (points=[-50, 45.4; -50, 52; -72, 52]);
      connect(chalfwall2.therm2, therm8) annotation (points=[3.30644e-016,45.4;
            3.30644e-016,65.7; 0,65.7; 0,82]);
      connect(chalfwall3.therm2, therm9)
        annotation (points=[48, 45.4; 48, 52; 72, 52]);
      connect(loadplus1.therm1, airload1.therm1) annotation (points=[62.8,16;
            48,16; 48,4.40858e-016; 62.8,4.40858e-016],    style(color=65,
            thickness=2));
      connect(chalfwall2.therm1, therm7) annotation (points=[-3.30644e-016,34.6;
            -3.30644e-016,0; -100,0],         style(color=65, thickness=2));
      connect(chalfwall3.therm1, therm7) annotation (points=[48, 34.6; 48, 0; -100,
             0], style(color=65, thickness=2));
      connect(chalfwall4.therm1, therm7) annotation (points=[48, -34.6; 48, 0;
            -100, 0], style(color=65, thickness=2));
      connect(chalfwall5.therm1, therm7) annotation (points=[3.30644e-016,-16.6;
            3.30644e-016,0; -100,0],    style(color=65, thickness=2));
      connect(twostar6.therm2, therm14) annotation (points=[-36, -22.6; -36, -6;
             -68, -6; -68, -28; -88, -28], style(color=41, thickness=2));
      connect(chalfwall6.therm2, therm12)
        annotation (points=[-50, -47.4; -50, -52; -72, -52]);
      connect(chalfwall7.therm2, therm13) annotation (points=[-3.30644e-016,
            -69.4; -3.30644e-016,-76.7; 0,-76.7; 0,-82]);
      connect(twostar5.therm1, chalfwall5.therm3)
        annotation (points=[-14,-19.4; -14,-22; -5.4,-22]);
      connect(twostar6.therm1, chalfwall6.therm3)
        annotation (points=[-36, -33.4; -36, -42; -44.6, -42]);
      connect(chalfwall4.therm2, therm10)
        annotation (points=[48, -45.4; 48, -52; 72, -52]);
      connect(npipe1.therm_underside, chalfwall7.therm1) annotation (points=[
            1.77636e-015,-50.24; 1.77636e-015,-52.48; 2.107e-015,-52.48;
            2.107e-015,-54.72; 3.30644e-016,-54.72; 3.30644e-016,-58.6]);
      connect(npipe1.therm_upside, chalfwall5.therm2) annotation (points=[
            1.77636e-015,-32.96; 1.77636e-015,-31.57; 1.44572e-015,-31.57;
            1.44572e-015,-30.18; -3.30644e-016,-30.18; -3.30644e-016,-27.4]);
      connect(npipe1.In, In) annotation (points=[-13.3,-42.56; -58,-82]);
      connect(npipe1.Out, Out) annotation (points=[13.3,-42.56; 58,-82]);
    end room6zones_pipes;

    package HumidyRooms
      extends Icons.Package;
      annotation (
        Coordsys(
          extent=[0, 0; 443, 453],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65,
          library=1,
          autolayout=1),
        Diagram);
      model room6zonesH "6-zone-room model with HumidyAir Caculation."
        extends broom6zones;

        parameter SIunits.Volume V=50 "Volume of room";
        parameter SIunits.HeatCapacity C=1007
          "Additional heat capacity (furniture etc.)";
        parameter SIunits.Emissivity eps[:]={0.93,0.93,0.93,0.93,0.93,0.93}
          "emissions coefficient: Walls #1...6";
        parameter SIunits.Density rhoWalls[:]={1600,1600,1600,1600,1600,1600}
          "Densities: Walls #1...6";
        parameter SIunits.SpecificHeatCapacity cWalls[:]={1000,1000,1000,1000,
            1000,1000} "Specific heat capacities: Walls #1...6";

        parameter SIunits.ThermalConductivity lambdaWalls[:]={2.4,2.4,2.4,2.4,
            2.4,2.4} "Thermal Conductivities: Walls #1...6";
        parameter SIunits.CoefficientOfHeatTransfer alphaWalls[:]={2.0,2.0,2.0,
            2.0,2.0,2.0} "Heat Transfer Coefficients: Walls #1...6";
        parameter SIunits.Thickness dWalls[:]={0.1,0.1,0.1,0.1,0.1,0.1}
          "Thickness of Walls #1...6";
        parameter Real T0=16 "initial temperature in °C";

        parameter Real H_rel_0=0.5
          "initial rel. humidity (H_rel := p2 / p2_sat)";
        parameter Real p=101300 "pressure in Pa (constant)";
        constant Real cp1=1005 "spec. heat capacity of gas 1 (air) in J/(kg*K)";
        constant Real cp2=1865
          "spec. heat capacity of gas 2 (water steam) in J/(kg*K)";
        constant Real R1=287 "gas constant of gas 1 (air) in J/(kg*K)";
        constant Real R2=461 "gas constant of gas 2 (water steam) in J/(kg*K)";

        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram(
            Polygon(points=[48, 72; -48, 72; -88, 0; -48, -72; 48, -72; 88, 0;
                  48, 72], style(color=0, thickness=2)),
            Text(extent=[-90, 72; -78, 60], string="1"),
            Text(extent=[-22, 90; -8, 76], string="2"),
            Text(extent=[76, 72; 90, 58], string="3"),
            Text(extent=[84, -46; 98, -62], string="4"),
            Text(extent=[12, -78; 30, -92], string="5"),
            Text(extent=[-82, -62; -68, -76], string="6")),
          Window(
            x=0.54,
            y=0.11,
            width=0.44,
            height=0.65),
          Icon(
            Text(extent=[-30, 32; 58, -44], string="room6zoneH"),
            Line(points=[-88, 0; -30, 0], style(color=73, thickness=4)),
            Line(points=[-74, -26; -32, -26], style(color=41, thickness=4)),
            Text(extent=[-80, 74; -68, 62], string="1"),
            Text(extent=[-20, 88; -6, 74], string="2"),
            Text(extent=[66, 72; 80, 58], string="3"),
            Text(extent=[82, -48; 96, -64], string="4"),
            Text(extent=[6, -76; 24, -90], string="5"),
            Text(extent=[-76, -62; -62, -76], string="6")));
        Layer.chalfwall chalfwall1(
          lambdaWall=lambdaWalls[1],
          alphaWall=alphaWalls[1],
          rhoWall=rhoWalls[1],
          cWall=cWalls[1],
          dWall=dWalls[1],
          AWall=AreaWalls[1])
          annotation (extent=[-44, 34; -56, 46], rotation=90);
        Layer.chalfwall chalfwall4(
          lambdaWall=lambdaWalls[4],
          alphaWall=alphaWalls[4],
          rhoWall=rhoWalls[4],
          cWall=cWalls[4],
          AWall=AreaWalls[4],
          dWall=dWalls[4]) annotation (extent=[54, -46; 42, -34], rotation=-90);
        Layer.chalfwall chalfwall6(
          lambdaWall=lambdaWalls[6],
          alphaWall=alphaWalls[6],
          rhoWall=rhoWalls[6],
          cWall=cWalls[6],
          dWall=dWalls[6],
          AWall=AreaWalls[6])
          annotation (extent=[-56, -46; -44, -34], rotation=-90);
        Layer.chalfwall chalfwall5(
          lambdaWall=lambdaWalls[5],
          alphaWall=alphaWalls[5],
          rhoWall=rhoWalls[5],
          cWall=cWalls[5],
          AWall=AreaWalls[5],
          dWall=dWalls[5]) annotation (extent=[6, -46; -6, -34], rotation=-90);
        Layer.chalfwall chalfwall3(
          lambdaWall=lambdaWalls[3],
          alphaWall=alphaWalls[3],
          rhoWall=rhoWalls[3],
          cWall=cWalls[3],
          dWall=dWalls[3],
          AWall=AreaWalls[3]) annotation (extent=[42, 34; 54, 46], rotation=90);
        Layer.chalfwall chalfwall2(
          lambdaWall=lambdaWalls[2],
          alphaWall=alphaWalls[2],
          rhoWall=rhoWalls[2],
          cWall=cWalls[2],
          dWall=dWalls[2],
          AWall=AreaWalls[2]) annotation (extent=[-6, 34; 6, 46], rotation=90);
        Elements.twostar twostar5(eps=eps[5], A=AreaWalls[5])
          annotation (extent=[-20, -34; -8, -22], rotation=90);
        Elements.twostar twostar6(eps=eps[6], A=AreaWalls[6])
          annotation (extent=[-42, -34; -30, -22], rotation=90);
        Elements.twostar twostar4(eps=eps[4], A=AreaWalls[4])
          annotation (extent=[26, -32; 38, -20], rotation=90);
        Elements.twostar twostar2(eps=eps[2], A=AreaWalls[2])
          annotation (extent=[-20, 34; -8, 22], rotation=90);
        Elements.twostar twostar1(eps=eps[1], A=AreaWalls[1])
          annotation (extent=[-42, 34; -30, 22], rotation=90);
        Elements.twostar twostar3(eps=eps[3], A=AreaWalls[3])
          annotation (extent=[26, 34; 38, 22], rotation=90);
        Elements.HumidAir HumidAir1(
          V=V,
          T0=T0,
          H_rel_0=H_rel_0,
          p=p,
          cp1=cp1,
          cp2=cp2,
          R1=R1,
          R2=R2) annotation (extent=[58, -10; 78, 10], rotation=90);
        flowHM flowHM3 annotation (extent=[80, -28; 96, -14]);
        therm therm8 annotation (extent=[-98, -34; -78, -14]);
        Elements.loadplus loadplus1(T0=T0, C=C)
          annotation (extent=[54, 12; 70, 28], rotation=90);
      equation

        connect(chalfwall6.therm3, twostar6.therm1)
          annotation (points=[-44.6, -40; -36, -40; -36, -33.4]);
        connect(twostar5.therm1, chalfwall5.therm3)
          annotation (points=[-14, -33.4; -14, -40; -5.4, -40]);
        connect(chalfwall1.therm3, twostar1.therm1)
          annotation (points=[-44.6, 40; -36, 40; -36, 33.4]);
        connect(chalfwall2.therm3, twostar2.therm1)
          annotation (points=[-5.4, 40; -14, 40; -14, 33.4]);
        connect(chalfwall3.therm3, twostar3.therm1)
          annotation (points=[42.6, 40; 32, 40; 32, 33.4]);
        connect(chalfwall4.therm3, twostar4.therm1)
          annotation (points=[42.6, -40; 32, -40; 32, -31.4]);
        connect(twostar1.therm2, twostar6.therm2) annotation (points=[-36, 22.6;
               -36, -22.6], style(color=41, thickness=2));
        connect(twostar6.therm2, twostar2.therm2) annotation (points=[-36, -22.6;
               -36, -6; -14, -6; -14, 22.6], style(color=41, thickness=2));
        connect(twostar2.therm2, twostar5.therm2) annotation (points=[-14, 22.6;
               -14, -22.6], style(color=41, thickness=2));
        connect(twostar5.therm2, twostar4.therm2) annotation (points=[-14, -22.6;
               -14, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
        connect(twostar4.therm2, twostar3.therm2) annotation (points=[32, -20.6;
               32, 22.6], style(color=41, thickness=2));
        connect(twostar1.therm2, twostar2.therm2) annotation (points=[-36, 22.6;
               -36, -6; -14, -6; -14, 22.6], style(color=41, thickness=2));
        connect(twostar1.therm2, twostar5.therm2) annotation (points=[-36, 22.6;
               -36, -6; -14, -6; -14, -22.6], style(color=41, thickness=2));
        connect(twostar1.therm2, twostar4.therm2) annotation (points=[-36, 22.6;
               -36, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
        connect(twostar1.therm2, twostar3.therm2) annotation (points=[-36, 22.6;
               -36, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
        connect(twostar6.therm2, twostar5.therm2) annotation (points=[-36, -22.6;
               -36, -6; -14, -6; -14, -22.6], style(color=41, thickness=2));
        connect(twostar6.therm2, twostar4.therm2) annotation (points=[-36, -22.6;
               -36, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
        connect(twostar6.therm2, twostar3.therm2) annotation (points=[-36, -22.6;
               -36, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
        connect(twostar2.therm2, twostar3.therm2) annotation (points=[-14, 22.6;
               -14, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
        connect(twostar2.therm2, twostar4.therm2) annotation (points=[-14, 22.6;
               -14, -6; 32, -6; 32, -20.6], style(color=41, thickness=2));
        connect(twostar5.therm2, twostar3.therm2) annotation (points=[-14, -22.6;
               -14, -6; 32, -6; 32, 22.6], style(color=41, thickness=2));
        connect(chalfwall1.therm2, therm1)
          annotation (points=[-50, 45.4; -50, 52; -72, 52]);
        connect(chalfwall2.therm2, therm2) annotation (points=[3.30644e-016,
              45.4; 3.30644e-016, 65.7; 0, 65.7; 0, 82]);
        connect(chalfwall3.therm2, therm3)
          annotation (points=[48, 45.4; 48, 52; 72, 52]);
        connect(chalfwall5.therm2, therm5)
          annotation (points=[-3.30644e-016, -45.4; 0, -82]);
        connect(chalfwall4.therm2, therm4)
          annotation (points=[48, -45.4; 48, -52; 72, -52]);
        connect(chalfwall6.therm2, therm6)
          annotation (points=[-50, -45.4; -50, -52; -72, -52]);
        connect(chalfwall1.therm1, therm7) annotation (points=[-50, 34.6; -50,
              0; -100, 0], style(color=65, thickness=2));
        connect(chalfwall6.therm1, therm7) annotation (points=[-50, -34.6; -50,
               0; -100, 0], style(color=65, thickness=2));
        connect(chalfwall2.therm1, therm7) annotation (points=[-3.30644e-016,
              34.6; -3.30644e-016, 0; -100, 0], style(color=65, thickness=2));
        connect(chalfwall5.therm1, therm7) annotation (points=[3.30644e-016, -34.6;
               0, 0; -100, 0], style(color=65, thickness=2));
        connect(chalfwall3.therm1, therm7) annotation (points=[48, 34.6; 48, 0;
               -100, 0], style(color=65, thickness=2));
        connect(chalfwall4.therm1, therm7) annotation (points=[48, -34.6; 48, 0;
               -100, 0], style(
            color=65,
            thickness=2,
            fillColor=7));
        connect(HumidAir1.therm1, chalfwall4.therm1) annotation (points=[58.7,
              -0.2; 48, -0.2; 48, -34.6], style(color=65, thickness=2));
        connect(HumidAir1.cut1, flowHM3) annotation (points=[77.2, -3.85683e-016;
               88, -3.85683e-016; 88, -21], style(color=69));
        connect(twostar1.therm2, therm8) annotation (points=[-36, 22.6; -36, -24;
               -88, -24], style(color=41, thickness=2));
        connect(chalfwall3.therm1, loadplus1.therm1) annotation (points=[48,
              34.6; 48, 20; 54.8, 20], style(color=65, thickness=2));
      end room6zonesH;

    end HumidyRooms;

    class room6zonesA2
      extends room6zones;
      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      parameter Real FFrame=0.2 "Ratio of frame area to window area";
      parameter SIunits.CoefficientOfHeatTransfer alphai=2
        "convective heat transfer coefficient (inside)";
      parameter SIunits.CoefficientOfHeatTransfer alphao=2
        "convective heat transfer coefficient (outside)";
      parameter SIunits.ThermalConductivity lambdawindow=2.4
        "Thermal conductivity of glass";
      constant SIunits.Density rhoair=1.204;
      constant SIunits.SpecificHeatCapacity cair=1012;
      parameter SIunits.Volume V=50;
      parameter SIunits.HeatCapacity C=1007 "Additonal capacitance";
      parameter SIunits.Emissivity epsw=0.93 "emissions coeffizient window";
      parameter Modelica.SIunits.Area WindowArea=6;
      parameter SIunits.Thickness d=0.01 "Thickness of glass";
      parameter Real Abskoeff=0.1 "Absorptance coefficient";
      parameter Real Transkoeff=0.6 "Solar transmission coefficient";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.24,
          y=0.32,
          width=0.67,
          height=0.69),
        Icon(
          Line(points=[-52, -28; -84, -28], style(color=0)),
          Rectangle(extent=[-54, -4; -46, -38], style(color=0)),
          Text(
            extent=[-50, 64; -14, 40],
            string="Rad win",
            style(color=41)),
          Text(extent=[-6, -56; 30, -72], string="int. gain"),
          Text(extent=[52, -68; 86, -86], string="air ex.")),
        Documentation(info="
"),     Diagram);
      RoomAttribute.sglasswjoint2 sglasswjoint2_1(
        WindowArea=WindowArea,
        cair=cair,
        rhoair=rhoair,
        V=V,
        alphai=alphai,
        alphao=alphao,
        lambda=lambdawindow,
        comp_surf_orient_alias=comp_surf_orient_alias)
        annotation (extent=[-72, -26; -52, -6]);
      Gain.vargain vargain2(k=0.8)
        annotation (extent=[-66, 30; -54, 18], rotation=-90);
      Gain.vargain vargain1(k=0.2)
        annotation (extent=[-66, 2; -54, 14], rotation=-90);
      Weather.t_and_sl_rad.CUTS.ic_total_rad_v ic_total_rad_v1(final n=Weather.
            t_and_sl_rad.n_of_surf_orient_def)
        annotation (extent=[-100, 16; -80, 36]);
      Modelica.Blocks.Interfaces.InPort ic_heat_gain
        annotation (extent=[26, -84; 38, -72], rotation=90);
      Modelica.Blocks.Interfaces.InPort ic_air_change
        annotation (extent=[38.6, -83.6; 49.4, -72.8], rotation=90);
      therm therm10 annotation (extent=[-54, 72; -34, 92]);
      therm therm9 annotation (extent=[-38, -92; -18, -72]);
    equation
      connect(sglasswjoint2_1.therm5, therm10)
        annotation (points=[-71, -22; -71, 82; -44, 82]);
      connect(sglasswjoint2_1.ic_total_rad_v1, ic_total_rad_v1)
        annotation (points=[-71, -10; -90, -10; -90, 26]);
      connect(sglasswjoint2_1.therm1, therm8)
        annotation (points=[-71, -16; -88, -16; -88, -28]);
      connect(sglasswjoint2_1.therm2, chalfwall6.therm1)
        annotation (points=[-53, -16; -50, -16; -50, -34.6], style(color=65));
      connect(vargain1.therm1, twostar2.therm2) annotation (points=[-54.6, 8; -14,
             8; -14, 22.6], style(color=85, thickness=2));
      connect(sglasswjoint2_1.therm4, vargain1.therm1) annotation (points=[-53,
             -10; -46, -10; -46, 8; -54.6, 8], style(color=45));
      connect(sglasswjoint2_1.InPort1, ic_air_change)
        annotation (points=[-62,-24.62; -62,-66; 44,-66; 44,-78.2]);
      connect(twostar6.therm2, therm9) annotation (points=[-36, -22.6; -36, -6;
             -28, -6; -28, -82], style(color=85, thickness=2));
      connect(vargain1.InPort, vargain2.InPort)
        annotation (points=[-60,13.4; -60,18.6]);
      connect(ic_heat_gain, vargain2.InPort)
        annotation (points=[32, -78; 32, 18.6; -60, 18.6]);
      connect(vargain2.therm1, chalfwall1.therm1) annotation (points=[-54.6, 24;
             -50, 24; -50, 34.6], style(color=65, fillColor=65));
      if cardinality(ic_total_rad_v1) == 1 then
        for i in 1:ic_total_rad_v1.n loop
          ic_total_rad_v1.I[i] = 0;
        end for;
      end if;
    end room6zonesA2;

  end Rooms;

  package RoomAttribute
    extends Icons.Package;
    type AirExchangeRate = Real (final quantity="AirExchange", final unit="m/h");
    annotation (
      Coordsys(
        extent=[0, 0; 668, 453],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-54, 36; 52, -54], style(
            color=0,
            pattern=0,
            fillColor=46)),
        Rectangle(extent=[-44, 26; -8, -44], style(
            color=0,
            pattern=0,
            fillColor=71)),
        Line(points=[-20, 4; -40, -24], style(color=7, thickness=2)),
        Rectangle(extent=[6, 26; 42, -44], style(
            color=0,
            pattern=0,
            fillColor=71)),
        Line(points=[34, 6; 14, -20], style(color=7, thickness=2))),
      Window(
        x=0.23,
        y=0.01,
        width=0.66,
        height=0.65,
        library=1,
        autolayout=1));
    class airexchange
      "describes a heat flow exchange or leakage between the joints of a window or a door"

      extends twotherm;
      parameter AirExchangeRate VA=2
        "Air flow volume per hour and square meter [m^3/(h*m^2)]";
      parameter Modelica.SIunits.Area A=10 "cross section area of air exchange";
      parameter Modelica.SIunits.SpecificHeatCapacity c=1000
        "Specific Heat Capacity of Air";
      parameter Modelica.SIunits.Density rho=1.25 "Air Density";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.16,
          y=0.1,
          width=0.75,
          height=0.6),
        Icon(
          Rectangle(extent=[-80, 82; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-48, 52; 44, 32], style(color=7, fillColor=7)),
          Polygon(points=[44, 58; 44, 26; 60, 42; 44, 58], style(color=7,
                fillColor=7)),
          Polygon(points=[-48, 58; -48, 26; -64, 42; -48, 58], style(color=7,
                fillColor=7)),
          Polygon(points=[-48, 16; -48, -16; -64, 0; -48, 16], style(color=7,
                fillColor=7)),
          Rectangle(extent=[-48, 10; 44, -10], style(color=7, fillColor=7)),
          Polygon(points=[44, 16; 44, -16; 60, 0; 44, 16], style(color=7,
                fillColor=7)),
          Polygon(points=[-48, -26; -48, -58; -64, -42; -48, -26], style(color=
                  7, fillColor=7)),
          Rectangle(extent=[-48, -32; 44, -52], style(color=7, fillColor=7)),
          Polygon(points=[44, -26; 44, -58; 60, -42; 44, -26], style(color=7,
                fillColor=7))));
    equation
      therm1.j = VA*A*c*rho*(therm1.T - therm2.T)/3600;
      therm1.j = -therm2.j;
    end airexchange;

    class varairexchange "describes heat flow caused by air exchange."
      extends twotherm;
      parameter Modelica.SIunits.SpecificHeatCapacity c=1000
        "Specific Heat Capacity of Air";
      parameter Modelica.SIunits.Density rho=1.25 "Air Density";
      parameter Modelica.SIunits.Volume V=50 "Volume of the room";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 82; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-48, 52; 44, 32], style(color=7, fillColor=7)),
          Polygon(points=[-48, 58; -48, 26; -64, 42; -48, 58], style(color=7,
                fillColor=7)),
          Polygon(points=[44, 58; 44, 26; 60, 42; 44, 58], style(color=7,
                fillColor=7)),
          Rectangle(extent=[-48, 10; 44, -10], style(color=7, fillColor=7)),
          Polygon(points=[44, 16; 44, -16; 60, 0; 44, 16], style(color=7,
                fillColor=7)),
          Polygon(points=[-48, 16; -48, -16; -64, 0; -48, 16], style(color=7,
                fillColor=7)),
          Polygon(points=[-48, -26; -48, -58; -64, -42; -48, -26], style(color=
                  7, fillColor=7)),
          Rectangle(extent=[-48, -32; 44, -52], style(color=7, fillColor=7)),
          Polygon(points=[44, -26; 44, -58; 60, -42; 44, -26], style(color=7,
                fillColor=7))),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6),
        Documentation(info="Input Signal is the air volume per hour for 1 m3 room.
"));
      Modelica.Blocks.Interfaces.InPort InPort1
        annotation (extent=[-12, 102; 8, 82], rotation=90);
    equation
      therm1.j = InPort1.signal[1]*V*c*rho*(therm1.T - therm2.T)/3600;
      therm1.j = -therm2.j;
    end varairexchange;

    class Door "describes heat tranfer through a closed door"
      extends twotherm;
      parameter Modelica.SIunits.Length Door_Height=2.5;
      parameter Modelica.SIunits.Length Door_Width=1;
      Modelica.SIunits.Area A;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer kd=2
        "Coefficient of the door";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=46)),
          Polygon(points=[-28, 42; -38, 38; -36, 30; -28, 28; -20, 30; -16, 36;
                 -20, 40; -28, 42], style(color=0)),
          Polygon(points=[28, 0; 20, -6; 24, -12; 34, -14; 38, -10; 38, -4; 36,
                 0; 32, 0; 28, 0], style(color=0)),
          Line(points=[-40, 76; -36, 70; -38, 66; -44, 60; -40, 56; -40, 50; -46,
                 46; -46, 40; -44, 32; -40, 28; -40, 22], style(color=0)),
          Line(points=[-40, 22; -38, 16; -34, 12; -34, 6; -34, -2; -30, -10; -28,
                 -20; -32, -26; -28, -36; -26, -40; -20, -46; -24, -52; -28, -56;
                 -28, -62; -28, -66], style(color=0)),
          Line(points=[-28, -66; -26, -70; -22, -72; -28, -76], style(color=0)),
          Line(points=[-30, 76; -32, 66; -30, 60; -36, 56; -30, 50; -20, 44; -12,
                 42; -10, 32; -22, 26; -26, 16; -26, 12; -26, 2; -20, -6; -20,
                -16; -22, -24; -24, -28; -20, -36; -18, -46; -12, -56; -18, -58;
                 -18, -66; -14, -74], style(color=0)),
          Line(points=[-20, 76; -22, 66; -18, 60; -20, 52; -8, 46; -6, 38; -8,
                28; -18, 22; -16, 12; -14, 4; -12, -8; -6, -14; -6, -24; -12, -28;
                 -10, -38; -4, -44; -4, -48; -8, -52; -4, -62; -6, -66; -8, -70],
               style(color=0)),
          Line(points=[24, 78; 24, 70; 28, 64; 28, 50; 22, 42; 24, 34; 24, 26;
                18, 20; 24, 12; 24, 6; 20, 2; 14, -2; 16, -14; 24, -20; 28, -32;
                 36, -40; 34, -44; 32, -50; 28, -58; 28, -62; 30, -66; 30, -70],
               style(color=0)),
          Line(points=[36, 76; 34, 64; 32, 60; 32, 50; 36, 46; 32, 34; 32, 26;
                36, 18; 40, 10; 34, 8; 36, 4; 44, -2; 44, -10; 36, -22; 38, -30;
                 38, -36; 42, -46; 40, -52; 38, -62; 42, -68; 42, -72; 40, -76],
               style(color=0)),
          Line(points=[-14, 76; -12, 64; -6, 56; -2, 44; -2, 40; -2, 30; -8, 18;
                 -8, 6; 0, -6; 0, -16; -2, -40; 4, -48; 2, -54; 2, -66; -2, -74],
               style(color=0)),
          Line(points=[-4, 76; -2, 68; 0, 60; 0, 54; 6, 46; 12, 46; 16, 50; 20,
                 56; 16, 64; 16, 72; 20, 76], style(color=0)),
          Line(points=[2, 76; 2, 68; 6, 60; 8, 52; 12, 54; 10, 62; 10, 70; 10,
                78], style(color=0)),
          Line(points=[46, 76; 44, 66; 48, 60; 46, 52; 42, 42; 44, 28; 46, 24;
                48, 22; 50, 12; 52, 4; 54, -8; 48, -16; 46, -28; 50, -34; 50, -44;
                 52, -50; 50, -52; 54, -60; 48, -66; 54, -70; 56, -78], style(
                color=0)),
          Line(points=[8, -74; 8, -46; 6, -34; 4, -24; 6, -8; 0, 8; -2, 16; 4,
                28; 6, 42; 16, 38; 14, 28; 10, 18; 10, 10; 12, 0; 12, -14; 20,
                -26; 26, -40; 24, -52; 26, -68], style(color=0)),
          Line(points=[-66, -78; -68, -58; -62, -46; -64, -28; -58, 2; -50, -2;
                 -50, -8; -44, -18; -46, -32; -36, -50; -32, -64; -34, -74; -32,
                 -78], style(color=0)),
          Line(points=[-58, -78; -56, -64; -58, -56; -54, -48; -56, -36; -56, -20;
                 -52, -28; -50, -42; -44, -56; -42, -66; -42, -76; -48, -78],
              style(color=0)),
          Line(points=[-50, 76; -58, 68; -56, 58; -56, 46; -56, 34; -48, 22; -44,
                 0; -42, -4; -40, -16; -34, -42; -32, -56; -28, -76], style(
                color=0)),
          Line(points=[-64, 76; -64, 62; -64, 58; -64, 46; -64, 40; -62, 24; -72,
                 8; -68, -2; -68, -22; -74, -32; -72, -46; -74, -62; -70, -74],
               style(color=0)),
          Line(points=[-72, 76; -74, 62; -72, 48; -74, 44; -74, 20; -78, 12; -76,
                 -6; -76, -26; -80, -38], style(color=0)),
          Line(points=[52, 72; 52, 60; 54, 50; 54, 34; 52, 30; 54, 22; 54, 6;
                66, -12; 70, -8; 72, 8; 72, 12; 72, 28; 74, 42; 74, 62; 74, 66;
                 74, 72], style(color=0)),
          Line(points=[58, 76; 60, 64; 60, 50; 62, 44; 60, 24; 66, 2; 66, 24;
                68, 38; 70, 52; 66, 62; 66, 72; 70, 76], style(color=0)),
          Line(points=[74, -74; 74, -58; 76, -42; 80, -28; 80, -24; 76, -10; 68,
                 -10; 64, -16; 58, -14; 56, -20; 52, -30; 58, -46; 60, -52; 60,
                 -62; 58, -66; 56, -76], style(color=0)),
          Line(points=[60, -76; 64, -62; 62, -50; 60, -36; 62, -28; 68, -20; 70,
                 -30; 72, -42; 70, -48; 70, -60; 70, -68; 72, -74], style(color=
                 0)),
          Ellipse(extent=[-66, 10; -48, -8], style(color=0, fillColor=49)),
          Line(points=[14, -78; 16, -62; 12, -46; 10, -24; 18, -32; 18, -36; 16,
                 -42; 16, -46; 20, -58; 20, -70; 28, -76], style(color=0))),
        Window(
          x=0.04,
          y=0.15,
          width=0.6,
          height=0.6),
        Diagram);

    equation
      A = Door_Height*Door_Width;
      therm1.j = -therm2.j;
      therm1.j = kd*A*(therm1.T - therm2.T);
    end Door;

    class doorwjoint
      "describe heat transfer through a closed door considering the air exchange through the joint"

      extends twotherm;
      type AirExchange = Real (final quantity="AirExchange", final unit="m/h");
      parameter Modelica.SIunits.Length Door_Height=2.5;
      parameter Modelica.SIunits.Length Door_Width=1;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer kd=2
        "Coefficient of the door";
      parameter AirExchange VL=2 "Air volume per hour";
      parameter Modelica.SIunits.SpecificHeatCapacity c=1000
        "Heat Capacity of air";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=46)),
          Polygon(points=[-28, 42; -38, 38; -36, 30; -28, 28; -20, 30; -16, 36;
                 -20, 40; -28, 42], style(color=0)),
          Polygon(points=[28, 0; 20, -6; 24, -12; 34, -14; 38, -10; 38, -4; 36,
                 0; 32, 0; 28, 0], style(color=0)),
          Line(points=[-40, 76; -36, 70; -38, 66; -44, 60; -40, 56; -40, 50; -46,
                 46; -46, 40; -44, 32; -40, 28; -40, 22], style(color=0)),
          Line(points=[-40, 22; -38, 16; -34, 12; -34, 6; -34, -2; -30, -10; -28,
                 -20; -32, -26; -28, -36; -26, -40; -20, -46; -24, -52; -28, -56;
                 -28, -62; -28, -66], style(color=0)),
          Line(points=[-28, -66; -26, -70; -22, -72; -28, -76], style(color=0)),
          Line(points=[-30, 76; -32, 66; -30, 60; -36, 56; -30, 50; -20, 44; -12,
                 42; -10, 32; -22, 26; -26, 16; -26, 12; -26, 2; -20, -6; -20,
                -16; -22, -24; -24, -28; -20, -36; -18, -46; -12, -56; -18, -58;
                 -18, -66; -14, -74], style(color=0)),
          Line(points=[-20, 76; -22, 66; -18, 60; -20, 52; -8, 46; -6, 38; -8,
                28; -18, 22; -16, 12; -14, 4; -12, -8; -6, -14; -6, -24; -12, -28;
                 -10, -38; -4, -44; -4, -48; -8, -52; -4, -62; -6, -66; -8, -70],
               style(color=0)),
          Line(points=[24, 78; 24, 70; 28, 64; 28, 50; 22, 42; 24, 34; 24, 26;
                18, 20; 24, 12; 24, 6; 20, 2; 14, -2; 16, -14; 24, -20; 28, -32;
                 36, -40; 34, -44; 32, -50; 28, -58; 28, -62; 30, -66; 30, -70],
               style(color=0)),
          Line(points=[36, 76; 34, 64; 32, 60; 32, 50; 36, 46; 32, 34; 32, 26;
                36, 18; 40, 10; 34, 8; 36, 4; 44, -2; 44, -10; 36, -22; 38, -30;
                 38, -36; 42, -46; 40, -52; 38, -62; 42, -68; 42, -72; 40, -76],
               style(color=0)),
          Line(points=[-14, 76; -12, 64; -6, 56; -2, 44; -2, 40; -2, 30; -8, 18;
                 -8, 6; 0, -6; 0, -16; -2, -40; 4, -48; 2, -54; 2, -66; -2, -74],
               style(color=0)),
          Line(points=[-4, 76; -2, 68; 0, 60; 0, 54; 6, 46; 12, 46; 16, 50; 20,
                 56; 16, 64; 16, 72; 20, 76], style(color=0)),
          Line(points=[2, 76; 2, 68; 6, 60; 8, 52; 12, 54; 10, 62; 10, 70; 10,
                78], style(color=0)),
          Line(points=[46, 76; 44, 66; 48, 60; 46, 52; 42, 42; 44, 28; 46, 24;
                48, 22; 50, 12; 52, 4; 54, -8; 48, -16; 46, -28; 50, -34; 50, -44;
                 52, -50; 50, -52; 54, -60; 48, -66; 54, -70; 56, -78], style(
                color=0)),
          Line(points=[8, -74; 8, -46; 6, -34; 4, -24; 6, -8; 0, 8; -2, 16; 4,
                28; 6, 42; 16, 38; 14, 28; 10, 18; 10, 10; 12, 0; 12, -14; 20,
                -26; 26, -40; 24, -52; 26, -68], style(color=0)),
          Line(points=[-66, -78; -68, -58; -62, -46; -64, -28; -58, 2; -50, -2;
                 -50, -8; -44, -18; -46, -32; -36, -50; -32, -64; -34, -74; -32,
                 -78], style(color=0)),
          Line(points=[-58, -78; -56, -64; -58, -56; -54, -48; -56, -36; -56, -20;
                 -52, -28; -50, -42; -44, -56; -42, -66; -42, -76; -48, -78],
              style(color=0)),
          Line(points=[-50, 76; -58, 68; -56, 58; -56, 46; -56, 34; -48, 22; -44,
                 0; -42, -4; -40, -16; -34, -42; -32, -56; -28, -76], style(
                color=0)),
          Line(points=[-64, 76; -64, 62; -64, 58; -64, 46; -64, 40; -62, 24; -72,
                 8; -68, -2; -68, -22; -74, -32; -72, -46; -74, -62; -70, -74],
               style(color=0)),
          Line(points=[-72, 76; -74, 62; -72, 48; -74, 44; -74, 20; -78, 12; -76,
                 -6; -76, -26; -80, -38], style(color=0)),
          Line(points=[52, 72; 52, 60; 54, 50; 54, 34; 52, 30; 54, 22; 54, 6;
                66, -12; 70, -8; 72, 8; 72, 12; 72, 28; 74, 42; 74, 62; 74, 66;
                 74, 72], style(color=0)),
          Line(points=[58, 76; 60, 64; 60, 50; 62, 44; 60, 24; 66, 2; 66, 24;
                68, 38; 70, 52; 66, 62; 66, 72; 70, 76], style(color=0)),
          Line(points=[74, -74; 74, -58; 76, -42; 80, -28; 80, -24; 76, -10; 68,
                 -10; 64, -16; 58, -14; 56, -20; 52, -30; 58, -46; 60, -52; 60,
                 -62; 58, -66; 56, -76], style(color=0)),
          Line(points=[60, -76; 64, -62; 62, -50; 60, -36; 62, -28; 68, -20; 70,
                 -30; 72, -42; 70, -48; 70, -60; 70, -68; 72, -74], style(color=
                 0)),
          Ellipse(extent=[-66, 10; -48, -8], style(color=0, fillColor=49)),
          Line(points=[14, -78; 16, -62; 12, -46; 10, -24; 18, -32; 18, -36; 16,
                 -42; 16, -46; 20, -58; 20, -70; 28, -76], style(color=0)),
          Rectangle(extent=[-80, -74; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-80, 80; 80, 74], style(color=0, fillColor=67)),
          Rectangle(extent=[74, 80; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-80, 80; -74, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[74, -36; 80, -54], style(color=0, fillColor=0)),
          Rectangle(extent=[74, 46; 80, 28], style(color=0, fillColor=0))),
        Window(
          x=0.02,
          y=0.13,
          width=0.86,
          height=0.6));

      Door Door1 annotation (extent=[-20, -44; 16, -6]);
      airexchange airexchange1(VA=VL, A=1)
        "Here VA = VL is the airexchange rate per hour (not per hour*sqm as defined in class airexchange). Therefore A must be 1. "
        annotation (extent=[-18, 8; 16, 44]);
      therm therm3 annotation (extent=[-100, -10; -80, 10], layer="icon");
      therm therm4 annotation (extent=[80, -10; 100, 10], layer="icon");
    equation
      connect(airexchange1.therm2, therm2)
        annotation (points=[14.3, 26; 38, 26; 38, 0; 90, 0]);
      connect(Door1.therm2, therm2)
        annotation (points=[14.2, -25; 38, -25; 38, 0; 90, 0]);
      connect(Door1.therm1, therm1)
        annotation (points=[-18.2, -25; -46, -25; -46, 0; -90, 0]);
      connect(airexchange1.therm1, therm1)
        annotation (points=[-16.3, 26; -46, 26; -46, 0; -90, 0]);
    end doorwjoint;

    class windowglass "describes a heat transfer through a simple window "
      extends twotherm;
      parameter Modelica.SIunits.Area WindowArea=6;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer kg=5.8
        "Coefficient of glass";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Line(points=[48, 46; -52, -54], style(color=7, thickness=2)),
          Line(points=[-2, 40; -48, -6], style(color=7, thickness=2)),
          Line(points=[46, 0; 0, -46], style(
              color=7,
              thickness=2,
              fillColor=7)),
          Rectangle(extent=[-80, 80; 80, -80], style(pattern=0, fillColor=46)),
          Rectangle(extent=[-74, 74; 74, -74], style(fillColor=71)),
          Line(points=[42, 36; -38, -44], style(color=7, thickness=2)),
          Line(points=[14, 36; -36, -14], style(color=7, thickness=2)),
          Line(points=[44, 10; -6, -40], style(color=7, thickness=2))),
        Window(
          x=0.03,
          y=0.19,
          width=0.75,
          height=0.71),
        Documentation(info="The default coefficient is for window from simple glass which its frame
is less than 5% of the whole window.
"));

    equation
      therm1.j = -therm2.j;
      therm1.j = kg*WindowArea*(therm1.T - therm2.T);
    end windowglass;

    class glasswjoint
      extends twotherm;
      parameter Modelica.SIunits.Area WindowArea=6;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer kg=5.8
        "Coefficient of glass";
      parameter Modelica.SIunits.SpecificHeatCapacity cair=1000
        "Heat Capacity of air";
      parameter Modelica.SIunits.Density rhoair=1.25 "Density of air";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-74, 74; 74, -74], style(color=0, fillColor=71)),
          Line(points=[14, 36; -36, -14], style(color=7, thickness=2)),
          Line(points=[42, 36; -38, -44], style(color=7, thickness=2)),
          Line(points=[44, 10; -6, -40], style(color=7, thickness=2))),
        Window(
          x=0.32,
          y=0.19,
          width=0.6,
          height=0.6));
      windowglass windowglass1(WindowArea=WindowArea, kg=kg)
        annotation (extent=[-22, 12; 24, 60]);
      varairexchange varairexchange1(c=cair, rho=rhoair)
        annotation (extent=[-20, -6; 20, -46]);
      Modelica.Blocks.Interfaces.InPort InPort1
        annotation (extent=[-100, -48; -80, -28]);
    equation
      connect(windowglass1.therm2, therm2)
        annotation (points=[21.7, 36; 46, 36; 46, 0; 90, 0]);
      connect(therm1, windowglass1.therm1)
        annotation (points=[-90, 0; -42, 0; -42, 36; -19.7, 36]);
      connect(varairexchange1.therm2, therm2)
        annotation (points=[18, -26; 46, -26; 46, 0; 90, 0]);
      connect(varairexchange1.therm1, therm1)
        annotation (points=[-18, -26; -42, -26; -42, 0; -90, 0]);
      connect(InPort1, varairexchange1.InPort1) annotation (points=[-90, -38; -38,
             -38; -38, -54; -0.4, -54; -0.4, -44.4]);
    end glasswjoint;

    class window "describes a heat transfer through a simple window with frame"

      import Modelica.SIunits;
      extends twotherm;
      parameter SIunits.Area WindowArea=6;
      parameter SIunits.CoefficientOfHeatTransfer kw=5.2
        "Coefficient of the window";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(pattern=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(
              color=0,
              pattern=0,
              fillColor=46)),
          Rectangle(extent=[-66, 62; -10, -64], style(
              color=0,
              pattern=0,
              fillColor=71)),
          Line(points=[-18, 24; -58, -28], style(color=7, thickness=2)),
          Line(points=[-20, 6; -40, -20], style(color=7, thickness=2)),
          Line(points=[-36, 18; -56, -10], style(color=7, thickness=2)),
          Rectangle(extent=[6, 62; 66, -64], style(
              color=0,
              pattern=0,
              fillColor=71)),
          Line(points=[38, 20; 18, -8], style(color=7, thickness=2)),
          Line(points=[54, 24; 16, -28], style(color=7, thickness=2)),
          Line(points=[56, 8; 36, -18], style(color=7, thickness=2))),
        Window(
          x=0.1,
          y=0.08,
          width=0.79,
          height=0.74),
        Documentation(info="The default coefficient is for window from simple glass which its frame
is 5% of the whole window or more.
"));
    equation
      therm1.j = -therm2.j;
      therm1.j = kw*WindowArea*(therm1.T - therm2.T);
    end window;

    class windowwjoint
      "describes a heat transfer through a simple window with frame considering the air flow through the joints."

      extends twotherm;
      parameter Modelica.SIunits.ThermalDiffusivity VL=2/3600
        "Air volume per seconds per meter";
      parameter Modelica.SIunits.SpecificHeatCapacity c=1000
        "Heat Capacity of air";
      parameter Modelica.SIunits.Length Window_Length=3;
      parameter Modelica.SIunits.Length Window_Width=2;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer kw=5.2
        "Coefficient of the window";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(
              color=0,
              pattern=0,
              fillColor=46)),
          Rectangle(extent=[-66, 62; -10, -64], style(
              color=0,
              pattern=0,
              fillColor=71)),
          Line(points=[-18, 24; -58, -28], style(color=7, thickness=2)),
          Line(points=[-20, 6; -40, -20], style(color=7, thickness=2)),
          Line(points=[-36, 18; -56, -10], style(color=7, thickness=2)),
          Rectangle(extent=[6, 62; 66, -64], style(
              color=0,
              pattern=0,
              fillColor=71)),
          Line(points=[38, 20; 18, -8], style(color=7, thickness=2)),
          Line(points=[54, 24; 16, -28], style(color=7, thickness=2)),
          Line(points=[56, 8; 36, -18], style(color=7, thickness=2)),
          Rectangle(extent=[-80, -76; 80, -80], style(color=0, fillColor=68)),
          Rectangle(extent=[-80, -74; 80, -80], style(color=0, fillColor=68)),
          Rectangle(extent=[-80, 80; 80, 74], style(color=0, fillColor=68)),
          Rectangle(extent=[-80, 80; -74, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[74, 80; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[74, 48; 80, 32], style(color=0, fillColor=0)),
          Rectangle(extent=[74, -28; 80, -44], style(color=0, fillColor=0)),
          Rectangle(extent=[-80, -28; -74, -44], style(color=0, fillColor=0)),
          Rectangle(extent=[-80, 46; -74, 30], style(color=0, fillColor=0))),
        Window(
          x=0.19,
          y=0.07,
          width=0.73,
          height=0.64),
        Documentation(info="The default coefficient is for window from simple glass which its frame
is 5% of the whole window or more.
"));
      therm therm3 annotation (extent=[-100, -10; -80, 10], layer="icon");
      therm therm4 annotation (extent=[80, -10; 100, 10], layer="icon");
      Modelica.Blocks.Interfaces.InPort InPort1
        annotation (extent=[-100, -44; -80, -24]);
      varairexchange varairexchange1 annotation (extent=[-20, -14; 16, -46]);
      window window1 annotation (extent=[-20, 12; 20, 52]);
    equation
      connect(window1.therm2, therm4)
        annotation (points=[18, 32; 38, 32; 38, 0; 90, 0]);
      connect(therm3, window1.therm1)
        annotation (points=[-90, 0; -46, 0; -46, 32; -18, 32]);
      connect(varairexchange1.therm2, therm4)
        annotation (points=[14.2, -30; 38, -30; 38, 0; 90, 0]);
      connect(varairexchange1.therm1, therm3)
        annotation (points=[-18.2, -30; -46, -30; -46, 0; -90, 0]);
      connect(InPort1, varairexchange1.InPort1) annotation (points=[-90, -34; -60,
             -34; -60, -56; -2.36, -56; -2.36, -44.72]);
    end windowwjoint;

    class sglasswjoint1
      extends twotherm;
      parameter Modelica.SIunits.Area WindowArea=6;
      parameter Modelica.SIunits.SpecificHeatCapacity cair=1000
        "Heat Capacity of air";
      parameter Modelica.SIunits.Density rhoair=1.25 "Density of air";
      parameter String tableNameAirExchange="NoName"
        "table name of Air Exchange Profile";
      parameter String fileNameAirExchange="NoName"
        "file where matrix is stored";
      parameter Modelica.SIunits.Volume V=50 "Volume of the room";
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphai=2
        "convective heat transfer coefficient (inside)";
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphao=2
        "convective heat transfer coefficient (outside)";
      parameter Modelica.SIunits.Thickness d=0.01 "Thickness";
      parameter Modelica.SIunits.ThermalConductivity lambda=2.4
        "Thermal conductivity of glass";
      parameter Real Abskoeff=0.1 "Absorptance coefficient";
      parameter Real Transkoeff=0.6 "Solar transmission coefficient";
      Weather.t_and_sl_rad.CUTS.ic_total_rad ic_total_rad1
        annotation (extent=[-100, 50; -80, 70]);
      Elements.Ijadapt solartransmission(koeff=Transkoeff, Area=WindowArea)
        annotation (extent=[-68, 44; -38, 76]);
      Elements.Ijadapt solarabsorptance(koeff=Abskoeff, Area=WindowArea)
        annotation (extent=[-68, 16; -38, 48]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-74, 74; 74, -74], style(color=0, fillColor=71)),
          Line(points=[14, 36; -36, -14], style(color=7, thickness=2)),
          Line(points=[42, 36; -38, -44], style(color=7, thickness=2)),
          Line(points=[44, 10; -6, -40], style(color=7, thickness=2)),
          Ellipse(extent=[48, 72; 72, 48], style(color=49, fillColor=45))),
        Window(
          x=0.2,
          y=0.06,
          width=0.6,
          height=0.6),
        Documentation(info="
"),     Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0))));
      varairexchange varairexchange1(
        c=cair,
        rho=rhoair,
        V=V) annotation (extent=[-12, -12; 22, -44]);
      Elements.heatcond heatcond1(
        A=WindowArea,
        d=d,
        lambda=lambda) annotation (extent=[-6, -10; 14, 10]);
      Elements.heattrans heattrans2(alpha=alphai, A=WindowArea)
        annotation (extent=[60, -10; 40, 10]);
      therm therm4 annotation (extent=[80, 50; 100, 70]);
      therm therm3 annotation (extent=[80, -70; 100, -50]);
      therm therm5 annotation (extent=[-100, -70; -80, -50]);
      Elements.heattrans heattrans1(alpha=alphao, A=WindowArea)
        annotation (extent=[-62, -10; -42, 10]);
      DailyTable DailyTable1(tableName=tableNameAirExchange, fileName=
            fileNameAirExchange) annotation (extent=[-26, -76; -6, -56]);
    equation
      connect(varairexchange1.therm2, therm2)
        annotation (points=[20.3, -28; 66, -28; 66, 0; 90, 0]);
      connect(heatcond1.therm2, heattrans2.therm2)
        annotation (points=[13, 0; 41, 0]);
      connect(heattrans2.therm1, therm2) annotation (points=[59, 0; 90, 0]);
      connect(heatcond1.therm2, therm3)
        annotation (points=[13, 0; 34, 0; 34, -60; 90, -60], style(color=41));
      connect(heattrans1.therm2, heatcond1.therm1)
        annotation (points=[-43, 0; -5, 0]);
      connect(heattrans1.therm1, therm1) annotation (points=[-61, 0; -90, 0]);
      connect(therm1, varairexchange1.therm1)
        annotation (points=[-90, 0; -70, 0; -70, -28; -10.3, -28]);
      connect(therm5, heattrans1.therm2) annotation (points=[-90, -60; -30, -60;
             -30, 0; -43, 0], style(color=41));
      connect(DailyTable1.outPort, varairexchange1.InPort1)
        annotation (points=[-5, -66; 4.66, -66; 4.66, -42.72]);
      connect(solartransmission.therm1, therm4)
        annotation (points=[-39.5, 60; 90, 60]);
      connect(solarabsorptance.therm1, heatcond1.therm1)
        annotation (points=[-39.5, 32; -30, 32; -30, 0; -5, 0]);
      connect(ic_total_rad1, solartransmission.ic_total_rad1)
        annotation (points=[-90, 60; -66.5, 60]);
      connect(ic_total_rad1, solarabsorptance.ic_total_rad1)
        annotation (points=[-90, 60; -70, 60; -70, 32; -66.5, 32]);
    end sglasswjoint1;

    class sglasswjoint2 "Window with heat transmission by solar radiation"
      extends Building.twotherm;
      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      parameter SIunits.Area WindowArea=6;
      parameter SIunits.SpecificHeatCapacity cair=1000 "Heat Capacity of air";
      parameter SIunits.Density rhoair=1.25 "Density of air";
      parameter SIunits.Volume V=50 "Volume of the room";
      parameter SIunits.CoefficientOfHeatTransfer alphai=2
        "convective heat transfer coefficient (inside)";
      parameter SIunits.CoefficientOfHeatTransfer alphao=2
        "convective heat transfer coefficient (outside)";
      parameter SIunits.Thickness d=0.01 "Thickness";
      parameter SIunits.ThermalConductivity lambda=2.4
        "Thermal conductivity of glass";
      parameter Real Abskoeff=0.1 "Absorptance coefficient";
      parameter Real Transkoeff=0.6 "Solar transmission coefficient";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-74, 74; 74, -74], style(color=0, fillColor=71)),
          Line(points=[14, 36; -36, -14], style(color=7, thickness=2)),
          Line(points=[42, 36; -38, -44], style(color=7, thickness=2)),
          Line(points=[44, 10; -6, -40], style(color=7, thickness=2)),
          Ellipse(extent=[48, 72; 72, 48], style(color=49, fillColor=45))),
        Window(
          x=0.26,
          y=0.21,
          width=0.49,
          height=0.55),
        Documentation(info="
"),     Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0))));
      Building.RoomAttribute.varairexchange varairexchange1(
        c=cair,
        rho=rhoair,
        V=V) annotation (extent=[-16, -12; 18, -44]);
      Building.Elements.heatcond heatcond1(
        A=WindowArea,
        d=d,
        lambda=lambda) annotation (extent=[-10, -10; 10, 10]);
      Building.Elements.heattrans heattrans2(alpha=alphai, A=WindowArea)
        annotation (extent=[60, -10; 40, 10]);
      Building.therm therm4 annotation (extent=[80, 50; 100, 70]);
      Building.Elements.Ijadapt solartransmission(koeff=Transkoeff, Area=
            WindowArea) annotation (extent=[-10, 44.8; 16, 72.8]);
      Building.therm therm3 annotation (extent=[80, -70; 100, -50]);
      Building.Elements.Ijadapt solarabsorptance(koeff=Abskoeff, Area=
            WindowArea)
        annotation (extent=[-43.2, 16.6; -17.2, 44.6], rotation=-90);
      Building.therm therm5 annotation (extent=[-100, -70; -80, -50]);
      Building.Elements.heattrans heattrans1(alpha=alphao, A=WindowArea)
        annotation (extent=[-62, -10; -42, 10]);
      Weather.t_and_sl_rad.CUTS.ic_total_rad_v ic_total_rad_v1(final n=
            t_and_sl_rad.n_of_surf_orient_def)
        annotation (extent=[-100, 50; -80, 70]);
      Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_aggregable_sel
        surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
            comp_surf_orient_alias) annotation (extent=[-68, 49.6; -48, 69.6]);
      Modelica.Blocks.Interfaces.InPort InPort1
        annotation (extent=[-5.4, -91.6; 5.4, -80.8], rotation=90);
    equation
      connect(varairexchange1.therm2, therm2)
        annotation (points=[16.3, -28; 66, -28; 66, 0; 90, 0]);
      connect(heatcond1.therm2, heattrans2.therm2)
        annotation (points=[9, 0; 41, 0]);
      connect(heattrans2.therm1, therm2) annotation (points=[59, 0; 90, 0]);
      connect(heatcond1.therm2, therm3)
        annotation (points=[9, 0; 28, 0; 28, -60; 90, -60], style(color=41));
      connect(solartransmission.therm1, therm4)
        annotation (points=[14.7,58.8; 53.35,58.8; 53.35,60; 90,60]);
      connect(heattrans1.therm2, heatcond1.therm1)
        annotation (points=[-43, 0; -9, 0]);
      connect(heattrans1.therm1, therm1) annotation (points=[-61, 0; -90, 0]);
      connect(therm1, varairexchange1.therm1)
        annotation (points=[-90, 0; -70, 0; -70, -28; -14.3, -28]);
      connect(therm5, heattrans1.therm2) annotation (points=[-90, -60; -30, -60;
             -30, 0; -43, 0], style(color=41));
      connect(ic_total_rad_v1, surf_orient_alias_aggregable_sel1.
        ic_total_rad_v1)
        annotation (points=[-90,60; -79.7,60; -79.7,59.6; -69.4,59.6]);
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
        solartransmission.ic_total_rad1) annotation (points=[-46.4,59.7; -37,
            59.7; -37,60; -18,60; -18,58.8; -8.7,58.8]);
      connect(varairexchange1.InPort1, InPort1) annotation (points=[0.66,-42.72;
            0.66,-54.04; 0.06,-54.04; 0.06,-65.36; 0,-65.36; 0,-86.2]);
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1, solarabsorptance.
         ic_total_rad1)
        annotation (points=[-46.4,59.7; -30.2,59.7; -30.2,43.2]);
      connect(heatcond1.therm1, solarabsorptance.therm1)
        annotation (points=[-9,0; -30.2,0; -30.2,18]);

    end sglasswjoint2;

    class DailyClock "generate daily time impuls in second"
      extends Modelica.Blocks.Interfaces.MO(final nout=1);
      Real td;
      parameter Real interval=1800 "sampling time (second)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.14,
          y=0.1,
          width=0.6,
          height=0.6),
        Icon(
          Ellipse(extent=[-82, 50; 18, -46], style(color=0)),
          Line(points=[-34, 46; -34, 0], style(color=0, thickness=2)),
          Line(points=[-34, 0; -12, 18], style(color=0, thickness=2)),
          Text(
            extent=[72, 100; 72, 56],
            string="1",
            style(color=0)),
          Text(
            extent=[72, -54; 72, -98],
            string="24",
            style(color=0)),
          Line(points=[72, 50; 72, -50], style(pattern=3, fillColor=61))),
        Diagram(
          Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                fillColor=9)),
          Line(points=[-80, 68; -80, -80], style(color=9)),
          Line(points=[-90, -70; 82, -70], style(color=9)),
          Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
              color=8,
              fillColor=9,
              fillPattern=1)),
          Text(
            extent=[-66, 92; -25, 72],
            string="outPort",
            style(color=9)),
          Text(
            extent=[70, -80; 94, -100],
            string="time",
            style(color=9)),
          Line(points=[-80, -70; -20, 0], style(color=0, thickness=2)),
          Line(points=[-20, -70; 40, 0], style(color=0, thickness=2)),
          Line(points=[-20, 0; -20, -70], style(color=0, pattern=2)),
          Line(points=[40, 0; 40, -70], style(color=0, pattern=2)),
          Line(points=[40, -70; 68, -38], style(color=0, thickness=2)),
          Line(points=[-80, 0; 40, 0], style(color=8, pattern=3)),
          Text(
            extent=[-98, 8; -82, -10],
            string="24",
            style(color=0, fillColor=0)),
          Text(
            extent=[-30, -72; -14, -90],
            string="24",
            style(color=0, fillColor=0)),
          Text(
            extent=[32, -74; 48, -92],
            string="48",
            style(color=0, fillColor=0))));
    equation
      when sample(0, interval) then
        td = mod(time, 86400);
      end when;
      outPort.signal[1] = td;
    end DailyClock;

    class DailyTable
      "this component will read a daily profil from table in a file"
      extends Modelica.Blocks.Interfaces.MO(final nout=size(icol, 1));
      parameter String tableName="NoName"
        "table name on file or in function usertab(optional)";
      parameter String fileName="NoName"
        "file where matrix is stored (optional)";
      parameter Real icol[:]={2} "columns of table to be interpolated";
      parameter Real interval=1800 "sampling time (second)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-60, 18; -30, -2], style(
              color=0,
              fillColor=6,
              fillPattern=1)),
          Rectangle(extent=[-60, -2; -30, -22], style(
              color=0,
              fillColor=6,
              fillPattern=1)),
          Rectangle(extent=[-60, -22; -30, -42], style(
              color=0,
              fillColor=6,
              fillPattern=1)),
          Line(points=[0, 18; 0, -62], style(color=0)),
          Line(points=[-60, 18; -60, -62; 60, -62; 60, 18; 30, 18; 30, -62; -30,
                 -62; -30, 18; -60, 18; -60, -2; 60, -2; 60, -22; -60, -22; -60,
                 -42; 60, -42; 60, -62; -60, -62; -60, 18; 60, 18; 60, -62],
              style(color=0)),
          Rectangle(extent=[-60, -42; -30, -62], style(
              color=0,
              fillColor=6,
              fillPattern=1)),
          Text(extent=[-82, 80; 88, 34], string="Daily")),
        Window(
          x=0.15,
          y=0.01,
          width=0.6,
          height=0.6),
        Documentation(info="The least interval time in the profile table is to be
chosen as sampling time.
"));
      DailyClock DailyClock1(interval=interval)
        annotation (extent=[-80, -20; -40, 20]);
      ModelicaAdditions.Tables.CombiTable1D Profiltable(
        tableName=tableName,
        fileName=fileName,
        icol=icol) annotation (extent=[0, -20; 40, 20]);
    equation
      connect(DailyClock1.outPort, Profiltable.inPort)
        annotation (points=[-36, 0; -6, 0]);
      connect(Profiltable.outPort, outPort) annotation (points=[42, 2; 106, 2]);
    end DailyTable;

    class raddistributor7
      "divide the energie from radiation in respect to area and absorptance koefficient"

      Real AreaAbstotal;
      parameter Modelica.SIunits.Area Area1=16;
      parameter Real Abs1=0.6;
      parameter Modelica.SIunits.Area Area2=16;
      parameter Real Abs2=0.6;
      parameter Modelica.SIunits.Area Area3=16;
      parameter Real Abs3=0.6;
      parameter Modelica.SIunits.Area Area4=16;
      parameter Real Abs4=0.6;
      parameter Modelica.SIunits.Area Area5=16;
      parameter Real Abs5=0.6;
      parameter Modelica.SIunits.Area Area6=16;
      parameter Real Abs6=0.6;
      parameter Modelica.SIunits.Area Area7=16;
      parameter Real Abs7=0.6;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-60, 80; 60, -80], style(color=0))),
        Icon(
          Rectangle(extent=[-60, 79; 60, -81], style(color=0, fillColor=68)),
          Line(points=[0, 77; 0, -74], style(color=41)),
          Line(points=[-10, -67; 0, -74; 10, -67], style(color=41)),
          Line(points=[-50, 50; 50, 50], style(color=41)),
          Line(points=[-44, 56; -50, 50; -44, 44], style(color=41)),
          Line(points=[44, 44; 50, 50; 44, 56], style(color=41)),
          Line(points=[-44, 6; -50, 0; -44, -6], style(color=41)),
          Line(points=[-50, 0; 50, 0], style(color=41)),
          Line(points=[44, -6; 50, 0; 44, 6], style(color=41)),
          Line(points=[-50, -50; 50, -50], style(color=41)),
          Line(points=[-44, -44; -50, -50; -44, -56], style(color=41)),
          Line(points=[44, -56; 50, -50; 44, -44], style(color=41))),
        Window(
          x=0.32,
          y=0.04,
          width=0.6,
          height=0.6),
        Documentation(info="Intended to be used with Room7zones to divide the radiative
energie flow inside the room.
"));
      therm therm1 annotation (extent=[60, 40; 80, 60]);
      therm therm2 annotation (extent=[60, -10; 80, 10]);
      therm therm3 annotation (extent=[60, -60; 80, -40]);
      therm therm5 annotation (extent=[-80, -60; -60, -40]);
      therm therm6 annotation (extent=[-80, -10; -60, 10]);
      therm therm7 annotation (extent=[-80, 40; -60, 60]);
      therm therm4 annotation (extent=[-10, -100; 10, -80]);
      therm therm8 annotation (extent=[-10, 80; 10, 100]);
    equation
      AreaAbstotal = Abs1*Area1 + Abs2*Area2 + Abs3*Area3 + Abs4*Area4 + Abs5*
        Area5 + Abs6*Area6 + Abs7*Area7;
      therm1.j = -Abs1*Area1/AreaAbstotal*therm8.j;
      therm2.j = -Abs2*Area2/AreaAbstotal*therm8.j;
      therm3.j = -Abs3*Area3/AreaAbstotal*therm8.j;
      therm4.j = -Abs4*Area4/AreaAbstotal*therm8.j;
      therm5.j = -Abs5*Area5/AreaAbstotal*therm8.j;
      therm6.j = -Abs6*Area6/AreaAbstotal*therm8.j;
      therm7.j = -Abs7*Area7/AreaAbstotal*therm8.j;
      //fictive Temperatur
      therm8.T = therm1.T;
    end raddistributor7;

    class raddistributor9
      "divide the energie from radiation in respect to area and absorptance koefficient"

      Real AreaAbstotal;
      parameter Modelica.SIunits.Area Area1=16;
      parameter Real Abs1=0.6;
      parameter Modelica.SIunits.Area Area2=16;
      parameter Real Abs2=0.6;
      parameter Modelica.SIunits.Area Area3=16;
      parameter Real Abs3=0.6;
      parameter Modelica.SIunits.Area Area4=16;
      parameter Real Abs4=0.6;
      parameter Modelica.SIunits.Area Area5=16;
      parameter Real Abs5=0.6;
      parameter Modelica.SIunits.Area Area6=16;
      parameter Real Abs6=0.6;
      parameter Modelica.SIunits.Area Area7=16;
      parameter Real Abs7=0.6;
      parameter Modelica.SIunits.Area Area8=16;
      parameter Real Abs8=0.6;
      parameter Modelica.SIunits.Area Area9=16;
      parameter Real Abs9=0.6;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-60, 80; 60, -80], style(color=0))),
        Icon(
          Rectangle(extent=[-60, 80; 60, -80], style(color=0, fillColor=68)),
          Line(points=[0, 77; 0, -74], style(color=41)),
          Line(points=[-50, 60; 50, 60], style(color=41)),
          Line(points=[-44, 66; -50, 60; -44, 54], style(color=41)),
          Line(points=[44, 54; 50, 60; 44, 66], style(color=41)),
          Line(points=[-10, -67; 0, -74; 10, -67], style(color=41)),
          Line(points=[-44, 26; -50, 20; -44, 14], style(color=41)),
          Line(points=[-50, 20; 50, 20], style(color=41)),
          Line(points=[44, 14; 50, 20; 44, 26], style(color=41)),
          Line(points=[-45, -14; -51, -20; -45, -26], style(color=41)),
          Line(points=[-51, -20; 49, -20], style(color=41)),
          Line(points=[43, -26; 49, -20; 43, -14], style(color=41)),
          Line(points=[-44, -54; -50, -60; -44, -66], style(color=41)),
          Line(points=[-50, -60; 50, -60], style(color=41)),
          Line(points=[44, -66; 50, -60; 44, -54], style(color=41))),
        Window(
          x=0.27,
          y=0.22,
          width=0.6,
          height=0.6),
        Documentation(info="Intended to be used with Room9zones to divide the radiative
energie flow inside the room.
"));
      therm therm1 annotation (extent=[60, 50; 80, 70]);
      therm therm2 annotation (extent=[60, 10; 80, 30]);
      therm therm3 annotation (extent=[60, -30; 80, -10]);
      therm therm4 annotation (extent=[60, -70; 80, -50]);
      therm therm5 annotation (extent=[-10, -100; 10, -80]);
      therm therm6 annotation (extent=[-80, -70; -60, -50]);
      therm therm7 annotation (extent=[-80, -30; -60, -10]);
      therm therm8 annotation (extent=[-80, 10; -60, 30]);
      therm therm9 annotation (extent=[-80, 50; -60, 70]);
      therm therm10 annotation (extent=[-10, 80; 10, 100]);
    equation
      AreaAbstotal = Abs1*Area1 + Abs2*Area2 + Abs3*Area3 + Abs4*Area4 + Abs5*
        Area5 + Abs6*Area6 + Abs7*Area7 + Abs8*Area8 + Abs9*Area9;
      therm1.j = -Abs1*Area1/AreaAbstotal*therm10.j;
      therm2.j = -Abs2*Area2/AreaAbstotal*therm10.j;
      therm3.j = -Abs3*Area3/AreaAbstotal*therm10.j;
      therm4.j = -Abs4*Area4/AreaAbstotal*therm10.j;
      therm5.j = -Abs5*Area5/AreaAbstotal*therm10.j;
      therm6.j = -Abs6*Area6/AreaAbstotal*therm10.j;
      therm7.j = -Abs7*Area7/AreaAbstotal*therm10.j;
      therm8.j = -Abs8*Area8/AreaAbstotal*therm10.j;
      therm9.j = -Abs9*Area9/AreaAbstotal*therm10.j;
      //fictive Temperature
      therm10.T = therm1.T;
    end raddistributor9;

    class raddistributor6
      Real AreaAbstotal;
      parameter Modelica.SIunits.Area Area1=16;
      parameter Real Abs1=0.6;
      parameter Modelica.SIunits.Area Area2=16;
      parameter Real Abs2=0.6;
      parameter Modelica.SIunits.Area Area3=16;
      parameter Real Abs3=0.6;
      parameter Modelica.SIunits.Area Area4=16;
      parameter Real Abs4=0.6;
      parameter Modelica.SIunits.Area Area5=16;
      parameter Real Abs5=0.6;
      parameter Modelica.SIunits.Area Area6=16;
      parameter Real Abs6=0.6;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-60, 80; 60, -80], style(color=0))),
        Icon(
          Rectangle(extent=[-60, 80; 60, -80], style(color=0, fillColor=68)),
          Line(points=[-50, 50; 50, 50], style(color=41)),
          Line(points=[-50, 0; 50, 0], style(color=41)),
          Line(points=[-50, -50; 50, -50], style(color=41)),
          Line(points=[-44, 56; -50, 50; -44, 44], style(color=41)),
          Line(points=[44, 44; 50, 50; 44, 56], style(color=41)),
          Line(points=[44, -6; 50, 0; 44, 6], style(color=41)),
          Line(points=[-44, 6; -50, 0; -44, -6], style(color=41)),
          Line(points=[-44, -44; -50, -50; -44, -56], style(color=41)),
          Line(points=[44, -56; 50, -50; 44, -44], style(color=41)),
          Line(points=[0, 77; 0, -50], style(color=41))),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      therm therm7 annotation (extent=[-10, 80; 10, 100]);
      therm therm1 annotation (extent=[60, 40; 80, 60]);
      therm therm2 annotation (extent=[60, -10; 80, 10]);
      therm therm3 annotation (extent=[60, -60; 80, -40]);
      therm therm4 annotation (extent=[-80, -60; -60, -40]);
      therm therm5 annotation (extent=[-80, -10; -60, 10]);
      therm therm6 annotation (extent=[-80, 40; -60, 60]);
    equation
      AreaAbstotal = Abs1*Area1 + Abs2*Area2 + Abs3*Area3 + Abs4*Area4 + Abs5*
        Area5 + Abs6*Area6;
      therm1.j = -Abs1*Area1/AreaAbstotal*therm7.j;
      therm2.j = -Abs2*Area2/AreaAbstotal*therm7.j;
      therm3.j = -Abs3*Area3/AreaAbstotal*therm7.j;
      therm4.j = -Abs4*Area4/AreaAbstotal*therm7.j;
      therm5.j = -Abs5*Area5/AreaAbstotal*therm7.j;
      therm6.j = -Abs6*Area6/AreaAbstotal*therm7.j;
      //fictive Temperatur
      therm7.T = therm1.T;
    end raddistributor6;

    class HeatFlow
      parameter Integer men=4 "Number of persons in room";
      parameter Integer n=4 "Number of independent lightsystems";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[0.5, 0.5],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-79.5, 86.5; 80.5, -75.5], style(color=0, fillColor=
                 71)),
          Ellipse(extent=[-61.5, 57.5; -21.5, 19.5], style(color=0, fillColor=
                  49)),
          Ellipse(extent=[-41.5, 43.5; -31.5, 31.5], style(color=0)),
          Ellipse(extent=[-47.5, 43.5; -37.5, 31.5], style(color=0)),
          Line(points=[-33.5, 33.5; -37.5, 21.5], style(color=0)),
          Line(points=[-49.5, 33.5; -45.5, 21.5], style(color=0)),
          Rectangle(extent=[-49.5, 21.5; -31.5, -2.5], style(color=0, fillColor=
                 8)),
          Ellipse(extent=[-51.5, 43.5; -43.5, 31.5], style(color=0)),
          Line(points=[-49.5, 1.5; -31.5, 1.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, 9.5; -31.5, 9.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, 15.5; -31.5, 15.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[28, -8; 28, -46], style(color=0)),
          Line(points=[28, -46; 54, -72], style(color=0)),
          Line(points=[26, -46; 2, -70], style(color=0)),
          Ellipse(extent=[8, 24; 44, -8], style(color=0)),
          Line(points=[26, -26; -4, -10], style(color=0)),
          Line(points=[26, -26; 60, -10], style(color=0)),
          Ellipse(extent=[14, 14; 24, 6], style(color=0)),
          Ellipse(extent=[28, 14; 38, 6], style(color=0)),
          Line(points=[18, 2; 26, -4; 36, 2], style(color=0)),
          Line(points=[-41, 63; -41, 77], style(color=85)),
          Line(points=[-41, 77; -47, 71], style(color=85)),
          Line(points=[-41, 77; -35, 71], style(color=85)),
          Line(points=[54, 14; 68, 20; 58, 22], style(color=85)),
          Line(points=[68, 20; 66, 12], style(color=85)),
          Line(points=[0, 14; -12, 22; -2, 22], style(color=85)),
          Line(points=[-12, 22; -8, 12], style(color=85)),
          Line(points=[50.5, -32; 64.5, -26; 54.5, -24], style(color=85)),
          Line(points=[64.5, -26; 62.5, -34], style(color=85)),
          Line(points=[-5, -31.5; -17, -23.5; -7, -23.5], style(color=85)),
          Line(points=[-17, -23.5; -13, -33.5], style(color=85)),
          Line(points=[-65, 49.5; -77, 57.5; -67, 57.5], style(color=85)),
          Line(points=[-77, 57.5; -73, 47.5], style(color=85)),
          Line(points=[-19.5, 48; -5.5, 54; -15.5, 56], style(color=85)),
          Line(points=[-5.5, 54; -7.5, 46], style(color=85)),
          Line(points=[25, 49; 31, 43], style(color=85)),
          Line(points=[25, 35; 25, 49], style(color=85)),
          Line(points=[25, 49; 19, 43], style(color=85))),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 81.5; 80, -80.5], style(color=0, fillColor=71)),
          Ellipse(extent=[-61.5, 57.5; -21.5, 19.5], style(color=0, fillColor=
                  49)),
          Ellipse(extent=[-41.5, 43.5; -31.5, 31.5], style(color=0)),
          Ellipse(extent=[-47.5, 43.5; -37.5, 31.5], style(color=0)),
          Line(points=[-33.5, 33.5; -37.5, 21.5], style(color=0)),
          Line(points=[-49.5, 33.5; -45.5, 21.5], style(color=0)),
          Rectangle(extent=[-49.5, 21.5; -31.5, -2.5], style(color=0, fillColor=
                 8)),
          Ellipse(extent=[-51.5, 43.5; -43.5, 31.5], style(color=0)),
          Line(points=[-49.5, 1.5; -31.5, 1.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, 9.5; -31.5, 9.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, 15.5; -31.5, 15.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[28, -8; 28, -46], style(color=0)),
          Line(points=[28, -46; 54, -72], style(color=0)),
          Line(points=[26, -46; 2, -70], style(color=0)),
          Ellipse(extent=[8, 24; 44, -8], style(color=0)),
          Line(points=[26, -26; -4, -10], style(color=0)),
          Line(points=[26, -26; 60, -10], style(color=0)),
          Ellipse(extent=[14, 14; 24, 6], style(color=0)),
          Ellipse(extent=[28, 14; 38, 6], style(color=0)),
          Line(points=[18, 2; 26, -4; 36, 2], style(color=0)),
          Line(points=[-41, 63; -41, 77], style(color=85)),
          Line(points=[-41, 77; -47, 71], style(color=85)),
          Line(points=[-41, 77; -35, 71], style(color=85)),
          Line(points=[54, 14; 68, 20; 58, 22], style(color=85)),
          Line(points=[68, 20; 66, 12], style(color=85)),
          Line(points=[0, 14; -12, 22; -2, 22], style(color=85)),
          Line(points=[-12, 22; -8, 12], style(color=85)),
          Line(points=[50.5, -32; 64.5, -26; 54.5, -24], style(color=85)),
          Line(points=[64.5, -26; 62.5, -34], style(color=85)),
          Line(points=[-5, -31.5; -17, -23.5; -7, -23.5], style(color=85)),
          Line(points=[-17, -23.5; -13, -33.5], style(color=85)),
          Line(points=[-65, 49.5; -77, 57.5; -67, 57.5], style(color=85)),
          Line(points=[-77, 57.5; -73, 47.5], style(color=85)),
          Line(points=[-19.5, 48; -5.5, 54; -15.5, 56], style(color=85)),
          Line(points=[-5.5, 54; -7.5, 46], style(color=85)),
          Line(points=[25, 49; 31, 43], style(color=85)),
          Line(points=[25, 35; 25, 49], style(color=85)),
          Line(points=[25, 49; 19, 43], style(color=85))),
        Window(
          x=0.12,
          y=0.19,
          width=0.65,
          height=0.6));

      Modelica.Blocks.Interfaces.InPort InPort1
        annotation (extent=[-122, 22; -80, 64]);
      Modelica.Blocks.Interfaces.InPort InPort2
        annotation (extent=[-123, -64; -80, -24]);
      Modelica.Blocks.Interfaces.OutPort OutPort
        annotation (extent=[81.5, -26; 117.5, 24]);
    equation
      if cardinality(InPort1) == 0 then
        InPort1.signal[1] = men;
      end if;
      if cardinality(InPort2) == 0 then
        InPort2.signal[1] = n;
      end if;
      OutPort.signal[1] = 126*InPort1.signal[1] + InPort2.signal[1]*0.96*40;
    end HeatFlow;

    class HeatFlow_Airexchange
      parameter Integer men=4 "Number of persons in room";
      parameter Integer n=4 "Number of independent lightsystems";
      parameter Real airex=1;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=71)),
          Ellipse(extent=[-61.5, -2.5; -21.5, -40.5], style(color=0, fillColor=
                  49)),
          Ellipse(extent=[-41.5, -16.5; -31.5, -28.5], style(color=0)),
          Ellipse(extent=[-47.5, -16.5; -37.5, -28.5], style(color=0)),
          Line(points=[-33.5, -26.5; -37.5, -38.5], style(color=0)),
          Line(points=[-49.5, -26.5; -45.5, -38.5], style(color=0)),
          Rectangle(extent=[-49.5, -38.5; -31.5, -62.5], style(color=0,
                fillColor=8)),
          Ellipse(extent=[-51.5, -16.5; -43.5, -28.5], style(color=0)),
          Line(points=[-49.5, -58.5; -31.5, -58.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -50.5; -31.5, -50.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -44.5; -31.5, -44.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[38, 2; 38, -36], style(color=0)),
          Line(points=[38, -36; 64, -62], style(color=0)),
          Line(points=[36, -38; 12, -62], style(color=0)),
          Ellipse(extent=[20, 34; 56, 2], style(color=0)),
          Line(points=[38, -16; 8, 0], style(color=0)),
          Line(points=[38, -16; 72, 0], style(color=0)),
          Ellipse(extent=[26, 24; 36, 16], style(color=0)),
          Ellipse(extent=[40, 24; 50, 16], style(color=0)),
          Line(points=[-41, 3; -41, 17], style(color=85)),
          Line(points=[-41, 17; -47, 11], style(color=85)),
          Line(points=[-41, 17; -35, 11], style(color=85)),
          Line(points=[62, 18; 76, 24; 66, 26], style(color=85)),
          Line(points=[76, 24; 72, 16], style(color=85)),
          Line(points=[14, 18; 2, 26; 12, 26], style(color=85)),
          Line(points=[2, 26; 6, 16], style(color=85)),
          Line(points=[58.5, -22; 72.5, -16; 62.5, -14], style(color=85)),
          Line(points=[72.5, -16; 70.5, -24], style(color=85)),
          Line(points=[17, -29.5; 5, -21.5; 15, -21.5], style(color=85)),
          Line(points=[5, -21.5; 9, -31.5], style(color=85)),
          Line(points=[-65, -10.5; -77, -2.5; -67, -2.5], style(color=85)),
          Line(points=[-77, -2.5; -73, -12.5], style(color=85)),
          Line(points=[-19.5, -12; -5.5, -6; -15.5, -4], style(color=85)),
          Line(points=[-5.5, -6; -7.5, -14], style(color=85)),
          Line(points=[37, 59; 43, 53], style(color=85)),
          Line(points=[37, 45; 37, 59], style(color=85)),
          Line(points=[37, 59; 31, 53], style(color=85)),
          Polygon(points=[-60, 48; -60, 22; -70, 36; -60, 48], style(color=69,
                fillColor=69)),
          Rectangle(extent=[-60, 42; -14, 30], style(color=69, fillColor=69)),
          Polygon(points=[-14, 48; -14, 24; -2, 36; -14, 48; -14, 48], style(
                color=69, fillColor=69)),
          Polygon(points=[-60, 78; -60, 52; -70, 66; -60, 78], style(color=69,
                fillColor=69)),
          Rectangle(extent=[-60, 72; -14, 60], style(color=69, fillColor=69)),
          Polygon(points=[-14, 78; -14, 54; -2, 66; -14, 78; -14, 78], style(
                color=69, fillColor=69)),
          Line(points=[26, 12; 32, 8; 38, 10; 44, 8; 48, 12], style(color=0))),
        Icon(
          Rectangle(extent=[-80, 81.5; 80, -80.5], style(color=0, fillColor=71)),
          Ellipse(extent=[-61.5, -2.5; -21.5, -40.5], style(color=0, fillColor=
                  49)),
          Ellipse(extent=[-41.5, -16.5; -31.5, -28.5], style(color=0)),
          Ellipse(extent=[-47.5, -16.5; -37.5, -28.5], style(color=0)),
          Line(points=[-33.5, -26.5; -37.5, -38.5], style(color=0)),
          Line(points=[-49.5, -26.5; -45.5, -38.5], style(color=0)),
          Rectangle(extent=[-49.5, -38.5; -31.5, -62.5], style(color=0,
                fillColor=8)),
          Ellipse(extent=[-51.5, -16.5; -43.5, -28.5], style(color=0)),
          Line(points=[-49.5, -58.5; -31.5, -58.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -50.5; -31.5, -50.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -44.5; -31.5, -44.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[38, 2; 38, -36], style(color=0)),
          Line(points=[38, -36; 64, -62], style(color=0)),
          Line(points=[36, -38; 12, -62], style(color=0)),
          Ellipse(extent=[20, 34; 56, 2], style(color=0)),
          Line(points=[36, -16; 6, 0], style(color=0)),
          Line(points=[36, -16; 70, 0], style(color=0)),
          Ellipse(extent=[26, 24; 36, 16], style(color=0)),
          Ellipse(extent=[40, 24; 50, 16], style(color=0)),
          Line(points=[30, 12; 38, 6; 48, 12], style(color=0)),
          Line(points=[-41, 3; -41, 17], style(color=85)),
          Line(points=[-41, 17; -47, 11], style(color=85)),
          Line(points=[-41, 17; -35, 11], style(color=85)),
          Line(points=[60, 18; 74, 24; 64, 26], style(color=85)),
          Line(points=[74, 24; 70, 16], style(color=85)),
          Line(points=[12, 16; 0, 24; 10, 24], style(color=85)),
          Line(points=[0, 24; 4, 14], style(color=85)),
          Line(points=[58.5, -22; 72.5, -16; 62.5, -14], style(color=85)),
          Line(points=[72.5, -16; 70.5, -24], style(color=85)),
          Line(points=[17, -29.5; 5, -21.5; 15, -21.5], style(color=85)),
          Line(points=[5, -21.5; 9, -31.5], style(color=85)),
          Line(points=[-65, -10.5; -77, -2.5; -67, -2.5], style(color=85)),
          Line(points=[-77, -2.5; -73, -12.5], style(color=85)),
          Line(points=[-19.5, -12; -5.5, -6; -15.5, -4], style(color=85)),
          Line(points=[-5.5, -6; -7.5, -14], style(color=85)),
          Line(points=[33, 59; 39, 53], style(color=85)),
          Line(points=[33, 45; 33, 59], style(color=85)),
          Line(points=[33, 59; 27, 53], style(color=85)),
          Rectangle(extent=[-58, 70; -12, 58], style(color=69, fillColor=69)),
          Polygon(points=[-12, 76; -12, 52; 0, 64; -12, 76; -12, 76], style(
                color=69, fillColor=69)),
          Rectangle(extent=[-58, 40; -12, 28], style(color=69, fillColor=69)),
          Polygon(points=[-58, 46; -58, 20; -68, 34; -58, 46], style(color=69,
                fillColor=69)),
          Polygon(points=[-12, 46; -12, 22; 0, 34; -12, 46; -12, 46], style(
                color=69, fillColor=69))),
        Window(
          x=0.22,
          y=0.23,
          width=0.6,
          height=0.67));

      Modelica.Blocks.Interfaces.InPort InPort1
        annotation (extent=[-122, 40; -80, 82]);
      Modelica.Blocks.Interfaces.InPort InPort2
        annotation (extent=[-123, -26; -80, 14]);
      Modelica.Blocks.Interfaces.OutPort OutPort1
        annotation (extent=[81.5, 12; 117.5, 62]);
      Modelica.Blocks.Interfaces.InPort InPort3
        annotation (extent=[-125, -88; -82, -48]);
      Modelica.Blocks.Interfaces.OutPort OutPort2
        annotation (extent=[81.5, -62; 117.5, -12]);
    algorithm
      if cardinality(InPort1) == 0 then
        InPort1.signal[1] := men;
      end if;
      if cardinality(InPort2) == 0 then
        InPort2.signal[1] := n;
      end if;
      if cardinality(InPort3) == 0 then
        InPort3.signal[1] := airex;
      end if;

      OutPort1.signal[1] := InPort3.signal[1];
      OutPort2.signal[1] := 126*InPort1.signal[1] + InPort2.signal[1]*0.96*40;
    end HeatFlow_Airexchange;

    class HeatFlow_Airex_tab
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=71)),
          Ellipse(extent=[-61.5, -2.5; -21.5, -40.5], style(color=0, fillColor=
                  49)),
          Ellipse(extent=[-41.5, -16.5; -31.5, -28.5], style(color=0)),
          Ellipse(extent=[-47.5, -16.5; -37.5, -28.5], style(color=0)),
          Line(points=[-33.5, -26.5; -37.5, -38.5], style(color=0)),
          Line(points=[-49.5, -26.5; -45.5, -38.5], style(color=0)),
          Rectangle(extent=[-49.5, -38.5; -31.5, -62.5], style(color=0,
                fillColor=8)),
          Ellipse(extent=[-51.5, -16.5; -43.5, -28.5], style(color=0)),
          Line(points=[-49.5, -58.5; -31.5, -58.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -50.5; -31.5, -50.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -44.5; -31.5, -44.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[38, 2; 38, -36], style(color=0)),
          Line(points=[38, -36; 64, -62], style(color=0)),
          Line(points=[38, -36; 14, -60], style(color=0)),
          Ellipse(extent=[20, 34; 56, 2], style(color=0)),
          Line(points=[40, -16; 10, 0], style(color=0)),
          Line(points=[36, -16; 70, 0], style(color=0)),
          Ellipse(extent=[26, 24; 36, 16], style(color=0)),
          Ellipse(extent=[40, 24; 50, 16], style(color=0)),
          Line(points=[30, 12; 38, 6; 48, 12], style(color=0)),
          Line(points=[-41, 3; -41, 17], style(color=85)),
          Line(points=[-41, 17; -47, 11], style(color=85)),
          Line(points=[-41, 17; -35, 11], style(color=85)),
          Line(points=[62, 18; 76, 24; 66, 26], style(color=85)),
          Line(points=[76, 24; 72, 16], style(color=85)),
          Line(points=[14, 18; 2, 26; 12, 26], style(color=85)),
          Line(points=[2, 26; 6, 16], style(color=85)),
          Line(points=[58.5, -22; 72.5, -16; 62.5, -14], style(color=85)),
          Line(points=[72.5, -16; 70.5, -24], style(color=85)),
          Line(points=[17, -29.5; 5, -21.5; 15, -21.5], style(color=85)),
          Line(points=[5, -21.5; 9, -31.5], style(color=85)),
          Line(points=[-65, -10.5; -77, -2.5; -67, -2.5], style(color=85)),
          Line(points=[-19.5, -12; -5.5, -6; -15.5, -4], style(color=85)),
          Line(points=[-5.5, -6; -7.5, -14], style(color=85)),
          Line(points=[33, 59; 39, 53], style(color=85)),
          Line(points=[33, 45; 33, 59], style(color=85)),
          Line(points=[33, 59; 27, 53], style(color=85)),
          Polygon(points=[-60, 48; -60, 22; -70, 36; -60, 48], style(color=69,
                fillColor=69)),
          Rectangle(extent=[-60, 42; -14, 30], style(color=69, fillColor=69)),
          Polygon(points=[-14, 48; -14, 24; -2, 36; -14, 48; -14, 48], style(
                color=69, fillColor=69)),
          Polygon(points=[-60, 78; -60, 52; -70, 66; -60, 78], style(color=69,
                fillColor=69)),
          Rectangle(extent=[-60, 72; -14, 60], style(color=69, fillColor=69)),
          Polygon(points=[-14, 78; -14, 54; -2, 66; -14, 78; -14, 78], style(
                color=69, fillColor=69)),
          Line(points=[-76, -4; -76, -12], style(color=41, fillColor=41))),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=71)),
          Ellipse(extent=[-61.5, -2.5; -21.5, -40.5], style(color=0, fillColor=
                  49)),
          Ellipse(extent=[-41.5, -16.5; -31.5, -28.5], style(color=0)),
          Ellipse(extent=[-47.5, -16.5; -37.5, -28.5], style(color=0)),
          Line(points=[-33.5, -26.5; -37.5, -38.5], style(color=0)),
          Line(points=[-49.5, -26.5; -45.5, -38.5], style(color=0)),
          Rectangle(extent=[-49.5, -38.5; -31.5, -62.5], style(color=0,
                fillColor=8)),
          Ellipse(extent=[-51.5, -16.5; -43.5, -28.5], style(color=0)),
          Line(points=[-49.5, -58.5; -31.5, -58.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -50.5; -31.5, -50.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-49.5, -44.5; -31.5, -44.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[38, 2; 38, -36], style(color=0)),
          Line(points=[38, -36; 64, -62], style(color=0)),
          Line(points=[38, -36; 14, -60], style(color=0)),
          Ellipse(extent=[20, 34; 56, 2], style(color=0)),
          Line(points=[40, -16; 10, 0], style(color=0)),
          Line(points=[36, -16; 70, 0], style(color=0)),
          Ellipse(extent=[26, 24; 36, 16], style(color=0)),
          Ellipse(extent=[40, 24; 50, 16], style(color=0)),
          Line(points=[30, 12; 38, 6; 48, 12], style(color=0)),
          Line(points=[-41, 3; -41, 17], style(color=85)),
          Line(points=[-41, 17; -47, 11], style(color=85)),
          Line(points=[-41, 17; -35, 11], style(color=85)),
          Line(points=[62, 18; 76, 24; 66, 26], style(color=85)),
          Line(points=[76, 24; 72, 16], style(color=85)),
          Line(points=[14, 18; 2, 26; 12, 26], style(color=85)),
          Line(points=[2, 26; 6, 16], style(color=85)),
          Line(points=[58.5, -22; 72.5, -16; 62.5, -14], style(color=85)),
          Line(points=[72.5, -16; 70.5, -24], style(color=85)),
          Line(points=[17, -29.5; 5, -21.5; 15, -21.5], style(color=85)),
          Line(points=[5, -21.5; 9, -31.5], style(color=85)),
          Line(points=[-65, -10.5; -77, -2.5; -67, -2.5], style(color=85)),
          Line(points=[-19.5, -12; -5.5, -6; -15.5, -4], style(color=85)),
          Line(points=[-5.5, -6; -7.5, -14], style(color=85)),
          Line(points=[33, 59; 39, 53], style(color=85)),
          Line(points=[33, 45; 33, 59], style(color=85)),
          Line(points=[33, 59; 27, 53], style(color=85)),
          Polygon(points=[-60, 48; -60, 22; -70, 36; -60, 48], style(color=69,
                fillColor=69)),
          Rectangle(extent=[-60, 42; -14, 30], style(color=69, fillColor=69)),
          Polygon(points=[-14, 48; -14, 24; -2, 36; -14, 48; -14, 48], style(
                color=69, fillColor=69)),
          Polygon(points=[-60, 78; -60, 52; -70, 66; -60, 78], style(color=69,
                fillColor=69)),
          Rectangle(extent=[-60, 72; -14, 60], style(color=69, fillColor=69)),
          Polygon(points=[-14, 78; -14, 54; -2, 66; -14, 78; -14, 78], style(
                color=69, fillColor=69)),
          Line(points=[-76, -4; -76, -12], style(color=41, fillColor=41))),
        Window(
          x=0.02,
          y=0.13,
          width=0.64,
          height=0.6),
        Documentation(info="InPort1.signal[1]=number of independent lightsystems
InPort1.signal[2]=number of persons in room
InPort1.signal[3]=quantity of air volume exchange per hour
"));
      Modelica.Blocks.Interfaces.InPort InPort1(n=3)
        annotation (extent=[-123, -12; -80, 28]);
      Modelica.Blocks.Interfaces.OutPort OutPort1
        annotation (extent=[81.5, 12; 117.5, 62]);
      Modelica.Blocks.Interfaces.OutPort OutPort2
        annotation (extent=[81.5, -62; 117.5, -12]);
    equation
      OutPort1.signal[1] = InPort1.signal[3];
      OutPort2.signal[1] = 126*InPort1.signal[2] + InPort1.signal[1]*0.96*40;
    end HeatFlow_Airex_tab;

    class sglasswjoint2_humid
      "Window with humid air exchange heat transmission by solar radiation"

      extends
        Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_inheritable_par;
      parameter SIunits.Area WindowArea=6;
      parameter SIunits.SpecificHeatCapacity cair=1000 "Heat Capacity of air";
      parameter SIunits.Density rhoair=1.25 "Density of air";
      parameter SIunits.Volume V=84 "Volume of the room";
      parameter SIunits.CoefficientOfHeatTransfer alphai=2
        "convective heat transfer coefficient (inside)";
      parameter SIunits.CoefficientOfHeatTransfer alphao=2
        "convective heat transfer coefficient (outside)";
      parameter Real Abskoeff=0.1 "Absorptance coefficient";
      parameter Real Transkoeff=0.6 "Solar transmission coefficient";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Rectangle(extent=[-74, 74; 74, -74], style(color=0, fillColor=71)),
          Line(points=[14, 36; -36, -14], style(color=7, thickness=2)),
          Line(points=[42, 36; -38, -44], style(color=7, thickness=2)),
          Line(points=[44, 10; -6, -40], style(color=7, thickness=2)),
          Ellipse(extent=[48, 72; 72, 48], style(color=49, fillColor=45))),
        Window(
          x=0.26,
          y=0.21,
          width=0.49,
          height=0.55),
        Documentation(info="
"),     Diagram);
      Building.Elements.heattrans heattrans2(alpha=alphai, A=WindowArea)
        annotation (extent=[55, -17; 35, 3]);
      Building.therm therm4 annotation (extent=[80, 50; 100, 70]);
      Building.Elements.Ijadapt solartransmission(koeff=Transkoeff, Area=
            WindowArea) annotation (extent=[-10, 45.8; 16, 73.8]);
      Building.Elements.Ijadapt solarabsorptance(koeff=Abskoeff, Area=
            WindowArea)
        annotation (extent=[-43.2, 16.6; -17.2, 44.6], rotation=-90);
      Building.Elements.heattrans heattrans1(alpha=alphao, A=WindowArea)
        annotation (extent=[-61, -17; -41, 3]);
      Weather.t_and_sl_rad.CUTS.ic_total_rad_v ic_total_rad_v1(final n=
            t_and_sl_rad.n_of_surf_orient_def)
        annotation (extent=[-100, 50; -80, 70]);
      Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_aggregable_sel
        surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
            comp_surf_orient_alias) annotation (extent=[-68, 49.6; -48, 69.6]);
      Modelica.Blocks.Interfaces.InPort InPort1
        annotation (extent=[-5.4, -91.6; 5.4, -80.8], rotation=90);
      flowHM flowHM1 annotation (extent=[-100,-15; -83,1]);
      flowHM flowHM2 annotation (extent=[81, -15; 98, 1]);
      therm_to_flowHM therm_to_flowHM1 annotation (extent=[-65,-15; -78,1]);
      therm_to_flowHM therm_to_flowHM2 annotation (extent=[61, -15; 75, 1]);
      therm therm5 annotation (extent=[-100, -71; -80, -51]);
      therm therm3 annotation (extent=[80, -71; 100, -51]);
      Elements.heatcond_kValue heatcond_kValue1(k=k, A=WindowArea)
        annotation (extent=[-15, -20; 13, 7]);
      parameter Real k=1 "k-value (without heat transfer by convection)";
      varairexchange_humid_CO2 varairexchange_humid_CO2_1(V=V)
        annotation (extent=[-16,-31; 15,-62]);
    equation
      connect(solartransmission.therm1, therm4)
        annotation (points=[14.7,59.8; 53.35,59.8; 53.35,60; 90,60]);
      connect(ic_total_rad_v1, surf_orient_alias_aggregable_sel1.
        ic_total_rad_v1)
        annotation (points=[-90,60; -79.7,60; -79.7,59.6; -69.4,59.6]);
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
        solartransmission.ic_total_rad1) annotation (points=[-46.4,59.7; -37,
            59.7; -37,60; -18,60; -18,59.8; -8.7,59.8]);
      connect(surf_orient_alias_aggregable_sel1.oc_total_rad1, solarabsorptance.
         ic_total_rad1)
        annotation (points=[-46.4,59.7; -30.2,59.7; -30.2,43.2]);

      connect(flowHM1, therm_to_flowHM1.flowHM1) annotation (points=[-91.5,-7;
            -75.8333,-7], style(
          color=4,
          rgbcolor={0,255,255},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(therm_to_flowHM1.therm1, heattrans1.therm1) annotation (points=[-67.1667,
            -6.86667; -63.0834,-6.86667; -63.0834,-7; -60,-7],     style(
            fillColor=7, fillPattern=1));
      connect(heattrans2.therm1, therm_to_flowHM2.therm1) annotation (points=[54,-7;
            58.6667,-7; 58.6667,-6.86667; 63.3333,-6.86667],            style(
            fillColor=7, fillPattern=1));
      connect(therm_to_flowHM2.flowHM1, flowHM2) annotation (points=[72.6667,-7;
            89.5,-7], style(
          color=4,
          rgbcolor={0,255,255},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(therm5, heattrans1.therm2) annotation (points=[-90, -61; -30, -61;
             -30, -7; -42, -7], style(fillColor=7, fillPattern=1));
      connect(therm3, heattrans2.therm2) annotation (points=[90, -61; 25, -61;
            25, -7; 36, -7], style(fillColor=7, fillPattern=1));
      connect(heattrans1.therm2, heatcond_kValue1.therm1) annotation (points=[-42,
             -7; -41, -6.5; -13.6, -6.5], style(gradient=1, fillColor=48));
      connect(heatcond_kValue1.therm2, heattrans2.therm2) annotation (points=[11.6,
            -6.5; 25,-6.5; 25,-7; 36,-7],          style(gradient=1, fillColor=
              48));
      connect(solarabsorptance.therm1, heatcond_kValue1.therm1) annotation (
          points=[-30.2,18; -30.2,-6.5; -13.6,-6.5],    style(gradient=1,
            fillColor=48));
      connect(InPort1, varairexchange_humid_CO2_1.InPort1) annotation (points=[0,-86.2;
            0,-86.2; 0,-60.45; -0.345,-60.45],          style(color=3, rgbcolor=
             {0,0,255}));
      connect(flowHM1, varairexchange_humid_CO2_1.cut1) annotation (points=[
            -91.5,-7; -91.5,-46.345; -14.605,-46.345], style(
          color=4,
          rgbcolor={0,255,255},
          thickness=2));
      connect(flowHM2, varairexchange_humid_CO2_1.cut2) annotation (points=[
            89.5,-7; 89.5,-46.345; 13.605,-46.345], style(
          color=4,
          rgbcolor={0,255,255},
          thickness=2));
    end sglasswjoint2_humid;

    class varairexchange_humid
      import flowHM;
      parameter Real airex=0.2 "default airexchange";
      //parameter Real q=1 "exchanged massflow rate";
      parameter Real cp1=1005
        "specific icobar heat capacity of gas 1 (air) in J/(kg*K)";
      parameter Real cp2=1865
        "specific icobar heat capacity of gas 2 (water steam) in J/(kg*K)";
      parameter Real V=84 "Volume of the room";
      Real pV "parts in gas-volume of the room";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=65)),
          Text(
            extent=[-68, -72; 70, -108],
            string="%name",
            style(color=0)),
          Ellipse(extent=[4, 10; 12, 2], style(fillColor=73)),
          Ellipse(extent=[20, -4; 28, -12], style(fillColor=73)),
          Ellipse(extent=[-34, 0; -26, -8], style(fillColor=73)),
          Ellipse(extent=[-18, -10; -12, -16], style(color=8, fillColor=8)),
          Ellipse(extent=[40, -8; 46, -14], style(color=8, fillColor=8)),
          Ellipse(extent=[6, -6; 12, -12], style(color=8, fillColor=8)),
          Ellipse(extent=[-48, 12; -42, 6], style(color=8, fillColor=8)),
          Ellipse(extent=[-14, 6; -8, 0], style(color=8, fillColor=8)),
          Ellipse(extent=[36, 12; 42, 6], style(color=8, fillColor=8)),
          Rectangle(extent=[-44, 52; 48, 32], style(color=7, fillColor=7)),
          Polygon(points=[-44, 58; -44, 26; -60, 42; -44, 58], style(color=7,
                fillColor=7)),
          Polygon(points=[48, 58; 48, 26; 64, 42; 48, 58], style(color=7,
                fillColor=7)),
          Polygon(points=[-44, -26; -44, -58; -60, -42; -44, -26], style(color=
                  7, fillColor=7)),
          Rectangle(extent=[-44, -32; 48, -52], style(color=7, fillColor=7)),
          Polygon(points=[48, -26; 48, -58; 64, -42; 48, -26], style(color=7,
                fillColor=7)),
          Text(
            extent=[18, 100; 90, 84],
            style(color=3),
            string="airexchange-rate")),
        Window(
          x=0.1,
          y=0,
          width=0.86,
          height=0.92));
      Building.flowHM cut1 annotation (extent=[-102, -12; -80, 10]);
      Building.flowHM cut2 annotation (extent=[80, -12; 102, 10]);
      Modelica.Blocks.Interfaces.InPort InPort1 annotation (
        extent=[-12, 80; 14, 100],
        rotation=-90,
        layer="icon");
    equation

      if cardinality(InPort1) == 0 then
        InPort1.signal[1] = airex;
      end if;

      //mass
      cut1.q[2] = -(cut2.x - cut1.x)*InPort1.signal[1];

      cut1.q[1] = -cut1.q[2];

      cut2.q = -cut1.q;

      //heat flow
      cut1.j = -InPort1.signal[1]*(((1 - cut2.x)*cp1 + cut2.x*cp2)*cut2.T - ((1
         - cut1.x)*cp1 + cut1.x*cp2)*cut1.T);

      cut2.j = -cut1.j;

      // CO2

      pV = V*1/22.4*1000*6.02E23;

      cut1.CO2parts = -(cut2.CO2parts - ((InPort1.signal[1]/3600)*(cut2.CO2conc
         - cut1.CO2conc)*pV/1E6));

    end varairexchange_humid;

    model AirEx_Pers_Lights
      parameter Real airex=0.5 "default of airexchange";
      parameter Real pers=4 "default number of persons";
      parameter Real elec_heat=4*40*0.96
        "heat by electrical equipment (4 lamps, 40 W, 96% heat)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[0.5, 0.5],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-93,95; 96,-94.5],       style(color=0, fillColor=
                  71)),
          Ellipse(extent=[-17,-32; 23,-70],        style(color=0, fillColor=49)),
          Ellipse(extent=[3,-46.5; 13,-58.5],  style(color=0)),
          Ellipse(extent=[-2.5,-46; 7.5,-58],          style(color=0)),
          Line(points=[11,-56.5; 7,-68.5],  style(color=0)),
          Line(points=[-5,-56.5; -1,-68.5], style(color=0)),
          Rectangle(extent=[-5,-68.5; 13,-92.5], style(color=0, fillColor=8)),
          Ellipse(extent=[-7,-46.5; 1,-58.5],  style(color=0)),
          Line(points=[-5,-86.5; 13,-86.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-5,-80.5; 13,-80.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Line(points=[-5,-74.5; 13,-74.5], style(
              color=0,
              thickness=2,
              fillColor=9)),
          Polygon(points=[-19.5,62; -19.5,38; -30.5,49; -19.5,62],     style(
                color=69, fillColor=69)),
          Rectangle(extent=[-19.5,56; 26.5,44],    style(color=69, fillColor=69)),
          Polygon(points=[26.5,62; 26.5,38; 38.5,50; 26.5,62; 26.5,62],
               style(color=69, fillColor=69)),
          Polygon(points=[-20,91; -19.5,67; -32,79.5; -20,91],         style(
                color=69, fillColor=69)),
          Rectangle(extent=[-19.5,86; 26.5,74],    style(color=69, fillColor=69)),
          Polygon(points=[26.5,92; 26.5,68; 38.5,80; 26.5,92; 26.5,92],
               style(color=69, fillColor=69)),
          Text(
            extent=[48,-75.5; 14,-92],
            style(color=1, pattern=0),
            string="[W]"),
          Ellipse(extent=[-0.5,21.5; 7.5,13.5],   style(color=1, fillColor=30)),
          Polygon(points=[-1.5,12.5; -8.5,-3.5; -5.5,-3.5; -1.5,8.5; -0.5,-3.5;
                9.5,-3.5; 8.5,9.5; 13.5,-3.5; 16.5,-3.5; 9.5,12.5; -1.5,12.5],
                             style(color=1, fillColor=30)),
          Polygon(points=[-1.5,-15.5; -2.5,-18.5; -7.5,-21.5; -4.5,-21.5; 1.5,
                -21.5; 4.5,-3.5; 7.5,-21.5; 16.5,-21.5; 13.5,-19.5; 10.5,-18.5;
                8.5,-3.5; 4.5,-3.5; -0.5,-3.5; -1.5,-15.5],    style(color=1,
                 fillColor=30))),
        Diagram,
        Window(
          x=0.12,
          y=0.19,
          width=0.65,
          height=0.6));

      Modelica.Blocks.Interfaces.OutPort OutPort_Airex
        annotation (extent=[97,58; 122.5,89]);
      Modelica.Blocks.Interfaces.OutPort OutPort_Pers
        annotation (extent=[96.5,-12; 121.5,19.5]);
      Modelica.Blocks.Interfaces.OutPort OutPort_Heat
        annotation (extent=[96.5,-85.5; 121.5,-57]);
      Modelica.Blocks.Interfaces.InPort InPort_Pers
        annotation (extent=[-117.5,-13.5; -92.5,14]);
      Modelica.Blocks.Interfaces.InPort InPort_Airex
        annotation (extent=[-117,56; -93,82.5]);
      Modelica.Blocks.Interfaces.InPort InPort_Heat
        annotation (extent=[-118.5,-79.5; -93,-51.5]);
    equation
      if cardinality(InPort_Airex) <> 0 then
        OutPort_Airex.signal[1] = InPort_Airex.signal[1];
      else
        InPort_Airex.signal[1] = airex;
        OutPort_Airex.signal[1] = InPort_Airex.signal[1];
      end if;

      if cardinality(InPort_Pers) <> 0 then
        OutPort_Pers.signal[1] = InPort_Pers.signal[1];
      else
        InPort_Pers.signal[1] = pers;
        OutPort_Pers.signal[1] = InPort_Pers.signal[1];
      end if;

      if cardinality(InPort_Heat) <> 0 then
        OutPort_Heat.signal[1] = InPort_Heat.signal[1];
        //
      else
        InPort_Heat.signal[1] = elec_heat;
        OutPort_Heat.signal[1] = InPort_Heat.signal[1];
      end if;

    end AirEx_Pers_Lights;

    class varairexchange_humid_CO2
    //  import flowHM;
      parameter Real airex(unit="1/h")=0.2 "Default air exchange rate";
      //parameter Real q=1 "exchanged massflow rate";
      parameter Real cp1=1005
        "specific icobar heat capacity of gas 1 (air) in J/(kg*K)";
      parameter Real cp2=1865
        "specific icobar heat capacity of gas 2 (water steam) in J/(kg*K)";
      parameter Modelica.SIunits.Volume V=84
        "Reference volume to which air exchange rate is related";
    //  Real pV "Parts in gas volume of the room";
      constant Modelica.SIunits.Density rho=1.2
        "Air density at p = 101300 Pa and T = 20 °C";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=65)),
          Text(
            extent=[-68, -72; 70, -108],
            string="%name",
            style(color=0)),
          Ellipse(extent=[4, 10; 12, 2], style(fillColor=73)),
          Ellipse(extent=[20, -4; 28, -12], style(fillColor=73)),
          Ellipse(extent=[-34, 0; -26, -8], style(fillColor=73)),
          Ellipse(extent=[-18, -10; -12, -16], style(color=8, fillColor=8)),
          Ellipse(extent=[40, -8; 46, -14], style(color=8, fillColor=8)),
          Ellipse(extent=[6, -6; 12, -12], style(color=8, fillColor=8)),
          Ellipse(extent=[-48, 12; -42, 6], style(color=8, fillColor=8)),
          Ellipse(extent=[-14, 6; -8, 0], style(color=8, fillColor=8)),
          Ellipse(extent=[36, 12; 42, 6], style(color=8, fillColor=8)),
          Rectangle(extent=[-44, 52; 48, 32], style(color=7, fillColor=7)),
          Polygon(points=[-44, 58; -44, 26; -60, 42; -44, 58], style(color=7,
                fillColor=7)),
          Polygon(points=[48, 58; 48, 26; 64, 42; 48, 58], style(color=7,
                fillColor=7)),
          Polygon(points=[-44, -26; -44, -58; -60, -42; -44, -26], style(color=
                  7, fillColor=7)),
          Rectangle(extent=[-44, -32; 48, -52], style(color=7, fillColor=7)),
          Polygon(points=[48, -26; 48, -58; 64, -42; 48, -26], style(color=7,
                fillColor=7)),
          Text(
            extent=[18, 100; 90, 84],
            style(color=3),
            string="airexchange-rate")),
        Window(
          x=0.1,
          y=0,
          width=0.86,
          height=0.92),
        Diagram);
      Building.flowHM cut1 annotation (extent=[-102, -12; -80, 10]);
      Building.flowHM cut2 annotation (extent=[80, -12; 102, 10]);
      Modelica.Blocks.Interfaces.InPort InPort1 annotation (
        extent=[-12, 80; 14, 100],
        rotation=-90,
        layer="icon");
    equation

      if cardinality(InPort1) == 0 then
        InPort1.signal[1] = airex;
      end if;

      // mass:
      cut1.q[2] = -(cut2.x - cut1.x)*(V*InPort1.signal[1]/3600)*rho;
      cut1.q[1] = -cut1.q[2];
      cut2.q = -cut1.q;

      // heat flow:
      cut1.j = -(V*InPort1.signal[1]/3600)*rho*(((1 - cut2.x)*cp1 + cut2.x*cp2)*cut2.T - ((1 - cut1.x)*cp1 + cut1.x*cp2)*cut1.T);
      cut2.j = -cut1.j;

      // CO2:

    //  pV = V*1/22.4*1000*6.02E23;

    /*  cut1.CO2parts = -(cut2.CO2parts - ((InPort1.signal[1]/3600)*(cut2.CO2conc
     - cut1.CO2conc)*pV/1E6));
*/
       cut1.CO2parts = (V*InPort1.signal[1]/3600)*(cut1.CO2conc - cut2.CO2conc)/1E6*6.02E23*(1000/22.4);
       cut2.CO2parts = -cut1.CO2parts;
    end varairexchange_humid_CO2;
  end RoomAttribute;

  package Elements
    extends Icons.Package;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-56, 30; 44, 2], style(fillColor=43)),
        Rectangle(extent=[-56, 2; 44, -26], style(fillColor=43)),
        Rectangle(extent=[-56, -26; 44, -54], style(fillColor=43)),
        Line(points=[-30, 30; -30, 2], style(fillColor=43)),
        Line(points=[16, 30; 16, 2], style(fillColor=43)),
        Line(points=[-6, 2; -6, -26], style(fillColor=43)),
        Line(points=[-30, -26; -30, -54], style(fillColor=43)),
        Line(points=[16, -26; 16, -54], style(fillColor=43)),
        Rectangle(extent=[-56, 30; -30, 2], style(gradient=3, fillColor=43)),
        Rectangle(extent=[-30, 30; 16, 2], style(gradient=3, fillColor=43)),
        Rectangle(extent=[16, 30; 44, 2], style(gradient=3, fillColor=43)),
        Rectangle(extent=[-56, 2; -6, -26], style(gradient=3, fillColor=43)),
        Rectangle(extent=[-6, 2; 44, -26], style(gradient=3, fillColor=43)),
        Rectangle(extent=[-56, -26; -30, -54], style(gradient=3, fillColor=43)),
        Rectangle(extent=[-30, -26; 16, -54], style(gradient=3, fillColor=43)),
        Rectangle(extent=[16, -26; 44, -54], style(gradient=3, fillColor=43))),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));

    class heattrans
      extends twotherm;
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha=2;
      parameter Modelica.SIunits.Area A=16;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 80; 0, -80], style(color=65, fillColor=
                  65)), Rectangle(extent=[0, 80; 80, -80], style(
              color=49,
              gradient=1,
              fillColor=49))),
        Icon(Rectangle(extent=[-80, 80; 0, -80], style(color=65, fillColor=65)),
             Rectangle(extent=[0, 80; 80, -80], style(
              color=49,
              gradient=1,
              fillColor=49))),
        Window(
          x=0.25,
          y=0.38,
          width=0.6,
          height=0.6));
    equation
      therm1.j + therm2.j = 0;
      // no storage of heat
      therm1.j = alpha*A*(therm1.T - therm2.T);
    end heattrans;

    class heatcond
      extends twotherm;
      parameter Modelica.SIunits.Area A=16;
      parameter Modelica.SIunits.Thickness d=0.1;
      parameter Modelica.SIunits.ThermalConductivity lambda=2.4;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 80; 80, -80], style(gradient=1,
                fillColor=49))),
        Icon(Rectangle(extent=[-80, 80; 80, -80], style(gradient=1, fillColor=
                  49))),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
    equation
      therm1.j + therm2.j = 0;
      // no storage of heat
      therm1.j = lambda*A/d*(therm1.T - therm2.T);
    end heatcond;

    class pipeconduction
      extends twotherm;
      constant Real pi=3.141592654;
      parameter Real Ri=0.010 "Innerradius of pipe in m";
      parameter Real Ra=0.012 "Outerradius of pipe in m";
      parameter Real lambda=0.32 "Heat conductivity of PU-pipe in W/mK";
      parameter Real L=40 "Length in m";
      Real area;
      Real thickness;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 80; 80, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1))),
        Icon(Rectangle(extent=[-80, 80; 80, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1))));
    equation
      area = 2*pi*Ri*L;
      thickness = Ra - Ri;
      therm1.j = -therm2.j;
      /*no storage of heat*/
      therm1.j = lambda/thickness*area*(therm1.T - therm2.T);
      /*heatflow through layer*/
    end pipeconduction;

    class load
      extends onetherm;
      parameter Modelica.SIunits.Density rho=1600;
      parameter Modelica.SIunits.SpecificHeatCapacity c=1000;
      parameter Modelica.SIunits.Thickness d=0.2;
      parameter Modelica.SIunits.Area A=16;
      Modelica.SIunits.Mass m;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=43)),
          Rectangle(extent=[-40, 80; 40, 40], style(color=0, fillColor=43)),
          Rectangle(extent=[-40, 0; 42, -40], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, -40; 20, -80], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, 40; 20, 0], style(color=0, fillColor=43)),
          Rectangle(extent=[2, 40; 80, 0], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, 80; -40, 40], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, 0; -40, -40], style(color=0, fillColor=43)),
          Rectangle(extent=[2, -40; 80, -80], style(color=0, fillColor=43))),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=43)),
          Rectangle(extent=[-40, 80; 40, 40], style(color=0, fillColor=43)),
          Rectangle(extent=[-40, 0; 42, -40], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, -40; 20, -80], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, 40; 20, 0], style(color=0, fillColor=43)),
          Rectangle(extent=[2, 40; 80, 0], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, 80; -40, 40], style(color=0, fillColor=43)),
          Rectangle(extent=[-80, 0; -40, -40], style(color=0, fillColor=43)),
          Rectangle(extent=[2, -40; 80, -80], style(color=0, fillColor=43))),
        Window(
          x=0.3,
          y=0.18,
          width=0.6,
          height=0.6));
    equation
      m = rho*A*d;
      der(T) = 1/m/c*therm1.j;
    end load;

    class airload
      extends onetherm;
      parameter Modelica.SIunits.Density rho=1.19;
      parameter Modelica.SIunits.SpecificHeatCapacity c=1007;
      parameter Modelica.SIunits.Volume V=64.0;
      Modelica.SIunits.Mass m;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Ellipse(extent=[-36, 12; 28, -26], style(color=7, fillColor=7)),
          Ellipse(extent=[-46, 40; 18, 2], style(color=7, fillColor=7)),
          Ellipse(extent=[-12, 32; 52, -6], style(color=7, fillColor=7)),
          Ellipse(extent=[-10, -12; 54, -50], style(color=7, fillColor=7)),
          Ellipse(extent=[-52, -2; 12, -40], style(color=7, fillColor=7)),
          Ellipse(extent=[-14, 4; 50, -34], style(color=7, fillColor=7))),
        Icon(
          Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Ellipse(extent=[-36, 12; 28, -26], style(color=7, fillColor=7)),
          Ellipse(extent=[-46, 40; 18, 2], style(color=7, fillColor=7)),
          Ellipse(extent=[-12, 32; 52, -6], style(color=7, fillColor=7)),
          Ellipse(extent=[-10, -12; 54, -50], style(color=7, fillColor=7)),
          Ellipse(extent=[-52, -2; 12, -40], style(color=7, fillColor=7)),
          Ellipse(extent=[-14, 4; 50, -34], style(color=7, fillColor=7))),
        Window(
          x=0.25,
          y=0.09,
          width=0.6,
          height=0.6));
    equation
      m = rho*V;
      der(T) = 1/m/c*therm1.j;

    end airload;

    class loadplus
      "describes a heat storage of air with capacitance as koefficient."
      extends onetherm;
      parameter Modelica.SIunits.HeatCapacity C=35000;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.12,
          y=0.16,
          width=0.6,
          height=0.6),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0)),
          Rectangle(extent=[-82, 80; 82, -80], style(color=0, fillColor=67)),
          Ellipse(extent=[-36, 12; 28, -26], style(color=7, fillColor=7)),
          Ellipse(extent=[-46, 40; 18, 2], style(color=7, fillColor=7)),
          Ellipse(extent=[-12, 30; 52, -8], style(color=7, fillColor=7)),
          Ellipse(extent=[-10, -12; 54, -50], style(color=7, fillColor=7)),
          Ellipse(extent=[-52, -2; 12, -40], style(color=7, fillColor=7)),
          Ellipse(extent=[-14, 4; 50, -34], style(color=7, fillColor=7)),
          Line(points=[-24, -4; 24, -4], style(color=0, thickness=2)),
          Line(points=[0, 22; 0, -28], style(color=0, thickness=2))));
    equation
      der(T) = 1/C*therm1.j;
    end loadplus;

    class Orthorad
      extends twotherm;
      parameter Modelica.SIunits.Length edge=4 "commom edge in m";
      parameter Modelica.SIunits.Length side1=4 "side of wall 1 in m";
      parameter Modelica.SIunits.Length side2=4 "side of wall 2 in m";
      parameter Modelica.SIunits.Emissivity eps1=0.94
        "emissions coeffizient wall1";
      parameter Modelica.SIunits.Emissivity eps2=0.94
        "emissions coeffizient wall2";
      constant Real sigma=5.67e-8 "radiation coeffizient in W/m2K4";
      parameter Real X=side1/edge;
      parameter Real Y=side2/edge;
      Real phi;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Icon(
          Rectangle(extent=[-80, 80; 60, 60], style(
              color=0,
              gradient=2,
              fillColor=46)),
          Rectangle(extent=[60, 60; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=46)),
          Rectangle(extent=[-80, 60; 60, -80], style(color=0, fillColor=68)),
          Rectangle(extent=[60, 80; 80, 60], style(color=0, fillColor=0)),
          Line(points=[-48, 14; 4, -42], style(color=49)),
          Line(points=[-34, 24; 18, -32], style(color=49)),
          Polygon(points=[18, -32; 12, -18; 6, -26; 18, -32], style(color=49,
                fillColor=49)),
          Polygon(points=[-50, 16; -46, 4; -40, 10; -50, 16], style(color=49,
                fillColor=49))),
        Window(
          x=0.07,
          y=0.03,
          width=0.99,
          height=0.65));
    equation

      phi = 1/Constants.pi/X*(X*arctan(1/X) + Y*arctan(1/Y) - sqrt(X*X + Y*Y)*
        arctan(1/sqrt(X*X + Y*Y)) + X*X/4*ln((1 + X*X + Y*Y)*X*X/(X*X + Y*Y)/(1
         + X*X)) + Y*Y/4*ln((1 + X*X + Y*Y)*Y*Y/(X*X + Y*Y)/(1 + Y*Y)) - ln((1
         + X*X + Y*Y)/(1 + X*X)/(1 + Y*Y)));

      therm1.j = -therm2.j;
      therm1.j = phi*edge*side1*eps1*eps2*Constants.sigma*((therm1.T + 273.15)^
        4 - (therm2.T + 273.15)^4);
    end Orthorad;

    class Parallelrad
      extends twotherm;
      parameter Modelica.SIunits.Length altitude=4 "commom edge in m";
      parameter Modelica.SIunits.Length length=4 "side of wall 1 in m";
      parameter Modelica.SIunits.Length distance=4 "side of wall 2 in m";
      parameter Modelica.SIunits.Emissivity eps1=0.94
        "emissions coeffizient wall1";
      parameter Modelica.SIunits.Emissivity eps2=0.94
        "emissions coeffizient wall2";
      constant Real sigma=5.67e-8 "radiation coeffizient in W/m2K4";
      parameter Real X=altitude/distance;
      parameter Real Y=length/distance;
      Real phi;
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]), Icon(
          Rectangle(extent=[-80, 80; -60, -80], style(
              color=0,
              gradient=1,
              fillColor=46)),
          Rectangle(extent=[-60, -80; 60, 80], style(color=0, fillColor=68)),
          Line(points=[-40, 20; 40, 20], style(color=49)),
          Rectangle(extent=[60, 80; 80, -80], style(
              color=0,
              gradient=1,
              fillColor=46)),
          Line(points=[-40, -20; 40, -20], style(color=49)),
          Polygon(points=[-38, 20; -28, 26; -28, 14; -38, 20], style(color=49,
                fillColor=49)),
          Line(points=[-40, 40; 40, 40], style(color=49)),
          Polygon(points=[40, -20; 32, -14; 32, -26; 40, -20], style(color=49,
                fillColor=49))));
    equation
      phi = 1/Constants.pi*(1/X/Y*ln((1 + X*X)*(1 + Y*Y)/(1 + X*X + Y*Y)) - 2/X
        *arctan(Y) - 2/Y*arctan(X) + 2/Y*sqrt(1 + Y*Y)*arctan(X/sqrt(1 + Y*Y))
         + 2/X*sqrt(1 + X*X)*arctan(Y/sqrt(1 + X*X)));

      therm1.j = -therm2.j;
      therm1.j = phi*altitude*length*eps1*eps2*sigma*((therm1.T + 273.15)^4 - (
        therm2.T + 273.15)^4);
    end Parallelrad;

    class radexchange
      extends Rooms.sixtherm;
      parameter Modelica.SIunits.Length Length=4.0 "length of the room";
      parameter Modelica.SIunits.Length Width=4.0 "width of the room";
      parameter Modelica.SIunits.Length Heigth=4.0 "heigth of the room";
      parameter Modelica.SIunits.Emissivity eps;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Text(extent=[-98, 98; -78, 80], string="W"),
          Text(extent=[82, -82; 102, -100], string="E"),
          Text(extent=[-100, -82; -80, -100], string="S"),
          Text(extent=[84, 100; 104, 82], string="N")),
        Icon(Line(points=[-56, 48; 34, 48; -56, 48; -56, -44; -56, 48; -4, -60;
                 -56, 48; 58, -34; -56, 48]), Line(points=[-48, -64; 44, -64; -48,
                 -64; 36, 22; -48, -64; -8, 38; -48, -64; -48, 10], style(color=
                 41))),
        Window(
          x=0.25,
          y=0.29,
          width=0.6,
          height=0.6));
      Parallelrad Parallelrad3(
        altitude=Heigth,
        length=Width,
        distance=Length) annotation (extent=[-42, -2; -22, 18]);
      Orthorad Orthorad4(
        edge=Heigth,
        side1=Length,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[-76, -8; -56, 12], rotation=90);
      Orthorad Orthorad1(
        edge=Length,
        side1=Heigth,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[-34, 56; -14, 76], rotation=180);
      Orthorad Orthorad2(
        edge=Heigth,
        side1=Length,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[24, 36; 44, 56], rotation=180);
      Orthorad Orthorad3(
        edge=Length,
        side1=Heigth,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[-12, -58; 8, -38], rotation=270);
      Orthorad Orthorad5(
        edge=Heigth,
        side1=Length,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[-40, -46; -20, -26], rotation=180);
      Orthorad Orthorad6(
        edge=Width,
        side1=Length,
        side2=Heigth,
        eps1=eps,
        eps2=eps) annotation (extent=[-40, -26; -20, -6], rotation=180);
      Orthorad Orthorad7(
        edge=Width,
        side1=Length,
        side2=Heigth,
        eps1=eps,
        eps2=eps) annotation (extent=[-40, -68; -20, -48], rotation=180);
      Orthorad Orthorad8(
        edge=Width,
        side1=Length,
        side2=Heigth,
        eps1=eps,
        eps2=eps) annotation (extent=[24, 56; 44, 76], rotation=180);
      Orthorad Orthorad9(
        edge=Heigth,
        side1=Length,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[56, -6; 76, 14], rotation=90);
      Orthorad Orthorad10(
        edge=Width,
        side1=Length,
        side2=Heigth,
        eps1=eps,
        eps2=eps) annotation (extent=[24, 14; 44, 34], rotation=180);
      Orthorad Orthorad11(
        edge=Length,
        side1=Heigth,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[22, -58; 42, -38]);
      Orthorad Orthorad12(
        edge=Length,
        side1=Heigth,
        side2=Width,
        eps1=eps,
        eps2=eps) annotation (extent=[30, -22; 50, -2]);
      Parallelrad Parallelrad1(
        altitude=Heigth,
        length=Length,
        distance=Width) annotation (extent=[-42, 26; -22, 46]);
      Parallelrad Parallelrad2(
        altitude=Length,
        length=Width,
        distance=Heigth) annotation (extent=[10, -34; 30, -14], rotation=90);
    equation
      connect(Orthorad4.therm2, therm1) annotation (points=[-66, 10; -66, 64]);
      connect(Orthorad4.therm1, therm6) annotation (points=[-66, -8; -66, -64]);
      connect(therm1, Orthorad1.therm2) annotation (points=[-62, 66; -32, 66]);
      connect(Orthorad1.therm1, therm2)
        annotation (points=[-14, 66; 4, 66; 4, 84]);
      connect(therm1, Orthorad2.therm2)
        annotation (points=[-64, 66; -46, 66; -46, 46; 25, 46]);
      connect(Orthorad3.therm2, therm5) annotation (points=[-2, -58; -2, -88]);
      connect(therm1, Orthorad3.therm1)
        annotation (points=[-66, 66; -66, 26; -2, 26; -2, -38]);
      connect(therm6, Orthorad5.therm2)
        annotation (points=[-66, -66; -66, -36; -38, -36]);
      connect(Orthorad5.therm1, therm4)
        annotation (points=[-20, -36; 66, -36; 66, -66]);
      connect(therm6, Orthorad6.therm2)
        annotation (points=[-66, -64; -66, -16; -40, -16]);
      connect(therm2, Orthorad6.therm1)
        annotation (points=[4, 84; 4, -16; -20, -16]);
      connect(therm6, Orthorad7.therm2)
        annotation (points=[-66, -68; -66, -58; -40, -58]);
      connect(Orthorad7.therm1, Orthorad3.therm2)
        annotation (points=[-20, -58; -2, -58]);
      connect(Orthorad2.therm1, therm3)
        annotation (points=[44, 46; 66, 46; 66, 64]);
      connect(Orthorad8.therm1, therm3) annotation (points=[44, 66; 64, 66]);
      connect(Orthorad8.therm2, therm2)
        annotation (points=[24, 66; 4, 66; 4, 86]);
      connect(therm3, Orthorad9.therm2) annotation (points=[66, 66; 66, 12]);
      connect(Orthorad9.therm1, therm4) annotation (points=[66, -6; 66, -62]);
      connect(therm3, Orthorad10.therm1)
        annotation (points=[66, 66; 66, 24; 42, 24]);
      connect(Orthorad10.therm2, therm5)
        annotation (points=[26, 24; 10, 24; 10, -68; -2, -68; -2, -86]);
      connect(Orthorad11.therm2, therm4)
        annotation (points=[40, -48; 66, -48; 66, -66]);
      connect(Orthorad11.therm1, therm5)
        annotation (points=[22, -48; 10, -48; 10, -68; -2, -68; -2, -88]);
      connect(therm4, Orthorad12.therm2)
        annotation (points=[66, -66; 66, -12; 49, -12]);
      connect(Orthorad12.therm1, therm2)
        annotation (points=[31, -12; 4, -12; 4, 84]);
      connect(therm6, Parallelrad3.therm1)
        annotation (points=[-66, -68; -66, -16; -50, -16; -50, 8; -41, 8]);
      connect(Parallelrad3.therm2, therm3)
        annotation (points=[-22, 8; 54, 8; 54, 24; 66, 24; 66, 68]);
      connect(therm1, Parallelrad1.therm1)
        annotation (points=[-66, 66; -66, 36; -40, 36]);
      connect(Parallelrad1.therm2, therm4)
        annotation (points=[-22, 36; 10, 36; 10, -68; 64, -68]);
      connect(therm5, Parallelrad2.therm1) annotation (points=[-2, -86; -2, -68;
             10, -68; 10, -36; 20, -36; 20, -33]);
      connect(Parallelrad2.therm2, therm2)
        annotation (points=[20, -14; 20, -12; 4, -12; 4, 84]);
    end radexchange;

    class twostar
      extends twotherm;
      parameter Modelica.SIunits.Area A=12 "m2";
      parameter Modelica.SIunits.Emissivity eps=0.94
        "emissions coeffizient wall";
      Real L;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Line(points=[-40, 28; 50, 28], style(color=49, arrow=1)),
          Line(points=[-42, 0; 48, 0], style(color=49, arrow=1)),
          Line(points=[-42, -30; 48, -30], style(color=49, arrow=1))),
        Icon(
          Rectangle(extent=[-60, 80; 80, -80], style(
              color=0,
              pattern=0,
              fillColor=68)),
          Line(points=[-40, 28; 50, 28], style(color=49, arrow=1)),
          Line(points=[-42, 0; 48, 0], style(color=49, arrow=1)),
          Line(points=[-42, -30; 48, -30], style(color=49, arrow=1)),
          Rectangle(extent=[-80, 80; -60, -80], style(
              color=0,
              gradient=1,
              fillColor=45))),
        Window(
          x=0.28,
          y=0.27,
          width=0.6,
          height=0.6));
    equation

      therm1.j = -therm2.j;
      L = Constants.sigma*eps*A*((therm1.T + 273.15)*(therm1.T + 273.15) + (
        therm2.T + 273.15)*(therm2.T + 273.15))*(therm1.T + 273.15 + therm2.T
         + 273.15);
      therm1.j = L*(therm1.T - therm2.T);
    end twostar;

    class radiatorload
      extends onetherm;
      parameter Modelica.SIunits.Mass mW=30 "Water mass inside radiator, in kg";
      parameter Modelica.SIunits.Mass mS=30 "Steel mass of radiator, in kg";
      parameter Modelica.SIunits.SpecificHeatCapacity cW=4181
        "Specific heat capacity of water in J/kgK";
      parameter Modelica.SIunits.SpecificHeatCapacity cS=545
        "Specific heat capacity of steel in J/kgK";
      Modelica.SIunits.Mass m;
      Modelica.SIunits.SpecificHeatCapacity c;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-78, 78; 78, -78]),
          Rectangle(extent=[-80, 82; 80, -82], style(
              color=7,
              fillColor=6,
              fillPattern=1)),
          Rectangle(extent=[-52, -36; 68, -58], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-72, 60; 54, 40], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-58, 80; -38, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-34, 80; -14, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-10, 80; 10, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[14, 80; 34, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[38, 80; 58, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Ellipse(extent=[62, -36; 74, -58], style(
              gradient=3,
              fillColor=8,
              fillPattern=1)),
          Ellipse(extent=[-76, 60; -66, 40], style(
              gradient=3,
              fillColor=8,
              fillPattern=1))),
        Diagram(
          Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
          Rectangle(extent=[-78, 78; 78, -78]),
          Rectangle(extent=[-80, 82; 80, -82], style(
              color=7,
              fillColor=6,
              fillPattern=1)),
          Rectangle(extent=[-52, -36; 68, -58], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-72, 60; 54, 40], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-58, 80; -38, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-34, 80; -14, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-10, 80; 10, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[14, 80; 34, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[38, 80; 58, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Ellipse(extent=[62, -36; 74, -58], style(
              gradient=3,
              fillColor=8,
              fillPattern=1)),
          Ellipse(extent=[-76, 60; -66, 40], style(
              gradient=3,
              fillColor=8,
              fillPattern=1))),
        Window(
          x=0.33,
          y=0.15,
          width=0.6,
          height=0.6));
    equation
      m = mW + mS;
      /*mass of radiator*/
      c = (mW*cW + mS*cS)/(mW + mS);
      /*specific heat capacity of radiaor in J/kgK*/

      der(T) = 1/m/c*therm1.j;
    end radiatorload;

    class Ijadapt "calculate the heat flow which received by a surface."
      parameter Real koeff=0.6 "weight coefficient";
      parameter SIunits.Area Area=6 "Area of Surface";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-80, 80; 80, -80], style(color=0))),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=48)),
          Text(extent=[-86, 24; -42, -20], string="I"),
          Text(extent=[38, 24; 90, -20], string="J"),
          Rectangle(extent=[8, 50; 14, -46], style(color=0, fillColor=46)),
          Rectangle(extent=[16, 4; 38, -4], style(color=41, fillColor=41)),
          Polygon(points=[38, 8; 38, 6; 38, -8; 44, 0; 38, 8], style(color=41,
                fillColor=41)),
          Line(points=[-42, 0; 8, 0], style(color=49, thickness=2)),
          Line(points=[-2, 8; 8, 0; -2, -10], style(color=49, thickness=2))),
        Window(
          x=0.29,
          y=0.14,
          width=0.6,
          height=0.6),
        Documentation(info="
"));
      Building.therm therm1 annotation (extent=[80, -10; 100, 10]);
      Weather.t_and_sl_rad.CUTS.ic_total_rad ic_total_rad1
        annotation (extent=[-100, -10; -80, 10]);
    equation
      therm1.j = -ic_total_rad1.I*Area*koeff;

    end Ijadapt;

    class HumidAir
      "Isobar mixture of two perfect gases (e.g. gas 1 = air, gas 2 = water steam) with variable percentage of gas 2.  -  Cannot describe condensation."

      parameter Real V=64 "volume in m^3";
      parameter Real T0=16 "initial temperature in °C";

      parameter Real H_rel_0=0.5 "initial rel. humidity (H_rel := p2 / p2_sat)";
      parameter Real p=101300 "pressure in Pa (constant)";
      parameter Real cp1=1007 "spec. heat capacity of gas 1 (air) in J/(kg*K)";
      parameter Real cp2=1865
        "spec. heat capacity of gas 2 (water steam) in J/(kg*K)";
      parameter Real R1=287 "gas constant of gas 1 (air) in J/(kg*K)";
      parameter Real R2=461 "gas constant of gas 2 (water steam) in J/(kg*K)";
      constant Real A=8.0732991
        "constant for calculation of saturation vapour pressure";
      constant Real B=1656.39
        "constant for calculation of saturation vapour pressure";
      constant Real C=226.86
        "constant for calculation of saturation vapour pressure";

      Real m1;
      Real m2(start=V*H_rel_0*100*(10^(A - B/(C + T0)))/R2/(T0 + 273.15));
      Real p1;
      Real p2;
      Real p2_sat "saturation vapour pressure of gas 2 (water)";
      Real T(start=T0) "temperature in °C";
      Real H_abs "absolute humidity (H_abs := m2/V)";
      Real H_rel "relative humidity";
      Real x "mass percentage of gas 2 (water steam): 0 < x < 1";
      Real m "auxiliary variable";

      parameter Real c_CO2_0(final unit="ppm") = 380
        "initial CO2-concentration in the room";

      Real c_CO2(start=c_CO2_0, final unit="ppm")
        "CO2-concentration of the air - unit: parts per million (ppm)";

      Real pV "parts in gas-volume of the room";

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.55,
          height=0.95),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Ellipse(extent=[-46, 52; 18, 14], style(color=7, fillColor=7)),
          Ellipse(extent=[-12, 44; 52, 6], style(color=7, fillColor=7)),
          Ellipse(extent=[-52, 10; 12, -28], style(color=7, fillColor=7)),
          Ellipse(extent=[-10, 0; 54, -38], style(color=7, fillColor=7)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=67)),
          Ellipse(extent=[-44, 44; 20, 6], style(color=7, fillColor=7)),
          Ellipse(extent=[-10, 36; 54, -2], style(color=7, fillColor=7)),
          Ellipse(extent=[-16, 4; 48, -34], style(color=7, fillColor=7)),
          Ellipse(extent=[-58, 20; 6, -18], style(color=7, fillColor=7)),
          Text(
            extent=[-68, 78; 72, 52],
            string="temp. / heat",
            style(color=41)),
          Text(extent=[-68, -52; 72, -86], string="humidity / mass"),
          Text(
            extent=[-40, -32; 42, -54],
            style(color=0, pattern=0),
            string="%name"),
          Ellipse(extent=[-30, 38; -22, 30], style(fillColor=73)),
          Ellipse(extent=[2, 36; 10, 28], style(fillColor=73)),
          Ellipse(extent=[-20, 4; -12, -4], style(fillColor=73)),
          Ellipse(extent=[22, 18; 30, 10], style(fillColor=73)),
          Ellipse(extent=[-44, -6; -36, -14], style(fillColor=73)),
          Ellipse(extent=[30, -16; 38, -24], style(fillColor=73)),
          Ellipse(extent=[-42, 6; -34, -2], style(fillColor=73)),
          Ellipse(extent=[0, 18; 8, 10], style(fillColor=73)),
          Ellipse(extent=[0, -14; 8, -22], style(fillColor=73)),
          Ellipse(extent=[-26, -8; -20, -14], style(color=8, fillColor=8)),
          Ellipse(extent=[-36, 26; -30, 20], style(color=8, fillColor=8)),
          Ellipse(extent=[28, -2; 34, -8], style(color=8, fillColor=8)),
          Ellipse(extent=[36, 26; 42, 20], style(color=8, fillColor=8)),
          Ellipse(extent=[-14, 40; -8, 34], style(color=8, fillColor=8)),
          Ellipse(extent=[14, -24; 20, -30], style(color=8, fillColor=8)),
          Ellipse(extent=[-16, 18; -10, 12], style(color=8, fillColor=8)),
          Ellipse(extent=[12, 8; 18, 2], style(color=8, fillColor=8)),
          Ellipse(extent=[-32, 16; -26, 10], style(color=8, fillColor=8)),
          Ellipse(extent=[8, -4; 14, -10], style(color=8, fillColor=8)),
          Ellipse(extent=[-12, -18; -6, -24], style(color=8, fillColor=8)),
          Ellipse(extent=[20, -10; 26, -16], style(color=8, fillColor=8)),
          Ellipse(extent=[18, 32; 24, 26], style(color=8, fillColor=8)),
          Ellipse(extent=[-8, -4; -2, -10], style(color=8, fillColor=8)),
          Ellipse(extent=[36, 10; 42, 4], style(color=8, fillColor=8))),
        Diagram);
      Building.flowHM cut1
        annotation (extent=[-14, -104; 14, -80], layer="icon");
      ATplus.Building.therm therm1
        annotation (extent=[-18, 78; 14, 108], layer="icon");
    equation
      T = therm1.T;
      // Koennte aus class "onetherm" vererbt werden.

      p1*V = m1*R1*(T + 273.15);
      p2*V = m2*R2*(T + 273.15);
      p*V = (m1*R1 + m2*R2)*(T + 273.15);

      m = m1 + m2;

      (cp1*m1 + cp2*m2)*der(T) = therm1.j + cut1.j;

      if m2 > 0 or cut1.q[2] > 0 then

        der(m2) = cut1.q[2] + x*der(m);
      else
        der(m2) = 0;
      end if;
      //  der(m1) = cut1.q[1] + (1 - x)*der(m);

      x = m2/(m1 + m2);

      H_abs = m2/V;
      H_rel = p2/p2_sat;

      p2_sat = 100*(10^(A - B/(C + T)));
      // Antoine's Equation

      assert(H_rel <= 1, "
    Error in component of class 'HumidAir': Pressure of gas 2 (water) has exceeded vapour pressure.
    The current version of this model is not valid in case of condensation.
     ");

      cut1.T = T;
      cut1.x = x;

      //CO2
      //===
      //source: "Ein Modell zur Simulation der Qualität der Innenraumluft am Beispiel von CO2"
      //        Niedersächsisches Landesgesundheitsamt, 30449 Hannover, Mai 2003

      pV = V*1/22.4*1000*6.02E23;
      //parts in Volume V of the gas

      der(c_CO2) = 1E6*cut1.CO2parts/pV;

      cut1.CO2conc = c_CO2;

      //CO2-concentration in the air, unit: "ppm"
      //n/3600 because we must calculate in seconds, not in hours!

    end HumidAir;

    model heatcond_kValue
      "Heatconductor, parameterised by k-value (e.g. for windows)"
      extends twotherm;
      parameter Real k(final unit="W/(m2 K)") = 1 "k-value";
      parameter SIunits.Area A=1 "Area (perpendicular to heat flow direction)";
    equation

      annotation (Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(
              color=42,
              gradient=1,
              fillColor=48)),
          Text(
            extent=[76, -22; -76, -54],
            string="W/(m2 K)",
            style(
              color=0,
              fillColor=7,
              fillPattern=1)),
          Text(
            extent=[76, 52; -76, 0],
            string="k = %k",
            style(
              color=0,
              fillColor=7,
              fillPattern=1))));
      therm1.j = k*A*(therm1.T - therm2.T);
      therm1.j + therm2.j = 0;
    end heatcond_kValue;
  end Elements;

  package Sources
    extends Icons.Package;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-60, 38; -26, -44], style(color=0, pattern=0)),
        Rectangle(extent=[-48, 40; -10, -48], style(
            color=0,
            arrow=4,
            fillColor=72)),
        Line(points=[-26, 28; -10, 28], style(color=0, thickness=2)),
        Line(points=[-26, 12; -10, 12], style(color=0, thickness=2)),
        Line(points=[-26, -4; -10, -4], style(color=0, thickness=2)),
        Line(points=[-26, -20; -10, -20], style(color=0, thickness=2)),
        Line(points=[-26, -36; -10, -36], style(color=0, thickness=2)),
        Rectangle(extent=[-8, 0; 36, -8], style(color=41, fillColor=41)),
        Polygon(points=[34, 8; 34, -16; 46, -4; 34, 8], style(color=41,
              fillColor=41)),
        Line(points=[-20, 4; -10, 4], style(color=0)),
        Line(points=[-20, 20; -10, 20], style(color=0)),
        Line(points=[-20, -12; -10, -12], style(color=0)),
        Line(points=[-20, -28; -10, -28], style(color=0)),
        Text(
          extent=[10, 26; 34, 0],
          string="C",
          style(color=0)),
        Text(
          extent=[-4, 30; 18, 10],
          string="o",
          style(color=0))),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));
    class sinustemp
      extends onetherm;
      parameter Modelica.SIunits.Temperature To=20
        "amplitude of oscillation in C";
      parameter Modelica.SIunits.Temperature Tave=10 "average temperature in C";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=72)),
          Line(points=[-60, 60; -60, -60], style(color=7)),
          Line(points=[-68, 0; 50, 0], style(color=7)),
          Line(points=[-60, 0; -56, 16; -48, 24; -36, 30; -26, 30; -14, 24; -8,
                 18; -2, 0; -2, 0; -2, 0; 6, -22; 14, -30; 30, -32; 42, -28; 50,
                 -22; 50, -22; 50, -22], style(color=41, thickness=2)),
          Ellipse(extent=[14, 30; 40, 6], style(color=41, fillColor=41)),
          Rectangle(extent=[24, 30; 30, 66], style(color=41, fillColor=41)),
          Rectangle(extent=[24, 42; 30, 66], style(color=7, fillColor=7)),
          Line(points=[20, 42; 34, 42], style(color=0))),
        Icon(
          Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=72)),
          Line(points=[-60, 60; -60, -60], style(color=7)),
          Line(points=[-68, 0; 50, 0], style(color=7)),
          Line(points=[-60, 0; -56, 16; -48, 24; -36, 30; -26, 30; -14, 24; -8,
                 18; -2, 0; -2, 0; -2, 0; 6, -22; 14, -30; 30, -32; 42, -28; 50,
                 -22; 50, -22; 50, -22], style(color=41, thickness=2)),
          Ellipse(extent=[14, 30; 40, 6], style(color=41, fillColor=41)),
          Rectangle(extent=[24, 30; 30, 66], style(color=41, fillColor=41)),
          Rectangle(extent=[24, 42; 30, 66], style(color=7, fillColor=7)),
          Line(points=[20, 42; 34, 42], style(color=0))),
        Window(
          x=0.31,
          y=0.22,
          width=0.6,
          height=0.6));
    equation
      therm1.T = To*sin(2*Constants.pi*time/24/60/60 + 21600) + Tave;
    end sinustemp;

    class FixedTemp
      extends onetherm;
      parameter Modelica.SIunits.Temp_C Ts=20;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=72)),
          Rectangle(extent=[-62, 26; -24, -62], style(
              color=0,
              arrow=4,
              fillColor=75)),
          Line(points=[-40, 14; -24, 14], style(color=0, thickness=2)),
          Line(points=[-40, -2; -24, -2], style(color=0, thickness=2)),
          Line(points=[-24, -20; -40, -20], style(color=0, thickness=2)),
          Line(points=[-40, -34; -24, -34], style(color=0, thickness=2)),
          Line(points=[-40, -50; -24, -50], style(color=0, thickness=2)),
          Rectangle(extent=[-22, -14; 8, -26], style(color=41, fillColor=41)),
          Line(points=[-34, -10; -24, -10], style(color=0)),
          Line(points=[-34, 6; -24, 6], style(color=0)),
          Line(points=[-34, -26; -24, -26], style(color=0)),
          Line(points=[-34, -42; -24, -42], style(color=0)),
          Rectangle(extent=[-6, 46; 8, -14], style(color=41, fillColor=41)),
          Polygon(points=[0, 66; -20, 46; 20, 46; 0, 66], style(color=41,
                fillColor=41)),
          Text(
            extent=[18, 10; 42, -16],
            string="o",
            style(color=0)),
          Text(
            extent=[46, -4; 46, -44],
            string="C",
            style(color=0))),
        Window(
          x=0.32,
          y=0.23,
          width=0.6,
          height=0.6),
        Diagram(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=7)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=72)),
          Text(
            extent=[46, -4; 46, -44],
            string="C",
            style(color=0)),
          Rectangle(extent=[-62, 26; -24, -62], style(
              color=0,
              arrow=4,
              fillColor=75)),
          Line(points=[-40, 14; -24, 14], style(color=0, thickness=2)),
          Line(points=[-40, -2; -24, -2], style(color=0, thickness=2)),
          Line(points=[-24, -20; -40, -20], style(color=0, thickness=2)),
          Line(points=[-40, -34; -24, -34], style(color=0, thickness=2)),
          Line(points=[-40, -50; -24, -50], style(color=0, thickness=2)),
          Rectangle(extent=[-22, -14; 8, -26], style(color=41, fillColor=41)),
          Line(points=[-34, -10; -24, -10], style(color=0)),
          Line(points=[-34, 6; -24, 6], style(color=0)),
          Line(points=[-34, -26; -24, -26], style(color=0)),
          Line(points=[-34, -42; -24, -42], style(color=0)),
          Rectangle(extent=[-6, 46; 8, -14], style(color=41, fillColor=41)),
          Polygon(points=[0, 66; -20, 46; 20, 46; 0, 66], style(color=41,
                fillColor=41)),
          Text(
            extent=[18, 10; 42, -16],
            string="o",
            style(color=0))));
    equation
      therm1.T = Ts;
    end FixedTemp;

    class FixedHeatFlow
      extends onetherm;
      parameter Modelica.SIunits.HeatFlux J=2000 "heat flow";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=72)),
          Polygon(points=[-12, -18; -22, -4; -26, 10; -24, 22; -8, 38; 0, 44;
                10, 60; 20, 42; 24, 20; 22, 4; 16, -10; 10, -18; -12, -18],
              style(color=49, fillColor=49)),
          Polygon(points=[-8, -18; -14, -6; -16, 6; -12, 16; 0, 26; 10, 40; 14,
                 28; 18, 14; 14, -2; 8, -18; -8, -18], style(color=45,
                fillColor=45)),
          Polygon(points=[-4, -18; -10, -4; -8, 8; 2, 16; 6, 22; 10, 8; 10, -2;
                 8, -8; 4, -18; -4, -18], style(color=41, fillColor=41)),
          Polygon(points=[-4, -18; -6, -6; -4, 4; 2, 10; 4, -2; 2, -12; 0, -18;
                 -4, -18], style(color=77, fillColor=74)),
          Polygon(points=[-40, -18; 40, -18; 24, -42; -24, -42; -40, -18],
              style(color=0, fillColor=0))),
        Window(
          x=0.33,
          y=0.23,
          width=0.6,
          height=0.6),
        Diagram(
          Polygon(points=[-12, -18; -22, -4; -26, 10; -24, 22; -8, 38; 0, 44;
                10, 60; 20, 42; 24, 20; 22, 4; 16, -10; 10, -18; -12, -18],
              style(color=49, fillColor=49)),
          Polygon(points=[-8, -18; -14, -6; -16, 6; -12, 16; 0, 26; 10, 40; 14,
                 28; 18, 14; 14, -2; 8, -18; -8, -18], style(color=45,
                fillColor=45)),
          Polygon(points=[-4, -18; -10, -4; -8, 8; 2, 16; 6, 22; 10, 8; 10, -2;
                 8, -8; 4, -18; -4, -18], style(color=41, fillColor=41)),
          Polygon(points=[-4, -18; -6, -6; -4, 4; 2, 10; 4, -2; 2, -12; 0, -18;
                 -4, -18], style(color=77, fillColor=74)),
          Polygon(points=[-40, -18; 40, -18; 24, -42; -24, -42; -40, -18],
              style(color=0, fillColor=0))));
    equation
      therm1.j = -J;
    end FixedHeatFlow;

    class VarTemp

      extends onetherm;
      parameter SIunits.Pressure p=101300
        "Constant pressure (if not entered via connector)";
      parameter Boolean Import_H_rel_Data=false
        "Import data for rel. humidity via connector?";
      parameter Real H_rel_constant=0.5
        "Relative humidity (if not entered via connector)";
      SIunits.Pressure p1 "Partial pressure of dry air";
      SIunits.Pressure p2 "Partial pressure of water steam";
      SIunits.Pressure p2_sat "Saturation pressure of water steam";
      parameter Real R1=287 "gas constant of gas 1 (air) in J/(kg*K)";
      parameter Real R2=461 "gas constant of gas 2 (water steam) in J/(kg*K)";
      constant Real A=8.0732991
        "constant for calculation of saturation vapour pressure";
      constant Real B=1656.39
        "constant for calculation of saturation vapour pressure";
      constant Real C=226.86
        "constant for calculation of saturation vapour pressure";
      parameter Real CO2_out(final unit="ppm") = 380
        "CO2-concentration of the outside air";
      parameter SIunits.CelsiusTemperature Temp=16 "temperature of the air";

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 60, -80], style(color=0, fillColor=7)),
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=72)),
          Text(
            extent=[76, 62; 46, 28],
            string="C",
            style(color=0)),
          Rectangle(extent=[-62, 26; -24, -62], style(
              color=0,
              arrow=4,
              fillColor=75)),
          Line(points=[-40, 14; -24, 14], style(color=0, thickness=2)),
          Line(points=[-40, -2; -24, -2], style(color=0, thickness=2)),
          Line(points=[-24, -20; -40, -20], style(color=0, thickness=2)),
          Line(points=[-40, -34; -24, -34], style(color=0, thickness=2)),
          Line(points=[-40, -50; -24, -50], style(color=0, thickness=2)),
          Rectangle(extent=[-22, -14; 8, -26], style(color=41, fillColor=41)),
          Line(points=[-34, -10; -24, -10], style(color=0)),
          Line(points=[-34, 6; -24, 6], style(color=0)),
          Line(points=[-34, -26; -24, -26], style(color=0)),
          Line(points=[-34, -42; -24, -42], style(color=0)),
          Rectangle(extent=[-6, 46; 8, -14], style(color=41, fillColor=41)),
          Polygon(points=[2, 66; -18, 46; 22, 46; 2, 66], style(color=41,
                fillColor=41)),
          Text(
            extent=[24, 70; 48, 44],
            string="o",
            style(color=0)),
          Text(
            extent=[30, -2; 70, 14],
            string="Air",
            style(color=67)),
          Text(
            extent=[22, -16; 78, -2],
            string="exchange",
            style(color=67))),
        Window(
          x=0.23,
          y=0.23,
          width=0.6,
          height=0.6),
        Diagram,
        DymolaStoredErrors);
      Modelica.Blocks.Interfaces.InPort InPort(n=if Import_H_rel_Data then 2 else
                  1) annotation (extent=[-100, -10; -80, 10], layer="icon");
      flowHM flowHM1 annotation (extent=[80, -8; 100, 12]);
    equation
      if cardinality(InPort) == 0 then
        InPort.signal[1] = Temp;
      end if;
      therm1.T = InPort.signal[1];
      flowHM1.T = InPort.signal[1];

      if Import_H_rel_Data then
        InPort.signal[2] = p2/p2_sat;
      else
        H_rel_constant = p2/p2_sat;
      end if;

      flowHM1.x = R1*p2/(p1*R2 + R1*p2);
      p = p1 + p2;
      p2_sat = 100*(10^(A - B/(C + therm1.T)));

      flowHM1.CO2conc = CO2_out;
      //CO2-concentration of the air
      //flowHM1.CO2parts = 0;
      //CO2-parts which come from additional chemical reactions
    end VarTemp;

    class VarHeatFlow
      extends onetherm;
      parameter Modelica.SIunits.HeatFlux J=2000 "heat flow";
      parameter Real k=1 "Weight factor";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=72)),
          Polygon(points=[-12, -18; -22, -4; -26, 10; -24, 22; -8, 38; 0, 44;
                10, 60; 20, 42; 24, 20; 22, 4; 16, -10; 10, -18; -12, -18],
              style(color=49, fillColor=49)),
          Polygon(points=[-8, -18; -14, -6; -16, 6; -12, 16; 0, 26; 10, 40; 14,
                 28; 18, 14; 14, -2; 8, -18; -8, -18], style(color=45,
                fillColor=45)),
          Polygon(points=[-4, -18; -10, -4; -8, 8; 2, 16; 6, 22; 10, 8; 10, -2;
                 8, -8; 4, -18; -4, -18], style(color=41, fillColor=41)),
          Polygon(points=[-4, -18; -6, -6; -4, 4; 2, 10; 4, -2; 2, -12; 0, -18;
                 -4, -18], style(color=77, fillColor=74)),
          Polygon(points=[-40, -18; 40, -18; 24, -42; -24, -42; -40, -18],
              style(color=0, fillColor=0))),
        Diagram(
          Polygon(points=[-12, -18; -22, -4; -26, 10; -24, 22; -8, 38; 0, 44;
                10, 60; 20, 42; 24, 20; 22, 4; 16, -10; 10, -18; -12, -18],
              style(color=49, fillColor=49)),
          Polygon(points=[-8, -18; -14, -6; -16, 6; -12, 16; 0, 26; 10, 40; 14,
                 28; 18, 14; 14, -2; 8, -18; -8, -18], style(color=45,
                fillColor=45)),
          Polygon(points=[-4, -18; -10, -4; -8, 8; 2, 16; 6, 22; 10, 8; 10, -2;
                 8, -8; 4, -18; -4, -18], style(color=41, fillColor=41)),
          Polygon(points=[-4, -18; -6, -6; -4, 4; 2, 10; 4, -2; 2, -12; 0, -18;
                 -4, -18], style(color=77, fillColor=74)),
          Polygon(points=[-40, -18; 40, -18; 24, -42; -24, -42; -40, -18],
              style(color=0, fillColor=0))),
        Window(
          x=0.23,
          y=0.12,
          width=0.6,
          height=0.6));
      Modelica.Blocks.Interfaces.InPort InPort
        annotation (extent=[-100, -10; -80, 10]);
    equation
      therm1.j = -J*InPort.signal[1]*k;
    end VarHeatFlow;
  end Sources;

  class TempSensor
    extends onetherm;
    annotation (
      Coordsys(
        extent=[-94, -104; 86, 152],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-20, 40; 18, -48], style(
            color=0,
            arrow=4,
            fillColor=75)),
        Line(points=[2, 28; 18, 28], style(color=0, thickness=2)),
        Line(points=[2, 12; 18, 12], style(color=0, thickness=2)),
        Line(points=[18, -6; 2, -6], style(color=0, thickness=2)),
        Line(points=[2, -20; 18, -20], style(color=0, thickness=2)),
        Line(points=[2, -36; 18, -36], style(color=0, thickness=2)),
        Line(points=[8, 4; 18, 4], style(color=0)),
        Line(points=[8, 20; 18, 20], style(color=0)),
        Line(points=[8, -12; 18, -12], style(color=0)),
        Line(points=[8, -28; 18, -28], style(color=0)),
        Text(extent=[-70, -28; -14, -86], string="C"),
        Text(extent=[-94, -10; -50, -58], string="o"),
        Text(extent=[34, -32; 80, -86], string="K"),
        Text(
          extent=[-56, 82; 46, 42],
          string="%name",
          style(color=0)),
        Text(extent=[12, 152; 56, 104], string="o"),
        Text(extent=[30, 132; 86, 74], string="C")),
      Diagram,
      Window(
        x=0.33,
        y=0.08,
        width=0.6,
        height=0.6));
    Modelica.Blocks.Interfaces.OutPort OutPortCelsius annotation (
      extent=[-40, -82; -78, -114],
      rotation=90,
      layer="icon");
    Modelica.Blocks.Interfaces.OutPort OutPortKelvin annotation (
      extent=[80, -82; 42, -114],
      rotation=90,
      layer="icon");
  equation
    therm1.j = 0;
    T = OutPortCelsius.signal[1];
    T + 273.15 = OutPortKelvin.signal[1];
  end TempSensor;

  connector flowHM

    Real T;
    // air temperature
    Real x;
    // mass-concentration of water
    flow Real q[2];
    // mass flow q[1]=dry, q[2]=water steam
    flow Real j;
    // heat flow
    flow Real CO2parts(unit="1/s");
    // parts of CO2
    Real CO2conc(unit="ppm");
    // CO2 concentration of the air
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-100, 100; 100, -100], style(color=69, fillColor=7)),
        Line(points=[-78, 66; 76, 66], style(color=65, thickness=2)),
        Line(points=[-76, 28; 78, 28], style(thickness=2)),
        Line(points=[-76, -18; 78, -18], style(color=65, thickness=2)),
        Line(points=[-76, -60; 78, -60], style(thickness=2)),
        Text(extent=[-52, -68; 54, -96], string="%name")),
      Window(
        x=0.25,
        y=0.18,
        width=0.6,
        height=0.6));

  end flowHM;

  class therm_to_flowHM
    therm therm1 annotation (extent=[-64, -24; -16, 26]);
    flowHM flowHM1 annotation (extent=[20, -20; 60, 20]);
    annotation (
      Icon(
        Line(points=[-20, 16; 20, 16; 10, 22; 20, 16; 10, 10], style(
            color=3,
            fillColor=7,
            fillPattern=1)),
        Line(points=[20, -16; -20, -16; -10, -10; -20, -16; -10, -22], style(
            color=3,
            fillColor=7,
            fillPattern=1)),
        Text(
          extent=[18, 6; -18, -8],
          style(
            color=3,
            fillColor=7,
            fillPattern=1),
          string="T, j")),
      Coordsys(extent=[-60, -60; 60, 60]),
      Diagram);
  equation
    therm1.T = flowHM1.T;
    therm1.j = -flowHM1.j;
    flowHM1.q = {0,0};

    flowHM1.CO2parts = 0;

      //CO2-Parts which come from chemical reactions --> generally 0 in this object !!

  end therm_to_flowHM;
end Building;

