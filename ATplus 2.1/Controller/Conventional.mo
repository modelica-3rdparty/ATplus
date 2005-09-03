package Conventional
  extends ATplus.Icons.Package;
  annotation (
    Coordsys(
      extent=[0, 0; 1024, 617],
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
      Rectangle(extent=[-42, 26; 24, -34], style(color=73, fillColor=74)),
      Text(
        extent=[-12, 12; -12, -18],
        string="PID",
        style(color=7)),
      Polygon(points=[24, 0; 24, -8; 30, -4; 24, 0], style(fillColor=7)),
      Polygon(points=[-48, -14; -48, -22; -42, -18; -48, -14], style(fillColor=
              73)),
      Polygon(points=[-48, 14; -48, 6; -42, 10; -48, 14], style(fillColor=73))));
  package Continuous
    extends ATplus.Icons.Package;
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
          extent=[0, 0; 402, 261],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0,
          y=0.6,
          width=0.4,
          height=0.4,
          library=1,
          autolayout=1));
      model Cont_Base
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram(Rectangle(extent=[-80, 80; 80, -80])),
          Icon(Rectangle(extent=[-80, 80; 80, -80])),
          Window(
            x=0.27,
            y=0.25,
            width=0.6,
            height=0.6));
        Modelica.Blocks.Interfaces.InPort In(final n=1) annotation (extent=[-
              100, 0; -80, 20], layer="icon");
        Modelica.Blocks.Interfaces.InPort Act annotation (extent=[-100, -60; -
              80, -40]);
        Modelica.Blocks.Interfaces.OutPort Out annotation (extent=[80, 0; 100,
              20]);
      end Cont_Base;
    end Base;

    model Cont_PI "PI Anti-Wind-Up-Reset"
      parameter Real Kp=1 "Proportional Gain";
      parameter Real Ki=1 "Integration Gain";
      parameter Real umax=1 "Maximum controller output";
      parameter Real umin=-umax "Minimum controller output";
      Real u;
      Real y;
      Real x;
      Real arw;
      extends Base.Cont_Base;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Documentation(info=" PI Anti-Wind-Up-Reset

 The PI Transfer Function block defines the transfer
 function between the input signal u1 (internally calculated)
 and the output signal :

                Ti s + 1
 uout  = Kp * ------------ * (uin-act)
                  Ti s



Additionally an \"Anti-Wind-Up-Reset\"-function is implemented.
"),     Window(
          x=0.01,
          y=0.11,
          width=0.6,
          height=0.6),
        Icon(
          Text(extent=[-70, 58; 62, -14], string="PI"),
          Text(extent=[-70, -10; 74, -64], string="Anti-Wind-Up-Reset"),
          Rectangle(extent=[-80, 80; 80, -80])),
        Diagram(
          Text(extent=[-70, 58; 62, -14], string="PI"),
          Text(extent=[-70, -10; 74, -64], string="Anti-Wind-Up-Reset"),
          Rectangle(extent=[-80, 80; 80, -80])));
    equation
      u = In.signal[1] - Act.signal[1];
      y = Kp*u + x;
      Out.signal[1] = if y > umax then umax else if y < umin then umin else y;
      arw = Out.signal[1] - y;
      der(x) = Ki*u + arw;
    end Cont_PI;

    model Cont_PID

      parameter Real Kp=1 "Gain";
      parameter Real Ti=1 "PI - Time Constant";
      parameter Real Td=1 "D - Time Constant";
      parameter Real N=10 "The higher the N, the more ideal the PID";
      parameter Real umax=1 "Maximum controller output";
      parameter Real umin=-umax "Minimum controller output";
      Real x;
      Real dx;
      Real u;
      Real y;
      Real arw;
      extends Base.Cont_Base;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Text(extent=[-70, 58; 62, -14], string="PID"),
          Text(extent=[-70, -10; 74, -64], string="Anti-Wind-Up-Reset"),
          Rectangle(extent=[-80, 80; 80, -80])),
        Icon(
          Text(extent=[-70, -10; 74, -64], string="Anti-Wind-Up-Reset"),
          Text(extent=[-70, 58; 62, -14], string="PID"),
          Rectangle(extent=[-80, 80; 80, -80])),
        Window(
          x=0.39,
          y=0.26,
          width=0.6,
          height=0.6));
    equation
      u = In.signal[1] - Act.signal[1];
      der(x) = dx;
      der(dx) = (u/Ti + arw/Kp - dx)*N/Td;
      arw = Out.signal[1] - y;
      y = Kp*(x + (Td/N - N*Ti)*dx + (N + 1)*u);
      Out.signal[1] = if y > umax then umax else if y < umin then umin else y;
    end Cont_PID;

    model Relay
      parameter Real jp1=-1 "Jump Low Point";
      parameter Real jp2=1 "Jump High Point";
      parameter Real min=0 "Output Value Low";
      parameter Real max=1 "Output Value High";
      Boolean x1;
      Real x2;
      Real c(start=0);
    //  constant Boolean tr=true;
    //  constant Boolean fs=false;
      Boolean cond;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, rgbfillColor=
                  {255,255,255})),
          Line(points=[40, 40; -40, 40; -40, -20], style(thickness=2)),
          Line(points=[-80, -20; 40, -20; 40, 40; 80, 40], style(
              pattern=1,
              thickness=2,
              arrow=0)),
          Text(extent=[-64,-34; -6,-60],    string="jp1"),
          Text(extent=[12,-34; 68,-58],   string="jp2"),
          Text(extent=[42,-8; 78,-26],   string="min"),
          Text(extent=[40,36; 80,22],   string="max")),
        Documentation(info="





  cond= if (new(x1)==1 and x1==0) then true else false;
"),     Window(
          x=0.05,
          y=0.11,
          width=0.92,
          height=0.67));
      Modelica.Blocks.Interfaces.InPort In(final n=1) annotation (extent=[-100,
              0; -80, 20]);
      Modelica.Blocks.Interfaces.OutPort Out annotation (extent=[80, 0; 100, 20]);
    equation
      x1 = if ((In.signal[1] < jp1) or (In.signal[1] > jp2)) then true else false;

      cond = if (x1 == true and pre(x1) == false) then true else false;

      when cond then
        x2 = if (In.signal[1] < jp1) then min else max;
        c = 1;
      end when;

      Out.signal[1] = if c > 0 then x2 else if In.signal[1] < jp1 then min else if
        In.signal[1] > jp2 then max else min;
    end Relay;

    model PWM "Pulse Width Modulation
