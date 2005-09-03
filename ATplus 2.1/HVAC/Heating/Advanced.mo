package Advanced
  extends ATplus.Icons.Package;
  package SIunits = Modelica.SIunits;
  package Constants = Modelica.Constants;

  annotation (Coordsys(
      extent=[0, 0; 443, 453],
      grid=[2, 2],
      component=[20, 20]), Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65,
      library=1,
      autolayout=1));
  package Base
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]));

    class pipe_elem
      parameter Real D=0.02 "Diameter in m";
      parameter Real Rekrit=1400 "crit. Reynolds number";
      constant Real rho=1000 "Water density in kg/(m*m*m)";
      constant Real pi=3.1415927;
      Real eta "dyn. viscosity in Pa*s";
      Real v "Actual velocity in m/s";
      Real vlam "Laminar velocity in m/s";
      Real vturb "Turbulent velocity in m/s";
      Real Relam "Laminar Reynolds number";
      Real Returb "Turbulent Reynolds number";
      Real lambdaturb "Turbulent pipe friction number";
      Real i "Mass flow rate in kg/s";
      parameter Real L=1 "Length in m";
      parameter Real T0=10 "Initial temperature in °C";
      constant Real c=4190 "Spec. heat capacity of water in J/(kg*K)";
      Real alpha "Coefficient of convective heat transfer W/(m*m*K)";
      Real T(start=T0) "Temperature in °C";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-88, 44; 88, -36], style(gradient=2, fillColor=71)),
          Text(extent=[-55, -43; 55, -67], string="%name"),
          Line(points=[-69, 2; 68, 2; 47, 10; 47, -7; 68, 2], style(color=0))),
        Window(
          x=0.14,
          y=0.23,
          width=0.78,
          height=0.7));

      Cuts.HeatFlow H annotation (extent=[-13, 69; 13, 45], layer="icon");
      Cuts.ThermoFlow IN annotation (extent=[-116, 13; -90, -13], layer="icon");
      Cuts.ThermoFlow OUT annotation (extent=[90, 13; 116, -13], layer="icon");
    equation

      if noEvent(i > 0) then
        c*i*(T - IN.T)/L + c*rho*pi*((D/2)^2)*der(T) = H.J/L;
        OUT.T = T;

      else
        if noEvent(i < 0) then
          c*i*(OUT.T - T)/L + c*rho*pi*((D/2)^2)*der(T) = H.J/L;
          IN.T = T;
        else
          c*rho*pi*((D/2)^2)*der(T) = H.J/L;
          OUT.T = T;
        end if;
      end if;

        //SCHACK's formula; 115 from NUSSELT's equation for lam. flow and v = 0:
      alpha = 115 + 3370*(1 + 0.014*T)*(noEvent(abs(v)))^0.85;

      H.J = pi*D*L*alpha*(H.T - T);

      IN.i = -OUT.i;
      i = IN.i;

      vlam = (IN.p - OUT.p)*(D^2)/(32*eta*L);
      Relam = rho*D*abs(vlam)/eta;

      vturb = if noEvent(IN.p - OUT.p > 0 and lambdaturb > 0) then sqrt(2*D*(IN.
         p - OUT.p)/(lambdaturb*rho*L)) else if noEvent(IN.p - OUT.p < 0 and
        lambdaturb > 0) then -sqrt(2*D*(OUT.p - IN.p)/(lambdaturb*rho*L)) else
        0;

      lambdaturb = if Returb < 20000 then 0.0497 - 0.000001183*Returb else if (
        Returb >= 20000 and Returb < 100000) then 0.0281 - 1.03E-7*Returb else
        0.0178;

      Returb = rho*D*abs(vturb)/eta;

      i = v*rho*pi*(D^2)/4;

      v = if noEvent(Relam < Rekrit) then vlam else vturb;

      eta = if noEvent(T < 45) then 0.001375 - 0.00001942*T else if noEvent(T
         >= 45 and T <= 90) then 0.00069 - 0.0000042*T else 0.000312;
    end pipe_elem;

    class PipeCurve
      "Pipe with parameterized characteristic curve for flow/pressure (v/p)  "
      parameter Real Acs=0.0004 "cross section area in m^2";
      parameter Real Cf=0.08 "outer circumference of pipe in m";
      parameter Real L=1 "length of pipe in m";
      parameter Real T0=10 "initial water temperature in °C";
      parameter Real P[4]={100,200,300,400}
        "pressure values of v, p-curve in Pa (P[4] should be max. pressure drop.)";
      parameter Real V[4]={0.1,0.141,0.173,0.2}
        "velocities at pressure values in m/s";
      constant Real rho=1000 "density of water in kg/(m*m*m)";
      constant Real pi=3.1415927;
      constant Real c=4190 "spec. heat capacity of water in J/(kg*K)";
      Real alpha "coefficient of convective heat transfer in W/(m*m*K)";
      Real T(start=T0) "water temperature in °C";
      Real dp "pressure drop in Pa";
      Real v "velocity in m/s";
      Real i "massflow rate in kg/s";
      annotation (
        Coordsys(
          extent=[-115, -120; 103, 62],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.04,
          y=0.02,
          width=0.94,
          height=0.92),
        Icon(
          Rectangle(extent=[-100, 48; 88, -44], style(gradient=2, fillColor=71)),
          Text(extent=[-66, -48; 54, -88], string="%name"),
          Line(points=[40, 4; 82, 4], style(color=0, thickness=2)),
          Line(points=[62, 14; 82, 4; 62, -6], style(color=0, thickness=2)),
          Line(points=[-30, 40; -30, -34]),
          Line(points=[-92, 2; 26, 2]),
          Text(extent=[-58, 48; -34, 30], string="v"),
          Line(points=[-34, 38; -30, 44; -26, 38]),
          Line(points=[22, 6; 30, 2; 22, -2]),
          Text(extent=[20, -4; 38, -20], string="p"),
          Text(
            extent=[-10, -6; 6, -20],
            string="P[i]",
            style(color=0, pattern=0)),
          Line(points=[-8, 4; -8, -2], style(color=0)),
          Line(points=[4, 4; 4, -2], style(color=0)),
          Line(points=[16, 4; 16, -2], style(color=0)),
          Line(points=[-32, 12; -26, 12], style(color=0)),
          Line(points=[-32, 24; -26, 24], style(color=0)),
          Line(points=[-32, 30; -26, 30], style(color=0)),
          Text(
            extent=[-54, 26; -38, 12],
            string="V[i]",
            style(color=0)),
          Line(points=[-68, 4; -68, -2], style(color=0, pattern=3)),
          Line(points=[-54, 4; -54, -2], style(color=0, pattern=3)),
          Line(points=[-40, 4; -40, -2], style(color=0, pattern=3)),
          Line(points=[-32, -8; -26, -8], style(color=0, pattern=3)),
          Line(points=[-32, -20; -26, -20], style(color=0, pattern=3)),
          Line(points=[-32, -26; -26, -26], style(color=0, pattern=3)),
          Line(points=[-32, 34; -26, 34], style(color=0)),
          Line(points=[-32, -30; -26, -30], style(color=0, pattern=3)),
          Line(points=[-80, 4; -80, -2], style(color=0, pattern=3)),
          Line(points=[-20, 4; -20, -2], style(color=0)),
          Line(points=[-90, -30; -80, -30; -68, -26; -54, -20; -40, -8; -20, 12;
                 -6, 24; 6, 32; 18, 36; 26, 36]),
          Text(
            extent=[-38, -80; 26, -120],
            string="L = %L m",
            style(color=0))));

      Cuts.HeatFlow H annotation (extent=[-14, 74; 12, 50], layer="icon");
      Cuts.ThermoFlow IN annotation (extent=[-128, 16; -102, -10], layer="icon");
      Cuts.ThermoFlow OUT annotation (extent=[90, 16; 116, -10], layer="icon");
    equation

      if noEvent(i >= 0) then
        c*i*(T - IN.T)/L + c*rho*Acs*der(T) = H.J/L;
        OUT.T = T;
      else
        c*i*(OUT.T - T)/L + c*rho*Acs*der(T) = H.J/L;
        IN.T = T;
      end if;

      alpha = 115 + 3370*(1 + 0.014*T)*(noEvent(abs(v)));

        // SCHACK's formula; 115 from NUSSELT's equation for laminar flow and v = 0

      H.J = Cf*L*alpha*(H.T - T);

      dp = IN.p - OUT.p;

      IN.i = -OUT.i;
      i = IN.i;
      i = v*rho*Acs;

      v = if (dp >= 0 and dp < P[1]) then (V[1]/P[1])*dp else if (dp >= P[1]
         and dp < P[2]) then V[1] + (V[2] - V[1])/(P[2] - P[1])*(dp - P[1]) else
              if (dp >= P[2] and dp < P[3]) then V[2] + (V[3] - V[2])/(P[3] - P[
        2])*(dp - P[2]) else if (dp >= P[3] and dp < P[4]) then V[3] + (V[4] -
        V[3])/(P[4] - P[3])*(dp - P[3]) else if (dp >= P[4]) then V[4] + 1E-5*(
        dp - P[4]) else if (dp < 0 and dp >= -P[1]) then (V[1]/P[1])*dp else
        if (dp < -P[1] and dp >= -P[2]) then -V[1] + (V[2] - V[1])/(P[2] - P[1])
        *(dp + P[1]) else if (dp < -P[2] and dp >= -P[3]) then -V[2] + (V[3] -
        V[2])/(P[3] - P[2])*(dp + P[2]) else if (dp < -P[3] and dp >= -P[4]) then
              -V[3] + (V[4] - V[3])/(P[4] - P[3])*(dp + P[3]) else -V[4] + 1E-5
        *(dp - P[4]);

        // between -P[4] and P[4] the characteristic curve v(dp) consists of pieces

        // of straight lines; below -P[4] and above P[4] the velocity is approximately
      // constant.

    end PipeCurve;

    class pipe_elem_wall_iso
      parameter Real L=1 "length of pipe";
      parameter Real D=0.02 "inner diameter of pipe in m";
      parameter Real D_o_wall=0.024 "outer diameter of wall in m";
      parameter Real lambda_wall=393 "heat conductivity of wall in W/(m*K)";
      parameter Real rho_wall=5000 "density of wall in kg/m^3";
      parameter Real c_wall=1000 "specific heat capacity of wall in J/(kg*K)";
      parameter Real D_o_iso=0.064 "outer diameter of wall in m";
      parameter Real lambda_iso=1 "heat conductivity of wall in W/(m*K)";
      parameter Real rho_iso=100 "density of isolation in kg/m^3";
      parameter Real c_iso=1000
        "specific heat capacity of isolation in J/(kg*K)";
      parameter Real T0_water=10 "start temperature of water in °C";
      parameter Real T0_wall=10 "start temperature of wall in °C";
      parameter Real T0_iso=10 "start temperature of isolation in °C";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Text(
            extent=[-136, 106; -26, 86],
            string="heat loss of insulation",
            style(color=41)),
          Rectangle(extent=[-86, 64; 88, -58], style(fillColor=8)),
          Rectangle(extent=[-86, 52; 88, -44], style(
              color=0,
              thickness=2,
              fillColor=0)),
          Rectangle(extent=[-86, 44; 88, -36], style(
              color=0,
              thickness=2,
              fillColor=71))),
        Diagram(Text(
            extent=[-132, 112; -22, 92],
            string="heat loss of insulation",
            style(color=41))),
        Window(
          x=0.27,
          y=0.15,
          width=0.59,
          height=0.69));
      pipe_elem water(
        D=D,
        L=L,
        T0=T0_water) annotation (extent=[-56, -54; 44, 20]);
      Cuts.ThermoFlow In annotation (extent=[-126, 24; -86, -14]);
      Cuts.ThermoFlow Out annotation (extent=[88, 22; 128, -16]);
      wall_iso Wall_and_Iso(
        L=L,
        D_i_wall=D,
        D_o_wall=D_o_wall,
        lambda_wall=lambda_wall,
        rho_wall=rho_wall,
        c_wall=c_wall,
        D_i_iso=D_o_wall,
        D_o_iso=D_o_iso,
        lambda_iso=lambda_iso,
        rho_iso=rho_iso,
        c_iso=c_iso,
        T0_wall=T0_wall,
        T0_iso=T0_iso) annotation (extent=[-80, -108; 46, 76]);
      Cuts.HeatFlow Out_heat annotation (extent=[-10, 90; 10, 110]);
    equation
      connect(In, water.IN) annotation (points=[-106, 6; -54, -19; -54, -19]);
      connect(water.OUT, Out) annotation (points=[49.5, -21; 88, -21; 88, 2]);
      connect(Out_heat, Wall_and_Iso.OUT) annotation (points=[0, 92; 0, 84]);
      connect(Wall_and_Iso.IN1, water.H)
        annotation (points=[-6, 17.4351; -6, 6]);
    end pipe_elem_wall_iso;

    class Cond
      "Heat conductor for radial heat flow in the wall of a cylindrical pipe"
      parameter Real d1=0.02 "inner diameter in m";
      parameter Real d2=0.023 "outer diameter in m";
      parameter Real L=1 "length in m";
      parameter Real lambda=373 "heat conductivity in W/(K*m)";
      constant Real pi=3.1415927;
      Real J;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Icon(
          Rectangle(extent=[-66, 86; 66, -86], style(gradient=2, fillColor=43)),
          Text(extent=[-48, 78; 50, 36], string="%name"),
          Line(points=[0, 34; 0, -76], style(color=41, arrow=1))),
        Window(
          x=0.34,
          y=0.18,
          width=0.6,
          height=0.6));

      Cuts.HeatFlow IN annotation (extent=[-18, 114; 12, 88]);
      Cuts.HeatFlow OUT annotation (extent=[-14, -88; 16, -114]);
    equation
      IN.J = -OUT.J;
      J = IN.J;
      J = (IN.T - OUT.T)*lambda*2*pi*L/ln(d2/d1);
    end Cond;

    class HeatStore "Heat capacitor"
      parameter Real C=1000 "abs. heat capacity per meter in J/(K*m)";
      parameter Real TO=10 "start temperature in °C";
      parameter Real L=1 "length in m";
      Real T(start=TO);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.41,
          y=0.2,
          width=0.6,
          height=0.6),
        Icon(
          Rectangle(extent=[-100, 100; 102, -86], style(gradient=3, fillColor=
                  41)),
          Text(
            extent=[-66, 58; 72, 24],
            string="Capacitor",
            style(color=0)),
          Text(extent=[-62, -12; 72, -54], string="%name")));
      Cuts.HeatFlow H annotation (extent=[-6, -88; 20, -114]);
    equation
      T = H.T;
      H.J = L*C*der(T);
    end HeatStore;

    class wall_iso
      parameter Real L=1 "length of pipe";
      parameter Real D_i_wall=0.02 "inner diameter of wall in m";
      parameter Real D_o_wall=0.024 "outer diameter of wall in m";
      parameter Real lambda_wall=393 "heat conductivity of wall in W/(m*K)";
      parameter Real rho_wall=5000 "density of wall in kg/m^3";
      parameter Real c_wall=1000 "specific heat capacity of wall in J/(kg*K)";
      parameter Real D_i_iso=0.024 "inner diameter of wall in m";
      parameter Real D_o_iso=0.064 "outer diameter of wall in m";
      parameter Real lambda_iso=1 "heat conductivity of wall in W/(m*K)";
      parameter Real rho_iso=100 "density of insulation in kg/m^3";
      parameter Real c_iso=1000
        "specific heat capacity of isolation in J/(kg*K)";
      parameter Real T0_wall=10 "initial temperature of wall in °C";
      parameter Real T0_iso=10 "initial temperature of insulation in °C";
      constant Real pi=3.1415927;
      annotation (
        Coordsys(
          extent=[-133, -126; 87.5, 105],
          grid=[0.5, 0.5],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-86.5, 56.5; 87.5, 34.5], style(thickness=2,
                fillColor=0)),
          Rectangle(extent=[-86.5, 105; 87.5, 59], style(
              color=9,
              fillColor=7,
              fillPattern=8)),
          Rectangle(extent=[-86.5, -47.5; 87.5, -67.5], style(thickness=2,
                fillColor=0)),
          Rectangle(extent=[-86.5, -69; 87.5, -115], style(
              color=9,
              fillColor=7,
              fillPattern=8)),
          Text(
            extent=[-141, 34; -61, 10],
            string="Heat loss of water",
            style(color=41)),
          Line(points=[-51.5, 23; -25.5, 23], style(color=41, arrow=1)),
          Text(
            extent=[-176, 127.5; -74, 98],
            string="Heat loss of insulation",
            style(color=41)),
          Line(points=[-64.5, 111.5; -38.5, 111.5], style(color=41, arrow=1))),
        Diagram(Text(extent=[-31, -37; 25, -75], string="Wall"), Text(extent=[-46,
                 76; 70, 22], string="Insulation")),
        Window(
          x=0.36,
          y=0.05,
          width=0.63,
          height=0.78));

      Cond PW1(
        d1=D_i_wall,
        d2=(D_i_wall + D_o_wall)/2,
        L=L,
        lambda=lambda_wall) annotation (extent=[-84.5, -69; -44.5, -107]);
      HeatStore WallStore(
        C=pi*L*rho_wall*c_wall/4*(D_o_wall^2 - D_i_wall^2),
        TO=T0_wall,
        L=L) annotation (extent=[-133, -51; -101, -19]);
      HeatStore InsuStore(
        C=pi*L*rho_iso*c_iso/4*(D_o_iso^2 - D_i_iso^2),
        TO=T0_iso,
        L=L) annotation (extent=[-130.5, 47.5; -96.5, 80]);
      Cond PW2(
        d1=(D_i_wall + D_o_wall)/2,
        d2=D_o_wall,
        L=L,
        lambda=lambda_wall) annotation (extent=[-85, -16.5; -45, -54.5]);
      Cond Insu1(
        d1=D_i_iso,
        d2=(D_i_iso + D_o_iso)/2,
        L=L,
        lambda=lambda_iso) annotation (extent=[-85, 33.5; -45, -4.5]);
      Cond Insu2(
        d1=(D_i_iso + D_o_iso)/2,
        d2=D_o_iso,
        L=L,
        lambda=lambda_iso) annotation (extent=[-85, 83.5; -45, 45.5]);
      Cuts.HeatFlow OUT annotation (extent=[-32.5, 118.5; 27.5, 96.5]);
      Cuts.HeatFlow IN1 annotation (extent=[-20.5, 34; 9.5, 20.5], layer="icon");
    equation
      connect(PW2.IN, PW1.OUT) annotation (points=[-65, -54.5; -65, -66.5]);
      connect(Insu2.IN, Insu1.OUT) annotation (points=[-65, 45.5; -65, 31.5]);
      connect(Insu1.IN, PW2.OUT) annotation (points=[-65, -4.5; -65, -16.5]);
      connect(Insu1.OUT, InsuStore.H)
        annotation (points=[-65, 33; -65, 40; -111.5, 40; -111.5, 48]);
      connect(PW1.OUT, WallStore.H) annotation (points=[-64.5, -67; -64.5, -61;
             -116, -61; -116.5, -51.16]);
      connect(PW1.IN, IN1) annotation (points=[-64.5, -109; -64.5, -126; 59.5,
            -126; 59.5, 21.5; 9, 21.5]);
      connect(Insu2.OUT, OUT)
        annotation (points=[-64, 85; -64, 106; -7.5, 106]);
    end wall_iso;

    class radiator "Hot water radiator composed of cylindrical pipes"
      parameter Real surface=5 "Surface in m^2";
      parameter Real epsilon=0.94 "Emission coefficient";
      parameter Real alpha=4
        "convective heat transfer coefficient in W/(K*m^2)";
      parameter Real d_in=0.02 "inner pipe diameter in m";
      parameter Real d_out=0.023 "outer pipe diameter in m";
      parameter Real L=5 "length of pipe in m";
      parameter Real C=1000 "abs. heat capacity per meter in J/(K*m)";
      parameter Real lambda=500 "heat conductivity in W/(K*m)";
      parameter Real T0=10 "start temperature";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Text(
            extent=[60, 90; 142, 66],
            string="Radiation",
            style(color=45)),
          Text(extent=[-88, 88; -34, 64], string="Air"),
          Text(
            extent=[-20, 130; 32, 106],
            string="Convection",
            style(color=0)),
          Line(points=[14, 110; -2, 90], style(color=0))),
        Icon(
          Text(extent=[-122, 110; -64, 82], string="Air"),
          Rectangle(extent=[-52, -36; 68, -58], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-72, 60; 54, 40], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-60, 80; -40, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-36, 80; -16, -80], style(
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
              fillPattern=1)),
          Rectangle(extent=[-52, -32; 80, -62], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-76, 62; 54, 34], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-60, 80; -40, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-36, 80; -16, -80], style(
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
          Ellipse(extent=[70, -32; 88, -62], style(
              gradient=3,
              fillColor=8,
              fillPattern=1)),
          Ellipse(extent=[-88, 62; -68, 34], style(
              gradient=3,
              fillColor=8,
              fillPattern=1)),
          Text(extent=[-62, -86; 60, -112], string="%name"),
          Line(points=[-130, 14; -96, 14; -110, 22; -96, 14; -112, 6]),
          Line(points=[90, -80; 124, -80; 110, -72; 124, -80; 108, -88]),
          Text(
            extent=[76, 110; 170, 80],
            string="Radiation",
            style(color=45))),
        Window(
          x=0.09,
          y=0.03,
          width=0.6,
          height=0.6));
      Cuts.therm therm1 annotation (extent=[-66, 80; -24, 110]);
      Cuts.therm therm2 annotation (extent=[26, 80; 66, 110]);
      Building.Elements.heattrans heattrans1(alpha=alpha, A=surface)
        annotation (extent=[-18, 72; 6, 94], rotation=-90);
      Base.Converter Converter1 annotation (extent=[-26, 22; 20, 56]);
      Base.Cond Cond1(
        d1=d_in,
        d2=(d_in + d_out)/2,
        L=L/2,
        lambda=lambda) annotation (extent=[-66, -34; -36, -66]);
      Base.Cond Cond2(
        d1=d_in,
        d2=(d_in + d_out)/2,
        L=L/2,
        lambda=lambda) annotation (extent=[32, -32; 60, -64]);
      Base.Cond Cond3(
        d1=(d_in + d_out)/2,
        d2=d_out,
        L=L/2,
        lambda=lambda) annotation (extent=[-68, 20; -34, -12]);
      Base.Cond Cond4(
        d1=(d_in + d_out)/2,
        d2=d_out,
        L=L/2,
        lambda=lambda) annotation (extent=[30, 20; 62, -12]);
      Base.HeatStore HeatStore1(
        C=C,
        TO=T0,
        L=L/2) annotation (extent=[-30, -22; -6, 2]);
      Base.HeatStore HeatStore2(
        C=C,
        TO=T0,
        L=L/2) annotation (extent=[2, -22; 26, 2]);
      Cuts.ThermoFlow IN annotation (extent=[-116, 30; -82, 64]);
      Cuts.ThermoFlow OUT annotation (extent=[80, -62; 112, -28]);
      Base.pipe_elem pipe_elem1(
        D=d_in,
        L=L/2,
        T0=T0) annotation (extent=[-78, -116; -26, -68]);
      Base.pipe_elem pipe_elem2(
        D=d_in,
        L=L/2,
        T0=T0) annotation (extent=[22, -116; 68, -66]);
      Building.Elements.twostar twostar1(A=surface, eps=1)
        annotation (extent=[34, 54; 53, 74], rotation=90);
    equation
      connect(heattrans1.therm2, Converter1.Out)
        annotation (points=[-6, 73.1; -6, 49.37]);
      connect(pipe_elem1.OUT, pipe_elem2.IN)
        annotation (points=[-22, -92; 22, -92]);
      connect(IN, pipe_elem1.IN)
        annotation (points=[-98, 32; -98, -90; -78, -90]);
      connect(pipe_elem2.OUT, OUT)
        annotation (points=[70, -90; 102, -90; 102, -60]);
      connect(Cond3.OUT, Converter1.In)
        annotation (points=[-52, 20.16; -52, 30.67; -8, 30.67]);
      connect(Converter1.In, Cond4.OUT)
        annotation (points=[-4, 30.67; 46, 30.67; 46, 20.16]);
      connect(Cond3.IN, Cond1.OUT) annotation (points=[-52, -12.16; -52, -32]);
      connect(Cond1.IN, pipe_elem1.H) annotation (points=[-52, -66; -52, -78]);
      connect(Cond2.IN, pipe_elem2.H) annotation (points=[46, -66; 46, -78]);
      connect(Cond4.IN, Cond2.OUT) annotation (points=[46, -12.16; 46, -32]);
      connect(HeatStore1.H, Cond1.OUT)
        annotation (points=[-18, -22; -18, -28; -52, -28; -52, -34]);
      connect(Cond2.OUT, HeatStore2.H)
        annotation (points=[46.14, -32; 46.14, -22.12; 14, -22.12]);
      connect(Converter1.Out, twostar1.therm1)
        annotation (points=[-4, 48; 44, 48; 44, 55]);
      connect(twostar1.therm2, therm2) annotation (points=[44, 74; 44, 94]);
      connect(heattrans1.therm1, therm1)
        annotation (points=[-6, 92.9; -6, 104; -48, 104]);
    end radiator;

    class RadiatorCurve

      parameter Real surface=5 "Surface in m^2";
      parameter Real epsilon=0.94 "Emission coefficient";
      parameter Real alpha=4
        "convective heat transfer coefficient in W/(K*m^2)";
      parameter Real Cf=0.08 "inner circumference of pipe in m";
      parameter Real d_out=0.023 "outer pipe diameter in m (approximation)";
      parameter Real Acs=0.0004
        "cross-section area of pipe in m^2 (if cross-section is not a circle)";
      parameter Real L=5 "length of pipe in m";
      parameter Real C=1000 "abs. heat capacity per meter in J/(K*m)";
      parameter Real lambda=500 "heat conductivity in W/(K*m)";
      parameter Real T0=10 "start temperature";
      parameter Real P[4]={100,200,300,400}
        "pressure values of v, p-curve in Pa";
      parameter Real V[4]={0.02,0.0282,0.0346,0.04}
        "velocities at pressure values in m/s";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Text(extent=[-122, 110; -64, 82], string="Air"),
          Rectangle(extent=[-52, -36; 68, -58], style(
              color=0,
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-72, 60; 54, 40], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-60, 80; -40, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-36, 80; -16, -80], style(
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
              fillPattern=1)),
          Rectangle(extent=[-52, -32; 80, -62], style(
              color=0,
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-76, 62; 54, 34], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-60, 80; -40, -80], style(
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
          Rectangle(extent=[38, 78; 58, -80], style(
              gradient=1,
              fillColor=8,
              fillPattern=1)),
          Ellipse(extent=[70, -32; 88, -62], style(
              gradient=3,
              fillColor=8,
              fillPattern=1)),
          Ellipse(extent=[-88, 62; -68, 34], style(
              gradient=3,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-130, 14; -96, 14; -110, 22; -96, 14; -112, 6]),
          Line(points=[90, -80; 124, -80; 110, -72; 124, -80; 108, -88]),
          Text(
            extent=[76, 110; 170, 80],
            string="Radiation",
            style(color=45)),
          Text(extent=[-62, -86; 60, -112], string="%name"),
          Line(points=[42, -12; 42, -18], style(color=0)),
          Line(points=[30, -12; 30, -18], style(color=0)),
          Line(points=[18, -12; 18, -18], style(color=0)),
          Line(points=[6, -12; 6, -18], style(color=0)),
          Line(points=[-66, -14; 52, -14], style(color=0)),
          Line(points=[-14, -12; -14, -18], style(color=0, pattern=3)),
          Line(points=[-28, -12; -28, -18], style(color=0, pattern=3)),
          Line(points=[-42, -12; -42, -18], style(color=0, pattern=3)),
          Line(points=[-54, -12; -54, -18], style(color=0, pattern=3)),
          Line(points=[-8, 22; -4, 28; 0, 22], style(color=0)),
          Line(points=[-4, 24; -4, -50], style(color=0)),
          Line(points=[-6, 18; 0, 18], style(color=0)),
          Line(points=[-6, 14; 0, 14], style(color=0)),
          Line(points=[-6, 8; 0, 8], style(color=0)),
          Line(points=[-6, -4; 0, -4], style(color=0)),
          Line(points=[-6, -24; 0, -24], style(color=0, pattern=3)),
          Line(points=[-6, -36; 0, -36], style(color=0, pattern=3)),
          Line(points=[-6, -42; 0, -42], style(color=0, pattern=3)),
          Line(points=[-6, -46; 0, -46], style(color=0, pattern=3)),
          Line(points=[48, -10; 56, -14; 48, -18], style(color=0)),
          Text(
            extent=[42, -20; 60, -36],
            string="p",
            style(color=0)),
          Text(
            extent=[-50, 78; 48, 58],
            string="Characteristic",
            style(color=0)),
          Text(
            extent=[-30, 34; -14, 16],
            string="v",
            style(color=0)),
          Text(
            extent=[-66, 70; 64, 26],
            string="curve",
            style(color=0)),
          Line(points=[-62, -46; -52, -46; -40, -42; -26, -36; -12, -24; 8, -4;
                 22, 8; 34, 16; 46, 20; 54, 20], style(color=0))),
        Diagram(
          Text(extent=[-122, 110; -64, 82], string="Air"),
          Line(points=[-144, 16; -110, 16; -124, 24; -110, 16; -126, 8]),
          Line(points=[96, -80; 130, -80; 116, -72; 130, -80; 114, -88]),
          Text(
            extent=[76, 110; 170, 80],
            string="Radiation",
            style(color=45)),
          Line(points=[14, 110; -2, 90], style(color=0)),
          Text(
            extent=[-20, 130; 32, 106],
            string="Convection",
            style(color=0)),
          Line(points=[14, 110; -2, 90], style(color=0)),
          Text(
            extent=[-20, 130; 32, 106],
            string="Convection",
            style(color=0))),
        Window(
          x=0.03,
          y=0.12,
          width=0.91,
          height=0.6));
      Cuts.therm therm1 annotation (extent=[-66, 80; -24, 110], layer="icon");
      Cuts.therm therm2 annotation (extent=[26, 80; 66, 110], layer="icon");
      Cuts.ThermoFlow IN annotation (extent=[-116, 30; -82, 64], layer="icon");
      Cuts.ThermoFlow OUT annotation (extent=[80, -62; 112, -28], layer="icon");
      PipeCurve pipe_elem1(
        Acs=Acs,
        Cf=Cf,
        L=L,
        T0=T0,
        P=P,
        V=V) annotation (extent=[-28, -114; 24, -66]);
      Cond Cond1(
        d1=Cf/3.142,
        d2=(Cf/3.142 + d_out)/2,
        L=L,
        lambda=lambda)
        "If the cross-section of the pipe is not a circle, Cf/3.142 is an approximation of the inner \"diameter\"."
        annotation (extent=[-16, -24; 14, -56]);
      HeatStore HeatStore1(
        C=C,
        TO=T0,
        L=L) annotation (extent=[-50, -14; -26, 10]);
      Cond Cond2(
        d1=(Cf/3.142 + d_out)/2,
        d2=d_out,
        L=L,
        lambda=lambda)
        "If the cross-section of the pipe is not a circle, Cf/3.142 is an approximation of the inner \"diameter\"."
        annotation (extent=[-18, 20; 16, -12]);
      Converter Converter1 annotation (extent=[-26, 22; 20, 56]);
      Building.Elements.twostar twostar1(A=surface, eps=1)
        annotation (extent=[34, 54; 53, 74], rotation=90);
      Building.Elements.heattrans heattrans1(alpha=alpha, A=surface)
        annotation (extent=[-18, 72; 6, 94], rotation=-90);
    equation
      connect(Cond1.IN, pipe_elem1.H)
        annotation (points=[-1.45, -58.16; -0.8073, -68]);
      connect(Converter1.Out, twostar1.therm1)
        annotation (points=[-4, 48; 44, 48; 44, 55]);
      connect(heattrans1.therm2, Converter1.Out)
        annotation (points=[-6, 73.1; -6, 49.37]);
      connect(heattrans1.therm1, therm1)
        annotation (points=[-6, 94; -6, 104; -30, 104]);
      connect(twostar1.therm2, therm2) annotation (points=[44, 74; 44, 92]);
      connect(Cond2.IN, Cond1.OUT) annotation (points=[-2, -14; -2, -23.84]);
      connect(pipe_elem1.IN, IN)
        annotation (points=[-28, -84; -100, -84; -100, 32]);
      connect(HeatStore1.H, Cond1.OUT)
        annotation (points=[-38, -14; -38, -24; -2, -24]);
      connect(Converter1.In, Cond2.OUT) annotation (points=[-2, 30; -2, 20]);
      connect(pipe_elem1.OUT, OUT)
        annotation (points=[24, -82; 84, -82; 84, -62]);
    end RadiatorCurve;

    class TMixer
      parameter Real G1=0.1
        "laminar mass flow conductance IN1-OUT in kg/(s*Pa)";
      parameter Real G2=0.1
        "laminar mass flow conductance IN2-OUT in kg/(s*Pa)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Text(
            extent=[-78, 29; -45, -3],
            string="T 1",
            style(color=69)),
          Text(
            extent=[-78, 0; -45, -32],
            string="T 2",
            style(color=77)),
          Text(
            extent=[-19, 19; 38, -14],
            string="T mix",
            style(color=73)),
          Rectangle(extent=[-78, -32; 75, -58], style(gradient=2, fillColor=80)),
          Rectangle(extent=[-78, 57; 77, 30], style(gradient=2, fillColor=71)),
          Line(points=[-46, 44; 44, 44; 26, 53; 26, 35; 42, 44], style(color=0)),
          Line(points=[-45, -46; 45, -46; 27, -37; 27, -55; 43, -46], style(
                color=0)),
          Rectangle(extent=[47, 57; 79, -58], style(gradient=1, fillColor=75))),
        Diagram,
        Window(
          x=0.22,
          y=0.27,
          width=0.78,
          height=0.6));

      Cuts.ThermoFlow IN1 annotation (extent=[-110, 30; -80, 60]);
      Cuts.ThermoFlow OUT annotation (extent=[80, -15; 110, 15]);
      Cuts.ThermoFlow IN2 annotation (extent=[-110, -60; -80, -30]);
    equation
      OUT.T = if noEvent(IN1.i + IN2.i > 0) then (IN1.i*IN1.T + IN2.i*IN2.T)/
        noEvent(abs(IN1.i + IN2.i)) else IN1.T;

      OUT.i = -(IN1.i + IN2.i);
      IN1.i = G1*(IN1.p - OUT.p);
      IN2.i = G2*(IN2.p - OUT.p);

    end TMixer;

    class Converter
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Rectangle(extent=[-102, 36; 98, -28], style(
              color=9,
              pattern=0,
              thickness=2)),
          Rectangle(extent=[-100, 46; 98, -28], style(pattern=0)),
          Rectangle(extent=[-100, 42; 98, -28], style(color=0)),
          Text(
            extent=[-76, 28; 62, -14],
            string="Cut converter",
            style(color=0, pattern=0))),
        Icon(Rectangle(extent=[-100, 42; 98, -28], style(color=0)), Text(
            extent=[-72, 30; 66, -12],
            string="Cut converter",
            style(color=0, pattern=0))),
        Window(
          x=0.39,
          y=0.05,
          width=0.6,
          height=0.6));
      Cuts.HeatFlow In annotation (extent=[-26, -30; 16, -68]);
      Cuts.therm Out annotation (extent=[-30, 40; 16, 82], layer="icon");
    equation
      Out.j = -In.J;
      Out.T = In.T;
    end Converter;

  end Base;

  package Cuts
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]));

    connector ThermoFlow
      Real T;
      Real p;
      flow Real i;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6),
        Diagram(Rectangle(extent=[-100, 100; 102, -100], style(color=69))),
        Icon(Rectangle(extent=[-100, 100; 102, -100], style(color=73))));
    end ThermoFlow;

    connector HeatFlow
      Real T;
      flow Real J;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100, 100; 100, -102], style(color=41))),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
    end HeatFlow;

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

  end Cuts;

  package Example
    extends ATplus.Icons.Package;
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
    class Test_pipe_long
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.05,
          y=0.03,
          width=0.55,
          height=0.65),
        Diagram);
      pipe_long Pipe(n=20) annotation (extent=[36, 8; 102, 54]);
      pump Pump(p=400) annotation (extent=[-134, -18; -92, 18]);
      BoilerFF Boiler annotation (extent=[-46, 4; 12, 58]);
      Modelica.Blocks.Sources.Step Step1(startTime={600})
        annotation (extent=[-76, -18; -56, 2]);
      Base.Converter CC1 annotation (extent=[-30, 82; -4, 66]);
      Base.HeatStore HeatStore1(C=1000000) annotation (extent=[60, 62; 80, 82]);
      Base.HeatStore HeatStore2(C=1000000)
        annotation (extent=[-28, 86; -8, 106]);
    equation
      connect(Step1.outPort, Boiler.InPort1)
        annotation (points=[-54, -8; -54, 18; -44, 18]);
      connect(Boiler.OUT, Pipe.In) annotation (points=[10.84, 34; 30, 34]);
      connect(Pump.OUT, Boiler.IN)
        annotation (points=[-114, 18; -114, 32; -48, 32]);
      connect(Pipe.Out, Pump.IN)
        annotation (points=[108, 32; 118, 32; 118, -38; -112, -38; -112, -18]);
      connect(CC1.Out, Boiler.therm1) annotation (points=[-18, 70; -18, 60]);
      connect(HeatStore1.H, Pipe.Out_heat)
        annotation (points=[70, 62; 70, 54.23]);
      connect(HeatStore2.H, CC1.In) annotation (points=[-18, 86; -18, 77.92]);
    end Test_pipe_long;
  end Example;

  class pipe_long "Cylindrical water pipe with heat insulation"
    parameter Real l=10 "length in m";
    parameter Integer n(min=1) = 10 "number of pipe elements";
    parameter Real D=0.02 "inner diameter in m";
    parameter Real D_o_wall=0.024 "outer diameter of wall in m";
    parameter Real D_o_iso=0.064 "outer diameter of insulation in m";
    parameter Real lambda_wall=393 "heat conductivity of wall in W/(m*K)";
    parameter Real rho_wall=5000 "density of wall in kg/m^3";
    parameter Real c_wall=1000 "specific heat capacity of wall in J/(kg*K)";
    parameter Real lambda_iso=1 "heat conductivity of insulation in W/(m*K)";
    parameter Real rho_iso=100 "density of insulation in kg/m^3";
    parameter Real c_iso=1000
      "specific heat capacity of insulation in J/(kg*K)";
    parameter Real T0_water=10 "start temperature of water in °C";
    parameter Real T0_wall=10 "start temperature of wall in °C";
    parameter Real T0_iso=10 "start temperature of insulation in °C";
    Base.pipe_elem_wall_iso PEWI[n](
      L=fill(l/n, n),
      D=fill(D, n),
      D_o_wall=fill(D_o_wall, n),
      lambda_wall=fill(lambda_wall, n),
      rho_wall=fill(rho_wall, n),
      c_wall=fill(c_wall, n),
      D_o_iso=fill(D_o_iso, n),
      lambda_iso=fill(lambda_iso, n),
      rho_iso=fill(rho_iso, n),
      c_iso=fill(c_iso, n),
      T0_water=fill(T0_water, n),
      T0_wall=fill(T0_wall, n),
      T0_iso=fill(T0_iso, n)) annotation (extent=[-35, -35; 35, 35]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Line(points=[-118, 24; -92, 24; -104, 28; -92, 24; -104, 18]),
        Line(points=[-118, 6; -92, 6; -104, 10; -92, 6; -104, 0]),
        Line(points=[-118, -14; -92, -14; -104, -10; -92, -14; -104, -20]),
        Line(points=[96, 24; 122, 24; 110, 28; 122, 24; 110, 18]),
        Line(points=[96, 6; 122, 6; 110, 10; 122, 6; 110, 0]),
        Line(points=[96, -14; 122, -14; 110, -10; 122, -14; 110, -20])),
      Icon(
        Rectangle(extent=[-86, 44; 88, -36], style(thickness=2)),
        Rectangle(extent=[-86, -34; 88, -46], style(thickness=2, fillColor=0)),
        Rectangle(extent=[-86, -46; 88, -82], style(
            color=9,
            fillColor=7,
            fillPattern=8)),
        Line(points=[-78, 74; 80, 74], style(pattern=0)),
        Text(extent=[-34, 16; 44, -36], string="n = %n"),
        Line(points=[68, 44; 68, -34], style(pattern=2)),
        Line(points=[-62, 44; -62, -34], style(pattern=2)),
        Line(points=[-40, 44; -40, -34], style(pattern=2)),
        Line(points=[46, 44; 46, -34], style(pattern=2)),
        Line(points=[-82, 64; 76, 64], style(color=0)),
        Rectangle(extent=[-86, 90; 88, 52], style(
            color=9,
            fillColor=7,
            fillPattern=8)),
        Rectangle(extent=[-86, 52; 88, 44], style(thickness=2, fillColor=0)),
        Line(points=[-122, 6; -90, 6; -106, 18; -90, 6; -108, -8], style(color=
                0)),
        Line(points=[6, 32; 6, 108; 0, 94; 6, 108; 12, 94], style(color=85)),
        Line(points=[6, -22; 6, -76; 14, -62; 6, -76; 0, -62], style(
            color=85,
            fillColor=7,
            fillPattern=8)),
        Line(points=[58, 28; 58, 78; 52, 64; 58, 78; 64, 64], style(color=85)),
        Line(points=[56, -22; 56, -76; 64, -62; 56, -76; 50, -62], style(
            color=85,
            fillColor=7,
            fillPattern=8)),
        Line(points=[-52, -22; -52, -76; -44, -62; -52, -76; -58, -62], style(
            color=85,
            fillColor=7,
            fillPattern=8)),
        Text(
          extent=[-56, -82; 56, -114],
          string="L = %l m",
          style(color=0, pattern=0)),
        Text(extent=[-38, 34; 44, 4], string="%name"),
        Line(points=[-52, 32; -52, 82; -58, 68; -52, 82; -46, 68], style(color=
                85)),
        Line(points=[-122, 6; -90, 6; -106, 18; -90, 6; -108, -8], style(color=
                0)),
        Line(points=[90, 4; 122, 4; 106, 16; 122, 4; 106, -8], style(color=0))),
      Window(
        x=0.01,
        y=0.12,
        width=0.83,
        height=0.72));

    Cuts.ThermoFlow In annotation (extent=[-124, 40; -88, -32], layer="icon");
    Cuts.ThermoFlow Out annotation (extent=[90, 40; 124, -32], layer="icon");
    Cuts.HeatFlow Out_heat annotation (extent=[-18, 110; 30, 92]);
  equation
    connect(In, PEWI[1].In);
    connect(Out, PEWI[n].Out);
    for i in 1:(n - 1) loop
      connect(PEWI[i].Out, PEWI[i + 1].In);
    end for;

    for i in 1:n loop
      connect(PEWI[i].Out_heat, Out_heat);
    end for;
  end pipe_long;

  class losspipe_long
    parameter SIunits.Temp_C Ta=16 "Ambient temperature";
    parameter SIunits.Length l=10 "Pipe length";
    parameter Integer n(min=1) = 10 "number of pipe elements";
    parameter Real D=0.02 "inner diameter in m";
    parameter Real D_o_wall=0.024 "outer diameter of wall in m";
    parameter Real D_o_iso=0.064 "outer diameter of insulation in m";
    parameter Real lambda_wall=393 "heat conductivity of wall in W/(m*K)";
    parameter Real rho_wall=5000 "density of wall in kg/m^3";
    parameter Real c_wall=1000 "specific heat capacity of wall in J/(kg*K)";
    parameter Real lambda_iso=1 "heat conductivity of insulation in W/(m*K)";
    parameter Real rho_iso=100 "density of insulation in kg/m^3";
    parameter Real c_iso=1000 "specific heat capacity of isolation in J/(kg*K)";
    parameter Real T0_water=10 "start temperature of water in °C";
    parameter Real T0_wall=10 "start temperature of wall in °C";
    parameter Real T0_iso=10 "start temperature of isolation in °C";
    parameter SIunits.CoefficientOfHeatTransfer alphawall=2;
    Base.Converter Converter1 annotation (extent=[-10, 38; 10, 58]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Line(points=[-118, 6; -92, 6; -104, 10; -92, 6; -104, 0]),
        Line(points=[-120, -22; -94, -22; -106, -18; -94, -22; -106, -28]),
        Line(points=[96, 24; 122, 24; 110, 28; 122, 24; 110, 18]),
        Line(points=[96, 6; 122, 6; 110, 10; 122, 6; 110, 0]),
        Line(points=[96, -14; 122, -14; 110, -10; 122, -14; 110, -20])),
      Icon(
        Line(points=[46, 44; 46, -34], style(pattern=2)),
        Line(points=[68, 44; 68, -34], style(pattern=2)),
        Line(points=[-40, 44; -40, -34], style(pattern=2)),
        Line(points=[-62, 44; -62, -34], style(pattern=2)),
        Rectangle(extent=[-86, 90; 88, 52], style(
            color=9,
            fillColor=7,
            fillPattern=8)),
        Rectangle(extent=[-86, 52; 88, 44], style(thickness=2, fillColor=0)),
        Rectangle(extent=[-86, 44; 88, -36], style(thickness=2)),
        Rectangle(extent=[-86, -34; 88, -46], style(thickness=2, fillColor=0)),
        Rectangle(extent=[-86, -46; 88, -82], style(
            color=9,
            fillColor=7,
            fillPattern=8)),
        Line(points=[-52, -22; -52, -76; -44, -62; -52, -76; -58, -62], style(
            color=85,
            fillColor=7,
            fillPattern=8)),
        Line(points=[0, -22.5; 0, -76.5; 8, -62.5; 0, -76.5; -6, -62.5], style(
            color=85,
            fillColor=7,
            fillPattern=8)),
        Line(points=[56, -22; 56, -76; 64, -62; 56, -76; 50, -62], style(
            color=85,
            fillColor=7,
            fillPattern=8)),
        Line(points=[58, 28; 58, 78; 52, 64; 58, 78; 64, 64], style(color=85)),
        Line(points=[-52, 28.5; -52, 78.5; -58, 64.5; -52, 78.5; -46, 64.5],
            style(color=85)),
        Text(extent=[54, 28; -42, -12], string="n = %n"),
        Text(
          extent=[0, -86; 0, -118],
          string="L = %l m",
          style(color=0, pattern=0)),
        Line(points=[0, 26.5; 0, 76.5; -6, 62.5; 0, 76.5; 6, 62.5], style(color=
               85)),
        Line(points=[-122, 6; -90, 6; -106, 18; -90, 6; -108, -8], style(color=
                0)),
        Line(points=[92, 4; 124, 4; 108, 16; 124, 4; 106, -10], style(color=0)),
        Line(points=[-14, 44; -14, -34], style(pattern=2)),
        Line(points=[16, 44; 16, -34], style(pattern=2))),
      Window(
        x=0.08,
        y=0.36,
        width=0.8,
        height=0.58));

    Base.pipe_elem_wall_iso PEWI[n](
      L=fill(l/n, n),
      D=fill(D, n),
      D_o_wall=fill(D_o_wall, n),
      lambda_wall=fill(lambda_wall, n),
      rho_wall=fill(rho_wall, n),
      c_wall=fill(c_wall, n),
      D_o_iso=fill(D_o_iso, n),
      lambda_iso=fill(lambda_iso, n),
      rho_iso=fill(rho_iso, n),
      c_iso=fill(c_iso, n),
      T0_water=fill(T0_water, n),
      T0_wall=fill(T0_wall, n),
      T0_iso=fill(T0_iso, n)) annotation (extent=[-33, -35; 37, 35]);
    Cuts.ThermoFlow In annotation (extent=[-124, 40; -88, -32]);
    Cuts.ThermoFlow Out annotation (extent=[90, 40; 124, -32]);
    Building.Sources.FixedTemp FixedTemp1(T0=27, Ts=Ta)
      annotation (extent=[-8, 104; 12, 84]);
    Building.Elements.heattrans heattrans_upside(alpha=alphawall, A=Constants.
          pi*l*D_o_iso) annotation (extent=[-14, 60; 12, 80], rotation=-90);
  equation
    connect(heattrans_upside.therm2, Converter1.Out)
      annotation (points=[-2, 60; -2, 54]);
    connect(heattrans_upside.therm1, FixedTemp1.therm1)
      annotation (points=[-2, 80; -2, 83; 2, 83; 2, 86]);
    connect(In, PEWI[1].In);
    connect(Out, PEWI[n].Out);
    for i in 1:(n - 1) loop
      connect(PEWI[i].Out, PEWI[i + 1].In);
    end for;

    for i in 1:n loop
      connect(PEWI[i].Out_heat, Converter1.In);
    end for;
  end losspipe_long;

  class pump
    parameter Real p0=0 "reference pressure (IN.p) in Pa";
    parameter Real p=10 "pressure drop in Pa";
    Cuts.ThermoFlow IN annotation (extent=[-8, -86; 20, -114], layer="icon");
    Cuts.ThermoFlow OUT annotation (extent=[-14, 114; 14, 86], layer="icon");
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Ellipse(extent=[-76, 82; 80, -78], style(color=0, fillColor=7)),
        Polygon(points=[0, 82; -58, -48; 62, -48; 0, 82], style(color=0,
              fillColor=0)),
        Text(
          extent=[-172, 32; -116, -22],
          string="%p Pa",
          style(color=0)),
        Line(points=[-98, 90; -98, -88], style(color=0, arrow=1))),
      Window(
        x=0.26,
        y=0.39,
        width=0.6,
        height=0.6));
  equation

    // IN.i = -OUT.i;
    OUT.p - IN.p = p;
    IN.p = p0;
    OUT.T = IN.T;
  end pump;

  class pump_controlled
    parameter Real p0=0 "reference pressure (IN.p) in Pa";
    parameter Real p=100
      "max. pressure drop in Pa (and default value if not controlled)";
    parameter Boolean fixed_potential=true "fixed potential? (true/false)";
    constant Real offset_p=10 "pressure offset in Pa";
    annotation (
      Coordsys(
        extent=[-154, -152; 150, 128],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Ellipse(extent=[-76, 82; 80, -78], style(color=0, fillColor=7)),
        Polygon(points=[0, 82; -58, -48; 62, -48; 0, 82], style(color=0,
              fillColor=0)),
        Text(
          extent=[-154, 92; -60, 52],
          string="pressure",
          style(color=73, pattern=0)),
        Text(
          extent=[-100, -42; -16, -80],
          string="fixed p",
          style(color=41)),
        Text(
          extent=[-20, -58; 6, -88],
          string="0",
          style(color=41)),
        Text(
          extent=[8, -42; 84, -84],
          string="= %fixed_potential",
          style(color=41)),
        Text(extent=[-154, 60; -72, 28], string="control"),
        Line(points=[106, 90; 106, -82], style(color=0, fillColor=7)),
        Line(points=[98, -64; 106, -84; 114, -64], style(color=0, fillColor=7)),
        Text(
          extent=[58, -84; 116, -116],
          string="max.",
          style(color=0)),
        Text(
          extent=[44, -114; 150, -158],
          string="%p Pa",
          style(color=0)),
        Text(extent=[-158, -12; -88, -44], string="0...1")),
      Window(
        x=0.12,
        y=0.03,
        width=0.81,
        height=0.9));

    Cuts.ThermoFlow IN annotation (extent=[-10, -84; 18, -112], layer="icon");
    Cuts.ThermoFlow OUT annotation (extent=[-16, 116; 12, 88], layer="icon");
    Modelica.Blocks.Interfaces.InPort InPort1
      annotation (extent=[-112, -14; -78, 26], layer="icon");
  equation

    if fixed_potential then
      IN.p = p0;
    end if;

    if not fixed_potential then
      IN.i = -OUT.i;
    end if;

    if cardinality(InPort1) == 0 then
      InPort1.signal[1] = 1;
    end if;

    OUT.p - IN.p = p*InPort1.signal[1] + offset_p;

    OUT.T = IN.T;
  end pump_controlled;

  class BoilerFF
    parameter Real P=50000 "Max. heating power of boiler in W";
    parameter Real T0=16 "Initial temperature in °C";
    parameter Real K=0.45
      "K value of the boiler, describes energy loss in W/(m^2*K)";
    parameter Real Tmax=95 "Max. temperature in °C";
    parameter Real Hys=5 "Hysteresis of temp. control in °C";
    parameter Real A=2.0 "Surface of boiler in m^2";
    parameter Real V=0.2 "Volume of water in boiler in m^3";
    parameter Real rho=1000 "Density of fluid (water) in boiler in kg/(m^3)";
    parameter Real c=4190 "Specific heat capacity of fluid (water) in J/(kg*K)";
    Real T(start=T0) "Actual water temperature in boiler in °C";
    Real P_controlled;
    Real T_max;
    Real H;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram,
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
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-8, -68; -10, -58; -4, -50; -8, -40; 6, -52; 6, -62; 0,
               -70; -6, -70; -8, -68], style(
            color=6,
            gradient=3,
            fillColor=45,
            fillPattern=1)),
        Rectangle(extent=[-30, -70; 24, -78], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-62, 20; -74, -2], style(
            gradient=2,
            fillColor=73,
            fillPattern=1)),
        Rectangle(extent=[-70, -80; 70, -100], style(
            color=0,
            gradient=3,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[74, 30; 84, -12], style(
            color=0,
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-74, 28; -84, -12], style(
            gradient=2,
            fillColor=73,
            fillPattern=1)),
        Line(points=[-80, -50; -30, -72], style(color=6, pattern=3)),
        Rectangle(extent=[-80, 100; 80, 96], style(
            gradient=1,
            fillColor=10,
            fillPattern=1)),
        Rectangle(extent=[-64, 20; -44, -2], style(
            gradient=2,
            fillColor=73,
            fillPattern=1)),
        Rectangle(extent=[74, 20; 68, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-24, 84; 16, 84], style(color=1)),
        Line(points=[-24, 76; 16, 76], style(color=1)),
        Line(points=[-24, 92; 16, 92], style(color=1)),
        Line(points=[-24, 68; 16, 68], style(color=1)),
        Line(points=[-128, 52; -100, 52; -112, 60; -100, 52; -114, 44], style(
              thickness=2)),
        Line(points=[98, 52; 126, 52; 114, 60; 126, 52; 112, 44], style(
              thickness=2)),
        Rectangle(extent=[-44, 52; 46, -40], style(color=0, thickness=4)),
        Polygon(points=[-42, 38; -34, 44; -24, 40; -16, 38; -10, 40; -4, 42; 4,
               44; 12, 42; 24, 38; 28, 40; 36, 44; 42, 42; 44, 34; 44, -38; -42,
               -38; -42, 38; -42, 38], style(gradient=1, fillColor=73)),
        Line(points=[24, 18; 28, 12; 26, 4; 24, -2; 26, -12; 26, -10; 26, -20;
              24, -26; 26, -32], style(color=85, fillColor=45)),
        Line(points=[8, 20; 12, 14; 10, 6; 8, 0; 10, -10; 10, -8; 10, -18; 8, -24;
               10, -30], style(color=85, fillColor=45)),
        Line(points=[-12, 20; -8, 14; -10, 6; -12, 0; -10, -10; -10, -8; -10, -18;
               -12, -24; -10, -30], style(color=85, fillColor=45)),
        Line(points=[-32, 22; -28, 16; -30, 8; -32, 2; -30, -8; -30, -6; -30, -16;
               -32, -22; -30, -28], style(color=85, fillColor=45)),
        Line(points=[34, 0; 80, -54], style(color=49, pattern=3)),
        Text(
          extent=[18, -38; 42, -74],
          string="P",
          style(color=49, fillColor=45)),
        Rectangle(extent=[46, 20; 70, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Text(
          extent=[84, -66; 108, -90],
          string="T",
          style(color=41)),
        Text(extent=[-124, -64; -90, -84], string="0...1")),
      Window(
        x=0.11,
        y=0.03,
        width=0.86,
        height=0.9));
    Modelica.Blocks.Interfaces.InPort InPort1
      annotation (extent=[-100, -60; -80, -40], layer="icon");
    Modelica.Blocks.Interfaces.OutPort OutPort1
      annotation (extent=[80, -64; 100, -44], layer="icon");
    Cuts.therm therm1 annotation (extent=[-24, 98; 14, 122], layer="icon");
    Cuts.ThermoFlow IN annotation (extent=[-112, 26; -80, -8]);
    Cuts.ThermoFlow OUT annotation (extent=[80, 26; 112, -8]);
  equation
    IN.i = -OUT.i;
    IN.p = OUT.p;
    OUT.T = T;

    T_max = Tmax;
    H = Hys;

    P_controlled = if (T >= T_max - H and der(T) < 0) then 0 else if (T > T_max) then
            0 else InPort1.signal[1]*P;

    c*IN.i*(OUT.T - IN.T) + c*rho*V*der(T) = therm1.j + P_controlled;

    therm1.j = A*K*(therm1.T - T);

    OutPort1.signal[1] = T;

  end BoilerFF;

  class Valve3W
    parameter Real G=0.01 "lam. massflow conductance in kg(s*Pa)";
    Real mix;
    annotation (
      Coordsys(
        extent=[-113, -101; 70, 109],
        grid=[1, 1],
        component=[20, 20]),
      Diagram,
      Icon(
        Ellipse(extent=[-58, 66; 63, -52], style(gradient=3, fillColor=10)),
        Ellipse(extent=[-44, 52; 48, -38], style(color=69, fillColor=69)),
        Polygon(points=[-38, -14; 39, 35; 43, 30; -34, -20; -38, -14], style(
              pattern=0, fillColor=0)),
        Ellipse(extent=[-8, 18; 10, 0], style(color=0, fillColor=0)),
        Polygon(points=[16, 64; 10, 52; 14, 50; 24, 46; 30, 42; 42, 54; 16, 64],
             style(color=69, fillColor=69)),
        Rectangle(extent=[10, 82; 41, 52], style(color=69, fillColor=69)),
        Rectangle(extent=[8, -38; 39, -70], style(color=69, fillColor=69)),
        Polygon(points=[10, -38; 43, -38; 32, -26; 28, -28; 24, -30; 22, -34;
              16, -36; 10, -38], style(color=69, fillColor=69)),
        Rectangle(extent=[-84, 26; -40, -10], style(color=69, fillColor=69)),
        Rectangle(extent=[-84, 26; -40, 22], style(
            color=0,
            gradient=2,
            fillColor=10)),
        Rectangle(extent=[-84, -6; -41, -10], style(
            color=0,
            gradient=2,
            fillColor=10)),
        Polygon(points=[-88, -45; -83, -42; -41, -93; -46, -96; -88, -45],
            style(
            color=8,
            pattern=0,
            fillPattern=0)),
        Line(points=[-28, 41; 36, -23; 33, -27; -32, 38; -28, 41], style(color=
                0, pattern=3)),
        Polygon(points=[-38, -14; 36, 34; 40, 28; -34, -20; -38, -14], style(
              pattern=0, fillColor=0)),
        Rectangle(extent=[8, -38; 13, -69], style(
            color=10,
            gradient=1,
            fillColor=10)),
        Rectangle(extent=[8, 82; 12, 53], style(
            color=10,
            gradient=1,
            fillColor=10)),
        Line(points=[-113, 42; -82, 42; -95, 47; -82, 42; -96, 37]),
        Line(points=[-87, -85; -52, -85; 2, -24; 2, 9], style(color=41, pattern=
               3)),
        Rectangle(extent=[38, 82; 44, 49], style(
            color=10,
            gradient=1,
            fillColor=10)),
        Rectangle(extent=[36, -30; 42, -69], style(
            color=10,
            gradient=1,
            fillColor=10)),
        Line(points=[64, 80; 64, 109; 57, 99; 64, 109; 70, 98]),
        Line(points=[62, -71; 62, -100; 55, -89; 62, -101; 70, -89]),
        Line(points=[17, 26; 15, 30; 11, 34; 6, 37; 0, 39; -9, 39], style(color=
               0)),
        Line(points=[-3, 44; -11, 39; -1, 33], style(color=0)),
        Text(extent=[-125, -43; -87, -67], string="0...1")),
      Window(
        x=0.2,
        y=0.01,
        width=0.79,
        height=0.65));
    Cuts.ThermoFlow IN annotation (extent=[-115, -9; -85, 25]);
    Cuts.ThermoFlow OUT1 annotation (extent=[11, 81; 43, 110]);
    Cuts.ThermoFlow OUT2 annotation (extent=[9, -100; 40, -70]);
    Modelica.Blocks.Interfaces.InPort InPort1(final n=1)
      annotation (extent=[-113, -101; -88, -72], layer="icon");
  equation

    mix = if InPort1.signal[1] < 0.001 then 0.001 else if InPort1.signal[1] >
      0.999 then 0.999 else InPort1.signal[1];

    OUT1.i = if noEvent(IN.p - OUT1.p >= 0) then -(IN.p - OUT1.p)*mix^2*G else
      0;
    OUT2.i = if noEvent(IN.p - OUT2.p >= 0) then -(IN.p - OUT2.p)*(1 - mix^2)*G else
            0;

    IN.i + OUT1.i + OUT2.i = 0;

    OUT1.T = IN.T;
    OUT2.T = IN.T;
  end Valve3W;

  class radiator_with_bypass
    parameter Real surface=5 "Surface in m^2";
    parameter Real epsilon=0.94 "Emission coefficient";
    parameter Real alpha=4
      "coefficient of convective heat transfer in W/(K*m^2)";
    parameter Real d_in=0.02 "inner pipe diameter in m";
    parameter Real d_out=0.023 "outer pipe diameter in m";
    parameter Real L=5 "length of pipe in m";
    parameter Real C=1000 "heat capacity per meter in J/(K*m)";
    parameter Real lambda=500 "heat conductivity in W/(K*m)";
    parameter Real T0=10 "start temperature";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Text(extent=[-116, 114; -64, 90], string="Air"),
        Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
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
        Rectangle(extent=[-60, 80; -40, -80], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-36, 80; -16, -80], style(
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
            fillPattern=1)),
        Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
        Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
        Rectangle(extent=[-78, 78; 78, -78]),
        Rectangle(extent=[-80, 86; 80, -82], style(
            color=7,
            fillColor=69,
            fillPattern=1)),
        Rectangle(extent=[-52, -32; 80, -62], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-76, 62; 54, 34], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 80; -40, -80], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-36, 80; -16, -80], style(
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
        Ellipse(extent=[70, -32; 88, -62], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-88, 62; -68, 34], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Text(
          extent=[82, 116; 160, 88],
          string="Radiation",
          style(color=45, fillColor=45)),
        Text(extent=[-62, -86; 60, -112], string="%name"),
        Line(points=[-126, 14; -92, 14; -106, 22; -92, 14; -108, 6]),
        Line(points=[90, -80; 124, -80; 110, -72; 124, -80; 108, -88]),
        Text(
          extent=[-130, -82; -82, -104],
          string="Valve",
          style(color=41)),
        Line(points=[-86, -62; -68, -62; -68, 24], style(color=41, pattern=3)),
        Polygon(points=[-88, 62; -88, 36; -50, 62; -50, 38; -88, 62], style(
              color=0, fillColor=0)),
        Line(points=[-68, 50; -68, 32], style(pattern=0)),
        Line(points=[-92, -8; -92, -28], style(pattern=0)),
        Line(points=[-68, 48; -68, 32], style(color=0)),
        Ellipse(extent=[-74, 34; -60, 22], style(color=0)),
        Text(
          extent=[-128, -100; -88, -124],
          string="(0...1)",
          style(color=41))),
      Window(
        x=0.27,
        y=0.19,
        width=0.6,
        height=0.6),
      Diagram);

    Modelica.Blocks.Interfaces.InPort InPort1
      annotation (extent=[-116, -80; -86, -42], layer="icon");
    Cuts.therm therm1 annotation (extent=[-62, 84; -18, 120], layer="icon");
    Cuts.therm therm2 annotation (extent=[26, 84; 68, 120], layer="icon");
    Base.radiator radiator1(
      surface=surface,
      epsilon=epsilon,
      alpha=alpha,
      d_in=d_in,
      d_out=d_out,
      L=L,
      C=C,
      lambda=lambda,
      T0=T0) annotation (extent=[-2, -10; 100, 74]);
    Cuts.ThermoFlow IN annotation (extent=[-114, 30; -80, 64]);
    Cuts.ThermoFlow OUT annotation (extent=[80, -62; 114, -28]);
    Valve3W Valve3W1 annotation (extent=[-68, 10; -22, 58]);
    Base.pipe_elem bypass_pipe(
      D=d_in,
      L=L,
      T0=T0) annotation (extent=[-38, -84; 10, -40]);
    Base.TMixer TMixer1 annotation (extent=[24, -72; 66, -28]);
  equation
    connect(therm1, radiator1.therm1)
      annotation (points=[-24, 90; -2.565, 90; -2.565, 72; 18.87, 72]);
    connect(IN, Valve3W1.IN) annotation (points=[-84, 36; -68, 36]);
    connect(Valve3W1.OUT1, radiator1.IN) annotation (points=[-32.8087, 54.9143;
           -19.4044, 54.9143; -19.4044, 50; -6, 50]);
    connect(therm2, radiator1.therm2)
      annotation (points=[52, 90; 52, 74; 74, 74]);
    connect(TMixer1.OUT, OUT) annotation (points=[68, -48; 82, -48]);
    connect(radiator1.OUT, TMixer1.IN1) annotation (points=[97.96, 12; 126, 12;
           126, -18; 12, -18; 12, -38; 24, -38]);
    connect(bypass_pipe.OUT, TMixer1.IN2)
      annotation (points=[12, -62; 24, -62]);
    connect(Valve3W1.OUT2, bypass_pipe.IN) annotation (points=[-33.4372,
          13.6571; -10, 13.6571; -10, -36; -54, -36; -54, -62; -40, -62]);
    connect(InPort1, Valve3W1.InPort1)
      annotation (points=[-90, -62; -78, -62; -78, 14; -68, 14]);
  end radiator_with_bypass;

  class RadiatorCurve_with_bypass
    parameter Real surface=5 "Surface in m^2";
    parameter Real epsilon=0.94 "Emission coefficient";
    parameter Real alpha=4 "convective heat transfer coefficient in W/(K*m^2)";
    parameter Real Cf=0.08 "inner circumference of pipe in m";
    parameter Real d_out=0.023 "outer pipe diameter in m (approximation)";
    parameter Real Acs=0.0004
      "cross-section area of pipe in m^2 (if cross-section is not a circle)";
    parameter Real L=5 "length of pipe in m";
    parameter Real C=1000 "abs. heat capacity per meter in J/(K*m)";
    parameter Real lambda=500 "heat conductivity in W/(K*m)";
    parameter Real T0=10 "start temperature";
    parameter Real P[4]={100,200,300,400}
      "pressure values of v, p-curve in Pa (P[4] should be max. pressure drop.)";
    parameter Real V[4]={0.1,0.141,0.173,0.2}
      "velocities at pressure values in m/s";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Text(extent=[-116, 114; -64, 90], string="Air"),
        Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
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
        Rectangle(extent=[-60, 80; -40, -80], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-36, 80; -16, -80], style(
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
            fillPattern=1)),
        Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
        Rectangle(extent=[-80, 80; 60, -80], style(color=0)),
        Rectangle(extent=[-78, 78; 78, -78]),
        Rectangle(extent=[-80, 86; 80, -82], style(
            color=7,
            fillColor=69,
            fillPattern=1)),
        Rectangle(extent=[-52, -32; 80, -62], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-76, 62; 54, 34], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-60, 80; -40, -80], style(
            gradient=1,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-36, 80; -16, -80], style(
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
        Ellipse(extent=[70, -32; 88, -62], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-88, 62; -68, 34], style(
            gradient=3,
            fillColor=8,
            fillPattern=1)),
        Text(
          extent=[82, 116; 160, 88],
          string="Radiation",
          style(color=45, fillColor=45)),
        Text(extent=[-62, -86; 60, -112], string="%name"),
        Line(points=[-126, 14; -92, 14; -106, 22; -92, 14; -108, 6]),
        Line(points=[90, -80; 124, -80; 110, -72; 124, -80; 108, -88]),
        Line(points=[-86, -62; -68, -62; -68, 24], style(color=41, pattern=3)),
        Polygon(points=[-88, 62; -88, 36; -50, 62; -50, 38; -88, 62], style(
              color=0, fillColor=0)),
        Line(points=[-68, 50; -68, 32], style(pattern=0)),
        Line(points=[-92, -8; -92, -28], style(pattern=0)),
        Line(points=[-68, 48; -68, 32], style(color=0)),
        Ellipse(extent=[-74, 34; -60, 22], style(color=0)),
        Line(points=[34, -2; 34, -8], style(color=0)),
        Line(points=[10, -2; 10, -8], style(color=0)),
        Line(points=[-10, -2; -10, -8], style(color=0, pattern=3)),
        Line(points=[-2, 6; 4, 6], style(color=0)),
        Line(points=[-2, -26; 4, -26], style(color=0, pattern=3)),
        Line(points=[-2, -32; 4, -32], style(color=0, pattern=3)),
        Text(
          extent=[46, -10; 64, -26],
          string="p",
          style(color=0)),
        Line(points=[46, -24; 46, -30], style(color=0)),
        Line(points=[34, -24; 34, -30], style(color=0)),
        Line(points=[22, -24; 22, -30], style(color=0)),
        Line(points=[10, -24; 10, -30], style(color=0)),
        Line(points=[-62, -26; 56, -26], style(color=0)),
        Line(points=[-10, -24; -10, -30], style(color=0, pattern=3)),
        Line(points=[-24, -24; -24, -30], style(color=0, pattern=3)),
        Line(points=[-38, -24; -38, -30], style(color=0, pattern=3)),
        Line(points=[-50, -24; -50, -30], style(color=0, pattern=3)),
        Line(points=[-4, 10; 0, 16; 4, 10], style(color=0)),
        Line(points=[0, 12; 0, -62], style(color=0)),
        Line(points=[-2, 6; 4, 6], style(color=0)),
        Line(points=[-2, 2; 4, 2], style(color=0)),
        Line(points=[-2, -4; 4, -4], style(color=0)),
        Line(points=[-2, -16; 4, -16], style(color=0)),
        Line(points=[-2, -36; 4, -36], style(color=0, pattern=3)),
        Line(points=[-2, -48; 4, -48], style(color=0, pattern=3)),
        Line(points=[-2, -54; 4, -54], style(color=0, pattern=3)),
        Line(points=[52, -22; 60, -26; 52, -30], style(color=0)),
        Text(
          extent=[42, -36; 60, -52],
          string="p",
          style(color=0)),
        Text(
          extent=[-32, 24; -16, 6],
          string="v",
          style(color=0)),
        Text(
          extent=[-38, 72; 60, 52],
          string="Characteristic",
          style(color=0)),
        Line(points=[-58, -56; -48, -56; -36, -52; -22, -46; -8, -34; 12, -14;
              26, -2; 38, 6; 50, 10; 58, 10], style(color=0)),
        Text(
          extent=[-130, -82; -82, -104],
          string="Valve",
          style(color=41)),
        Text(
          extent=[-124, -102; -90, -122],
          string="(0...1)",
          style(color=41)),
        Text(
          extent=[-130, -82; -82, -104],
          string="Valve",
          style(color=41)),
        Text(
          extent=[-128, -98; -86, -124],
          string="(0...1)",
          style(color=41)),
        Text(
          extent=[-32, 56; 44, 24],
          string="curve",
          style(color=0, pattern=0))),
      Window(
        x=0.14,
        y=0.04,
        width=0.82,
        height=0.6),
      Diagram);

    Modelica.Blocks.Interfaces.InPort InPort1
      annotation (extent=[-116, -80; -86, -42], layer="icon");
    Cuts.therm therm1 annotation (extent=[-62, 84; -18, 120], layer="icon");
    Cuts.therm therm2 annotation (extent=[26, 84; 68, 120], layer="icon");
    Base.RadiatorCurve radiator1(
      surface=surface,
      epsilon=epsilon,
      alpha=alpha,
      Cf=Cf,
      d_out=d_out,
      Acs=Acs,
      L=L,
      C=C,
      lambda=lambda,
      T0=T0,
      P=P,
      V=V) annotation (extent=[-2, -10; 100, 74]);
    Cuts.ThermoFlow IN annotation (extent=[-114, 30; -80, 64]);
    Cuts.ThermoFlow OUT annotation (extent=[80, -62; 114, -28]);
    Valve3W Valve3W1(G=0.001) annotation (extent=[-68, 10; -22, 58]);
    Base.PipeCurve bypass_pipe(
      Acs=Acs,
      Cf=Cf,
      L=L,
      T0=T0,
      P=P,
      V=V) annotation (extent=[-38, -90; 10, -46]);
    Base.TMixer TMixer1 annotation (extent=[24, -72; 66, -28]);
  equation
    connect(therm1, radiator1.therm1)
      annotation (points=[-24, 90; -2.565, 90; -2.565, 72; 18.87, 72]);
    connect(IN, Valve3W1.IN) annotation (points=[-84, 36; -68, 36]);
    connect(therm2, radiator1.therm2)
      annotation (points=[52, 90; 52, 74; 74, 74]);
    connect(TMixer1.OUT, OUT) annotation (points=[68, -48; 82, -48]);
    connect(Valve3W1.OUT2, bypass_pipe.IN) annotation (points=[-33.4372,
          13.6571; -10, 13.6571; -10, -36; -54, -36; -54, -60.2637; -40, -60.2637]);
    connect(InPort1, Valve3W1.InPort1)
      annotation (points=[-90, -62; -78, -62; -78, 14; -68, 14]);
    connect(radiator1.OUT, TMixer1.IN1) annotation (points=[104, 14; 122, 14;
          122, -16; 16, -16; 16, -40; 26, -40]);
    connect(bypass_pipe.OUT, TMixer1.IN2)
      annotation (points=[10, -60; 26, -60]);
    connect(Valve3W1.OUT1, radiator1.IN) annotation (points=[-32, 56; -6, 56]);
  end RadiatorCurve_with_bypass;

  class FourWayMixer
    parameter Real G=1 "lam. massflow conductance in kg/(s*Pa)";
    Real i11;
    Real i12;
    Real i21;
    Real i22;
    Real mix;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.29,
        y=0.02,
        width=0.7,
        height=0.71),
      Icon(
        Rectangle(extent=[-84, 78; 82, -82]),
        Line(points=[-130, 32; -102, 32; -114, 40; -102, 32; -116, 24], style(
              thickness=2)),
        Line(points=[128, 32; 100, 32; 114, 40; 100, 32; 114, 24], style(
              thickness=2)),
        Line(points=[-46, 90; -46, 114; -54, 102; -46, 114; -38, 102], style(
              thickness=2)),
        Line(points=[-40, -96; -40, -120; -48, -110; -40, -120; -32, -110],
            style(thickness=2)),
        Text(extent=[-120, -32; -96, -58], string="1"),
        Text(extent=[26, -96; 50, -124], string="1"),
        Text(extent=[30, 116; 54, 90], string="2"),
        Text(extent=[98, -32; 118, -58], string="2"),
        Rectangle(extent=[-82, 76; 78, -80], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-52, 50; 48, -50], style(
            gradient=3,
            fillColor=3,
            fillPattern=1)),
        Rectangle(extent=[-12, 48; 8, 24], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[-52, 8; -28, -12], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[-12, -24; 8, -52], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[24, 8; 48, -12], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Ellipse(extent=[-32, 28; 28, -32], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[-14, 78; 10, 46], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-26, 78; 20, 72], style(
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[42, 10; 76, -14], style(
            gradient=2,
            fillColor=71,
            fillPattern=1)),
        Rectangle(extent=[72, 22; 80, -24], style(
            gradient=2,
            fillColor=71,
            fillPattern=1)),
        Rectangle(extent=[-14, -46; 10, -80], style(
            gradient=1,
            fillColor=71,
            fillPattern=1)),
        Rectangle(extent=[-24, -74; 22, -80], style(
            gradient=1,
            fillColor=71,
            fillPattern=1)),
        Rectangle(extent=[-80, 12; -44, -14], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-84, 22; -78, -24], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-22, 16; 18, -20], style(
            color=0,
            thickness=2,
            fillColor=75)),
        Line(points=[-22, -20; 18, 18], style(
            color=0,
            pattern=3,
            thickness=1,
            arrow=0)),
        Line(points=[-82, 70; -52, 70; -22, 16], style(color=41, pattern=2)),
        Ellipse(extent=[-6, 2; 2, -6], style(color=0, fillColor=0))),
      Diagram(
        Line(points=[-74, -4; -12, -76], style(arrow=1)),
        Line(points=[78, -6; 14, -74], style(arrow=1)),
        Line(points=[-74, 4; -10, 70], style(arrow=1)),
        Line(points=[78, 6; 10, 70], style(arrow=1))));
    Cuts.ThermoFlow In1 annotation (extent=[-118, 16; -86, -18]);
    Cuts.ThermoFlow In2 annotation (extent=[82, 14; 112, -18]);
    Cuts.ThermoFlow Out1 annotation (extent=[-16, -82; 16, -112]);
    Cuts.ThermoFlow Out2 annotation (extent=[-22, 110; 14, 78]);
    Modelica.Blocks.Interfaces.InPort InPort1
      annotation (extent=[-116, 52; -84, 88]);
  equation

    mix = if InPort1.signal[1] > 1 then 1 else if InPort1.signal[1] < 0.001 then
            0.001 else InPort1.signal[1];

    //In1.i + In2.i + Out1.i + Out2.i = 0;

    i11 = if In1.p - Out1.p > 0 then (1 - mix)*G*(In1.p - Out1.p) else 0;
    i12 = if In1.p - Out2.p > 0 then mix*G*(In1.p - Out2.p) else 0;
    i11 + i12 = In1.i;

    i22 = if In2.p - Out2.p > 0 then (1 - mix)*G*(In2.p - Out2.p) else 0;
    i21 = if In2.p - Out1.p > 0 then mix*G*(In2.p - Out1.p) else 0;
    i22 + i21 = In2.i;

    Out1.i = -(i11 + i21);
    Out2.i = -(i12 + i22);

    Out1.T = if i11 + i21 > 0 then (i11*In1.T + i21*In2.T)/(i11 + i21) else 0;
    Out2.T = if i12 + i22 > 0 then (i12*In1.T + i22*In2.T)/(i12 + i22) else 0;

  end FourWayMixer;

  model Floorheating
    constant Real pi=3.1415927;
    parameter SIunits.Length Lpipe=0.02 "Length of pipe";
    parameter SIunits.Diameter dI=0.02 "Inner diameter of pipe";
    parameter SIunits.Diameter dO=0.023 "Outer diameter of pipe";
    parameter SIunits.Temp_C T0pipe=16 "Initial temperature of pipe";
    parameter Modelica.SIunits.CelsiusTemperature T0Screed=16
      "Initial temperature of pipe";
    parameter SIunits.ThermalConductivity lambdaPipe=373
      "Heat conductivity of pipe";
    parameter SIunits.SpecificHeatCapacity cPipe=1000
      "Specific Heat Capacity of pipe";
    parameter SIunits.Density rhoPipe=1600 "Density of pipe";
    parameter SIunits.Area Ascreed=16 "Area of screed";
    parameter SIunits.Thickness dScreedHalf=0.1 "Half thickness of screed";
    parameter SIunits.ThermalConductivity lambdaScreed=2.4
      "Thermal conductivity of screed";
    parameter SIunits.Density rhoScreed=1600 "Density of screed";
    parameter SIunits.SpecificHeatCapacity cScreed=1000
      "Specific Heat Capacity of screed";
    annotation (
      Coordsys(
        extent=[-100, -106; 100, 104],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(
        Text(
          extent=[-10, 18; 42, 0],
          string="Pipe wall",
          style(color=41)),
        Text(
          extent=[-138, 68; -42, 52],
          string="Heat transfer pipe wall / floor ",
          style(color=41, fillColor=42)),
        Text(
          extent=[-40, -66; 38, -82],
          string="half layer of screed",
          style(fillColor=41))),
      Icon(
        Rectangle(extent=[-84, 96; 88, -96]),
        Line(points=[-120, -6; -82, -6; -94, 0; -94, -14; -82, -6]),
        Text(extent=[-84, 118; -28, 100], string="upside"),
        Text(extent=[-80, -96; -18, -122], string="underside"),
        Ellipse(extent=[-64, -64; -48, -84], style(color=10)),
        Ellipse(extent=[-24, -64; -8, -84], style(color=10)),
        Ellipse(extent=[18, -64; 34, -84], style(color=10)),
        Ellipse(extent=[-24, 42; -8, 20], style(color=10)),
        Ellipse(extent=[16, 42; 32, 20], style(color=10)),
        Ellipse(extent=[58, 42; 74, 20], style(color=10)),
        Line(points=[-64, -72; -24, 36], style(color=10)),
        Line(points=[-48, -76; -8, 32], style(color=10)),
        Line(points=[-24, -72; 16, 36], style(color=10)),
        Line(points=[-8, -78; 32, 30], style(color=10)),
        Line(points=[18, -72; 58, 36], style(color=10)),
        Line(points=[34, -80; 74, 28], style(color=10)),
        Text(extent=[-70, 82; 72, 58], string="Heated floor"),
        Line(points=[88, -4; 126, -4; 114, 2; 114, -12; 126, -4])),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65));
    Base.pipe_elem pipe_elem1(
      D=dO,
      L=Lpipe,
      T0=T0pipe) annotation (extent=[-58, -62; 6, -14]);
    Building.Elements.heattrans heattrans_upside(alpha=100000, A=pi*dO*Lpipe)
      annotation (extent=[-38, 56; -16, 68], rotation=-90);
    Base.Cond Cond1(
      d1=dI,
      d2=(dO + dI)/2,
      L=Lpipe,
      lambda=lambdaPipe) annotation (extent=[-16, 4; -36, -16]);
    Base.HeatStore HeatStore1(
      C=cPipe*rhoPipe*pi/4*(dO*dO - dI*dI),
      TO=T0pipe,
      L=Lpipe) annotation (extent=[-44, 0; -64, 20], rotation=-90);
    Base.Cond Cond2(
      d1=(dO + dI)/2,
      d2=dO,
      L=Lpipe,
      lambda=lambdaPipe) annotation (extent=[-36, 36; -16, 16]);
    Base.Converter Converter1 annotation (extent=[-36, 38; -16, 58]);
    Building.Layer.layer layer_underside(
      A=Ascreed,
      d=dScreedHalf,
      lambda=lambdaScreed,
      rho=rhoScreed,
      c=cScreed,
      T0=T0Screed) annotation (extent=[46, -84; 66, -64], rotation=-90);
    Building.therm therm_upside annotation (extent=[-22, 94; 24, 118]);
    Cuts.ThermoFlow OUT annotation (extent=[88, -22; 124, 14]);
    Cuts.ThermoFlow IN annotation (extent=[-120, -20; -84, 12]);
    Building.therm therm_underside annotation (extent=[-20, -120; 28, -94]);
  equation
    connect(Cond1.IN, pipe_elem1.H)
      annotation (points=[-26, -16.1; -26, -24], style(color=41));
    connect(HeatStore1.H, Cond1.OUT)
      annotation (points=[-43.9, 10; -26, 10; -26, 4.1], style(color=41));
    connect(Cond2.IN, Cond1.OUT)
      annotation (points=[-26, 16; -26, 4.1], style(color=41));
    connect(Converter1.In, Cond2.OUT)
      annotation (points=[-26, 42; -26, 36], style(color=41));
    connect(heattrans_upside.therm2, Converter1.Out)
      annotation (points=[-26, 56.6; -26, 54]);
    connect(pipe_elem1.OUT, OUT) annotation (points=[10, -38; 58.5, -38; 58.5,
          -6; 107, -6], style(color=73));
    connect(pipe_elem1.IN, IN)
      annotation (points=[-62, -38; -90, -38; -90, -4], style(color=73));
    connect(heattrans_upside.therm1, therm_upside)
      annotation (points=[-28, 67.4; -28, 98; 2, 98]);
    connect(heattrans_upside.therm1, layer_underside.therm1)
      annotation (points=[-26, 67.4; -26, 70; 56, 70; 56, -66]);
    connect(layer_underside.therm2, therm_underside)
      annotation (points=[56, -82; 56, -108; -8, -108]);
  end Floorheating;

  class Boiler2
    parameter Real T0=16 "Initial temperature in °C";
    parameter Real K=0.45 "K value of the boiler, describes energy loss in W/K";
    parameter Real Tmax=95 "Max. temperature in °C";
    parameter Real V=0.2 "Volume of water in boiler in m^3";
    parameter Real rho=1000 "Density of fluid (water) in boiler in kg/(m^3)";
    parameter Real c=4190 "Specific heat capacity of fluid (water) in J/(kg*K)";
    Real T(start=T0) "Actual water temperature in boiler in °C";
    annotation (
      Coordsys(
        extent=[-128, -100; 126, 110],
        grid=[2, 2],
        component=[20, 20]),
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
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-62, 20; -74, -2], style(
            gradient=2,
            fillColor=73,
            fillPattern=1)),
        Rectangle(extent=[-70, -80; 70, -100], style(
            color=0,
            gradient=3,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[74, 30; 84, -12], style(
            color=0,
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Rectangle(extent=[-74, 28; -84, -12], style(
            gradient=2,
            fillColor=73,
            fillPattern=1)),
        Rectangle(extent=[-80, 100; 80, 96], style(
            gradient=1,
            fillColor=10,
            fillPattern=1)),
        Rectangle(extent=[-64, 20; -44, -2], style(
            gradient=2,
            fillColor=73,
            fillPattern=1)),
        Rectangle(extent=[74, 20; 68, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-24, 84; 16, 84], style(color=1)),
        Line(points=[-24, 76; 16, 76], style(color=1)),
        Line(points=[-24, 92; 16, 92], style(color=1)),
        Line(points=[-24, 68; 16, 68], style(color=1)),
        Line(points=[-114, 50; -86, 50; -98, 58; -86, 50; -100, 42], style(
              thickness=2)),
        Line(points=[86, 52; 114, 52; 102, 60; 114, 52; 100, 44], style(
              thickness=2)),
        Rectangle(extent=[-44, 52; 46, -40], style(color=0, thickness=4)),
        Polygon(points=[-42, 38; -34, 44; -24, 40; -16, 38; -10, 40; -4, 42; 4,
               44; 12, 42; 24, 38; 28, 40; 36, 44; 42, 42; 44, 34; 44, -38; -42,
               -38; -42, 38; -42, 38], style(gradient=1, fillColor=73)),
        Line(points=[24, 18; 28, 12; 26, 4; 24, -2; 26, -12; 26, -10; 26, -20;
              24, -26; 26, -32], style(color=85, fillColor=45)),
        Line(points=[8, 20; 12, 14; 10, 6; 8, 0; 10, -10; 10, -8; 10, -18; 8, -24;
               10, -30], style(color=85, fillColor=45)),
        Line(points=[-12, 20; -8, 14; -10, 6; -12, 0; -10, -10; -10, -8; -10, -18;
               -12, -24; -10, -30], style(color=85, fillColor=45)),
        Line(points=[-32, 22; -28, 16; -30, 8; -32, 2; -30, -8; -30, -6; -30, -16;
               -32, -22; -30, -28], style(color=85, fillColor=45)),
        Line(points=[34, 0; 80, -54], style(color=49, pattern=3)),
        Rectangle(extent=[46, 20; 70, -2], style(
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Text(
          extent=[84, -66; 108, -90],
          string="T",
          style(color=41)),
        Line(points=[-80, -52; 0, -10], style(color=49)),
        Text(
          extent=[-10, -14; 16, -40],
          string="P",
          style(color=49))),
      Window(
        x=0.14,
        y=0.05,
        width=0.6,
        height=0.6));
    Modelica.Blocks.Interfaces.OutPort OutPort1
      annotation (extent=[80, -64; 100, -44], layer="icon");
    Cuts.therm thermloss annotation (extent=[-24, 98; 14, 122], layer="icon");
    Cuts.ThermoFlow IN annotation (extent=[-112, 26; -80, -8], layer="icon");
    Cuts.ThermoFlow OUT annotation (extent=[80, 26; 112, -8], layer="icon");
    Cuts.therm thermpower
      annotation (extent=[-100, -60; -78, -40], layer="icon");
  equation
    IN.i = -OUT.i;
    IN.p = OUT.p;
    OUT.T = T;

    c*IN.i*(OUT.T - IN.T) + c*rho*V*der(T) = thermloss.j + thermpower.j;

    thermloss.j = K*(thermloss.T - T);

    thermpower.T = T;
    OutPort1.signal[1] = T;
  end Boiler2;

  model onepipe "pipe with one lement and without insulation"
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
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram(Text(
          extent=[8, 16; 60, -2],
          string="Pipe wall",
          style(color=41))),
      Icon(
        Rectangle(extent=[-80, 50; 82, -38], style(gradient=2, fillColor=71)),
        Line(points=[-69, 6; 68, 6; 47, 14; 47, -3; 68, 6], style(color=73)),
        Text(extent=[-52, -46; 56, -68], string="onepipe"),
        Rectangle(extent=[-80, 50; 82, 40], style(color=10, fillColor=44)),
        Line(points=[2, 20; 2, 50; -4, 36; 2, 50; 8, 36], style(color=41)),
        Rectangle(extent=[-80, -28; 82, -38], style(color=10, fillColor=44))),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65));
    Base.pipe_elem pipe_elem1(
      D=dO,
      L=Lpipe,
      T0=T0pipe) annotation (extent=[-38, -98; 26, -50]);
    Base.Cond Cond1(
      d1=dI,
      d2=(dO + dI)/2,
      L=Lpipe,
      lambda=lambdaPipe) annotation (extent=[6, -34; -14, -54]);
    Base.HeatStore HeatStore1(
      C=cPipe*rhoPipe*pi/4*(dO*dO - dI*dI),
      TO=T0pipe,
      L=Lpipe) annotation (extent=[-18, -36; -38, -16], rotation=-90);
    Base.Cond Cond2(
      d1=(dO + dI)/2,
      d2=dO,
      L=Lpipe,
      lambda=lambdaPipe) annotation (extent=[-14, -2; 6, -22]);
    Base.Converter Converter1 annotation (extent=[-14, 2; 6, 22]);
    Building.Elements.heattrans heattrans_upside(alpha=100000, A=pi*dO*Lpipe)
      annotation (extent=[-16, 26; 6, 38], rotation=-90);
    Building.therm therm1 annotation (extent=[-20, 48; 22, 78]);
    Cuts.ThermoFlow Out annotation (extent=[82, -16; 114, 26]);
    Cuts.ThermoFlow In annotation (extent=[-112, -18; -80, 24]);
  equation
    connect(Cond1.IN, pipe_elem1.H)
      annotation (points=[-4, -54.1; -4, -60.32], style(color=41));
    connect(Converter1.Out, heattrans_upside.therm2)
      annotation (points=[-4, 18.1; -4, 26.6]);
    connect(pipe_elem1.OUT, Out)
      annotation (points=[28, -74; 66, -74; 66, 8; 104, 8], style(color=73));
    connect(pipe_elem1.IN, In) annotation (points=[-36.96, -74; -67.48, -74; -67.48,
           4; -98, 4], style(color=73));
    connect(heattrans_upside.therm1, therm1)
      annotation (points=[-4, 37.4; -4, 64]);
    connect(Cond2.IN, Cond1.OUT)
      annotation (points=[-4, -22; -4, -34], style(color=41));
    connect(HeatStore1.H, Cond2.IN)
      annotation (points=[-18, -26; -4, -26; -4, -22.1], style(color=41));
    connect(Converter1.In, Cond2.OUT)
      annotation (points=[-4, 6; -4, -1.9], style(color=41));
  end onepipe;

  model npipe "pipe with n elements and without insulation  "
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
    ATplus.Hvac.Heating.Advanced.onepipe PipeElement[n](
      Lpipe=fill(Lpipe/n, n),
      dI=fill(dI, n),
      dO=fill(dO, n),
      T0pipe=fill(T0pipe, n),
      lambdaPipe=fill(lambdaPipe, n),
      cPipe=fill(cPipe, n),
      rhoPipe=fill(rhoPipe, n)) annotation (extent=[-37, -49; 33, 21]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Diagram,
      Icon(
        Text(extent=[-44, -74; 48, -100], string="npipe"),
        Line(points=[80, -16; 110, -16; 98, -10; 98, -22; 110, -16]),
        Rectangle(extent=[-80, 34; 80, -54]),
        Rectangle(extent=[-66, 28; -10, 12], style(color=69, fillColor=71)),
        Rectangle(extent=[-28, -34; 28, -50], style(color=69, fillColor=71)),
        Rectangle(extent=[-28, 12; -10, -34], style(color=69, fillColor=71)),
        Rectangle(extent=[10, 12; 28, -34], style(color=69, fillColor=71)),
        Rectangle(extent=[48, 12; 66, -8], style(color=69, fillColor=71)),
        Rectangle(extent=[10, 28; 66, 12], style(color=69, fillColor=71)),
        Rectangle(extent=[48, -8; 80, -24], style(color=69, fillColor=71)),
        Rectangle(extent=[-66, 12; -48, -8], style(color=69, fillColor=71)),
        Rectangle(extent=[-80, -8; -48, -24], style(color=69, fillColor=71)),
        Line(points=[-54, 20; -24, 20; -36, 26; -36, 14; -24, 20]),
        Line(points=[26, 20; 56, 20; 44, 26; 44, 14; 56, 20]),
        Line(points=[-12, -42; 18, -42; 6, -36; 6, -48; 18, -42]),
        Line(points=[-110, -16; -80, -16; -92, -10; -92, -22; -80, -16])),
      Documentation(info="connect half layer of screed ontop of the pipes with therm_upside and
half layer of screed under the pipes with therm_underside
"),   Window(
        x=0.26,
        y=0.14,
        width=0.44,
        height=0.65));
    Cuts.ThermoFlow In annotation (extent=[-110, -24; -80, -8]);
    Building.therm therm_upside annotation (extent=[-18, 32; 18, 56]);
    Building.therm therm_underside annotation (extent=[-18, -76; 18, -52]);
    Cuts.ThermoFlow Out annotation (extent=[80, -24; 110, -8], layer="icon");
  equation
    connect(therm_underside, therm_upside)
      annotation (points=[0, -58; 0, -44; 62, -44; 62, 22; 2, 22; 2, 40]);

    connect(In, PipeElement[1].In);
    connect(Out, PipeElement[n].Out);
    for i in 1:(n - 1) loop
      connect(PipeElement[i].Out, PipeElement[i + 1].In);
    end for;

    for i in 1:n loop
      connect(PipeElement[i].therm1, therm_upside);
    end for;
  end npipe;

  class Valve2W
    parameter Real G=0.01 "lam. massflow conductance in kg(s*Pa)";
    Real a;
    annotation (
      Coordsys(
        extent=[-113, -101; 70, 109],
        grid=[1, 1],
        component=[20, 20]),
      Diagram,
      Icon(
        Line(points=[-92, 98; -92, 98; -13, 80; -13, 81], style(color=41,
              pattern=3)),
        Line(points=[80, 30; 90, 34; 64, 34; 90, 34; 81, 39]),
        Text(extent=[-121, 83; -83, 59], string="0...1"),
        Polygon(points=[-80, -50; -80, 60; -13, 6; 51, 60; 51, -50; -13, 5; -80,
               -50], style(gradient=2, fillColor=69)),
        Line(points=[-13, 6; -13, 80], style(fillColor=69, fillPattern=1)),
        Line(points=[-39, 80; 12, 80], style(fillColor=69, fillPattern=1)),
        Line(points=[-105.85, 31.5; -95.85, 35.5; -121.85, 35.5; -95.85, 35.5;
              -104.85, 40.5])),
      Window(
        x=0.2,
        y=0.01,
        width=0.79,
        height=0.65));
    Cuts.ThermoFlow IN annotation (extent=[-112, -9; -82, 25]);
    Cuts.ThermoFlow OUT annotation (extent=[52, -6; 81, 26]);
    Modelica.Blocks.Interfaces.InPort InPort1(final n=1)
      annotation (extent=[-118, 84; -93, 113], layer="icon");
  equation

    a = if InPort1.signal[1] < 0.001 then 0.001 else if InPort1.signal[1] >
      0.999 then 0.999 else InPort1.signal[1];

    OUT.i = if noEvent(IN.p - OUT.p >= 0) then -(IN.p - OUT.p)*a^2*G else 0;

    IN.i + OUT.i = 0;

    OUT.T = IN.T;

  end Valve2W;

  model TempSensorFlow
    annotation (Diagram, Icon(
        Rectangle(extent=[-86, 92; 74, -68], style(gradient=3, fillColor=73)),
        Ellipse(extent=[-40, 16; 22, -48], style(color=41, fillColor=41)),
        Rectangle(extent=[-22, 32; 2, -8], style(color=41, fillColor=41)),
        Line(points=[2, 54; 16, 54], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Line(points=[2, 42; 16, 42], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Line(points=[2, 30; 16, 30], style(
            color=8,
            thickness=2,
            fillColor=8)),
        Rectangle(extent=[50, 38; 54, -16], style(gradient=1, fillColor=49)),
        Rectangle(extent=[50, 38; 54, 42], style(gradient=3, fillColor=49)),
        Rectangle(extent=[58, -16; 66, -12], style(gradient=2, fillColor=49)),
        Rectangle(extent=[54, -16; 58, -12], style(gradient=3, fillColor=49)),
        Rectangle(extent=[18, 38; 50, 42], style(gradient=2, fillColor=49)),
        Rectangle(extent=[-22, 64; 2, 22], style(fillColor=7, fillPattern=7))));
    Cuts.ThermoFlow ThermoFlow2 annotation (extent=[-20, -94; 8, -68]);
    Modelica.Blocks.Interfaces.OutPort OutPort2
      annotation (extent=[74, -14; 104, 16]);
  equation

    OutPort2.signal[1] = ThermoFlow2.T;
    ThermoFlow2.i = 0;
  end TempSensorFlow;


end Advanced;