Element translates continous input to a discrete (0,1) signal.
The time ratio between output signal = 1 and 0 is proportional to the input signal."

      extends Discrete.Base.Control_Base;
      parameter Real Period=10 "Period of the pulse";
      Boolean L1(start=false);
      Boolean L2(start=true);
      Real trigger_time;
      Real delay_time;
      Real In_Signal;
      Boolean Cond;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Text(extent=[-68, 38; 68, -40], string="PWM")),
        Diagram(Text(extent=[-68, 38; 68, -40], string="PWM")),
        Documentation(info="
"),     Window(
          x=0.13,
          y=0.13,
          width=0.65,
          height=0.78));
    equation

      In_Signal = In.signal[1];

      when sample(0, Period) then
        L1 = not pre(L1);
      end when;

      Cond = if (L1 and not pre(L1) or not L1 and pre(L1)) then true else false;

      when Cond then
        trigger_time = time;
      end when;

      delay_time = In_Signal*Period;

      when (time - trigger_time > delay_time) then
        L2 = not pre(L2);
      end when;

      Out.signal[1] = if (not (In_Signal > 0)) then 0 else if (not (In_Signal
         < 1)) then 1 else if (L1 and L2) or ((not L1) and (not L2)) then 1 else
              0;

    end PWM;

    model PIDBlock
      extends Base.Cont_Base;
      parameter Real Kp=1;
      parameter Real Ki=1;
      parameter Real Kd=1;
      parameter Real umax=1;
      parameter Real umin=0;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Icon(Text(extent=[-64, 56; 64, -2], string="PID"), Text(extent=[-64, -6;
                  64, -64], string="Block")));
      Modelica.Blocks.Math.Feedback Feedback1 annotation (extent=[-76, 0; -56,
            20]);
      Modelica.Blocks.Math.Gain P(k={Kp}) annotation (extent=[-30, 38; -10, 58]);
      Modelica.Blocks.Continuous.Integrator Integrator1(k={Ki}) annotation (
          extent=[-18, 0; 2, 20]);
      Modelica.Blocks.Continuous.Derivative Derivative1(k={Kd}) annotation (
          extent=[-18, -36; 2, -16]);
      Modelica.Blocks.Math.Add3 Add3_1 annotation (extent=[16, -2; 36, 18]);
      Modelica.Blocks.Nonlinear.Limiter Limiter1(uMax={umax}, uMin={umin})
        annotation (extent=[52, 0; 72, 20]);
      ARW ARW1(umax=umax, umin=umin) annotation (extent=[4, -62; 24, -42],
          rotation=180);
      Modelica.Blocks.Math.Product Product1 annotation (extent=[-48, -2; -28,
            18]);
    equation
      connect(In, Feedback1.inPort1) annotation (points=[-90,10; -74,10]);
      connect(Act, Feedback1.inPort2) annotation (points=[-90,-50; -66,-50; -66,
            2]);
      connect(Feedback1.outPort, P.inPort) annotation (points=[-57, 10; -57, 48;
              -32, 48]);
      connect(P.outPort, Add3_1.inPort1) annotation (points=[-9,48; 6,48; 6,16;
            14,16]);
      connect(Derivative1.outPort, Add3_1.inPort3) annotation (points=[3,-26; 8,
            -26; 8,0; 14,0]);
      connect(Feedback1.outPort, Derivative1.inPort) annotation (points=[-57,
            10; -57, -26; -20, -26]);
      connect(Integrator1.outPort, Add3_1.inPort2) annotation (points=[3,10;
            8.5,10; 8.5,8; 14,8]);
      connect(Add3_1.outPort, Limiter1.inPort) annotation (points=[37,8; 50,10]);
      connect(Limiter1.outPort, Out) annotation (points=[73,10; 90,10]);
      connect(Add3_1.outPort, ARW1.In) annotation (points=[37,8; 42,10; 42,-52;
            23,-52]);
      connect(Product1.outPort, Integrator1.inPort) annotation (points=[-27,8;
            -20,10]);
      connect(Feedback1.outPort, Product1.inPort1) annotation (points=[-57,10;
            -50,14]);
      connect(ARW1.Out, Product1.inPort2) annotation (points=[5,-52; -50,-52;
            -50,2]);
    end PIDBlock;

    model ARW
      extends Discrete.Base.Control_Base;
      parameter Real umax=1;
      parameter Real umin=0;
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]), Icon(Text(extent=[-68, 34; 66, -36], string=
                "ARW")));
    equation
      Out.signal[1] = if (In.signal[1] > umax or In.signal[1] < umin) then 0 else
              1;
    end ARW;

    class RelayInv
      parameter Real jp1=-1 "Jump Low Point";
      parameter Real jp2=1 "Jump High Point";
      parameter Real min=0 "Output Value Low";
      parameter Real max=1 "Output Value High";
      Boolean x1;
      Real x2;
      Real c(start=0);
    //  constant Boolean tr=true;
    //  constant Boolean fs=false;
      Boolean cond;
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]), Icon(
          Rectangle(extent=[-80, 80; 80, -80], style(fillColor=7, rgbfillColor=
                  {255,255,255})),
          Line(points=[42, -20; -42, -20; -42, 40], style(color=1, thickness=2)),
          Line(points=[-78, 40; 42, 40; 42, -20; 78, -20], style(
              color=1,
              pattern=1,
              thickness=2,
              arrow=0)),
          Text(
            extent=[10,-26; 78,-52],
            string="jp2",
            style(color=41)),
          Text(
            extent=[-74,-26; -8,-52],
            string="jp1",
            style(color=41)),
          Text(extent=[42,0; 80,-18],   string="min"),
          Text(extent=[42,46; 80,30],   string="max")));
      Modelica.Blocks.Interfaces.InPort In(final n=1) annotation (extent=[-100,
            0; -80,20],    layer="icon");
      Modelica.Blocks.Interfaces.OutPort Out annotation (extent=[80, 0; 100, 20],
               layer="icon");
    equation
      x1 = if ((In.signal[1] < jp1) or (In.signal[1] > jp2)) then true else false;

      cond = if (x1 == true and pre(x1) == false) then true else false;

      when cond then
        x2 = if (In.signal[1] < jp1) then max else min;
        c = 1;
      end when;

      Out.signal[1] = if c > 0 then x2 else if In.signal[1] < jp1 then max else
              if In.signal[1] > jp2 then min else max;
    end RelayInv;

    model Delay "Delay block for discrete derivative"
      parameter Modelica.SIunits.Time DelayTime=1 "Delay";
      annotation (Icon(
          Rectangle(extent=[-90, 100; 90, -100]),
          Line(points=[-66, -60; 74, -60; 54, -54; 54, -66; 74, -60], style(
                color=10)),
          Line(points=[-60, -62; -60, 82; -66, 66; -54, 66; -60, 82], style(
                color=10)),
          Line(points=[-60, -58; -32, -58; -32, 52; 40, 52], style(color=0)),
          Line(points=[-12, -58; 42, -58; 42, 52; 70, 52], style(color=1)),
          Line(points=[30, 0; 86, 0], style(color=8, pattern=2)),
          Line(points=[-82, 0; -38, 0; -52, 8; -38, 0; -54, -8], style(pattern=
                  2)),
          Line(points=[48, 0; 84, 0; 72, 8; 84, 0; 72, -8], style(color=1,
                pattern=2)),
          Line(points=[-30, -32; 38, -32; 26, -26; 38, -32; 26, -38], style(
                color=1)),
          Line(points=[-20, -38; -30, -32; -20, -26], style(color=1)),
          Text(
            extent=[-32, 20; 40, 0],
            style(color=1),
            string="Delay"),
          Text(
            extent=[-32, 0; 40, -20],
            style(color=1),
            string="= %DelayTime s")));
      Modelica.Blocks.Interfaces.InPort InPort annotation (extent=[-110, -10; -
            90, 10]);
      Modelica.Blocks.Interfaces.OutPort OutPort annotation (extent=[90, -10;
            110, 10]);
    equation
      OutPort.signal[1] = delay(InPort.signal[1], DelayTime);
    end Delay;
  end Continuous;

  package Discrete
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
    package Base
      annotation (Coordsys(
          extent=[0, 0; 299, 222],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.04,
          y=0.06,
          width=0.3,
          height=0.35,
          library=1,
          autolayout=1));
      model Control_Base
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram(Rectangle(extent=[-80, 80; 80, -80])),
          Icon(Rectangle(extent=[-80, 80; 80, -80])),
          Window(
            x=0.32,
            y=0.28,
            width=0.6,
            height=0.6));
        Modelica.Blocks.Interfaces.InPort In annotation (extent=[-100, -10; -80,
                10], layer="icon");
        Modelica.Blocks.Interfaces.OutPort Out annotation (extent=[80, -10; 100,
                10], layer="icon");
      end Control_Base;

      model Alg_Base
        extends Control_Base;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.33,
            y=0.28,
            width=0.6,
            height=0.6));
        Modelica.Blocks.Interfaces.InPort ukx annotation (extent=[-10, -100; 10,
                -80], rotation=90);
      end Alg_Base;

      model PIDBase
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram(
            Rectangle(extent=[-80, 80; 80, -80]),
            Rectangle(extent=[-80, 80; 80, -80]),
            Rectangle(extent=[-80, 80; 80, -80])),
          Icon(
            Rectangle(extent=[-80, 80; 80, -80]),
            Rectangle(extent=[2, 24; 64, -28]),
            Ellipse(extent=[-50, 10; -26, -14]),
            Line(points=[-82, -2; -50, -2]),
            Line(points=[-26, -2; 2, -2]),
            Line(points=[84, -50; -38, -50; -38, -14]),
            Line(points=[40, 80; 40, 40; 40, 24]),
            Line(points=[-40, 80; -40, 52; 22, 52; 22, 24], style(color=81)),
            Line(points=[64, -2; 82, -2]),
            Polygon(points=[-62, 2; -62, -6; -50, -2; -62, 2], style(fillColor=
                    73)),
            Rectangle(extent=[-80, 80; 80, -80]),
            Rectangle(extent=[2, 24; 64, -28]),
            Ellipse(extent=[-50, 10; -26, -14]),
            Line(points=[40, 80; 40, 40; 40, 24]),
            Line(points=[-40, 80; -40, 52; 22, 52; 22, 24], style(color=81)),
            Line(points=[64, -2; 82, -2]),
            Polygon(points=[-10, 2; -10, -6; 2, -2; -10, 2], style(fillColor=73)),
            Polygon(points=[-38, -14; -42, -24; -34, -24; -38, -14], style(
                  fillColor=73))),
          Window(
            x=0.38,
            y=0.25,
            width=0.6,
            height=0.6));
        Modelica.Blocks.Interfaces.InPort Act(final n=1) annotation (
          extent=[80, -60; 100, -40],
          rotation=180,
          layer="icon");
        Modelica.Blocks.Interfaces.BooleanInPort uL annotation (
          extent=[-50, 80; -30, 100],
          rotation=270,
          layer="icon");
        Modelica.Blocks.Interfaces.InPort uhand annotation (extent=[30, 80; 50,
                100], rotation=270);
        Modelica.Blocks.Interfaces.InPort In(final n=1) annotation (extent=[-
              100, -12; -80, 8]);
        Modelica.Blocks.Interfaces.OutPort Out annotation (extent=[80, -12; 100,
                8]);
      end PIDBase;

      model Summer "Summer for Feedback"
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram(
            Line(points=[-82, 0; -30, 0]),
            Line(points=[30, 0; 80, 0]),
            Line(points=[0, -90; 0, -30]),
            Ellipse(extent=[-30, 28; 30, -32], style(fillColor=8)),
            Rectangle(extent=[-50, -32; -30, -36], style(color=0, fillColor=0))),
          Icon(
            Ellipse(extent=[-30, 28; 30, -32], style(fillColor=8)),
            Line(points=[0, -90; 0, -30]),
            Line(points=[-82, 0; -30, 0]),
            Line(points=[30, 0; 80, 0]),
            Rectangle(extent=[-52, -32; -32, -36], style(color=0, fillColor=0))),
          Window(
            x=0.36,
            y=0.26,
            width=0.6,
            height=0.6));
        Modelica.Blocks.Interfaces.InPort In1 annotation (extent=[-102, -10; -
              82, 10]);
        Modelica.Blocks.Interfaces.InPort In2 annotation (extent=[-10, -100; 10,
                -80], rotation=90);
        Modelica.Blocks.Interfaces.OutPort Out annotation (extent=[80, -8; 100,
                12], layer="icon");
      equation
        Out.signal[1] = In1.signal[1] - In2.signal[1];
      end Summer;
    end Base;

    model Discrete_PI1 "Discrete-Time PI Controller from Lutz/Wendt "
      constant Boolean DymolaCompatibility=true;
      extends Base.Alg_Base;
      parameter Real Kp=1 "Proportional Gain";
      parameter Real Ki=1 "Integration Gain";
      parameter Boolean BU=true;
      parameter Boolean ARW=true;
      parameter Real maxval
        "maximum difference between set point and actual value";
      parameter Real minval
        "minimum difference between set point and actual value";
      parameter Real bits "number of bits of ADconverter";
      parameter Modelica.SIunits.Time SampleInterval
        "Sample period of component";
      constant Modelica.SIunits.Time SampleOffset=0 "First sample time instant";
      output Boolean sampleTrigger "True, if sample time instant";
      parameter Real umax;
      parameter Real umin;
      Real null=0;
      Real yk;
      Real yk_0;
      Real yk_1;
      Real xdk;
      Real xdk_0;
      Real xdk_1;
      Real T;
      Real y;
      Real qInterval "Quantization interval";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Text(extent=[-64, 34; 64, -36], string="Algorithm")),
        Icon(Text(extent=[-64, 34; 64, -36], string="PI1")),
        Window(
          x=0.36,
          y=0.05,
          width=0.6,
          height=0.6));
    equation
      qInterval = ((maxval - minval)/2^bits);
      T = SampleInterval;

      sampleTrigger = sample(SampleOffset, SampleInterval);

      when sampleTrigger then
        xdk = In.signal[1];
        xdk_1 = pre(xdk_0);
        xdk_0 = pre(xdk);

        yk = yk_1 + Kp*xdk - (Kp - T*Ki)*xdk_1;
        Out.signal[1] = yk;
        y = if (not (noEvent(abs(yk - ukx.signal[1])) < 1.0e-12) and BU) then (
          if ukx.signal[1] > umax then umax else if ukx.signal[1] < umin then
          umin else ukx.signal[1]) else (if yk > umax then umax else if yk <
          umin then umin else yk);

        yk_1 = pre(yk_0);
        yk_0 = if ARW then y else yk;
      end when;
    end Discrete_PI1;

    model Discrete_PI2 "Discrete-Time PI Regler nach Vorlesung "
      extends Base.Alg_Base;
      parameter Real Kp=1 "Proportional Gain";
      parameter Real Ki=1 "Integration Gain";
      parameter Real SampleInterval "Sample Interval [sec]";
      parameter Real maxval
        "maximum difference between set point and actual value";
      parameter Real minval
        "minimum difference between set point and actual value";
      parameter Real bits "number of bits of ADconverter";
      parameter Real umax "maximum output";
      parameter Real umin "minimum output";
      Real qInterval "quantization interval";
      Real uk;
      Real upk;
      Real ui;
      Real uik;
      Real uik_0;
      Real uik_1;
      Real ek;
      Real ek_0;
      Real ek_1;
      Real T;

      Boolean b[2];
      Real epsilon;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Text(extent=[-64, 34; 64, -36], string="Algorithm")),
        Icon(Text(extent=[-64, 34; 64, -36], string="PI2")),
        Window(
          x=0.27,
          y=0.15,
          width=0.6,
          height=0.6));
    equation
      qInterval = ((maxval - minval)/2^bits);
      T = SampleInterval;

      when sample(0, SampleInterval) then
        epsilon = 0.0001*min(abs(uk), abs(ukx.signal[1]));
        b = {uk > ukx.signal[1] + epsilon,uk < ukx.signal[1] - epsilon};

        ek = In.signal[1];

        ek_1 = pre(ek_0);
        ek_0 = pre(ek);

        uik = uik_1 + Ki*T*ek_1;
        upk = Kp*ek;

        uk = upk + uik;
        Out.signal[1] = uk;

        /*Anti-Windup-Reset Measure*/
        ui = if (b[1] or b[2]) then (if ukx.signal[1] > umax then umax - upk else
                if ukx.signal[1] < umin then umin - upk else ukx.signal[1] -
          upk) else (if uk > umax then umax - upk else if uk < umin then umin
           - upk else uik);

        uik_1 = pre(uik_0);
        uik_0 = ui;
      end when;
    end Discrete_PI2;

    model Discrete_PID "Discrete-Time PID Controller from Lutz/Wendt "
      extends Base.Alg_Base;
      parameter Real Kp=1 "Proportional Gain";
      parameter Real Ki=1 "Integration Gain";
      parameter Real Kd=1 "Derivative Gain";
      parameter Real SampleInterval "Sample Interval [sec]";
      parameter Real maxval
        "maximum difference between set point and actual value";
      parameter Real minval
        "minimum difference between set point and actual value";
      parameter Real bits "number of bits of ADconverter";
      parameter Real umax "maximum output";
      parameter Real umin "minimum output";
      Real qInterval "quantization interval";
      Real yk;
      Real yk_0;
      Real yk_1;
      Real xdk;
      Real xdk_0;
      Real xdk_1;
      Real xdk_2;
      Real T;
      Real y;

      Boolean b[2];
      Real epsilon;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Text(extent=[-64, 34; 64, -36], string="Algorithm")),
        Icon(Text(extent=[-64, 34; 64, -36], string="PID")),
        Window(
          x=0.18,
          y=0.07,
          width=0.6,
          height=0.6));
    equation
      qInterval = ((maxval - minval)/2^bits);
      T = SampleInterval;

      when sample(0, SampleInterval) then
        epsilon = 0.0001*min(abs(yk), abs(ukx.signal[1]));
        b = {yk > ukx.signal[1] + epsilon,yk < ukx.signal[1] - epsilon};
        xdk = In.signal[1];

        xdk_2 = pre(xdk_1);
        xdk_1 = pre(xdk_0);
        xdk_0 = xdk;

        yk = yk_1 + (Kp + Kd/T)*xdk - (Kp - T*Ki + 2*Kd/T)*xdk_1 + Kd/T*xdk_2;
        Out.signal[1] = yk;

        y = if (b[1] or b[2]) then (if ukx.signal[1] > umax then umax else if
          ukx.signal[1] < umin then umin else ukx.signal[1]) else (if yk > umax then
                umax else if yk < umin then umin else yk);

        yk_1 = pre(yk_0);
        yk_0 = y;
      end when;
    end Discrete_PID;

    model Discrete_PIDSmooth
      "Discrete-Time PID Controller with Smoothing Element "
      extends Base.Alg_Base;
      parameter Real Kp=1 "Proportional Gain";
      parameter Real Ti=1 "Integration Gain";
      parameter Real Td=1 "Derivative Gain";
      parameter Real N=1 "Smoothing Constant";
      parameter Real SampleInterval "Sample Interval [sec]";
      parameter Real maxval
        "maximum difference between set point and actual value";
      parameter Real minval
        "minimum difference between set point and actual value";
      parameter Real bits "number of bits of ADconverter";
      parameter Real umax "maximum output";
      parameter Real umin "minimum output";
      Real qInterval "quantization interval";
      Real yk;
      Real yk_0;
      Real yk_1;
      Real yk_2;
      Real xdk;
      Real xdk_0;
      Real xdk_1;
      Real xdk_2;
      Real T;
      Real a;
      Real b;
      Real c;
      Real d;
      Real y;
      Boolean g[2];
      Real epsilon;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Text(extent=[-64, 34; 64, -36], string="Algorithm")),
        Icon(Text(extent=[-64, 34; 64, -36], string="PID"), Text(extent=[-74, -
                18; 72, -50], string="smooth")),
        Documentation(info=" Discrete version of PID Controller with the form :


              [           1           Kd s     ]
              [                                ]
  G(s) = Kp * [  1   +  ------  +   ---------- ]
              [                      Kd        ]
              [          Ki s        -- s + 1  ]
              [                       N        ]
"),     Window(
          x=0.24,
          y=0.11,
          width=0.66,
          height=0.64));
    equation
      qInterval = ((maxval - minval)/2^bits);
      T = SampleInterval;

      /*Calculation of constants*/
      a = Ti + (Td/N);
      b = Ti*Td + Ti*Td/N;
      c = Ti*Td/N;
      d = Ti;

      when sample(0, SampleInterval) then
        epsilon = 0.0001*min(abs(yk), abs(ukx.signal[1]));
        g = {yk > ukx.signal[1] + epsilon,yk < ukx.signal[1] - epsilon};
        xdk = In.signal[1];

        xdk_2 = pre(xdk_1);
        xdk_1 = pre(xdk_0);
        xdk_0 = xdk;

        yk = 1/(d*T + c)*((d*T + 2*c)*yk_1 - c*yk_2 + Kp*((T*T + a*T + b)*xdk
           - (a*T + 2*b)*xdk_1 + b*xdk_2));
        Out.signal[1] = yk;

        y = if (g[1] or g[2]) then (if ukx.signal[1] > umax then umax else if
          ukx.signal[1] < umin then umin else ukx.signal[1]) else (if yk > umax then
                umax else if yk < umin then umin else yk);

        yk_2 = pre(yk_1);
        yk_1 = pre(yk_0);
        yk_0 = y;
      end when;
    end Discrete_PIDSmooth;

    model Dis_PI1
      extends Base.PIDBase;
      parameter Modelica.SIunits.Time SampleInterval=1
        "Sample period of component";
      parameter Real maxval=50
        "maximum input or output of A/D or D/A Converter";
      parameter Real minval=-30
        "minimum input or output of A/D or D/A Converter";
      parameter Real bits=18 "number of bits of ADconverter";
      parameter Real umax=1 "maximum output";
      parameter Real umin=0 "minimum output";
      parameter Real maxdzone=0 "upper bound of dead zone";
      parameter Real mindzone=-maxdzone "lower bound of dead zone";
      Controller.Conventional.Discrete.DA_Converter DA_Converter(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[38, -18; 70, 16]);
      Controller.Conventional.Discrete.DeadZone DeadZone(maxdzone=maxdzone,
          mindzone=mindzone) annotation (extent=[-68, 24; -36, 56]);
      Controller.Conventional.Discrete.Discrete_PI1 Discrete_PI1(
        maxval=maxval,
        minval=minval,
        bits=bits,
        SampleInterval=SampleInterval,
        umax=umax,
        umin=umin) annotation (extent=[-22, 24; 10, 56]);
      Controller.Conventional.Discrete.OpSwitch OpSwitch(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[24, 24; 56, 56]);
      Controller.Conventional.Discrete.BoundElement BoundElement(umax=umax,
          umin=umin) annotation (extent=[-2, -18; 32, 16]);
      Controller.Conventional.Discrete.Base.Summer Summer annotation (extent=[-
            32, -12; -12, 12]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Window(
          x=0.27,
          y=0.13,
          width=0.62,
          height=0.71),
        Icon(Text(extent=[4, 22; 62, -28], string="PI1")),
        Documentation(info="
"));
      AD_Converter AD_Converter1(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[-68, -16; -36, 16]);
      AD_Converter AD_Converter2(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[64, -66; 32, -34]);
    equation
      connect(In, AD_Converter1.In) annotation (points=[-90, -2; -78.2, -2; -
            78.2, 0; -66.4, 0]);
      connect(AD_Converter2.In, Act) annotation (points=[62.4, -50; 90, -50]);
      connect(uL, OpSwitch.uL) annotation (points=[-40, 90; -40, 68; 33.6, 68;
            33.6, 54.4], style(color=81));
      connect(AD_Converter1.Out, Summer.In1) annotation (points=[-37.6, 0; -
            31.2, 0]);
      connect(AD_Converter2.Out, Summer.In2) annotation (points=[33.6, -50; -22,
              -50; -22, -10.8]);
      connect(BoundElement.Out, DA_Converter.In) annotation (points=[30.3, -1;
            39.6, -1]);
      connect(DA_Converter.Out, Out) annotation (points=[68.4, -1; 90, -2]);
      connect(Summer.Out, DeadZone.In) annotation (points=[-13, 0.24; -13, 20;
            -76, 20; -76, 40; -66.4, 40]);
      connect(DeadZone.Out, Discrete_PI1.In) annotation (points=[-37.6, 40; -
            20.4, 40]);
      connect(Discrete_PI1.Out, OpSwitch.In) annotation (points=[8.4, 40; 25.6,
              40]);
      connect(OpSwitch.Out, BoundElement.In) annotation (points=[54.4, 40; 66,
            40; 66, 20; -6, 20; -6, -1; -0.3, -1]);
      connect(OpSwitch.Out, Discrete_PI1.ukx) annotation (points=[54.4, 40; 66,
              40; 66, 20; -6, 20; -6, 25.6]);
      connect(uhand, OpSwitch.uhand) annotation (points=[40, 90; 40, 68; 46.4,
            68; 46.4, 54.4]);
    end Dis_PI1;

    model Dis_PI2
      extends Base.PIDBase;
      parameter Modelica.SIunits.Time SampleInterval=1
        "Sample period of component";
      parameter Real maxval=50
        "maximum input or output of A/D or D/A Converter";
      parameter Real minval=-30
        "minimum input or output of A/D or D/A Converter";
      parameter Real bits=18 "number of bits of ADconverter";
      parameter Real umax=1 "maximum output";
      parameter Real umin=0 "minimum output";
      parameter Real maxdzone=0 "upper bound of dead zone";
      parameter Real mindzone=-maxdzone "lower bound of dead zone";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Window(
          x=0.03,
          y=0.33,
          width=0.62,
          height=0.71),
        Icon(Text(extent=[4, 22; 62, -28], string="PI2")),
        Documentation(info="
"));
      AD_Converter AD_Converter1(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[-68, -16; -36, 16]);
      AD_Converter AD_Converter2(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[64, -66; 32, -34]);
      Conventional.Discrete.DA_Converter DA_Converter(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[38, -18; 70, 16]);
      Conventional.Discrete.DeadZone DeadZone(maxdzone=maxdzone, mindzone=
            mindzone) annotation (extent=[-68, 24; -36, 56]);
      Conventional.Discrete.OpSwitch OpSwitch(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[24, 24; 56, 56]);
      Conventional.Discrete.BoundElement BoundElement(umax=umax, umin=umin)
        annotation (extent=[-2, -18; 32, 16]);
      Conventional.Discrete.Base.Summer Summer annotation (extent=[-32, -12; -
            12, 12]);
      Discrete_PI2 Discrete_PI2_1 annotation (extent=[-22, 24; 10, 56]);
    equation
      connect(uL, OpSwitch.uL) annotation (points=[-40, 90; -40, 68; 33.6, 68;
            33.6, 54.4], style(color=81));
      connect(In, AD_Converter1.In) annotation (points=[-90, -2; -78.2, -2; -
            78.2, 0; -66.4, 0]);
      connect(AD_Converter1.Out, Summer.In1) annotation (points=[-37.6, 0; -
            31.2, 0]);
      connect(AD_Converter2.Out, Summer.In2) annotation (points=[33.6, -50; -22,
              -50; -22, -10.8]);
      connect(AD_Converter2.In, Act) annotation (points=[62.4, -50; 90, -50]);
      connect(BoundElement.Out, DA_Converter.In) annotation (points=[30.3, -1;
            39.6, -1]);
      connect(DA_Converter.Out, Out) annotation (points=[68.4, -1; 90, -2]);
      connect(Summer.Out, DeadZone.In) annotation (points=[-13, 0.24; -13, 20;
            -76, 20; -76, 40; -66.4, 40]);
      connect(OpSwitch.Out, BoundElement.In) annotation (points=[54.4, 40; 66,
            40; 66, 20; -6, 20; -6, -1; -0.3, -1]);
      connect(uhand, OpSwitch.uhand) annotation (points=[40, 90; 40, 68; 46.4,
            68; 46.4, 54.4]);
      connect(DeadZone.Out, Discrete_PI2_1.In) annotation (points=[-37.6, 40; -
            20.6, 40]);
      connect(Discrete_PI2_1.Out, OpSwitch.In) annotation (points=[8.4, 40;
            25.6, 40]);
      connect(OpSwitch.Out, Discrete_PI2_1.ukx) annotation (points=[54.4, 40;
            66, 40; 66, 20; -6, 20; -6, 25.6]);
    end Dis_PI2;

    model Dis_PID
      extends Base.PIDBase;
      parameter Modelica.SIunits.Time SampleInterval=1
        "Sample period of component";
      parameter Real maxval=50
        "maximum input or output of A/D or D/A Converter";
      parameter Real minval=-30
        "minimum input or output of A/D or D/A Converter";
      parameter Real bits=18 "number of bits of ADconverter";
      parameter Real umax=1 "maximum output";
      parameter Real umin=0 "minimum output";
      parameter Real maxdzone=0 "upper bound of dead zone";
      parameter Real mindzone=-maxdzone "lower bound of dead zone";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Window(
          x=0.27,
          y=0.13,
          width=0.62,
          height=0.71),
        Icon(Text(extent=[4, 22; 62, -28], string="PID")),
        Documentation(info="
"));
      AD_Converter AD_Converter1(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[-68, -16; -36, 16]);
      AD_Converter AD_Converter2(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[64, -66; 32, -34]);
      Conventional.Discrete.DA_Converter DA_Converter(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[38, -18; 70, 16]);
      Conventional.Discrete.DeadZone DeadZone(maxdzone=maxdzone, mindzone=
            mindzone) annotation (extent=[-68, 24; -36, 56]);
      Conventional.Discrete.OpSwitch OpSwitch(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[24, 24; 56, 56]);
      Conventional.Discrete.BoundElement BoundElement(umax=umax, umin=umin)
        annotation (extent=[-2, -18; 32, 16]);
      Conventional.Discrete.Base.Summer Summer annotation (extent=[-32, -12; -
            12, 12]);
      Discrete_PID Discrete_PID1 annotation (extent=[-20, 24; 8, 56]);
    equation
      connect(uL, OpSwitch.uL) annotation (points=[-40, 90; -40, 68; 33.6, 68;
            33.6, 54.4], style(color=81));
      connect(In, AD_Converter1.In) annotation (points=[-90, -2; -78.2, -2; -
            78.2, 0; -66.4, 0]);
      connect(AD_Converter1.Out, Summer.In1) annotation (points=[-37.6, 0; -
            31.2, 0]);
      connect(AD_Converter2.Out, Summer.In2) annotation (points=[33.6, -50; -22,
              -50; -22, -10.8]);
      connect(AD_Converter2.In, Act) annotation (points=[62.4, -50; 90, -50]);
      connect(BoundElement.Out, DA_Converter.In) annotation (points=[30.3, -1;
            39.6, -1]);
      connect(DA_Converter.Out, Out) annotation (points=[68.4, -1; 90, -2]);
      connect(Summer.Out, DeadZone.In) annotation (points=[-13, 0.24; -13, 20;
            -76, 20; -76, 40; -66.4, 40]);
      connect(OpSwitch.Out, BoundElement.In) annotation (points=[54.4, 40; 66,
            40; 66, 20; -6, 20; -6, -1; -0.3, -1]);
      connect(uhand, OpSwitch.uhand) annotation (points=[40, 90; 40, 68; 46.4,
            68; 46.4, 54.4]);
      connect(DeadZone.Out, Discrete_PID1.In) annotation (points=[-37.6, 40; -
            18.6, 40]);
      connect(Discrete_PID1.Out, OpSwitch.In) annotation (points=[6.6, 40; 25.6,
              40]);
      connect(OpSwitch.Out, Discrete_PID1.ukx) annotation (points=[54.4, 40; 66,
              40; 66, 20; -6, 20; -6, 25.6]);
    end Dis_PID;

    model Dis_PIDSmooth
      extends Base.PIDBase;
      parameter Modelica.SIunits.Time SampleInterval=1
        "Sample period of component";
      parameter Real maxval=50
        "maximum input or output of A/D or D/A Converter";
      parameter Real minval=-30
        "minimum input or output of A/D or D/A Converter";
      parameter Real bits=18 "number of bits of ADconverter";
      parameter Real umax=1 "maximum output";
      parameter Real umin=0 "minimum output";
      parameter Real maxdzone=0 "upper bound of dead zone";
      parameter Real mindzone=-maxdzone "lower bound of dead zone";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Window(
          x=0.27,
          y=0.13,
          width=0.62,
          height=0.71),
        Icon(Text(extent=[4, 26; 62, -24], string="PID"), Text(extent=[2, -12;
                60, -62], string="smooth")),
        Documentation(info="
"));
      AD_Converter AD_Converter1(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[-68, -16; -36, 16]);
      AD_Converter AD_Converter2(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[64, -66; 32, -34]);
      Conventional.Discrete.DA_Converter DA_Converter(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[38, -18; 70, 16]);
      Conventional.Discrete.DeadZone DeadZone(maxdzone=maxdzone, mindzone=
            mindzone) annotation (extent=[-68, 24; -36, 56]);
      Conventional.Discrete.OpSwitch OpSwitch(
        SampleInterval=SampleInterval,
        maxval=maxval,
        minval=minval,
        bits=bits) annotation (extent=[24, 24; 56, 56]);
      Conventional.Discrete.BoundElement BoundElement(umax=umax, umin=umin)
        annotation (extent=[-2, -18; 32, 16]);
      Conventional.Discrete.Base.Summer Summer annotation (extent=[-32, -12; -
            12, 12]);
      Discrete_PIDSmooth Discrete_PIDSmooth1 annotation (extent=[-20, 26; 8, 54]);
    equation
      connect(uL, OpSwitch.uL) annotation (points=[-40, 90; -40, 68; 33.6, 68;
            33.6, 54.4], style(color=81));
      connect(In, AD_Converter1.In) annotation (points=[-90, -2; -78.2, -2; -
            78.2, 0; -66.4, 0]);
      connect(AD_Converter1.Out, Summer.In1) annotation (points=[-37.6, 0; -
            31.2, 0]);
      connect(AD_Converter2.Out, Summer.In2) annotation (points=[33.6, -50; -22,
              -50; -22, -10.8]);
      connect(AD_Converter2.In, Act) annotation (points=[62.4, -50; 90, -50]);
      connect(BoundElement.Out, DA_Converter.In) annotation (points=[30.3, -1;
            39.6, -1]);
      connect(DA_Converter.Out, Out) annotation (points=[68.4, -1; 90, -2]);
      connect(Summer.Out, DeadZone.In) annotation (points=[-13, 0.24; -13, 20;
            -76, 20; -76, 40; -66.4, 40]);
      connect(OpSwitch.Out, BoundElement.In) annotation (points=[54.4, 40; 66,
            40; 66, 20; -6, 20; -6, -1; -0.3, -1]);
      connect(uhand, OpSwitch.uhand) annotation (points=[40, 90; 40, 68; 46.4,
            68; 46.4, 54.4]);
      connect(DeadZone.Out, Discrete_PIDSmooth1.In) annotation (points=[-37.6,
            40; -18.6, 40]);
      connect(Discrete_PIDSmooth1.Out, OpSwitch.In) annotation (points=[6.6, 40;
              25.6, 40]);
      connect(OpSwitch.Out, Discrete_PIDSmooth1.ukx) annotation (points=[54.4,
            40; 66, 40; 66, 20; -6, 20; -6, 27.4]);
    end Dis_PIDSmooth;

    model AD_Converter

      extends Base.Control_Base;
      parameter Modelica.SIunits.Time SampleInterval=0.1
        "Sample period of component";
      parameter Real maxval "upper bound value";
      parameter Real minval "lower bound value";
      parameter Real bits "number of bits of ADconverter";
      Real qInterval "quantization interval";
      Real uBound "bounded input";
      constant Modelica.SIunits.Time SampleOffset=0 "First sample time instant";
      output Boolean sampleTrigger "True, if sample time instant";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Text(extent=[-76, 74; -34, 32], string="A"),
          Text(extent=[32, -34; 74, -76], string="D"),
          Line(points=[-80, -80; 80, 80])),
        Icon(
          Line(points=[-80, -80; 80, 80]),
          Text(extent=[-76, 74; -34, 32], string="A"),
          Text(extent=[32, -34; 74, -76], string="D")),
        Window(
          x=0.1,
          y=0.13,
          width=0.6,
          height=0.6));
    equation
      qInterval = ((maxval - minval)/2^bits);

      sampleTrigger = sample(SampleOffset, SampleInterval);

      when sampleTrigger then
        uBound = if In.signal[1] > maxval then maxval else if In.signal[1] <
          minval then minval else In.signal[1];
        Out.signal[1] = qInterval*floor(abs(uBound/qInterval) + 0.5)*sign(
          uBound);
      end when;
    end AD_Converter;

    model DA_Converter
      extends Base.Control_Base;
      parameter Modelica.SIunits.Time SampleInterval=0.1
        "Sample period of component";
      parameter Real maxval "upper bound value";
      parameter Real minval "lower bound value";
      parameter Real bits "number of bits of DAconverter";
      Real qInterval "quantization interval";
      Real uBound "bounded input";
      constant Modelica.SIunits.Time SampleOffset=0 "First sample time instant";
      output Boolean sampleTrigger "True, if sample time instant";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Text(extent=[-76, 74; -34, 32], string="D"),
          Text(extent=[32, -34; 74, -76], string="A"),
          Line(points=[-80, -80; 80, 80])),
        Icon(
          Text(extent=[-76, 74; -34, 32], string="D"),
          Text(extent=[32, -34; 74, -76], string="A"),
          Line(points=[-80, -80; 80, 80])),
        Window(
          x=0.29,
          y=0.24,
          width=0.6,
          height=0.63));
    equation
      qInterval = ((maxval - minval)/2^bits);

      sampleTrigger = sample(SampleOffset, SampleInterval);

      when sampleTrigger then
        uBound = if In.signal[1] > maxval then maxval else if In.signal[1] <
          minval then minval else In.signal[1];
        Out.signal[1] = qInterval*floor(abs(uBound/qInterval) + 0.5)*sign(
          uBound);
      end when;
    end DA_Converter;

    model DeadZone
      extends Base.Control_Base;
      parameter Real maxdzone "Upper bound";
      parameter Real mindzone "Lower bound";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Line(points=[80, 60; 20, 0; -20, 0; -80, -60], style(color=0,
                thickness=2)),
          Line(points=[-80, 0; 80, 0], style(color=0, pattern=2)),
          Line(points=[0, 40; 0, -38], style(color=0, pattern=2))),
        Icon(
          Line(points=[0, 40; 0, -38], style(color=0, pattern=2)),
          Line(points=[-80, 0; 80, 0], style(color=0, pattern=2)),
          Line(points=[80, 60; 20, 0; -20, 0; -80, -60], style(color=0,
                thickness=2))),
        Window(
          x=0.13,
          y=0.2,
          width=0.6,
          height=0.6));
    equation
      Out.signal[1] = if In.signal[1] > maxdzone then In.signal[1] - maxdzone else
              if In.signal[1] < mindzone then In.signal[1] - mindzone else 0;
    end DeadZone;

    model BoundElement
      extends Base.Control_Base;
      parameter Real umax "bound upper value";
      parameter Real umin "bound lower value";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Line(points=[80, 40; 40, 40; -40, -40; -80, -40], style(color=0,
                thickness=2)),
          Line(points=[-80, 0; 80, 0], style(color=0, pattern=2)),
          Line(points=[0, 40; 0, -40], style(color=0, pattern=2))),
        Icon(
          Line(points=[0, 40; 0, -40], style(color=0, pattern=2)),
          Line(points=[-80, 0; 80, 0], style(color=0, pattern=2)),
          Line(points=[80, 40; 40, 40; -40, -40; -80, -40], style(color=0,
                thickness=2))),
        Window(
          x=0.2,
          y=0.26,
          width=0.6,
          height=0.6));
    equation
      Out.signal[1] = if In.signal[1] > umax then umax else if In.signal[1] <
        umin then umin else In.signal[1];
    end BoundElement;

    model OpSwitch
      extends Base.Control_Base;
      parameter Modelica.SIunits.Time SampleInterval=0.1
        "Sample period of component";
      parameter Real maxval
        "maximum difference between set point and actual value";
      parameter Real minval
        "minimum difference between set point and actual value";
      parameter Real bits "number of bits of ADconverter";
      Real qInterval;
      Real T "quantization interval";
      Real uhand_k_0;
      Real uhand_k_1;
      constant Modelica.SIunits.Time SampleOffset=0 "First sample time instant";
      output Boolean sampleTrigger "True, if sample time instant";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Polygon(points=[-80, 80; 80, 80; 80, -80; -80, 80], style(fillPattern=
                 0)),
          Text(extent=[-80, -36; -38, -78], string="A"),
          Text(extent=[36, 78; 78, 36], string="H"),
          Line(points=[-60, 40; -60, 20; 58, 20], style(color=81, fillColor=83)),
          Line(points=[40, 30; 60, 20], style(color=81)),
          Line(points=[40, 10; 60, 20], style(color=81)),
          Line(points=[-60, -20; 60, -20], style(color=81)),
          Line(points=[40, -10; 60, -20], style(color=81)),
          Line(points=[40, -30; 60, -20], style(color=81))),
        Icon(
          Text(extent=[36, 78; 78, 36], string="H"),
          Text(extent=[-80, -36; -38, -78], string="A"),
          Polygon(points=[-80, 80; 80, 80; 80, -80; -80, 80], style(fillPattern=
                 0)),
          Line(points=[-60, 40; -60, 20; 58, 20], style(color=81, fillColor=83)),
          Line(points=[40, 30; 60, 20], style(color=81)),
          Line(points=[40, 10; 60, 20], style(color=81)),
          Line(points=[-60, -20; 60, -20], style(color=81)),
          Line(points=[40, -10; 60, -20], style(color=81)),
          Line(points=[40, -30; 60, -20], style(color=81))),
        Window(
          x=0.37,
          y=0.09,
          width=0.6,
          height=0.6),
        Documentation(info="
"));
      Modelica.Blocks.Interfaces.BooleanInPort uL annotation (extent=[-50, 80;
            -30, 100], rotation=270);
      Modelica.Blocks.Interfaces.InPort uhand annotation (extent=[30, 80; 50,
            100], rotation=270);
    equation
      qInterval = ((maxval - minval)/2^bits);
      T = SampleInterval;

      sampleTrigger = sample(SampleOffset, SampleInterval);

      when sampleTrigger then
        uhand_k_1 = pre(uhand_k_0);
        uhand_k_0 = uhand.signal[1];

        Out.signal[1] = if not uL.signal[1] then In.signal[1] else uhand_k_1;
      end when;
    end OpSwitch;
  end Discrete;
end Conventional;
