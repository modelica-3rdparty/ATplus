package Fuzzy_Control

  annotation (
    Coordsys(
      extent=[0, 0; 606, 355],
      grid=[2, 2],
      component=[20, 20]),
    Icon(
      Rectangle(extent=[-100, -100; 80, 50], style(fillPattern=0)),
      Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
            fillColor=8, fillPattern=1)),
      Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
            fillColor=8, fillPattern=1)),
      Text(
        extent=[-80, -32; 65, -119],
        string="Library",
        style(color=3)),
      Text(extent=[-6, 116; -6, 64], string="%name"),
      Line(points=[-78, -30; 62, -30], style(color=0, arrow=1)),
      Line(points=[-66, -32; -66, 32], style(color=0, arrow=1)),
      Line(points=[-74, 6; -68, 6], style(color=0)),
      Text(
        extent=[-88, 12; -76, -2],
        string="1",
        style(color=0)),
      Line(points=[-58, 6; -42, 6; -22, -30], style(color=10, thickness=2)),
      Line(points=[-38, -30; -18, 6; 2, 6; 18, -30], style(color=41, thickness=
              2)),
      Line(points=[8, -30; 24, 6; 36, 6], style(color=69, thickness=2)),
      Text(
        extent=[62, -22; 74, -36],
        string="e",
        style(color=0)),
      Text(
        extent=[-70, -34; -52, -46],
        string="emin",
        style(color=0)),
      Text(
        extent=[26, -32; 46, -44],
        string="emax",
        style(color=0)),
      Line(points=[36, 6; 36, -30], style(color=0, pattern=2)),
      Line(points=[-58, 6; -58, -30], style(color=0, pattern=2)),
      Line(points=[-42, 6; -42, -30], style(color=0, pattern=2)),
      Line(points=[-18, 6; -18, -30], style(color=0, pattern=2)),
      Line(points=[2, 6; 2, -30], style(color=0, pattern=2)),
      Line(points=[24, 6; 24, -30], style(color=0, pattern=2)),
      Text(
        extent=[-66, 26; -28, 8],
        string="small",
        style(color=10)),
      Text(
        extent=[-28, 26; 14, 6],
        string="medium",
        style(color=41)),
      Text(
        extent=[12, 26; 50, 8],
        string="big",
        style(color=69))),
    Window(
      x=0.4,
      y=0.4,
      width=0.6,
      height=0.6,
      library=1,
      autolayout=1));
  package Version_1
    extends Icons.Package;
    annotation (
      Coordsys(
        extent=[0, 0; 443, 181],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0,
        y=0.71,
        width=0.44,
        height=0.29,
        library=1,
        autolayout=1),
      Icon);
    package inputs
      extends Icons.Package;
      annotation (Coordsys(
          extent=[0, 0; 443, 223],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.35,
          library=1,
          autolayout=1));
      class v1_input_3
        "Input with three fuzzy sets (\"small\", \"medium\", \"big\")"

        annotation (Images(Parameters(name="3setsin", source=
                  "Controller/Images/3setsin.png")));

        parameter Real emin=0 "Minimum input";
        parameter Real emax=1 "Maximum input";
        parameter Real[2] es={0,0.5} "small";

        parameter Real[4] em={0,0.5,0.5,1} "medium";

        parameter Real[2] eb={0.5,1} "big";

        parameter Real out_minus=0 "value of 'small' if input < emin";
        parameter Real out_plus=0 "value of 'big' if input > emax";
        parameter Boolean SAMPLE=false "Sampled controller";
        parameter Real T_sample=0.1 "sampling period in s";
        parameter Real T_0=0 "time of first sampling in s";
        Real e;
        annotation (
          Coordsys(
            extent=[-105, -102; 149, 104],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.03,
            y=0.07,
            width=0.93,
            height=0.65),
          Diagram,
          Icon(
            Text(
              extent=[68, 14; 142, -22],
              string="medium",
              style(color=0)),
            Text(
              extent=[86, 82; 144, 54],
              string="small",
              style(color=0)),
            Text(
              extent=[88, -52; 146, -80],
              string="big",
              style(color=0)),
            Rectangle(extent=[-90, 104; 146, -102], style(color=73)),
            Line(points=[-80, -50; 90, -50], style(color=0, arrow=1)),
            Line(points=[-74, -50; -74, 48], style(color=0, arrow=1)),
            Line(points=[-76, 30; -70, 30], style(color=0)),
            Text(
              extent=[-88, 38; -76, 24],
              string="1",
              style(color=0)),
            Line(points=[-60, 30; -40, 30; -12, -50], style(color=10, thickness=
                   2)),
            Line(points=[-52, -50; 0, 30; 20, 30; 46, -50], style(color=41,
                  thickness=2)),
            Line(points=[30, -50; 58, 30; 72, 30], style(thickness=2)),
            Text(
              extent=[78, -32; 90, -46],
              string="e",
              style(color=0)),
            Text(
              extent=[-72, -54; -54, -66],
              string="emin",
              style(color=10)),
            Text(
              extent=[68, -54; 88, -66],
              string="emax",
              style(color=73)),
            Line(points=[72, 26; 72, -54], style(color=0, pattern=2)),
            Line(points=[-60, 26; -60, -56], style(color=0, pattern=2)),
            Line(points=[-40, 26; -40, -54], style(color=0, pattern=2)),
            Line(points=[0, 26; 0, -74], style(color=0, pattern=2)),
            Line(points=[20, 26; 20, -74], style(color=0, pattern=2)),
            Line(points=[58, 26; 58, -54], style(color=0, pattern=2)),
            Text(
              extent=[-48, -64; -34, -54],
              style(color=10),
              string="es[1]"),
            Text(
              extent=[-20, -64; -6, -54],
              style(color=10),
              string="es[2]"),
            Line(points=[-52, -50; -52, -74], style(color=0, pattern=4)),
            Text(
              extent=[-60, -84; -46, -74],
              style(color=41),
              string="em[1]"),
            Text(
              extent=[-8, -84; 6, -74],
              style(color=41),
              string="em[2]"),
            Text(
              extent=[14, -84; 28, -74],
              style(color=41),
              string="em[3]"),
            Text(
              extent=[38, -84; 52, -74],
              style(color=41),
              string="em[4]"),
            Text(extent=[22, -64; 36, -54], string="eb[7]"),
            Text(extent=[52, -64; 66, -54], string="eb[8]"),
            Line(points=[46, -50; 46, -76], style(color=0, pattern=4)),
            Text(
              extent=[-42, 76; 42, 40],
              style(color=0),
              string="3 Fuzzy Sets"),
            Text(
              extent=[-62, 50; -26, 34],
              string="small",
              style(color=10)),
            Text(
              extent=[-16, 52; 30, 32],
              string="medium",
              style(color=41)),
            Text(extent=[46, 50; 82, 34], string="big"),
            Text(
              extent=[-74, 94; 52, 60],
              string="Input %name",
              style(color=73))));
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-120, -14; -90, 26]);
        Modelica.Blocks.Interfaces.OutPort klein
          annotation (extent=[148, 56; 178, 88]);
        Modelica.Blocks.Interfaces.OutPort mittel
          annotation (extent=[148, -16; 178, 14]);
        Modelica.Blocks.Interfaces.OutPort gross
          annotation (extent=[148, -82; 178, -50]);
      equation

        if SAMPLE then
          when sample(T_0, T_sample) then
            e = pre(InPort1.signal[1]);
          end when;
        else
          e = InPort1.signal[1];
        end if;

        klein.signal[1] = if e < emin then out_minus else if e >= emin and e <
          es[1] then 1 else if e >= es[1] and e < es[2] then e/(es[1] - es[2])
           + es[1]/(es[2] - es[1]) + 1 else 0;

        mittel.signal[1] = if e >= em[1] and e < em[2] then e/(em[2] - em[1])
           - em[1]/(em[2] - em[1]) else if e >= em[2] and e < em[3] then 1 else
                if e >= em[3] and e < em[4] then -e/(em[4] - em[3]) + em[3]/(em[
          4] - em[3]) + 1 else 0;

        gross.signal[1] = if e < eb[1] then 0 else if e >= eb[1] and e < eb[2] then
                e/(eb[2] - eb[1]) - eb[1]/(eb[2] - eb[1]) else if e >= eb[2]
           and e < emax then 1 else out_plus;
      end v1_input_3;

      class v1_input_5
        "Input with five fuzzy sets (\"vsmall\", \"small\", \"medium\", \"big\", \"vbig\")"

        annotation (Images(Parameters(name="5setsin", source=
                  "Controller/Images/5setsin.png")));
        parameter Real emin=0 "Minimum input";
        parameter Real emax=1 "Maximum input";
        parameter Real[2] evs={0,0.25} "vsmall";
        parameter Real[4] es={0,0.25,0.25,0.5} "small";

        parameter Real[4] em={0.25,0.5,0.5,0.75} "medium";

        parameter Real[4] eb={0.5,0.75,0.75,1} "big";

        parameter Real[2] evb={0.75,1} "vbig";

        parameter Real out_minus=0 "value of 'vsmall' if input < emin";
        parameter Real out_plus=0 "value of 'vbig' if input > emax";
        Real e;
        parameter Boolean SAMPLE=false "Sampled controller";
        parameter Real T_sample=0.1 "sampling period in s";
        parameter Real T_0=0 "time of first sampling in s";
        annotation (
          Coordsys(
            extent=[-181, -112; 145, 116],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-164, 116; 128, -112], style(color=73)),
            Text(
              extent=[46, 24; 124, -20],
              string="medium",
              style(color=0, pattern=0)),
            Text(
              extent=[56, 56; 128, 28],
              string="small",
              style(color=0, pattern=0)),
            Text(
              extent=[80, -26; 124, -56],
              string="big",
              style(color=0, pattern=0)),
            Text(
              extent=[50, 96; 126, 68],
              style(color=0, pattern=0),
              string="vsmall"),
            Text(
              extent=[76, -68; 124, -96],
              string="vbig",
              style(color=0, pattern=0)),
            Line(points=[-128, -50; 61, -50], style(color=0, arrow=1)),
            Line(points=[-120, -51; -120, 64], style(color=0, arrow=1)),
            Line(points=[-122, 30; -116, 30], style(color=0)),
            Text(
              extent=[-138, 36; -126, 22],
              string="1",
              style(color=0)),
            Line(points=[-113, 30; -100, 30; -82, -50], style(thickness=2)),
            Line(points=[-107, -50; -73, 30; -54, 30; -37, -49], style(color=10,
                   thickness=2)),
            Line(points=[10, -49; 30, 30; 41, 30], style(color=81, thickness=2)),
            Text(
              extent=[51, -29; 63, -43],
              string="e",
              style(color=0)),
            Text(extent=[-126, -59; -110, -70], string="emin"),
            Text(
              extent=[38, -60; 57, -69],
              string="emax",
              style(color=81)),
            Line(points=[41, 29; 41, -57], style(color=81, pattern=2)),
            Line(points=[-113, 29; -113, -58], style(color=73, pattern=2)),
            Line(points=[-100, 30; -100, -58], style(color=73, pattern=2)),
            Line(points=[-72, 29; -72, -57], style(color=10, pattern=2)),
            Line(points=[-55, 28; -55, -57], style(color=10, pattern=2)),
            Line(points=[30, 29; 30, -57], style(color=81, pattern=2)),
            Text(extent=[-105, -69; -91, -60], string="evs[1]"),
            Text(extent=[-92, -69; -79, -60], string="evs[2]"),
            Line(points=[-107, -50; -107, -79], style(color=10, pattern=4)),
            Text(
              extent=[-115, -91; -102, -82],
              style(color=10),
              string="es[1]"),
            Text(
              extent=[-75, -69; -62, -60],
              style(color=10),
              string="es[2]"),
            Text(
              extent=[-62, -69; -49, -60],
              style(color=10),
              string="es[3]"),
            Text(
              extent=[-44, -91; -30, -82],
              style(color=10),
              string="es[4]"),
            Text(
              extent=[-84, -92; -71, -83],
              style(color=41),
              string="em[1]"),
            Text(
              extent=[-36, -69; -23, -60],
              style(color=41),
              string="em[3]"),
            Line(points=[-37, -51; -37, -79], style(color=10, pattern=4)),
            Text(
              extent=[-90, 72; 13, 47],
              style(color=0),
              string="5 Fuzzy Sets"),
            Text(extent=[-120, 44; -85, 34], string="vsmall"),
            Text(
              extent=[-77, 44; -52, 34],
              string="small",
              style(color=10)),
            Text(
              extent=[24, 44; 46, 34],
              string="vbig",
              style(color=81)),
            Text(
              extent=[-112, 112; 27, 74],
              string="Input %name",
              style(color=73)),
            Line(points=[-77, -50; -44, 30; -25, 30; -10, -49], style(color=41,
                   thickness=2)),
            Line(points=[-43, 29; -43, -57], style(color=41, pattern=2)),
            Line(points=[-26, 28; -26, -58], style(color=41, pattern=2)),
            Line(points=[-77, -51; -77, -79], style(color=41, pattern=4)),
            Line(points=[-48, -50; -15, 30; 4, 30; 19, -49], style(color=69,
                  thickness=2)),
            Line(points=[-14, 30; -14, -57], style(color=69, pattern=2)),
            Line(points=[3, 29; 3, -56], style(color=69, pattern=2)),
            Text(
              extent=[-49, 45; -20, 33],
              string="medium",
              style(color=41)),
            Line(points=[-48, -51; -48, -79], style(color=69, pattern=4)),
            Line(points=[-10, -51; -10, -79], style(color=41, pattern=4)),
            Text(
              extent=[-49, -69; -36, -60],
              style(color=41),
              string="em[2]"),
            Text(
              extent=[-16, -92; -4, -82],
              style(color=41),
              string="em[4]"),
            Text(
              extent=[-17, 44; 6, 34],
              string="big",
              style(color=69)),
            Text(
              extent=[-60, -92; -46, -82],
              style(color=69),
              string="eb[1]"),
            Text(
              extent=[-23, -69; -11, -60],
              style(color=69),
              string="eb[2]"),
            Text(
              extent=[-5, -69; 7, -60],
              style(color=69),
              string="eb[3]"),
            Line(points=[19, -51; 19, -78], style(color=69, pattern=4)),
            Text(
              extent=[18, -92; 31, -82],
              style(color=69),
              string="eb[4]"),
            Line(points=[10, -51; 10, -79], style(color=81, pattern=4)),
            Text(
              extent=[0, -92; 13, -82],
              style(color=81),
              string="evb[1]"),
            Text(
              extent=[22, -69; 34, -60],
              style(color=81),
              string="evb[2]"),
            Text(extent=[-170, 74; -148, 56], string="")),
          Window(
            x=0.01,
            y=0.02,
            width=0.79,
            height=0.81));

        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-198, -14; -164, 28], layer="icon");
        Modelica.Blocks.Interfaces.OutPort s_klein
          annotation (extent=[130, 68; 160, 100], layer="icon");
        Modelica.Blocks.Interfaces.OutPort mittel
          annotation (extent=[130, -14; 160, 16], layer="icon");
        Modelica.Blocks.Interfaces.OutPort gross
          annotation (extent=[130, -56; 160, -24], layer="icon");
        Modelica.Blocks.Interfaces.OutPort klein
          annotation (extent=[130, 28; 160, 60]);
        Modelica.Blocks.Interfaces.OutPort s_gross
          annotation (extent=[130, -96; 160, -64]);
      equation

        if SAMPLE then
          when sample(T_0, T_sample) then
            e = pre(InPort1.signal[1]);
          end when;
        else
          e = InPort1.signal[1];
        end if;

        s_klein.signal[1] = if e < emin then out_minus else if e >= emin and e
           < evs[1] then 1 else if e >= evs[1] and e < evs[2] then -e/(evs[2]
           - evs[1]) + evs[1]/(evs[2] - evs[1]) + 1 else 0;

        klein.signal[1] = if e >= es[1] and e < es[2] then e/(es[2] - es[1]) -
          es[1]/(es[2] - es[1]) else if e >= es[2] and e < es[3] then 1 else
          if e >= es[3] and e < es[4] then -e/(es[4] - es[3]) + es[3]/(es[4] -
          es[3]) + 1 else 0;

        mittel.signal[1] = if e >= em[1] and e < em[2] then e/(em[2] - em[1])
           - em[1]/(em[2] - em[1]) else if e >= em[2] and e < em[3] then 1 else
                if e >= em[3] and e < em[4] then -e/(em[4] - em[3]) + em[3]/(em[
          4] - em[3]) + 1 else 0;

        gross.signal[1] = if e >= eb[1] and e < eb[2] then e/(eb[2] - eb[1]) -
          eb[1]/(eb[2] - eb[1]) else if e >= eb[2] and e < eb[3] then 1 else
          if e >= eb[3] and e < eb[4] then -e/(eb[4] - eb[3]) + eb[3]/(eb[4] -
          eb[3]) + 1 else 0;

        s_gross.signal[1] = if e >= evb[1] and e < evb[2] then e/(evb[2] - evb[
          1]) - evb[1]/(evb[2] - evb[1]) else if e >= evb[2] and e < emax then
          1 else if e >= emax then out_plus else 0;
      end v1_input_5;
    end inputs;

    package outputs
      extends Icons.Package;
      annotation (Coordsys(
          extent=[0, 0; 443, 443],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.45,
          y=0.3,
          width=0.44,
          height=0.63,
          library=1,
          autolayout=1));
      class v1_output_cos_3
        "Output with three fuzzy sets (\"SMALL\", \"MEDIUM\", \"BIG\"). The method of defuzzification is 'Centre of Singletons'."

        annotation (Images(Parameters(name="3setsin", source="Controller/Images/cos3.png")));
        parameter Real u1=0 "SMALL";
        parameter Real u2=0.5 "MEDIUM";
        parameter Real u3=1 "BIG";
        parameter Real default_output=0 "output if no rule is active";
        Version_1.cuts_v1.cut_flow_v1 SMALL
          annotation (extent=[-148, 86; -118, 60]);
        Version_1.cuts_v1.cut_flow_v1 MEDIUM
          annotation (extent=[-148, 16; -118, -10]);
        Version_1.cuts_v1.cut_flow_v1 BIG
          annotation (extent=[-148, -54; -118, -80]);
        annotation (
          Coordsys(
            extent=[-125, -104; 124, 118],
            grid=[2, 2],
            component=[20, 20]),
          Diagram,
          Icon(
            Rectangle(extent=[-118, 112; 110, -100], style(color=41)),
            Text(
              extent=[-116, 88; -44, 54],
              string="SMALL",
              style(color=0)),
            Text(
              extent=[-116, 20; -32, -20],
              string="MEDIUM",
              style(color=0)),
            Line(points=[-30, -50; 103, -50], style(color=0, arrow=1)),
            Line(points=[-20, -62; -20, 62], style(color=0, arrow=1)),
            Line(points=[-22, 40; -16, 40], style(color=0)),
            Text(
              extent=[-38, 44; -26, 30],
              string="1",
              style(color=0)),
            Text(
              extent=[93, -29; 105, -43],
              string="u",
              style(color=0)),
            Text(
              extent=[-16, -70; 6, -52],
              string="u1",
              style(color=10)),
            Text(
              extent=[20, -72; 44, -54],
              string="u2",
              style(color=41)),
            Text(
              extent=[67, -71; 88, -54],
              string="u3",
              style(color=73)),
            Text(
              extent=[-28, 84; 92, 56],
              style(color=0, pattern=0),
              string="3 Fuzzy Sets"),
            Text(
              extent=[-18, 58; 18, 44],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[-110, 112; 100, 80],
              string="Output %name",
              style(color=41)),
            Text(
              extent=[18, 60; 60, 42],
              string="MEDIUM",
              style(color=41)),
            Text(
              extent=[64, 58; 92, 44],
              string="BIG",
              style(color=73)),
            Text(
              extent=[20, -72; 106, -102],
              string="C. o. S.",
              style(color=41)),
            Line(points=[-2, 40; -2, -52], style(color=10, thickness=2)),
            Line(points=[36, 40; 36, -52], style(color=41, thickness=2)),
            Line(points=[78, 40; 78, -52], style(color=73, thickness=2)),
            Text(
              extent=[-116, -56; -46, -86],
              string="BIG",
              style(color=0)),
            Rectangle(extent=[10, -72; 110, -100], style(color=0))),
          Window(
            x=0.24,
            y=0.17,
            width=0.66,
            height=0.52));
        Modelica.Blocks.Interfaces.OutPort Out
          annotation (extent=[112, -22; 136, 16]);
      equation

        // Centre of singleton:

        Out.signal[1] = if noEvent(SMALL.m + MEDIUM.m + BIG.m > 0) then (u1*
          SMALL.m + u2*MEDIUM.m + u3*BIG.m)/(SMALL.m + MEDIUM.m + BIG.m) else
          default_output;

      end v1_output_cos_3;

      class v1_output_cos_5
        "Output with five fuzzy sets (\"VSMALL, \"SMALL\", \"MEDIUM\", \"BIG\", \"VBIG\"). The method of defuzzification is 'Centre of Singletons'."

        annotation (Images(Parameters(name="5sets", source="Controller/Images/cos5.png")),
             Diagram);

        parameter Real u1=0 "VSMALL";
        parameter Real u2=0.25 "SMALL";
        parameter Real u3=0.5 "MEDIUM";
        parameter Real u4=0.75 "BIG";
        parameter Real u5=1 "VBIG";
        parameter Real default_output=0 "output if no rule is active";
        annotation (
          Coordsys(
            extent=[-161, -114; 136, 118],
            grid=[2, 2],
            component=[20, 20]),
          Diagram,
          Icon(
            Text(
              extent=[-160, 64; -92, 32],
              string="SMALL",
              style(color=0)),
            Text(
              extent=[-164, -22; -92, -48],
              string="BIG",
              style(color=0)),
            Rectangle(extent=[-164, 116; 122, -114], style(color=41)),
            Text(
              extent=[-158, 106; -76, 70],
              string="VSMALL",
              style(color=0)),
            Text(
              extent=[-162, -66; -98, -94],
              string="VBIG",
              style(color=0)),
            Text(
              extent=[-160, 20; -78, -16],
              string="MEDIUM",
              style(color=0)),
            Line(points=[-82, -54; 107, -54], style(color=0, arrow=1)),
            Line(points=[-74, -62; -74, 74], style(color=0, arrow=1)),
            Line(points=[-76, 40; -70, 40], style(color=0)),
            Text(
              extent=[-92, 44; -80, 30],
              string="1",
              style(color=0)),
            Text(
              extent=[97, -33; 109, -47],
              string="u",
              style(color=0)),
            Text(extent=[-68, -76; -44, -58], string="u1"),
            Text(
              extent=[-32, -76; -10, -58],
              string="u2",
              style(color=10)),
            Text(
              extent=[-4, -76; 20, -58],
              string="u3",
              style(color=41)),
            Text(
              extent=[39, -75; 60, -58],
              string="u4",
              style(color=69)),
            Text(
              extent=[68, -76; 94, -58],
              string="u5",
              style(color=81)),
            Text(
              extent=[-46, 82; 66, 56],
              style(color=0, pattern=0),
              string="5 Fuzzy Sets"),
            Text(extent=[-76, 64; -38, 36], string="VSMALL"),
            Text(
              extent=[-36, 56; -2, 42],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[66, 56; 94, 44],
              string="VBIG",
              style(color=81)),
            Text(
              extent=[-64, 122; 102, 74],
              string="Output %name",
              style(color=41)),
            Text(
              extent=[2, 58; 40, 40],
              string="MEDIUM",
              style(color=41)),
            Text(
              extent=[40, 56; 66, 44],
              string="BIG",
              style(color=69)),
            Text(
              extent=[-6, -74; 118, -116],
              string="C. o. S.",
              style(color=41)),
            Line(points=[-56, 40; -56, -52], style(thickness=2)),
            Line(points=[-18, 40; -18, -52], style(color=10, thickness=2)),
            Line(points=[18, 40; 18, -52], style(color=41, thickness=2)),
            Line(points=[50, 40; 50, -52], style(color=69, thickness=2)),
            Line(points=[82, 40; 82, -52], style(color=81, thickness=2)),
            Rectangle(extent=[-8, -76; 122, -114], style(color=0))),
          Window(
            x=0.02,
            y=0.01,
            width=0.84,
            height=0.61));
        Version_1.cuts_v1.cut_flow_v1 SMALL
          annotation (extent=[-196, 64; -166, 34]);
        Version_1.cuts_v1.cut_flow_v1 MEDIUM
          annotation (extent=[-196, 22; -166, -8]);
        Version_1.cuts_v1.cut_flow_v1 BIG
          annotation (extent=[-196, -20; -166, -50]);
        Modelica.Blocks.Interfaces.OutPort Out
          annotation (extent=[122, -24; 156, 20]);
        Version_1.cuts_v1.cut_flow_v1 VSMALL
          annotation (extent=[-196, 104; -166, 74], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 VBIG
          annotation (extent=[-196, -62; -166, -92], layer="icon");
      equation
        Out.signal[1] = if noEvent(VSMALL.m + SMALL.m + MEDIUM.m + BIG.m + VBIG.
           m > 0) then (u1*VSMALL.m + u2*SMALL.m + u3*MEDIUM.m + u4*BIG.m + u5*
          VBIG.m)/(VSMALL.m + SMALL.m + MEDIUM.m + BIG.m + VBIG.m) else
          default_output;

      end v1_output_cos_5;

      class v1_output_cog_3
        "Output with three fuzzy sets (\"SMALL\", \"MEDIUM\", \"BIG\"). The method of inference is 'Sum-Prod', the method of defuzzification 'Centre of Gravity'."

        annotation (Images(Parameters(name="3setsout", source=
                  "Controller/Images/3setsout.png")));

        parameter Real umin=0 "minimum output";
        parameter Real umax=1 "maximum output";
        parameter Real[2] us={0,0.5} "SMALL";
        parameter Real[4] um={0,0.5,0.5,1} "MEDIUM";
        parameter Real[2] ub={0.5,1} "BIG";
        parameter Real N=100 "# of integrator steps";
        parameter Real Default_output=0 "Output if no rule is active";
        Real mwk;
        Real mwm;
        Real mwg;
        Real msk;
        Real msm;
        Real msg;
        Real u;
        Real uk;
        Real uke;
        Real um1;
        Real um2;
        Real ug;
        Real uge;
        Real sum1;
        Real sum2;
      protected
        Real u1e=umin - (us[1] - umin);
        Real u2e=umin - (us[2] - umin);
        Real u7e=umax + (umax - ub[1]);
        Real u8e=umax + (umax - ub[2]);
        annotation (
          Coordsys(
            extent=[-184, -104; 117, 116],
            grid=[2, 2],
            component=[20, 20]),
          Diagram,
          Icon(
            Text(
              extent=[-160, 26; -76, -10],
              string="MEDIUM",
              style(color=0, pattern=0)),
            Text(
              extent=[-162, 94; -92, 64],
              string="SMALL",
              style(color=0, pattern=0)),
            Text(
              extent=[-166, -48; -102, -74],
              string="BIG",
              style(color=0, pattern=0)),
            Rectangle(extent=[-168, 116; 104, -102], style(color=41)),
            Line(points=[-72, -36; 98, -36], style(color=0, arrow=1)),
            Line(points=[-66, -36; -66, 62], style(color=0, arrow=1)),
            Line(points=[-68, 44; -62, 44], style(color=0)),
            Text(
              extent=[-82, 52; -70, 38],
              string="1",
              style(color=0)),
            Line(points=[-52, 44; -32, 44; -4, -36], style(color=10, thickness=
                    2)),
            Line(points=[-44, -36; 8, 44; 28, 44; 54, -36], style(color=41,
                  thickness=2)),
            Line(points=[38, -36; 66, 44; 80, 44], style(thickness=2)),
            Text(
              extent=[86, -18; 98, -32],
              string="u",
              style(color=0)),
            Text(
              extent=[-64, -40; -46, -52],
              string="umin",
              style(color=10)),
            Text(
              extent=[76, -40; 96, -52],
              string="umax",
              style(color=73)),
            Line(points=[80, 40; 80, -40], style(color=0, pattern=2)),
            Line(points=[-52, 40; -52, -42], style(color=0, pattern=2)),
            Line(points=[-32, 40; -32, -40], style(color=0, pattern=2)),
            Line(points=[8, 40; 8, -60], style(color=0, pattern=2)),
            Line(points=[28, 40; 28, -60], style(color=0, pattern=2)),
            Line(points=[66, 40; 66, -40], style(color=0, pattern=2)),
            Text(
              extent=[-40, -50; -26, -40],
              style(color=10),
              string="us[1]"),
            Text(
              extent=[-12, -50; 2, -40],
              style(color=10),
              string="us[2]"),
            Line(points=[-44, -36; -44, -60], style(color=0, pattern=4)),
            Text(
              extent=[-52, -70; -38, -60],
              style(color=41),
              string="um[1]"),
            Text(
              extent=[0, -70; 14, -60],
              style(color=41),
              string="um[2]"),
            Text(
              extent=[22, -70; 36, -60],
              style(color=41),
              string="um[3]"),
            Text(
              extent=[46, -70; 60, -60],
              style(color=41),
              string="um[4]"),
            Text(extent=[30, -50; 44, -40], string="ub[1]"),
            Text(extent=[60, -50; 74, -40], string="ub[2]"),
            Line(points=[54, -36; 54, -62], style(color=0, pattern=4)),
            Text(
              extent=[-48, 88; 64, 56],
              style(color=0),
              string="3 Fuzzy Sets"),
            Text(
              extent=[-58, 62; -20, 44],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[-4, 62; 38, 42],
              string="MEDIUM",
              style(color=41)),
            Text(extent=[58, 60; 90, 46], string="BIG"),
            Text(
              extent=[-80, 116; 86, 78],
              string="Output %name",
              style(color=41)),
            Text(
              extent=[4, -72; 98, -106],
              string="C. o. G.",
              style(color=41)),
            Text(
              extent=[-146, -72; -34, -108],
              string="Sum-Prod",
              style(color=41)),
            Rectangle(extent=[-168, -74; 104, -102], style(color=0))),
          Window(
            x=0.05,
            y=0.09,
            width=0.95,
            height=0.65));
      public
        Modelica.Blocks.Interfaces.OutPort OutPort1
          annotation (extent=[104, -8; 130, 28]);
        Version_1.cuts_v1.cut_flow_v1 In_SMALL
          annotation (extent=[-198, 64; -170, 96]);
        Version_1.cuts_v1.cut_flow_v1 In_MEDIUM
          annotation (extent=[-198, -6; -170, 26]);
        Version_1.cuts_v1.cut_flow_v1 In_BIG
          annotation (extent=[-198, -76; -170, -44]);
      equation

        mwk = In_SMALL.m;
        mwm = In_MEDIUM.m;
        mwg = In_BIG.m;

        uk = us[1] + (1 - mwk)*(us[2] - us[1]);
        uke = umin - (uk - umin);
        um1 = um[1] + mwm*(um[2] - um[1]);
        um2 = um[3] + (1 - mwm)*(um[4] - um[3]);
        ug = ub[1] + mwg*(ub[2] - ub[1]);
        uge = umax + (umax - ug);

      algorithm
        sum1 := 0;
        sum2 := 0;

        for i in 1:N loop
          u := u2e + i*(u7e - u2e)/N;

          msk := if u > u2e and u <= u1e then u/(u1e - u2e) - u2e/(u1e - u2e) else
                  if u > u1e and u <= us[1] then 1 else if u > us[1] and u <=
            us[2] then -u/(us[2] - us[1]) + us[1]/(us[2] - us[1]) + 1 else 0;
          msm := if u >= um[1] and u <= um[2] then u/(um[2] - um[1]) - um[1]/(
            um[2] - um[1]) else if u > um[2] and u <= um[3] then 1 else if u >
            um[3] and u <= um[4] then -u/(um[4] - um[3]) + um[3]/(um[4] - um[3])
             + 1 else 0;
          msg := if u > ub[1] and u <= ub[2] then u/(ub[2] - ub[1]) - ub[1]/(ub[
            2] - ub[1]) else if u > ub[2] and u <= u8e then 1 else if u > u8e
             and u <= u7e then -u/(u7e - u8e) + u8e/(u7e - u8e) + 1 else 0;

          sum1 := sum1 + u*(msk*mwk + msm*mwm + msg*mwg)*(u7e - u2e)/N;
          sum2 := sum2 + (msk*mwk + msm*mwm + msg*mwg)*(u7e - u2e)/N;

        end for;

        OutPort1.signal[1] := if noEvent(sum2 > 0) then sum1/sum2 else
          Default_output;

      end v1_output_cog_3;

      class v1_output_cog_5
        "Output with five fuzzy sets (\"VSMALL\", \"SMALL\", \"MEDIUM\", \"BIG\", VBIG\"). The method of inference is 'Sum-Prod', the method of defuzzification 'Centre of Gravity'."

        annotation (Images(Parameters(name="5setsout", source=
                  "Controller/Images/5setsout.png")));
        parameter Real umin=0 "minimum output";
        parameter Real[2] uvs={0,0.25} "VSMALL";
        parameter Real[4] us={0,0.25,0.25,0.5} "SMALL";
        parameter Real[4] um={0.25,0.5,0.5,0.75} "MEDIUM";
        parameter Real[4] ub={0.5,0.75,0.75,1} "BIG";
        parameter Real[2] uvb={0.75,1} "VBIG";
        parameter Real umax=1 "maximum output";
        parameter Integer N=100 "# of integrator steps";
        parameter Real default_output=0 "Output if no rule is active";
        Real u;
        Real mD_VSMALL;
        Real mD_SMALL;
        Real mD_MEDIUM;
        Real mD_BIG;
        Real mD_VBIG;
        Real mR;
        Real sum1;
        Real sum2;
      protected
        Real u1e=umin - (uvs[1] - umin);
        Real u2e=umin - (uvs[2] - umin);
        Real u15e=umax + (umax - uvb[1]);
        Real u16e=umax + (umax - uvb[2]);
        annotation (
          Coordsys(
            extent=[-183, -114; 130, 122],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Line(points=[-82, -40; 107, -40], style(color=0, arrow=1)),
            Line(points=[-74, -41; -74, 74], style(color=0, arrow=1)),
            Line(points=[-76, 40; -70, 40], style(color=0)),
            Text(
              extent=[-92, 46; -80, 32],
              string="1",
              style(color=0)),
            Line(points=[-67, 40; -54, 40; -36, -40], style(thickness=2)),
            Line(points=[-61, -40; -27, 40; -8, 40; 9, -39], style(color=10,
                  thickness=2)),
            Line(points=[56, -39; 76, 40; 87, 40], style(color=81, thickness=2)),
            Text(
              extent=[97, -19; 109, -33],
              string="u",
              style(color=0)),
            Text(extent=[-79, -50; -64, -58], string="umin"),
            Text(
              extent=[84, -52; 100, -60],
              string="umax",
              style(color=81)),
            Line(points=[87, 39; 87, -47], style(color=81, pattern=2)),
            Line(points=[-67, 39; -67, -48], style(color=73, pattern=2)),
            Line(points=[-54, 40; -54, -48], style(color=73, pattern=2)),
            Line(points=[-26, 39; -26, -47], style(color=10, pattern=2)),
            Line(points=[-9, 38; -9, -47], style(color=10, pattern=2)),
            Line(points=[76, 39; 76, -47], style(color=81, pattern=2)),
            Text(extent=[-61, -59; -46, -49], string="uvs[1]"),
            Text(extent=[-45, -59; -31, -49], string="uvs[2]"),
            Line(points=[-61, -40; -61, -69], style(color=10, pattern=4)),
            Text(
              extent=[-71, -83; -57, -72],
              style(color=10),
              string="us[1]"),
            Text(
              extent=[-30, -60; -16, -49],
              style(color=10),
              string="us[2]"),
            Text(
              extent=[-16, -59; -2, -50],
              style(color=10),
              string="us[3]"),
            Text(
              extent=[4, -81; 20, -73],
              style(color=10),
              string="us[4]"),
            Text(
              extent=[-40, -83; -25, -72],
              style(color=41),
              string="um[1]"),
            Text(
              extent=[12, -60; 26, -50],
              style(color=41),
              string="um[3]"),
            Line(points=[9, -41; 9, -69], style(color=10, pattern=4)),
            Text(
              extent=[-44, 83; 84, 59],
              style(color=0, pattern=0),
              string="5 Fuzzy Sets"),
            Text(extent=[-74, 54; -39, 44], string="VSMALL"),
            Text(
              extent=[-31, 54; -6, 44],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[69, 55; 93, 44],
              string="VBIG",
              style(color=81)),
            Text(
              extent=[-79, 124; 104, 77],
              string="Output %name",
              style(color=41)),
            Line(points=[-31, -40; 2, 40; 21, 40; 36, -39], style(color=41,
                  thickness=2)),
            Line(points=[3, 39; 3, -49], style(color=41, pattern=2)),
            Line(points=[20, 38; 20, -49], style(color=41, pattern=2)),
            Line(points=[-31, -41; -31, -69], style(color=41, pattern=4)),
            Line(points=[-2, -40; 31, 40; 50, 40; 65, -39], style(color=69,
                  thickness=2)),
            Line(points=[32, 40; 32, -47], style(color=69, pattern=2)),
            Line(points=[49, 39; 49, -46], style(color=69, pattern=2)),
            Text(
              extent=[-3, 55; 27, 42],
              string="MEDIUM",
              style(color=41)),
            Line(points=[-2, -41; -2, -69], style(color=69, pattern=4)),
            Line(points=[36, -41; 36, -69], style(color=41, pattern=4)),
            Text(
              extent=[-2, -61; 12, -50],
              style(color=41),
              string="um[2]"),
            Text(
              extent=[28, -82; 42, -72],
              style(color=41),
              string="um[4]"),
            Text(
              extent=[29, 54; 52, 44],
              string="BIG",
              style(color=69)),
            Text(
              extent=[-14, -82; 1, -72],
              style(color=69),
              string="ub[1]"),
            Text(
              extent=[26, -60; 39, -50],
              style(color=69),
              string="ub[2]"),
            Text(
              extent=[40, -60; 53, -50],
              style(color=69),
              string="ub[3]"),
            Line(points=[65, -41; 65, -68], style(color=69, pattern=4)),
            Text(
              extent=[64, -82; 77, -72],
              style(color=69),
              string="ub[4]"),
            Line(points=[56, -41; 56, -69], style(color=81, pattern=4)),
            Text(
              extent=[44, -82; 59, -72],
              style(color=81),
              string="uvb[1]"),
            Text(
              extent=[66, -60; 80, -50],
              style(color=81),
              string="uvb[2]"),
            Text(
              extent=[-18, -86; 112, -119],
              string="C. o. G.",
              style(color=41)),
            Text(
              extent=[-170, 66; -92, 29],
              string="SMALL",
              style(color=0)),
            Text(
              extent=[-173, -20; -103, -49],
              string="BIG",
              style(color=0)),
            Rectangle(extent=[-176, 121; 114, -114], style(color=41)),
            Text(
              extent=[-171, 107; -80, 68],
              string="VSMALL",
              style(color=0)),
            Text(
              extent=[-168, -60; -92, -91],
              string="VBIG",
              style(color=0)),
            Text(
              extent=[-167, 25; -78, -15],
              string="MEDIUM",
              style(color=0)),
            Text(
              extent=[-151, -89; -35, -115],
              string="Sum-Prod",
              style(color=41)),
            Line(points=[-176, -90; 114, -90], style(color=0))),
          Window(
            x=0.08,
            y=0.04,
            width=0.74,
            height=0.84));

      public
        Modelica.Blocks.Interfaces.OutPort OutPort1(final n=1)
          annotation (extent=[116, -10; 144, 30], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 In_VSMALL
          annotation (extent=[-208, 102; -178, 72], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 In_VBIG
          annotation (extent=[-208, -64; -178, -94], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 In_SMALL
          annotation (extent=[-208, 62; -178, 32], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 In_MEDIUM
          annotation (extent=[-208, 20; -178, -10], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 In_BIG
          annotation (extent=[-208, -22; -178, -52], layer="icon");
      algorithm

        sum1 := 0;
        sum2 := 0;

        for i in 1:N loop
          u := u2e + i*(u15e - u2e)/N;

          mD_VSMALL := if u > u2e and u <= u1e then u/(u1e - u2e) - u2e/(u1e -
            u2e) else if u > u1e and u <= uvs[1] then 1 else if u > uvs[1] and
            u <= uvs[2] then -u/(uvs[2] - uvs[1]) + uvs[1]/(uvs[2] - uvs[1]) +
            1 else 0;
          mD_SMALL := if u >= us[1] and u <= us[2] then u/(us[2] - us[1]) - us[
            1]/(us[2] - us[1]) else if u > us[2] and u <= us[3] then 1 else if
            u > us[3] and u <= us[4] then -u/(us[4] - us[3]) + us[3]/(us[4] -
            us[3]) + 1 else 0;
          mD_MEDIUM := if u >= um[1] and u <= um[2] then u/(um[2] - um[1]) - um[
            1]/(um[2] - um[1]) else if u > um[2] and u <= um[3] then 1 else if
            u > um[3] and u <= um[4] then -u/(um[4] - um[3]) + um[3]/(um[4] -
            um[3]) + 1 else 0;
          mD_BIG := if u >= ub[1] and u <= ub[2] then u/(ub[2] - ub[1]) - ub[1]
            /(ub[2] - ub[1]) else if u > ub[2] and u <= ub[3] then 1 else if u
             > ub[3] and u <= ub[4] then -u/(ub[4] - ub[3]) + ub[3]/(ub[4] - ub[
            3]) + 1 else 0;
          mD_VBIG := if u > uvb[1] and u <= uvb[2] then u/(uvb[2] - uvb[1]) -
            uvb[1]/(uvb[2] - uvb[1]) else if u > uvb[2] and u <= u16e then 1 else
                  if u > u16e and u <= u15e then -u/(u15e - u16e) + u16e/(u15e
             - u16e) + 1 else 0;

          mR := In_VSMALL.m*mD_VSMALL + In_SMALL.m*mD_SMALL + In_MEDIUM.m*
            mD_MEDIUM + In_BIG.m*mD_BIG + In_VBIG.m*mD_VBIG;

          sum1 := sum1 + u*mR*(u15e - u2e)/N;
          sum2 := sum2 + mR*(u15e - u2e)/N;

        end for;

        OutPort1.signal[1] := if noEvent(sum2 > 0) then sum1/sum2 else
          default_output;
      end v1_output_cog_5;
    end outputs;

    package rules_v1
      extends Icons.Package;

      annotation (Coordsys(
          extent=[0, 0; 443, 241],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.45,
          y=0.59,
          width=0.44,
          height=0.37,
          library=1,
          autolayout=1));
      class rule_1_1
        parameter FuzzyLogicalAddition FLA=" "
          "Fuzzy logical Addition (only 'not' available)";
        parameter Real p=1 "Priority of rule";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram,
          Icon(
            Text(
              extent=[-68, 60; 78, 14],
              string="Rule %name",
              style(color=0, pattern=0)),
            Rectangle(extent=[-96, 70; 94, -70], style(color=10)),
            Text(
              extent=[-80, 14; -4, -20],
              string="%FLA",
              style(color=45)),
            Text(
              extent=[-42, -26; 88, -64],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.22,
            y=0.16,
            width=0.73,
            height=0.6));
        Version_1.cuts_v1.cut_flow_v1 w annotation (extent=[94, 26; 130, -28]);
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-132, -26; -96, 22]);
      equation
        -w.m = if FLA <> "not" then p*InPort1.signal[1] else p*(1 - InPort1.
          signal[1]);
      end rule_1_1;

      class rule_1_2
        parameter FuzzyLogicalAddition FLA=" "
          "Fuzzy logical Addition (only 'not' available)";
        parameter Real p=1 "Priority of rule";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-72, 64; 74, 18],
              string="Rule %name",
              style(color=0, pattern=0)),
            Rectangle(extent=[-96, 70; 94, -70], style(color=10)),
            Text(
              extent=[-80, 14; -4, -20],
              string="%FLA",
              style(color=45)),
            Text(
              extent=[-42, -30; 88, -66],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65));
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 62; 130, 8], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-132, -26; -96, 22], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, -8; 130, -62], layer="icon");
      equation
        -w1.m = if FLA <> "not" then p*InPort1.signal[1] else p*(1 - InPort1.
          signal[1]);
        -w2.m = -w1.m;
      end rule_1_2;

      class rule_1_3
        parameter FuzzyLogicalAddition FLA=" "
          "Fuzzy logical Addition (only 'not' available)";
        parameter Real p=1 "Priority of rule";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-72, 82; 74, 36],
              string="Rule %name",
              style(color=0, pattern=0)),
            Rectangle(extent=[-96, 94; 94, -98], style(color=10)),
            Text(
              extent=[-80, 14; -4, -20],
              string="%FLA",
              style(color=45)),
            Text(
              extent=[-42, -46; 90, -90],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.32,
            y=0.16,
            width=0.6,
            height=0.6));
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 88; 130, 34], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-130, -24; -98, 24], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, 22; 130, -32], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w3
          annotation (extent=[94, -44; 130, -98], layer="icon");
      equation
        -w1.m = if FLA <> "not" then p*InPort1.signal[1] else p*(1 - InPort1.
          signal[1]);
        -w2.m = -w1.m;
        -w3.m = -w1.m;
      end rule_1_3;

      class rule_2_1
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition (only 'not' available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition (only 'not' available)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram,
          Icon(
            Text(
              extent=[-52, -80; 88, 74],
              string="&",
              style(color=0)),
            Text(
              extent=[-72, 96; 74, 50],
              string="Rule %name",
              style(color=0)),
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-30, -56; 90, -96],
              string="p = %p",
              style(color=0)),
            Text(
              extent=[-96, 66; -24, 26],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-96, -24; -24, -68],
              string="%FLA2",
              style(color=45)),
            Text(extent=[-138, 104; -104, 70], string="1"),
            Text(extent=[-134, 4; -100, -30], string="2")),
          Window(
            x=0.29,
            y=0.19,
            width=0.69,
            height=0.6));
        Version_1.cuts_v1.cut_flow_v1 w annotation (extent=[94, 28; 130, -24]);
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-132, 26; -98, 70]);
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-132, -70; -98, -28]);
      equation
        -w.m = if FLA1 == "not" and FLA2 == "not" then p*min(1 - InPort1.signal[
          1], 1 - InPort2.signal[1]) else if FLA1 == "not" and FLA2 <> "not" then
                p*min(1 - InPort1.signal[1], InPort2.signal[1]) else if FLA1
           <> "not" and FLA2 == "not" then p*min(InPort1.signal[1], 1 - InPort2.
           signal[1]) else p*min(InPort1.signal[1], InPort2.signal[1]);
      end rule_2_1;

      class rule_2_2

        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-60, -80; 80, 74],
              string="&",
              style(color=0)),
            Text(
              extent=[-78, 100; 78, 48],
              string="Rule %name",
              style(color=0)),
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-92, 58; -34, 16],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-92, -32; -34, -74],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-24, -56; 90, -98],
              string="p = %p",
              style(color=0)),
            Text(extent=[-134, 4; -100, -30], string="2"),
            Text(extent=[-138, 104; -104, 70], string="1")),
          Window(
            x=0.23,
            y=0.1,
            width=0.75,
            height=0.64));
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 72; 130, 20], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-128, 26; -96, 74], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-128, -76; -96, -32], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, -20; 130, -72], layer="icon");
      equation
        -w1.m = if FLA1 == "not" and FLA2 <> "not" then min((1 - InPort1.signal[
          1]), InPort2.signal[1]) else if FLA1 == "not" and FLA2 == "not" then
          min((1 - InPort1.signal[1]), (1 - InPort2.signal[1])) else if FLA1
           <> "not" and FLA2 == "not" then min(InPort1.signal[1], (1 - InPort2.
          signal[1])) else min(InPort1.signal[1], InPort2.signal[1]);

        -w2.m = -w1.m;
      end rule_2_2;

      class rule_2_3
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-52, -78; 84, 74],
              string="&",
              style(color=0)),
            Text(
              extent=[-80, 98; 76, 46],
              string="Rule %name",
              style(color=0)),
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-92, 58; -34, 16],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-92, -32; -34, -74],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-22, -56; 90, -96],
              string="p = %p",
              style(color=0)),
            Text(extent=[-134, 4; -100, -30], string="2"),
            Text(extent=[-138, 104; -104, 70], string="1")),
          Window(
            x=0.36,
            y=0.19,
            width=0.6,
            height=0.6));
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 96; 130, 44], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-130, 22; -96, 66], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-130, -74; -96, -30], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, 28; 130, -24], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w3 annotation (extent=[94, -40; 130, -92]);
      equation
        -w1.m = if FLA1 == "not" and FLA2 <> "not" then p*min((1 - InPort1.
          signal[1]), InPort2.signal[1]) else if FLA1 == "not" and FLA2 ==
          "not" then p*min((1 - InPort1.signal[1]), (1 - InPort2.signal[1])) else
                if FLA1 <> "not" and FLA2 == "not" then p*min(InPort1.signal[1],
           (1 - InPort2.signal[1])) else p*min(InPort1.signal[1], InPort2.
          signal[1]);

        -w2.m = -w1.m;

        -w3.m = -w1.m;
      end rule_2_3;

      class rule_3_1
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA3=" "
          "Fuzzy logical Addition to Input 3 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-112, -104; 121, 112],
            grid=[2, 2],
            component=[20, 20]),
          Diagram,
          Icon(
            Rectangle(extent=[-96, 112; 106, -100], style(color=10)),
            Text(
              extent=[-48, -74; 82, 76],
              string="&",
              style(color=0, pattern=0)),
            Text(
              extent=[-50, 112; 106, 62],
              string="Rule %name",
              style(color=0)),
            Text(
              extent=[-94, -46; -28, -94],
              string="%FLA3",
              style(color=45)),
            Text(
              extent=[-92, 28; -34, -26],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-94, 100; -34, 48],
              string="%FLA1",
              style(color=45)),
            Text(extent=[-122, 110; -102, 86], string="1"),
            Text(extent=[-122, 40; -102, 16], string="2"),
            Text(extent=[-124, -34; -104, -58], string="3"),
            Text(
              extent=[-34, -54; 102, -96],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.09,
            y=0.02,
            width=0.86,
            height=0.82));
        Version_1.cuts_v1.cut_flow_v1 w annotation (extent=[106, 24; 136, -20]);
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-126, 50; -98, 90]);
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-126, -22; -98, 20]);
        Modelica.Blocks.Interfaces.InPort InPort3
          annotation (extent=[-126, -92; -98, -52], layer="icon");
      equation
        -w.m = if FLA1 <> "not" and FLA2 <> "not" and FLA3 <> "not" then p*min(
          min(InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 <> "not" and FLA3 <> "not" then p*min(min(1
           - InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" and FLA3 <> "not" then p*min(min(
          InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 == "not" and FLA3 <> "not" then p*min(min(1
           - InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 <> "not" and FLA3 == "not" then p*min(
          min(InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 == "not" and FLA2 <> "not" and FLA3 == "not" then p*min(
          min(1 - InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 == "not" and FLA3 == "not" then p*min(
          min(InPort1.signal[1], 1 - InPort2.signal[1]), 1 - InPort3.signal[1]) else
                p*min(min(1 - InPort1.signal[1], 1 - InPort2.signal[1]), 1 -
          InPort3.signal[1]);
        // if FLA1 == "not" and FLA2 == "not" and FLA3 == "not"

      end rule_3_1;

      class rule_3_2
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA3=" "
          "Fuzzy logical Addition to Input 3 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-60, -72; 78, 74],
              string="&",
              style(color=0, pattern=0)),
            Text(
              extent=[-54, 102; 92, 56],
              string="Rule %name",
              style(color=0)),
            Text(
              extent=[-94, 100; -34, 48],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-92, 28; -34, -26],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-94, -46; -28, -94],
              string="%FLA3",
              style(color=45)),
            Text(
              extent=[-26, -54; 90, -96],
              string="p = %p",
              style(color=0)),
            Text(extent=[-122, 110; -102, 86], string="1"),
            Text(extent=[-122, 40; -102, 16], string="2"),
            Text(extent=[-124, -34; -104, -58], string="3")),
          Window(
            x=0.16,
            y=0,
            width=0.82,
            height=0.77));
        Modelica.Blocks.Interfaces.InPort InPort3
          annotation (extent=[-126, -92; -98, -52], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, -24; 124, -68], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-126, 50; -98, 90], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-126, -22; -98, 20], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 74; 124, 30], layer="icon");
      equation
        -w1.m = if FLA1 <> "not" and FLA2 <> "not" and FLA3 <> "not" then p*min(
          min(InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 <> "not" and FLA3 <> "not" then p*min(min(1
           - InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" and FLA3 <> "not" then p*min(min(
          InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 == "not" and FLA3 <> "not" then p*min(min(1
           - InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 <> "not" and FLA3 == "not" then p*min(
          min(InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 == "not" and FLA2 <> "not" and FLA3 == "not" then p*min(
          min(1 - InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 == "not" and FLA3 == "not" then p*min(
          min(InPort1.signal[1], 1 - InPort2.signal[1]), 1 - InPort3.signal[1]) else
                p*min(min(1 - InPort1.signal[1], 1 - InPort2.signal[1]), 1 -
          InPort3.signal[1]);
        -w2.m = -w1.m;
      end rule_3_2;

      class rule_3_3
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA3=" "
          "Fuzzy logical Addition to Input 3 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-54, -72; 86, 82],
              string="&",
              style(color=0, pattern=0)),
            Text(
              extent=[-54, 102; 92, 56],
              string="Rule %name",
              style(color=0)),
            Text(extent=[-122, 110; -102, 86], string="1"),
            Text(extent=[-122, 40; -102, 16], string="2"),
            Text(extent=[-124, -34; -104, -58], string="3"),
            Text(
              extent=[-94, -46; -28, -94],
              string="%FLA3",
              style(color=45)),
            Text(
              extent=[-92, 28; -34, -26],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-94, 100; -34, 48],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-34, -54; 90, -96],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.26,
            y=0.11,
            width=0.67,
            height=0.76));
        Modelica.Blocks.Interfaces.InPort InPort3
          annotation (extent=[-126, -92; -98, -52], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, 22; 124, -22], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-126, 50; -98, 90], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-126, -22; -98, 20], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 84; 124, 40], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w3
          annotation (extent=[94, -40; 124, -84], layer="icon");
      equation
        -w1.m = if FLA1 <> "not" and FLA2 <> "not" and FLA3 <> "not" then p*min(
          min(InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 <> "not" and FLA3 <> "not" then p*min(min(1
           - InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" and FLA3 <> "not" then p*min(min(
          InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 == "not" and FLA3 <> "not" then p*min(min(1
           - InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 <> "not" and FLA3 == "not" then p*min(
          min(InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 == "not" and FLA2 <> "not" and FLA3 == "not" then p*min(
          min(1 - InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 == "not" and FLA3 == "not" then p*min(
          min(InPort1.signal[1], 1 - InPort2.signal[1]), 1 - InPort3.signal[1]) else
                p*min(min(1 - InPort1.signal[1], 1 - InPort2.signal[1]), 1 -
          InPort3.signal[1]);
        -w2.m = -w1.m;
        -w3.m = -w1.m;
      end rule_3_3;

      class rule_2_1_or
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition (only 'not' available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition (only 'not' available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram,
          Icon(
            Text(
              extent=[-60, 62; 36, -40],
              string=">",
              style(color=0)),
            Text(
              extent=[-60, 28; 36, -74],
              string="=",
              style(color=0)),
            Text(
              extent=[18, 60; 76, -70],
              string="1",
              style(color=0)),
            Text(
              extent=[-66, 96; 80, 50],
              string="Rule %name",
              style(color=0)),
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(extent=[-138, 104; -104, 70], string="1"),
            Text(extent=[-134, 4; -100, -30], string="2"),
            Text(
              extent=[-96, 66; -24, 26],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-96, -24; -24, -68],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-30, -46; 90, -94],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.28,
            y=0.12,
            width=0.68,
            height=0.6));
        Version_1.cuts_v1.cut_flow_v1 w annotation (extent=[94, 28; 130, -24]);
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-132, 26; -98, 70]);
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-132, -70; -98, -28]);
      equation
        -w.m = if FLA1 == "not" and FLA2 == "not" then p*max(1 - InPort1.signal[
          1], 1 - InPort2.signal[1]) else if FLA1 == "not" and FLA2 <> "not" then
                p*max(1 - InPort1.signal[1], InPort2.signal[1]) else if FLA1
           <> "not" and FLA2 == "not" then p*max(InPort1.signal[1], 1 - InPort2.
           signal[1]) else p*max(InPort1.signal[1], InPort2.signal[1]);
      end rule_2_1_or;

      class rule_2_2_or
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-66, 106; 90, 54],
              string="Rule %name",
              style(color=0)),
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-62, 64; 34, -38],
              string=">",
              style(color=0)),
            Text(
              extent=[-62, 30; 34, -72],
              string="=",
              style(color=0)),
            Text(
              extent=[16, 62; 74, -68],
              string="1",
              style(color=0)),
            Text(extent=[-138, 104; -104, 70], string="1"),
            Text(extent=[-134, 4; -100, -30], string="2"),
            Text(
              extent=[-96, 66; -24, 26],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-96, -24; -24, -68],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-30, -46; 90, -94],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.23,
            y=0.01,
            width=0.71,
            height=0.76));
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 72; 130, 20], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-128, 26; -96, 74], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-128, -76; -96, -32], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, -20; 130, -72], layer="icon");
      equation
        -w1.m = if FLA1 == "not" and FLA2 == "not" then p*max(1 - InPort1.
          signal[1], 1 - InPort2.signal[1]) else if FLA1 == "not" and FLA2 <>
          "not" then p*max(1 - InPort1.signal[1], InPort2.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" then p*max(InPort1.signal[1], 1 -
          InPort2.signal[1]) else p*max(InPort1.signal[1], InPort2.signal[1]);

        -w2.m = -w1.m;
      end rule_2_2_or;

      class rule_2_3_or
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-74, 104; 82, 52],
              string="Rule %name",
              style(color=0)),
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(extent=[-138, 104; -104, 70], string="1"),
            Text(extent=[-134, 4; -100, -30], string="2"),
            Text(
              extent=[-96, 66; -24, 26],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-96, -24; -24, -68],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-30, -46; 90, -92],
              string="p = %p",
              style(color=0)),
            Text(
              extent=[-54, 66; 42, -36],
              string=">",
              style(color=0)),
            Text(
              extent=[-54, 32; 42, -70],
              string="=",
              style(color=0)),
            Text(
              extent=[24, 64; 82, -66],
              string="1",
              style(color=0))),
          Window(
            x=0.12,
            y=0.03,
            width=0.73,
            height=0.77));
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 96; 130, 44], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-130, 22; -96, 66], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-130, -74; -96, -30], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, 28; 130, -24], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w3
          annotation (extent=[94, -40; 130, -92], layer="icon");
      equation
        -w1.m = if FLA1 == "not" and FLA2 == "not" then p*max(1 - InPort1.
          signal[1], 1 - InPort2.signal[1]) else if FLA1 == "not" and FLA2 <>
          "not" then p*max(1 - InPort1.signal[1], InPort2.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" then p*max(InPort1.signal[1], 1 -
          InPort2.signal[1]) else p*max(InPort1.signal[1], InPort2.signal[1]);

        -w2.m = -w1.m;

        -w3.m = -w1.m;
      end rule_2_3_or;

      class rule_3_1_or
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA3=" "
          "Fuzzy logical Addition to Input 3 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-54, 102; 92, 56],
              string="Rule %name",
              style(color=0)),
            Text(
              extent=[-60, 32; 36, -70],
              string="=",
              style(color=0)),
            Text(
              extent=[-60, 66; 36, -36],
              string=">",
              style(color=0)),
            Text(
              extent=[18, 64; 76, -66],
              string="1",
              style(color=0)),
            Text(extent=[-122, 110; -102, 86], string="1"),
            Text(extent=[-122, 40; -102, 16], string="2"),
            Text(extent=[-124, -34; -104, -58], string="3"),
            Text(
              extent=[-94, 100; -34, 48],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-92, 28; -34, -26],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-94, -46; -34, -92],
              string="%FLA3",
              style(color=45)),
            Text(
              extent=[-34, -54; 90, -96],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.22,
            y=0.05,
            width=0.72,
            height=0.82));
        Modelica.Blocks.Interfaces.InPort InPort3
          annotation (extent=[-126, -92; -98, -52], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w
          annotation (extent=[94, 22; 124, -22], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-126, 50; -98, 90], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-126, -22; -98, 20], layer="icon");
      equation
        -w.m = if FLA1 <> "not" and FLA2 <> "not" and FLA3 <> "not" then p*max(
          max(InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 <> "not" and FLA3 <> "not" then p*max(max(1
           - InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" and FLA3 <> "not" then p*max(max(
          InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 == "not" and FLA3 <> "not" then p*max(max(1
           - InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 <> "not" and FLA3 == "not" then p*max(
          max(InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 == "not" and FLA2 <> "not" and FLA3 == "not" then p*max(
          max(1 - InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 == "not" and FLA3 == "not" then p*max(
          max(InPort1.signal[1], 1 - InPort2.signal[1]), 1 - InPort3.signal[1]) else
                p*max(max(1 - InPort1.signal[1], 1 - InPort2.signal[1]), 1 -
          InPort3.signal[1]);
        // if FLA1 == "not" and FLA2 == "not" and FLA3 == "not"
      end rule_3_1_or;

      class rule_3_2_or
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA3=" "
          "Fuzzy logical Addition to Input 3 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-50, 104; 96, 58],
              string="Rule %name",
              style(color=0)),
            Text(
              extent=[-60, 66; 36, -36],
              string=">",
              style(color=0)),
            Text(
              extent=[-60, 32; 36, -70],
              string="=",
              style(color=0)),
            Text(
              extent=[18, 68; 82, -66],
              string="1",
              style(color=0)),
            Text(extent=[-122, 110; -102, 86], string="1"),
            Text(extent=[-122, 40; -102, 16], string="2"),
            Text(extent=[-124, -34; -104, -58], string="3"),
            Text(
              extent=[-94, 100; -34, 48],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-92, 28; -34, -26],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-94, -46; -30, -92],
              string="%FLA3",
              style(color=45)),
            Text(
              extent=[-38, -48; 92, -94],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.19,
            y=0.04,
            width=0.7,
            height=0.78));
        Modelica.Blocks.Interfaces.InPort InPort3
          annotation (extent=[-126, -92; -98, -52], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, -24; 124, -68], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-126, 50; -98, 90], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-126, -22; -98, 20], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 74; 124, 30], layer="icon");
      equation
        -w1.m = if FLA1 <> "not" and FLA2 <> "not" and FLA3 <> "not" then p*max(
          max(InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 <> "not" and FLA3 <> "not" then p*max(max(1
           - InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" and FLA3 <> "not" then p*max(max(
          InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 == "not" and FLA3 <> "not" then p*max(max(1
           - InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 <> "not" and FLA3 == "not" then p*max(
          max(InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 == "not" and FLA2 <> "not" and FLA3 == "not" then p*max(
          max(1 - InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 == "not" and FLA3 == "not" then p*max(
          max(InPort1.signal[1], 1 - InPort2.signal[1]), 1 - InPort3.signal[1]) else
                p*max(max(1 - InPort1.signal[1], 1 - InPort2.signal[1]), 1 -
          InPort3.signal[1]);
        // if FLA1 == "not" and FLA2 == "not" and FLA3 == "not"

        -w2.m = -w1.m;
      end rule_3_2_or;

      class rule_3_3_or
        parameter FuzzyLogicalAddition FLA1=" "
          "Fuzzy logical Addition to Input 1 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA2=" "
          "Fuzzy logical Addition to Input 2 (only 'not' is available)";
        parameter FuzzyLogicalAddition FLA3=" "
          "Fuzzy logical Addition to Input 3 (only 'not' is available)";
        parameter Real p=1 "Priority of rule (p = 0 ... 1)";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-96, 100; 94, -100], style(color=10)),
            Text(
              extent=[-50, 98; 96, 52],
              string="Rule %name",
              style(color=0)),
            Text(
              extent=[-54, 66; 42, -36],
              string=">",
              style(color=0)),
            Text(
              extent=[-54, 32; 42, -70],
              string="=",
              style(color=0)),
            Text(
              extent=[24, 64; 82, -66],
              string="1",
              style(color=0)),
            Text(extent=[-122, 110; -102, 86], string="1"),
            Text(extent=[-122, 40; -102, 16], string="2"),
            Text(extent=[-124, -34; -104, -58], string="3"),
            Text(
              extent=[-94, 100; -34, 48],
              string="%FLA1",
              style(color=45)),
            Text(
              extent=[-92, 28; -34, -26],
              string="%FLA2",
              style(color=45)),
            Text(
              extent=[-94, -46; -34, -92],
              string="%FLA3",
              style(color=45)),
            Text(
              extent=[-34, -54; 90, -96],
              string="p = %p",
              style(color=0))),
          Window(
            x=0.33,
            y=0.19,
            width=0.6,
            height=0.6));
        Modelica.Blocks.Interfaces.InPort InPort3
          annotation (extent=[-126, -92; -98, -52], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w2
          annotation (extent=[94, 22; 124, -22], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1
          annotation (extent=[-126, 50; -98, 90], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort2
          annotation (extent=[-126, -22; -98, 20], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w1
          annotation (extent=[94, 84; 124, 40], layer="icon");
        Version_1.cuts_v1.cut_flow_v1 w3
          annotation (extent=[94, -40; 124, -84], layer="icon");
      equation
        -w1.m = if FLA1 <> "not" and FLA2 <> "not" and FLA3 <> "not" then p*max(
          max(InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 <> "not" and FLA3 <> "not" then p*max(max(1
           - InPort1.signal[1], InPort2.signal[1]), InPort3.signal[1]) else if
          FLA1 <> "not" and FLA2 == "not" and FLA3 <> "not" then p*max(max(
          InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
          if FLA1 == "not" and FLA2 == "not" and FLA3 <> "not" then p*max(max(1
           - InPort1.signal[1], 1 - InPort2.signal[1]), InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 <> "not" and FLA3 == "not" then p*max(
          max(InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 == "not" and FLA2 <> "not" and FLA3 == "not" then p*max(
          max(1 - InPort1.signal[1], InPort2.signal[1]), 1 - InPort3.signal[1]) else
                if FLA1 <> "not" and FLA2 == "not" and FLA3 == "not" then p*max(
          max(InPort1.signal[1], 1 - InPort2.signal[1]), 1 - InPort3.signal[1]) else
                p*max(max(1 - InPort1.signal[1], 1 - InPort2.signal[1]), 1 -
          InPort3.signal[1]);
        // if FLA1 == "not" and FLA2 == "not" and FLA3 == "not"

        -w2.m = -w1.m;
        -w3.m = -w1.m;
      end rule_3_3_or;

      type FuzzyLogicalAddition = String annotation (choices(choice="not"
            "not (input negated)", choice=" " "- no addition -"));

    end rules_v1;

    package cuts_v1
      extends Icons.Package;
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
      connector cut_flow_v1
        flow Real m;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram(Polygon(points=[-96, 98; -96, -100; 102, -2; -96, 98], style(
                  color=10, fillPattern=0)), Text(extent=[46, -46; -94, 56],
                string="%name")),
          Window(
            x=0.24,
            y=0.13,
            width=0.6,
            height=0.6),
          Icon(Polygon(points=[-96, 98; -96, -100; 102, -2; -96, 98], style(
                  color=10, fillPattern=0))));
      end cut_flow_v1;
    end cuts_v1;
  end Version_1;

  package Version_2
    extends Icons.Package;
    annotation (Coordsys(
        extent=[0, 0; 443, 453],
        grid=[2, 2],
        component=[20, 20]), Window(
        x=0.01,
        y=0.28,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));
    package inputs_v2
      extends Icons.Package;
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

      class v2_input_3
        "Input with three fuzzy sets: \"small\", \"medium\", \"big\" "

        annotation (Images(Parameters(name="3setsin", source=
                  "Controller/Images/3setsin.png")));
        parameter Real emin=0 "minimum of input";
        parameter Real emax=1 "maximum of input";
        parameter Real[2] es={0,0.5} "small";

        parameter Real[4] em={0,0.5,0.5,1} "medium";

        parameter Real[2] eb={0.5,1} "big";

        parameter Real out_minus=0 "value of 'small' if input < emin";
        parameter Real out_plus=0 "value of 'big' if input > emax";
        parameter Boolean SAMPLE=false "Sampled controller";
        parameter Real T_sample=0.1 "sample period in s";
        parameter Real T_0=0 "time of first sample in s";
        Real e;
        annotation (
          Coordsys(
            extent=[-111, -100; 121, 108],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-94, 100; 96, -100], style(color=73, thickness=2)),
            Line(points=[-78, -48; 92, -48], style(color=0, arrow=1)),
            Line(points=[-72, -48; -72, 50], style(color=0, arrow=1)),
            Line(points=[-74, 32; -68, 32], style(color=0)),
            Text(
              extent=[-90, 38; -78, 24],
              string="1",
              style(color=0)),
            Line(points=[-58, 32; -38, 32; -10, -48], style(color=10, thickness=
                   2)),
            Line(points=[-50, -48; 2, 32; 22, 32; 48, -48], style(color=41,
                  thickness=2)),
            Line(points=[32, -48; 60, 32; 74, 32], style(color=69, thickness=2)),
            Text(
              extent=[80, -30; 92, -44],
              string="e",
              style(color=0)),
            Text(
              extent=[-70, -52; -52, -64],
              string="emin",
              style(color=0)),
            Text(
              extent=[70, -52; 90, -64],
              string="emax",
              style(color=0)),
            Line(points=[74, 28; 74, -52], style(color=0, pattern=2)),
            Line(points=[-58, 28; -58, -54], style(color=0, pattern=2)),
            Line(points=[-38, 28; -38, -52], style(color=0, pattern=2)),
            Line(points=[2, 28; 2, -72], style(color=0, pattern=2)),
            Line(points=[22, 28; 22, -72], style(color=0, pattern=2)),
            Line(points=[60, 28; 60, -52], style(color=0, pattern=2)),
            Text(
              extent=[-46, -64; -28, -52],
              style(color=10),
              string="es[1]"),
            Text(
              extent=[-20, -66; -2, -52],
              style(color=10),
              string="es[2]"),
            Line(points=[-50, -48; -50, -72], style(color=0, pattern=4)),
            Text(
              extent=[-58, -82; -40, -70],
              style(color=41),
              string="em[1]"),
            Text(
              extent=[-10, -82; 8, -70],
              style(color=41),
              string="em[2]"),
            Text(
              extent=[14, -82; 32, -70],
              style(color=41),
              string="em[3]"),
            Text(
              extent=[40, -82; 58, -70],
              style(color=41),
              string="em[4]"),
            Text(
              extent=[24, -62; 42, -52],
              style(color=69),
              string="eb[1]"),
            Text(
              extent=[52, -62; 68, -52],
              style(color=69),
              string="eb[2]"),
            Line(points=[48, -48; 48, -74], style(color=0, pattern=4)),
            Text(
              extent=[-52, 72; 48, 46],
              style(color=0, thickness=4),
              string="3 Fuzzy Sets"),
            Text(
              extent=[-64, 50; -26, 32],
              string="small",
              style(color=10)),
            Text(
              extent=[-10, 50; 32, 30],
              string="medium",
              style(color=41)),
            Text(
              extent=[46, 50; 84, 32],
              string="big",
              style(color=69)),
            Text(
              extent=[-62, 108; 54, 56],
              string="Input %name",
              style(color=73, thickness=4)),
            Text(
              extent=[64, 96; 88, 70],
              string="V II",
              style(color=0))),
          Diagram,
          Window(
            x=0.08,
            y=0.1,
            width=0.77,
            height=0.78));

        Modelica.Blocks.Interfaces.InPort In
          annotation (extent=[-128, -14; -96, 28], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 Out
          annotation (extent=[98, -20; 144, 30], layer="icon");
      equation

        if SAMPLE then
          when sample(T_0, T_sample) then
            e = pre(In.signal[1]);
          end when;
        else
          e = In.signal[1];
        end if;

        -Out.s[1] = 0;

        -Out.s[2] = if e < emin then out_minus else if e >= emin and e < es[1] then
                1 else if e >= es[1] and e < es[2] then e/(es[1] - es[2]) + es[
          1]/(es[2] - es[1]) + 1 else 0;

        -Out.s[3] = if e >= em[1] and e < em[2] then e/(em[2] - em[1]) - em[1]/
          (em[2] - em[1]) else if e >= em[2] and e < em[3] then 1 else if e >=
          em[3] and e < em[4] then -e/(em[4] - em[3]) + em[3]/(em[4] - em[3])
           + 1 else 0;

        -Out.s[4] = if e < eb[1] then 0 else if e >= eb[1] and e < eb[2] then e
          /(eb[2] - eb[1]) - eb[1]/(eb[2] - eb[1]) else if e >= eb[2] and e <
          emax then 1 else out_plus;

        -Out.s[5] = 0;

      end v2_input_3;

      class v2_input_5
        "Input with five fuzzy sets: \"vsmall\", \"small\", \"medium\", \"big\", \"vbig\" "

        annotation (Images(Parameters(name="5setsin", source=
                  "Controller/Images/5setsin.png")));
        parameter Real emin=0 "minimum of input";
        parameter Real emax=1 "minimum of input";
        parameter Real[2] evs={0,0.25} "vsmall";
        parameter Real[4] es={0,0.25,0.25,0.5} "small";

        parameter Real[4] em={0.25,0.5,0.5,0.75} "medium";

        parameter Real[4] eb={0.5,0.75,0.75,1} "big";

        parameter Real[2] evb={0.75,1} "vbig";

        parameter Real out_minus=0
          "value of 'vsmall' (very small) if input < emin";
        parameter Real out_plus=0 "value of 'vbig' (very big) if input > emax";
        Real e;
        parameter Boolean SAMPLE=false "Sampled controller";
        parameter Real T_sample=0.1 "sample period in s";
        parameter Real T_0=0 "time of first sample in s";
        annotation (
          Coordsys(
            extent=[-143.5, -100; 140, 112],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-127, 111; 115, -100], style(color=73, thickness=
                    2)),
            Line(points=[-96, -40; 93, -40], style(color=0, arrow=1)),
            Line(points=[-88, -41; -88, 74], style(color=0, arrow=1)),
            Line(points=[-90, 40; -84, 40], style(color=0)),
            Text(
              extent=[-108, 47; -96, 33],
              string="1",
              style(color=0)),
            Line(points=[-81, 40; -68, 40; -50, -40], style(thickness=2)),
            Line(points=[-75, -40; -41, 40; -22, 40; -5, -39], style(color=10,
                  thickness=2)),
            Line(points=[42, -39; 62, 40; 73, 40], style(color=81, thickness=2)),
            Text(
              extent=[84, -16; 96, -30],
              string="e",
              style(color=0)),
            Text(extent=[-94, -46; -78, -57], string="emin"),
            Text(
              extent=[70, -46; 89, -55],
              string="emax",
              style(color=81)),
            Line(points=[73, 39; 73, -47], style(color=81, pattern=2)),
            Line(points=[-81, 39; -81, -48], style(color=73, pattern=2)),
            Line(points=[-68, 40; -68, -40], style(color=73, pattern=2)),
            Line(points=[-40, 39; -40, -50], style(color=10, pattern=2)),
            Line(points=[-23, 38; -23, -50], style(color=10, pattern=2)),
            Line(points=[62, 40; 62, -40], style(color=81, pattern=2)),
            Text(extent=[-76, -50; -60, -40], string="evs[1]"),
            Text(extent=[-60, -50; -44, -39], string="evs[2]"),
            Line(points=[-75, -40; -75, -66], style(color=10, pattern=4)),
            Text(
              extent=[-82, -74; -69, -65],
              style(color=10),
              string="es[1]"),
            Text(
              extent=[-46, -59; -32, -49],
              style(color=10),
              string="es[2]"),
            Text(
              extent=[-31, -60; -17, -48],
              style(color=10),
              string="es[3]"),
            Text(
              extent=[-10, -74; 4, -66],
              style(color=10),
              string="es[4]"),
            Text(
              extent=[-54, -74; -38, -64],
              style(color=41),
              string="em[1]"),
            Text(
              extent=[-1, -49; 15, -38],
              style(color=41),
              string="em[3]"),
            Line(points=[-5, -41; -5, -66], style(color=10, pattern=4)),
            Text(
              extent=[-66, 80; 37, 55],
              style(color=0),
              string="5 Fuzzy Sets"),
            Text(extent=[-88, 54; -53, 44], string="vsmall"),
            Text(
              extent=[-45, 54; -20, 44],
              string="small",
              style(color=10)),
            Text(
              extent=[57, 55; 80, 45],
              string="vbig",
              style(color=81)),
            Text(
              extent=[-72, 112; 48, 70],
              string="Input %name",
              style(color=73)),
            Line(points=[-45, -40; -12, 40; 7, 40; 22, -39], style(color=41,
                  thickness=2)),
            Line(points=[-11, 39; -11, -40], style(color=41, pattern=2)),
            Line(points=[6, 38; 6, -40], style(color=41, pattern=2)),
            Line(points=[-45, -40; -45, -68], style(color=41, pattern=4)),
            Line(points=[-16, -40; 17, 40; 36, 40; 51, -39], style(color=69,
                  thickness=2)),
            Line(points=[18, 40; 18, -47], style(color=69, pattern=2)),
            Line(points=[35, 39; 35, -46], style(color=69, pattern=2)),
            Text(
              extent=[-17, 55; 12, 43],
              string="medium",
              style(color=41)),
            Line(points=[-16, -41; -16, -69], style(color=69, pattern=4)),
            Line(points=[22, -41; 22, -69], style(color=41, pattern=4)),
            Text(
              extent=[-18, -49; -2, -38],
              style(color=41),
              string="em[2]"),
            Text(
              extent=[13, -77; 30, -64],
              style(color=41),
              string="em[4]"),
            Text(
              extent=[15, 54; 38, 44],
              string="big",
              style(color=69)),
            Text(
              extent=[-25, -75; -11, -65],
              style(color=69),
              string="eb[1]"),
            Text(
              extent=[12.5, -58; 26.5, -48],
              style(color=69),
              string="eb[2]"),
            Text(
              extent=[27, -59; 42, -48],
              style(color=69),
              string="eb[3]"),
            Line(points=[51, -41; 51, -68], style(color=69, pattern=4)),
            Text(
              extent=[49, -74; 64, -65],
              style(color=69),
              string="eb[4]"),
            Line(points=[42, -41; 42, -41], style(color=81, pattern=4)),
            Text(
              extent=[35, -49; 53, -38],
              style(color=81),
              string="evb[1]"),
            Text(
              extent=[53, -49; 71, -38],
              style(color=81),
              string="evb[2]"),
            Text(
              extent=[76, 104; 104, 76],
              string="V  II",
              style(color=0, pattern=0))),
          Window(
            x=0.03,
            y=0.08,
            width=0.73,
            height=0.83));

        Modelica.Blocks.Interfaces.InPort In(final n=1)
          annotation (extent=[-159, -10; -128, 28], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 Out
          annotation (extent=[117, -18; 163, 32], layer="icon");
      equation

        if SAMPLE then
          when sample(T_0, T_sample) then
            e = pre(In.signal[1]);
          end when;
        else
          e = In.signal[1];
        end if;

        -Out.s[1] = if e < emin then out_minus else if e >= emin and e < evs[1] then
                1 else if e >= evs[1] and e < evs[2] then -e/(evs[2] - evs[1])
           + evs[1]/(evs[2] - evs[1]) + 1 else 0;

        -Out.s[2] = if e >= es[1] and e < es[2] then e/(es[2] - es[1]) - es[1]/
          (es[2] - es[1]) else if e >= es[2] and e < es[3] then 1 else if e >=
          es[3] and e < es[4] then -e/(es[4] - es[3]) + es[3]/(es[4] - es[3])
           + 1 else 0;

        -Out.s[3] = if e >= em[1] and e < em[2] then e/(em[2] - em[1]) - em[1]/
          (em[2] - em[1]) else if e >= em[2] and e < em[3] then 1 else if e >=
          em[3] and e < em[4] then -e/(em[4] - em[3]) + em[3]/(em[4] - em[3])
           + 1 else 0;

        -Out.s[4] = if e >= eb[1] and e < eb[2] then e/(eb[2] - eb[1]) - eb[1]/
          (eb[2] - eb[1]) else if e >= eb[2] and e < eb[3] then 1 else if e >=
          eb[3] and e < eb[4] then -e/(eb[4] - eb[3]) + eb[3]/(eb[4] - eb[3])
           + 1 else 0;

        -Out.s[5] = if e >= evb[1] and e < evb[2] then e/(evb[2] - evb[1]) -
          evb[1]/(evb[2] - evb[1]) else if e >= evb[2] and e < emax then 1 else
                if e >= emax then out_plus else 0;
      end v2_input_5;
    end inputs_v2;

    package outputs_v2

      extends Icons.Package;
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
      class v2_output_cos_3
        "Output with three fuzzy sets (\"SMALL\", \"MEDIUM\", \"BIG\"). The method of defuzzification is 'Centre of Singletons'."

        annotation (Images(Parameters(name="cos3", source="Controller/Images/cos3.png")));
        parameter Real u1=0 "SMALL";
        parameter Real u2=0.5 "MEDIUM";
        parameter Real u3=1 "BIG";
        parameter Real default_output=0 "output if no rule is active";
        annotation (
          Coordsys(
            extent=[-108, -108; 110, 102],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-54, -82; 52, -110],
              string="C. o. S.",
              style(color=0)),
            Rectangle(extent=[-110, 100; 96, -108], style(color=41, thickness=2)),
            Text(
              extent=[-78, 102; 50, 72],
              string="Output %name",
              style(color=41)),
            Text(
              extent=[-63, 76; 54, 56],
              style(color=0),
              string="3 Fuzzy Sets"),
            Text(
              extent=[60, 98; 88, 66],
              string="V  II",
              style(color=0)),
            Line(points=[-68, -62; 84, -62], style(color=0, arrow=1)),
            Line(points=[-60, -70; -60, 54], style(color=0, arrow=1)),
            Line(points=[-64, 34; -56, 34], style(color=0)),
            Text(
              extent=[-78, 40; -66, 26],
              string="1",
              style(color=0)),
            Text(
              extent=[69, -37; 81, -51],
              string="u",
              style(color=0)),
            Text(
              extent=[-44, -82; -22, -64],
              string="u1",
              style(color=10)),
            Text(
              extent=[-2, -82; 22, -64],
              string="u2",
              style(color=41)),
            Text(
              extent=[41, -83; 62, -66],
              string="u3",
              style(color=73)),
            Text(
              extent=[-44, 48; -20, 36],
              string="small",
              style(color=10)),
            Text(
              extent=[-10, 48; 26, 36],
              string="medium",
              style(color=41)),
            Text(
              extent=[38, 48; 62, 36],
              string="big",
              style(color=73)),
            Line(points=[-30, 32; -30, -60], style(color=10, thickness=2)),
            Line(points=[12, 32; 12, -60], style(color=41, thickness=2)),
            Line(points=[52, 32; 52, -60], style(color=73, thickness=2)),
            Line(points=[-108, -82; 96, -82], style(color=0))),
          Diagram,
          Window(
            x=0.04,
            y=0.14,
            width=0.9,
            height=0.82));

        Modelica.Blocks.Interfaces.OutPort Out
          annotation (extent=[96, -16; 124, 22]);
        Modelica.Blocks.Interfaces.InPort In(n=5)
          annotation (extent=[-140, -20; -112, 18]);
      equation

        // Centre of singleton:

        Out.signal[1] = if noEvent(In.signal[2] + In.signal[3] + In.signal[4]
           > 0) then (u1*In.signal[2] + u2*In.signal[3] + u3*In.signal[4])/(In.
          signal[2] + In.signal[3] + In.signal[4]) else default_output;

      end v2_output_cos_3;

      class v2_output_cos_5
        "Output with five fuzzy sets (\"VSMALL\", \"SMALL\", \"MEDIUM\", \"BIG\", VBIG\"). The method of defuzzification is 'Centre of Singletons'"

        annotation (Images(Parameters(name="cos3", source="Controller/Images/cos5.png")));
        parameter Real u1=0 "VSMALL";
        parameter Real u2=0.25 "SMALL";
        parameter Real u3=0.5 "MEDIUM";
        parameter Real u4=0.75 "BIG";
        parameter Real u5=1 "VBIG";
        parameter Real default_output=0 "output if no rule is active";
        annotation (
          Coordsys(
            extent=[-112, -108; 132, 106],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Line(points=[-82, -54; 107, -54], style(color=0, arrow=1)),
            Line(points=[-74, -62; -74, 74], style(color=0, arrow=1)),
            Line(points=[-76, 40; -70, 40], style(color=0)),
            Text(
              extent=[-92, 44; -80, 30],
              string="1",
              style(color=0)),
            Text(
              extent=[95, -27; 107, -41],
              string="u",
              style(color=0)),
            Text(extent=[-68, -76; -44, -58], string="u1"),
            Text(
              extent=[-32, -76; -10, -58],
              string="u2",
              style(color=10)),
            Text(
              extent=[-4, -76; 20, -58],
              string="u3",
              style(color=41)),
            Text(
              extent=[39, -75; 60, -58],
              string="u4",
              style(color=69)),
            Text(
              extent=[68, -76; 94, -58],
              string="u5",
              style(color=81)),
            Text(
              extent=[-52, 80; 42, 58],
              style(color=0, pattern=0),
              string="5 Fuzzy Sets "),
            Text(extent=[-72, 58; -38, 40], string="VSMALL"),
            Text(
              extent=[-36, 56; -6, 44],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[68, 54; 94, 44],
              string="VBIG",
              style(color=81)),
            Text(
              extent=[-2, 58; 32, 42],
              string="MEDIUM",
              style(color=41)),
            Text(
              extent=[38, 54; 60, 44],
              string="BIG",
              style(color=69)),
            Line(points=[-56, 40; -56, -52], style(thickness=2)),
            Line(points=[-18, 40; -18, -52], style(color=10, thickness=2)),
            Line(points=[18, 40; 18, -52], style(color=41, thickness=2)),
            Line(points=[50, 40; 50, -52], style(color=69, thickness=2)),
            Line(points=[82, 40; 82, -52], style(color=81, thickness=2)),
            Rectangle(extent=[-114, 106; 116, -108], style(color=41, thickness=
                    2)),
            Text(
              extent=[-50, -76; 60, -106],
              string="C. o. S.",
              style(color=0)),
            Text(
              extent=[76, 104; 104, 72],
              string="V  II",
              style(color=0)),
            Text(
              extent=[-78, 108; 60, 76],
              string="Output %name",
              style(color=41)),
            Line(points=[-114, -76; 116, -76], style(color=0))),
          Window(
            x=0.12,
            y=0.04,
            width=0.63,
            height=0.67));
        Modelica.Blocks.Interfaces.InPort In(n=5)
          annotation (extent=[-144, -18; -116, 22], layer="icon");
        Modelica.Blocks.Interfaces.OutPort Out
          annotation (extent=[118, -18; 146, 24], layer="icon");
      equation
        Out.signal[1] = if noEvent(In.signal[1] + In.signal[2] + In.signal[3]
           + In.signal[4] + In.signal[5] > 0) then (u1*In.signal[1] + u2*In.
          signal[2] + u3*In.signal[3] + u4*In.signal[4] + u5*In.signal[5])/(In.
          signal[1] + In.signal[2] + In.signal[3] + In.signal[4] + In.signal[5]) else
                default_output;
      end v2_output_cos_5;

      class v2_output_rbe_3
        "Output with three fuzzy sets (\"SMALL\", \"MEDIUM\", \"BIG\"). The method of defuzzification is 'Minimum of Rule Base Error'"

        annotation (Images(Parameters(name="3setsout", source=
                  "Controller/Images/3setsout.png")));
        parameter Real umin=0 "minimum of output";
        parameter Real[2] us={0,0.5} "SMALL";
        parameter Real[4] um={0,0.5,0.5,1} "MEDIUM";
        parameter Real[2] ub={0.5,1} "BIG";

        parameter Real umax=1 "maximum of output";
        parameter Real c=0 "degree of compromise (c = 0 ... 1)";
        parameter Boolean c0=false
          "compromise if c=0 and minimum of RBE is not unique?";
        constant Integer L=4 "Zahl der Knickstellen";
        Real uk[L];
        Integer guk[L];
        Real e[L];
        Real d[L];
        Real mwk;
        Real mwm;
        Real mwg;
        Real mw[L];
        Real eplus;
        Real eminus;
        Real sum1;
        Real sum2;
        Real u;
        Real yklein;
        Real ymittel;
        Real ygross;
        Real h1;
        Integer h2;
        Real h3;
        constant Real epsilon=0.000001;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Line(points=[-80, -40; 90, -40], style(color=0, arrow=1)),
            Line(points=[-74, -40; -74, 58], style(color=0, arrow=1)),
            Line(points=[-76, 40; -70, 40], style(color=0)),
            Text(
              extent=[-94, 46; -82, 32],
              string="1",
              style(color=0)),
            Line(points=[-60, 40; -40, 40; -12, -40], style(color=10, thickness=
                   2)),
            Line(points=[-52, -40; 0, 40; 20, 40; 46, -40], style(color=41,
                  thickness=2)),
            Line(points=[30, -40; 58, 40; 72, 40], style(color=69, thickness=2)),
            Text(
              extent=[80, -18; 92, -32],
              string="u",
              style(color=0)),
            Text(
              extent=[-72, -44; -55, -55],
              string="umin",
              style(color=0)),
            Text(
              extent=[68, -44; 88, -56],
              string="umax",
              style(color=0)),
            Line(points=[72, 36; 72, -44], style(color=0, pattern=2)),
            Line(points=[-60, 36; -60, -46], style(color=0, pattern=2)),
            Line(points=[-40, 36; -40, -44], style(color=0, pattern=2)),
            Line(points=[0, 36; 0, -64], style(color=0, pattern=2)),
            Line(points=[20, 36; 20, -64], style(color=0, pattern=2)),
            Line(points=[58, 36; 58, -44], style(color=0, pattern=2)),
            Text(
              extent=[-48, -54; -34, -44],
              style(color=10),
              string="us[1]"),
            Text(
              extent=[-20, -54; -6, -44],
              style(color=10),
              string="us[2]"),
            Line(points=[-52, -40; -52, -64], style(color=0, pattern=4)),
            Text(
              extent=[-60, -74; -46, -64],
              style(color=41),
              string="um[1]"),
            Text(
              extent=[-8, -74; 6, -64],
              style(color=41),
              string="um[2]"),
            Text(
              extent=[14, -74; 28, -64],
              style(color=41),
              string="um[3]"),
            Text(
              extent=[38, -74; 52, -64],
              style(color=41),
              string="um[4]"),
            Text(
              extent=[22, -54; 36, -44],
              style(color=69),
              string="ub[1]"),
            Text(
              extent=[52, -54; 66, -44],
              style(color=69),
              string="ub[2]"),
            Line(points=[46, -40; 46, -66], style(color=41, pattern=4)),
            Text(
              extent=[-67, 76; 54, 56],
              style(color=0),
              string="3 Fuzzy Sets"),
            Text(
              extent=[-66, 58; -26, 38],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[-12, 58; 30, 38],
              string="MEDIUM",
              style(color=41)),
            Text(
              extent=[48, 54; 82, 40],
              string="BIG",
              style(color=69)),
            Rectangle(extent=[-100, 100; 100, -100], style(color=41, thickness=
                    2)),
            Text(
              extent=[-15, -76; 26, -102],
              string="RBE",
              style(color=0)),
            Text(
              extent=[65, 100; 93, 68],
              string="V  II",
              style(color=0)),
            Text(
              extent=[-72, 102; 56, 72],
              string="Output %name",
              style(color=41)),
            Line(points=[-100, -75; 100, -75], style(color=0))),
          Window(
            x=0.07,
            y=0.01,
            width=0.89,
            height=0.92));

        Modelica.Blocks.Interfaces.OutPort Out(final n=1)
          annotation (extent=[102, -14; 130, 26], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1(final n=5)
          annotation (extent=[-128, -16; -102, 20]);
      equation
        mwk = InPort1.signal[2];
        mwm = InPort1.signal[3];
        mwg = InPort1.signal[4];

        mw[1] = mwk;
        mw[2] = mwm;
        mw[3] = mwm;
        mw[4] = mwg;

      algorithm
        uk[1] := us[1] + (1 - mwk)*(us[2] - us[1]);
        uk[2] := um[1] + mwm*(um[2] - um[1]);
        uk[3] := um[3] + (1 - mwm)*(um[4] - um[3]);
        uk[4] := ub[1] + mwg*(ub[2] - ub[1]);

        for j in 1:L loop

          u := uk[j];

          yklein := if u <= us[1] then 1 else if u > us[1] and u <= us[2] then
            -u/(us[2] - us[1]) + us[1]/(us[2] - us[1]) + 1 else 0;
          ymittel := if u <= um[1] then 0 else if u > um[1] and u <= um[2] then
                  u/(um[2] - um[1]) - um[1]/(um[2] - um[1]) else if u > um[2]
             and u <= um[3] then 1 else if u > um[3] and u <= um[4] then -u/(um[
            4] - um[3]) + um[3]/(um[4] - um[3]) + 1 else 0;
          ygross := if u <= ub[1] then 0 else if u > ub[1] and u <= ub[2] then
            u/(ub[2] - ub[1]) - ub[1]/(ub[2] - ub[1]) else 1;

          e[j] := 0;

          e[j] := e[j] + min(mwk, abs(mwk - yklein)) + min(mwm, abs(mwm -
            ymittel)) + min(mwg, abs(mwg - ygross));

          eplus := 0;
          eminus := 0;

          u := uk[j] + (umax - umin)/1000;

          yklein := if u <= us[1] then 1 else if u > us[1] and u <= us[2] then
            -u/(us[2] - us[1]) + us[1]/(us[2] - us[1]) + 1 else 0;
          ymittel := if u <= um[1] then 0 else if u > um[1] and u <= um[2] then
                  u/(um[2] - um[1]) - um[1]/(um[2] - um[1]) else if u > um[2]
             and u <= um[3] then 1 else if u > um[3] and u <= um[4] then -u/(um[
            4] - um[3]) + um[3]/(um[4] - um[3]) + 1 else 0;
          ygross := if u <= ub[1] then 0 else if u > ub[1] and u <= ub[2] then
            u/(ub[2] - ub[1]) - ub[1]/(ub[2] - ub[1]) else 1;

          eplus := min(mwk, abs(mwk - yklein)) + min(mwm, abs(mwm - ymittel))
             + min(mwg, abs(mwg - ygross));

          u := uk[j] - (umax - umin)/1000;

          yklein := if u <= us[1] then 1 else if u > us[1] and u <= us[2] then
            -u/(us[2] - us[1]) + us[1]/(us[2] - us[1]) + 1 else 0;
          ymittel := if u <= um[1] then 0 else if u > um[1] and u <= um[2] then
                  u/(um[2] - um[1]) - um[1]/(um[2] - um[1]) else if u > um[2]
             and u <= um[3] then 1 else if u > um[3] and u <= um[4] then -u/(um[
            4] - um[3]) + um[3]/(um[4] - um[3]) + 1 else 0;
          ygross := if u <= ub[1] then 0 else if u > ub[1] and u <= ub[2] then
            u/(ub[2] - ub[1]) - ub[1]/(ub[2] - ub[1]) else 1;

          eminus := min(mwk, abs(mwk - yklein)) + min(mwm, abs(mwm - ymittel))
             + min(mwg, abs(mwg - ygross));

          guk[j] := if (mw[j] > 0 and e[j] <= eplus and e[j] <= eminus) then 1 else
                  0;

        end for;

        for j in 2:L loop

          if e[j] < e[1] - epsilon and guk[j] == 1 then
            h1 := e[1];
            e[1] := e[j];
            e[j] := h1;
            h2 := guk[1];
            guk[1] := guk[j];
            guk[j] := h2;
            h3 := uk[1];
            uk[1] := uk[j];
            uk[j] := h3;
          end if;

        end for;

        sum1 := 0;
        sum2 := 0;

        for j in 2:L loop

          d[j] := if c > 0 and e[j] > 0 then (e[1]/(e[j] + epsilon))^(1/c) else
                  if c0 and not e[j] > e[1] + epsilon then 1 else 0;
          sum1 := sum1 + guk[j]*d[j]*uk[j];
          sum2 := sum2 + guk[j]*d[j];

        end for;

        Out.signal[1] := (uk[1] + sum1)/(1 + sum2);
      end v2_output_rbe_3;

      class v2_output_rbe_5
        "Output with five fuzzy sets (\"VSMALL, \"SMALL\", \"MEDIUM\", \"BIG\", \"VBIG\"). The method of defuzzification is 'Minimum of Rule Base Error'"

        parameter Real umin=0 "minimum of output";
        parameter Real[2] uvs={0,0.25} "VSMALL";

        parameter Real[4] us={0,0.25,0.25,0.5} "SMALL";

        parameter Real[4] um={0.25,0.5,0.5,0.75} "MEDIUM";

        parameter Real[4] ub={0.5,0.75,0.75,1} "BIG";

        parameter Real[2] uvb={0.75,1} "VBIG";

        parameter Real umax=1 "maximum of output";
        parameter Real c=0 "degree of compromise (c = 0 ... 1)";
        parameter Boolean c0=true
          "Compromise if c=0 and minimum of RBE is not unique?";
        constant Integer L=8 "Zahl der Knickstellen";
        Real uk[L];
        Integer guk[L];
        Real e[L];
        Real d[L];
        Real mwsk;
        Real mwk;
        Real mwm;
        Real mwg;
        Real mwsg;
        Real mw[L];
        Real eplus;
        Real eminus;
        Real sum1;
        Real sum2;
        Real u;
        Real ysklein;
        Real yklein;
        Real ymittel;
        Real ygross;
        Real ysgross;
        Real h1;
        Integer h2;
        Real h3;
        constant Real epsilon=0.000001;
        annotation (Images(Parameters(name="5setsout", source=
                  "Controller/Images/5setsout.png")));
        annotation (
          Coordsys(
            extent=[-117, -112; 128, 114],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Line(points=[-92, -42; 97, -42], style(color=0, arrow=1)),
            Line(points=[-84, -43; -84, 72], style(color=0, arrow=1)),
            Line(points=[-86, 38; -80, 38], style(color=0)),
            Text(
              extent=[-106, 44; -94, 30],
              string="1",
              style(color=0)),
            Line(points=[-77, 38; -64, 38; -46, -42], style(thickness=2)),
            Line(points=[-71, -42; -37, 38; -18, 38; -1, -41], style(color=10,
                  thickness=2)),
            Line(points=[46, -41; 66, 38; 77, 38], style(color=81, thickness=2)),
            Text(
              extent=[89, -19; 101, -33],
              string="u",
              style(color=0)),
            Text(extent=[-90, -53; -72, -60], string="umin"),
            Text(
              extent=[73, -53; 92, -60],
              string="umax",
              style(color=81)),
            Line(points=[77, 37; 77, -49], style(color=81, pattern=2)),
            Line(points=[-77, 37; -77, -53], style(color=73, pattern=2)),
            Line(points=[-64, 38; -64, -56], style(color=73, pattern=2)),
            Line(points=[-36, 37; -36, -49], style(color=10, pattern=2)),
            Line(points=[-19, 36; -19, -49], style(color=10, pattern=2)),
            Line(points=[66, 37; 66, -49], style(color=81, pattern=2)),
            Text(extent=[-70, -64; -56, -55], string="uvs[1]"),
            Text(extent=[-58, -53; -43, -42], string="uvs[2]"),
            Line(points=[-71, -42; -71, -71], style(color=10, pattern=4)),
            Text(
              extent=[-78, -77; -65, -68],
              style(color=10),
              string="us[1]"),
            Text(
              extent=[-40, -58; -27, -49],
              style(color=10),
              string="us[2]"),
            Text(
              extent=[-25, -58; -12, -49],
              style(color=10),
              string="us[3]"),
            Text(
              extent=[-6, -76; 9, -69],
              style(color=10),
              string="us[4]"),
            Text(
              extent=[-48, -77; -34, -69],
              style(color=41),
              string="um[1]"),
            Text(
              extent=[1, -65; 15, -55],
              style(color=41),
              string="um[3]"),
            Line(points=[-1, -43; -1, -71], style(color=10, pattern=4)),
            Text(
              extent=[-54, 81; 49, 54],
              style(color=0, pattern=0),
              string="5 Fuzzy Sets"),
            Text(extent=[-84, 52; -49, 42], string="VSMALL"),
            Text(
              extent=[-42, 52; -17, 42],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[59, 52; 83, 42],
              string="VBIG",
              style(color=81)),
            Text(
              extent=[-92, 112; 60, 76],
              string="Output %name",
              style(color=41)),
            Line(points=[-41, -42; -8, 38; 11, 38; 26, -41], style(color=41,
                  thickness=2)),
            Line(points=[-7, 37; -7, -58], style(color=41, pattern=2)),
            Line(points=[10, 36; 10, -56], style(color=41, pattern=2)),
            Line(points=[-41, -43; -41, -71], style(color=41, pattern=4)),
            Line(points=[-12, -42; 21, 38; 40, 38; 55, -41], style(color=69,
                  thickness=2)),
            Line(points=[22, 38; 22, -49], style(color=69, pattern=2)),
            Line(points=[39, 37; 39, -48], style(color=69, pattern=2)),
            Text(
              extent=[-12, 54; 19, 41],
              string="MEDIUM",
              style(color=41)),
            Line(points=[-12, -43; -12, -71], style(color=69, pattern=4)),
            Line(points=[26, -43; 26, -71], style(color=41, pattern=4)),
            Text(
              extent=[-14, -64; 0, -55],
              style(color=41),
              string="um[2]"),
            Text(
              extent=[18, -78; 32, -68],
              style(color=41),
              string="um[4]"),
            Text(
              extent=[23, 52; 46, 42],
              string="BIG",
              style(color=69)),
            Text(
              extent=[-20, -78; -7, -68],
              style(color=69),
              string="ub[1]"),
            Text(
              extent=[14, -58; 26, -49],
              style(color=69),
              string="ub[2]"),
            Text(
              extent=[32, -58; 44, -49],
              style(color=69),
              string="ub[3]"),
            Line(points=[55, -43; 55, -70], style(color=69, pattern=4)),
            Text(
              extent=[53, -77; 66, -68],
              style(color=69),
              string="ub[4]"),
            Line(points=[46, -43; 46, -71], style(color=81, pattern=4)),
            Text(
              extent=[38, -77; 53, -68],
              style(color=81),
              string="uvb[1]"),
            Text(
              extent=[58, -61; 72, -50],
              style(color=81),
              string="uvb[2]"),
            Rectangle(extent=[-118, 114; 112, -112], style(color=41, thickness=
                    2)),
            Text(
              extent=[-30, -86; 28, -114],
              string="RBE",
              style(color=0)),
            Text(
              extent=[68, 112; 96, 80],
              string="V  II",
              style(color=0)),
            Line(points=[-118, -86; 112, -86], style(color=0))),
          Window(
            x=0.01,
            y=0,
            width=0.76,
            height=0.84));

        Modelica.Blocks.Interfaces.InPort In(final n=5)
          annotation (extent=[-144, -12; -118, 24], layer="icon");
        Modelica.Blocks.Interfaces.OutPort Out(final n=1)
          annotation (extent=[114, -10; 142, 30], layer="icon");
      equation

        mwsk = In.signal[1];
        mwk = In.signal[2];
        mwm = In.signal[3];
        mwg = In.signal[4];
        mwsg = In.signal[5];

        mw[1] = mwsk;
        mw[2] = mwk;
        mw[3] = mwk;
        mw[4] = mwm;
        mw[5] = mwm;
        mw[6] = mwg;
        mw[7] = mwg;
        mw[8] = mwsg;

      algorithm
        uk[1] := uvs[1] + (1 - mwsk)*(uvs[2] - uvs[1]);
        uk[2] := us[1] + mwk*(us[2] - us[1]);
        uk[3] := us[3] + (1 - mwk)*(us[4] - us[3]);
        uk[4] := um[1] + mwm*(um[2] - um[1]);
        uk[5] := um[3] + (1 - mwm)*(um[4] - um[3]);
        uk[6] := ub[1] + mwg*(ub[2] - ub[1]);
        uk[7] := ub[3] + (1 - mwg)*(ub[4] - ub[3]);
        uk[8] := uvb[1] + mwsg*(uvb[2] - uvb[1]);

        for j in 1:L loop

          u := uk[j];

          ysklein := if u <= umin then 1 else if u > umin and u <= uvs[1] then
            1 else if u > uvs[1] and u <= uvs[2] then -u/(uvs[2] - uvs[1]) +
            uvs[1]/(uvs[2] - uvs[1]) + 1 else 0;
          yklein := if u <= us[1] then 0 else if u > us[1] and u <= us[2] then
            u/(us[2] - us[1]) - us[1]/(us[2] - us[1]) else if u > us[2] and u
             <= us[3] then 1 else if u > us[3] and u <= us[4] then -u/(us[4] -
            us[3]) + us[3]/(us[4] - us[3]) + 1 else 0;
          ymittel := if u <= um[1] then 0 else if u > um[1] and u <= um[2] then
                  u/(um[2] - um[1]) - um[1]/(um[2] - um[1]) else if u > um[2]
             and u <= um[3] then 1 else if u > um[3] and u <= um[4] then -u/(um[
            4] - um[3]) + um[3]/(um[4] - um[3]) + 1 else 0;
          ygross := if u <= ub[1] then 0 else if u > ub[1] and u <= ub[2] then
            u/(ub[2] - ub[1]) - ub[1]/(ub[2] - ub[1]) else if u > ub[2] and u
             <= ub[3] then 1 else if u > ub[3] and u <= ub[4] then -u/(ub[4] -
            ub[3]) + ub[3]/(ub[4] - ub[3]) + 1 else 1;
          ysgross := if u <= uvb[1] then 0 else if u > uvb[1] and u <= uvb[2] then
                  u/(uvb[2] - uvb[1]) - uvb[1]/(uvb[2] - uvb[1]) else if u >
            uvb[2] and u <= umax then 1 else 0;

          e[j] := 0;

          e[j] := e[j] + min(mwsk, abs(mwsk - ysklein)) + min(mwk, abs(mwk -
            yklein)) + min(mwm, abs(mwm - ymittel)) + min(mwg, abs(mwg - ygross))
             + min(mwsg, abs(mwsg - ysgross));

          eplus := 0;
          eminus := 0;

          u := uk[j] + (umax - umin)/1000;

          ysklein := if u <= umin then 1 else if u > umin and u <= uvs[1] then
            1 else if u > uvs[1] and u <= uvs[2] then -u/(uvs[2] - uvs[1]) +
            uvs[1]/(uvs[2] - uvs[1]) + 1 else 0;
          yklein := if u <= us[1] then 0 else if u > us[1] and u <= us[2] then
            u/(us[2] - us[1]) - us[1]/(us[2] - us[1]) else if u > us[2] and u
             <= us[3] then 1 else if u > us[3] and u <= us[4] then -u/(us[4] -
            us[3]) + us[3]/(us[4] - us[3]) + 1 else 0;
          ymittel := if u <= um[1] then 0 else if u > um[1] and u <= um[2] then
                  u/(um[2] - um[1]) - um[1]/(um[2] - um[1]) else if u > um[2]
             and u <= um[3] then 1 else if u > um[3] and u <= um[4] then -u/(um[
            4] - um[3]) + um[3]/(um[4] - um[3]) + 1 else 0;
          ygross := if u <= ub[1] then 0 else if u > ub[1] and u <= ub[2] then
            u/(ub[2] - ub[1]) - ub[1]/(ub[2] - ub[1]) else if u > ub[2] and u
             <= ub[3] then 1 else if u > ub[3] and u <= ub[4] then -u/(ub[4] -
            ub[3]) + ub[3]/(ub[4] - ub[3]) + 1 else 0;
          ysgross := if u <= uvb[1] then 0 else if u > uvb[1] and u <= uvb[2] then
                  u/(uvb[2] - uvb[1]) - uvb[1]/(uvb[2] - uvb[1]) else if u >
            uvb[2] and u <= umax then 1 else 1;

          eplus := e[j] + min(mwsk, abs(mwsk - ysklein)) + min(mwk, abs(mwk -
            yklein)) + min(mwm, abs(mwm - ymittel)) + min(mwg, abs(mwg - ygross))
             + min(mwsg, abs(mwsg - ysgross));

          u := uk[j] - (umax - umin)/1000;

          ysklein := if u <= umin then 1 else if u > umin and u <= uvs[1] then
            1 else if u > uvs[1] and u <= uvs[2] then -u/(uvs[2] - uvs[1]) +
            uvs[1]/(uvs[2] - uvs[1]) + 1 else 0;
          yklein := if u <= us[1] then 0 else if u > us[1] and u <= us[2] then
            u/(us[2] - us[1]) - us[1]/(us[2] - us[1]) else if u > us[2] and u
             <= us[3] then 1 else if u > us[3] and u <= us[4] then -u/(us[4] -
            us[3]) + us[3]/(us[4] - us[3]) + 1 else 0;
          ymittel := if u <= um[1] then 0 else if u > um[1] and u <= um[2] then
                  u/(um[2] - um[1]) - um[1]/(um[2] - um[1]) else if u > um[2]
             and u <= um[3] then 1 else if u > um[3] and u <= um[4] then -u/(um[
            4] - um[3]) + um[3]/(um[4] - um[3]) + 1 else 0;
          ygross := if u <= ub[1] then 0 else if u > ub[1] and u <= ub[2] then
            u/(ub[2] - ub[1]) - ub[1]/(ub[2] - ub[1]) else if u > ub[2] and u
             <= ub[3] then 1 else if u > ub[3] and u <= ub[4] then -u/(ub[4] -
            ub[3]) + ub[3]/(ub[4] - ub[3]) + 1 else 0;
          ysgross := if u <= uvb[1] then 0 else if u > uvb[1] and u <= uvb[2] then
                  u/(uvb[2] - uvb[1]) - uvb[1]/(uvb[2] - uvb[1]) else if u >
            uvb[2] and u <= umax then 1 else 1;

          eminus := e[j] + min(mwsk, abs(mwsk - ysklein)) + min(mwk, abs(mwk -
            yklein)) + min(mwm, abs(mwm - ymittel)) + min(mwg, abs(mwg - ygross))
             + min(mwsg, abs(mwsg - ysgross));

          guk[j] := if (mw[j] > 0 and e[j] <= eplus and e[j] <= eminus) then 1 else
                  0;

        end for;

        for j in 2:L loop

          if e[j] < e[1] - epsilon and guk[j] == 1 then
            h1 := e[1];
            e[1] := e[j];
            e[j] := h1;
            h2 := guk[1];
            guk[1] := guk[j];
            guk[j] := h2;
            h3 := uk[1];
            uk[1] := uk[j];
            uk[j] := h3;
          end if;

        end for;

        sum1 := 0;
        sum2 := 0;

        for j in 2:L loop

          d[j] := if c > 0 and e[j] > 0 then (e[1]/(e[j] + epsilon))^(1/c) else
                  if c0 and not e[j] > e[1] + epsilon then 1 else 0;

          sum1 := sum1 + guk[j]*d[j]*uk[j];
          sum2 := sum2 + guk[j]*d[j];

        end for;

        Out.signal[1] := (uk[1] + sum1)/(1 + sum2);

      end v2_output_rbe_5;

      class v2_output_cog_3
        "Output with three fuzzy sets (\"SMALL\", \"MEDIUM\", \"BIG\"). The method of defuzzification is 'Centre of Gravity'"

        annotation (Images(Parameters(name="3setsout", source=
                  "Controller/Images/3setsout.png")));

      protected
        type method = String annotation (choices(
            choice="Max-Min" "Max-Min",
            choice="Max-Prod" "Max-Prod",
            choice="Sum-Prod" "Sum-Prod"));
      public
        parameter method Method="Max-Min" "Method of Inference";
        parameter Real umin=0 "minimum of output";
        parameter Real umax=1 "maximum of output";
        parameter Real[2] us={0,0.5} "SMALL";
        parameter Real[4] um={0,0.5,0.5,1} "MEDIUM";
        parameter Real[2] ub={0.5,1} "BIG";
        parameter Real N=100 "# of integrator steps";
        parameter Real Default_output=0 "Output if no rule is active";
        Real mwk;
        Real mwm;
        Real mwg;
        Real msk;
        Real msm;
        Real msg;
        Real u;
        Real uk;
        Real uke;
        Real um1;
        Real um2;
        Real ug;
        Real uge;
        Real sum1;
        Real sum2;
      protected
        Real u1e=umin - (us[1] - umin);
        Real u2e=umin - (us[2] - umin);
        Real u7e=umax + (umax - ub[1]);
        Real u8e=umax + (umax - ub[2]);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Line(points=[-80, -40; 90, -40], style(color=0, arrow=1)),
            Line(points=[-74, -40; -74, 58], style(color=0, arrow=1)),
            Line(points=[-76, 40; -70, 40], style(color=0)),
            Text(
              extent=[-90, 48; -78, 34],
              string="1",
              style(color=0)),
            Line(points=[-60, 40; -40, 40; -12, -40], style(color=10, thickness=
                   2)),
            Line(points=[-52, -40; 0, 40; 20, 40; 46, -40], style(color=41,
                  thickness=2)),
            Line(points=[30, -40; 58, 40; 72, 40], style(thickness=2)),
            Text(
              extent=[78, -22; 90, -36],
              string="u",
              style(color=0)),
            Text(
              extent=[-72, -44; -54, -56],
              string="umin",
              style(color=10)),
            Text(
              extent=[68, -44; 88, -56],
              string="umax",
              style(color=73)),
            Line(points=[72, 36; 72, -44], style(color=0, pattern=2)),
            Line(points=[-60, 36; -60, -46], style(color=0, pattern=2)),
            Line(points=[-40, 36; -40, -44], style(color=0, pattern=2)),
            Line(points=[0, 36; 0, -64], style(color=0, pattern=2)),
            Line(points=[20, 36; 20, -64], style(color=0, pattern=2)),
            Line(points=[58, 36; 58, -44], style(color=0, pattern=2)),
            Text(
              extent=[-48, -54; -34, -44],
              style(color=10),
              string="us[1]"),
            Text(
              extent=[-20, -54; -6, -44],
              style(color=10),
              string="us[2]"),
            Line(points=[-52, -40; -52, -64], style(color=0, pattern=4)),
            Text(
              extent=[-60, -74; -46, -64],
              style(color=41),
              string="um[1]"),
            Text(
              extent=[-8, -74; 6, -64],
              style(color=41),
              string="um[2]"),
            Text(
              extent=[14, -74; 28, -64],
              style(color=41),
              string="um[3]"),
            Text(
              extent=[40, -74; 54, -64],
              style(color=41),
              string="um[4]"),
            Text(extent=[22, -54; 36, -44], string="ub[1]"),
            Text(extent=[52, -54; 66, -44], string="ub[2]"),
            Line(points=[46, -40; 46, -66], style(color=0, pattern=4)),
            Text(
              extent=[-58, 78; 42, 54],
              style(color=0),
              string="3 Fuzzy Sets"),
            Text(
              extent=[-66, 58; -28, 40],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[-12, 60; 34, 38],
              string="MEDIUM",
              style(color=41)),
            Text(extent=[48, 58; 86, 40], string="BIG"),
            Text(
              extent=[-76, 100; 54, 74],
              string="Output %name",
              style(color=41)),
            Text(
              extent=[4, -74; 104, -100],
              string="C. o. G.",
              style(color=0)),
            Rectangle(extent=[-100, 100; 96, -100], style(color=41, thickness=2)),
            Text(
              extent=[-86, -76; -6, -100],
              string="%Method",
              style(color=0)),
            Text(
              extent=[62, 100; 90, 68],
              string="V  II",
              style(color=0)),
            Line(points=[-98, -76; 96, -76], style(color=0))),
          Window(
            x=0.21,
            y=0.06,
            width=0.78,
            height=0.85));

      public
        Modelica.Blocks.Interfaces.OutPort Out(final n=1)
          annotation (extent=[98, -16; 126, 22], layer="icon");
        Modelica.Blocks.Interfaces.InPort InPort1(final n=5)
          annotation (extent=[-128, -16; -102, 22]);
      equation

        mwk = InPort1.signal[2];
        mwm = InPort1.signal[3];
        mwg = InPort1.signal[4];

        uk = us[1] + (1 - mwk)*(us[2] - us[1]);
        uke = umin - (uk - umin);
        um1 = um[1] + mwm*(um[2] - um[1]);
        um2 = um[3] + (1 - mwm)*(um[4] - um[3]);
        ug = ub[1] + mwg*(ub[2] - ub[1]);
        uge = umax + (umax - ug);

      algorithm
        sum1 := 0;
        sum2 := 0;

        for i in 1:N loop
          u := u2e + i*(u7e - u2e)/N;

          if Method == "Max-Min" then
            msk := if u > u2e and u <= uke then u/(u1e - u2e) - u2e/(u1e - u2e) else
                    if u > uke and u <= uk then mwk else if u > uk and u <= us[
              2] then -u/(us[2] - us[1]) + us[1]/(us[2] - us[1]) + 1 else 0;
            msm := if u >= um[1] and u <= um1 then u/(um[2] - um[1]) - um[1]/(
              um[2] - um[1]) else if u > um1 and u <= um2 then mwm else if u >
              um2 and u <= um[4] then -u/(um[4] - um[3]) + um[3]/(um[4] - um[3])
               + 1 else 0;
            msg := if u > ub[1] and u <= ug then u/(ub[2] - ub[1]) - ub[1]/(ub[
              2] - ub[1]) else if u > ug and u <= uge then mwg else if u > uge
               and u <= u7e then -u/(u7e - u8e) + u8e/(u7e - u8e) + 1 else 0;

            sum1 := sum1 + u*max(max(msk, msm), msg)*(u7e - u2e)/N;
            sum2 := sum2 + max(max(msk, msm), msg)*(u7e - u2e)/N;
          end if;

          if Method == "Sum-Prod" then
            msk := if u > u2e and u <= u1e then u/(u1e - u2e) - u2e/(u1e - u2e) else
                    if u > u1e and u <= us[1] then 1 else if u > us[1] and u
               <= us[2] then -u/(us[2] - us[1]) + us[1]/(us[2] - us[1]) + 1 else
                    0;
            msm := if u >= um[1] and u <= um[2] then u/(um[2] - um[1]) - um[1]/
              (um[2] - um[1]) else if u > um[2] and u <= um[3] then 1 else if u
               > um[3] and u <= um[4] then -u/(um[4] - um[3]) + um[3]/(um[4] -
              um[3]) + 1 else 0;
            msg := if u > ub[1] and u <= ub[2] then u/(ub[2] - ub[1]) - ub[1]/(
              ub[2] - ub[1]) else if u > ub[2] and u <= u8e then 1 else if u >
              u8e and u <= u7e then -u/(u7e - u8e) + u8e/(u7e - u8e) + 1 else 0;

            sum1 := sum1 + u*(msk*mwk + msm*mwm + msg*mwg)*(u7e - u2e)/N;
            sum2 := sum2 + (msk*mwk + msm*mwm + msg*mwg)*(u7e - u2e)/N;
          end if;

          if Method == "Max-Prod" then
            msk := if u > u2e and u <= u1e then u/(u1e - u2e) - u2e/(u1e - u2e) else
                    if u > u1e and u <= us[1] then 1 else if u > us[1] and u
               <= us[2] then -u/(us[2] - us[1]) + us[1]/(us[2] - us[1]) + 1 else
                    0;
            msm := if u >= um[1] and u <= um[2] then u/(um[2] - um[1]) - um[1]/
              (um[2] - um[1]) else if u > um[2] and u <= um[3] then 1 else if u
               > um[3] and u <= um[4] then -u/(um[4] - um[3]) + um[3]/(um[4] -
              um[3]) + 1 else 0;
            msg := if u > ub[1] and u <= ub[2] then u/(ub[2] - ub[1]) - ub[1]/(
              ub[2] - ub[1]) else if u > ub[2] and u <= u8e then 1 else if u >
              u8e and u <= u7e then -u/(u7e - u8e) + u8e/(u7e - u8e) + 1 else 0;
            sum1 := sum1 + u*(max(max(msk*mwk, msm*mwm), msg*mwg))*(u7e - u2e)/
              N;
            sum2 := sum2 + (max(max(msk*mwk, msm*mwm), msg*mwg))*(u7e - u2e)/N;
          end if;

        end for;

        Out.signal[1] := if noEvent(sum2 > 0) then sum1/sum2 else
          Default_output;

      end v2_output_cog_3;

      class v2_output_cog_5
        "Output with five fuzzy sets (\"VSMALL\", \"SMALL\", \"MEDIUM\", \"BIG\", VBIG\"). The method of defuzzification is 'Centre of Gravity'"

        annotation (Images(Parameters(name="5setsout", source=
                  "Controller/Images/5setsout.png")));
      protected
        type method = String annotation (choices(
            choice="Max-Min" "Max-Min",
            choice="Max-Prod" "Max-Prod",
            choice="Sum-Prod" "Sum-Prod"));
      public
        parameter method Method="Max-Min" "Method of Inference";
        parameter Real umin=0 "minimum of output";
        parameter Real[2] uvs={0,0.25} "VSMALL";
        parameter Real[4] us={0,0.25,0.25,0.5} "SMALL";
        parameter Real[4] um={0.25,0.5,0.5,0.75} "MEDIUM";
        parameter Real[4] ub={0.5,0.75,0.75,1} "BIG";
        parameter Real[2] uvb={0.75,1} "VBIG";
        parameter Real umax=1 "maximum of output";
        parameter Integer N=100 "# of integrator steps";
        parameter Real default_output=0 "Output if no rule is active";
        Real u;
        Real mD_VSMALL;
        Real mD_SMALL;
        Real mD_MEDIUM;
        Real mD_BIG;
        Real mD_VBIG;
        Real mR;
        Real sum1;
        Real sum2;
      protected
        Real u1e=umin - (uvs[1] - umin);
        Real u2e=umin - (uvs[2] - umin);
        Real u15e=umax + (umax - uvb[1]);
        Real u16e=umax + (umax - uvb[2]);
        annotation (
          Coordsys(
            extent=[-117, -112; 128, 122],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Line(points=[-82, -40; 107, -40], style(color=0, arrow=1)),
            Line(points=[-74, -41; -74, 74], style(color=0, arrow=1)),
            Line(points=[-76, 40; -70, 40], style(color=0)),
            Text(
              extent=[-92, 46; -80, 32],
              string="1",
              style(color=0)),
            Line(points=[-67, 40; -54, 40; -36, -40], style(thickness=2)),
            Line(points=[-61, -40; -27, 40; -8, 40; 9, -39], style(color=10,
                  thickness=2)),
            Line(points=[56, -39; 76, 40; 87, 40], style(color=81, thickness=2)),
            Text(
              extent=[97, -19; 109, -33],
              string="u",
              style(color=0)),
            Text(extent=[-80, -49; -64, -60], string="umin"),
            Text(
              extent=[84, -50; 103, -59],
              string="umax",
              style(color=81)),
            Line(points=[87, 39; 87, -47], style(color=81, pattern=2)),
            Line(points=[-67, 39; -67, -48], style(color=73, pattern=2)),
            Line(points=[-54, 40; -54, -40], style(color=73, pattern=2)),
            Line(points=[-26, 39; -26, -50], style(color=10, pattern=2)),
            Line(points=[-9, 38; -8, -50], style(color=10, pattern=2)),
            Line(points=[76, 39; 76, -40], style(color=81, pattern=2)),
            Text(extent=[-62, -50; -45, -38], string="uvs[1]"),
            Text(extent=[-46, -49; -28, -38], string="uvs[2]"),
            Line(points=[-61, -40; -61, -69], style(color=10, pattern=4)),
            Text(
              extent=[-69, -77; -54, -66],
              style(color=10),
              string="us[1]"),
            Text(
              extent=[-29, -59; -16, -50],
              style(color=10),
              string="us[2]"),
            Text(
              extent=[-14, -59; -1, -50],
              style(color=10),
              string="us[3]"),
            Text(
              extent=[2, -75; 16, -66],
              style(color=10),
              string="us[4]"),
            Text(
              extent=[-38, -78; -22, -66],
              style(color=41),
              string="um[1]"),
            Text(
              extent=[12, -49; 28, -38],
              style(color=41),
              string="um[3]"),
            Line(points=[9, -41; 9, -69], style(color=10, pattern=4)),
            Text(
              extent=[-50, 86; 53, 59],
              style(color=0, pattern=0),
              string="5 Fuzzy Sets"),
            Text(extent=[-74, 54; -39, 44], string="VSMALL"),
            Text(
              extent=[-31, 54; -6, 44],
              string="SMALL",
              style(color=10)),
            Text(
              extent=[68, 56; 92, 45],
              string="VBIG",
              style(color=81)),
            Text(
              extent=[-74, 116; 66, 84],
              string="Output %name",
              style(color=41)),
            Line(points=[-31, -40; 2, 40; 21, 40; 36, -39], style(color=41,
                  thickness=2)),
            Line(points=[3, 39; 4, -40], style(color=41, pattern=2)),
            Line(points=[20, 38; 20, -40], style(color=41, pattern=2)),
            Line(points=[-31, -41; -31, -69], style(color=41, pattern=4)),
            Line(points=[-2, -40; 31, 40; 50, 40; 65, -39], style(color=69,
                  thickness=2)),
            Line(points=[32, 40; 32, -47], style(color=69, pattern=2)),
            Line(points=[49, 39; 49, -46], style(color=69, pattern=2)),
            Text(
              extent=[-3, 55; 28, 44],
              string="MEDIUM",
              style(color=41)),
            Line(points=[-2, -41; -2, -69], style(color=69, pattern=4)),
            Line(points=[36, -41; 36, -69], style(color=41, pattern=4)),
            Text(
              extent=[-4, -50; 12, -38],
              style(color=41),
              string="um[2]"),
            Text(
              extent=[28, -76; 44, -66],
              style(color=41),
              string="um[4]"),
            Text(
              extent=[29, 54; 52, 44],
              string="BIG",
              style(color=69)),
            Text(
              extent=[-11, -77; 2, -66],
              style(color=69),
              string="ub[1]"),
            Text(
              extent=[22, -60; 37, -48],
              style(color=69),
              string="ub[2]"),
            Text(
              extent=[40, -58; 55, -48],
              style(color=69),
              string="ub[3]"),
            Line(points=[65, -41; 65, -68], style(color=69, pattern=4)),
            Text(
              extent=[61, -77; 76, -66],
              style(color=69),
              string="ub[4]"),
            Line(points=[56, -41; 56, -42], style(color=81, pattern=4)),
            Text(
              extent=[50, -50; 66, -38],
              style(color=81),
              string="uvb[1]"),
            Text(
              extent=[68, -51; 84, -37],
              style(color=81),
              string="uvb[2]"),
            Rectangle(extent=[-116, 120; 112, -112], style(color=41, thickness=
                    2)),
            Text(
              extent=[20, -80; 112, -110],
              string="C. o. G.",
              style(color=0)),
            Text(
              extent=[76, 116; 104, 84],
              string="V  II",
              style(color=0)),
            Text(
              extent=[-88, -82; 2, -108],
              string="%Method",
              style(color=0)),
            Line(points=[-116, -82; 110, -82], style(color=0))),
          Window(
            x=0.14,
            y=0.01,
            width=0.84,
            height=0.7));

      public
        Modelica.Blocks.Interfaces.InPort In(final n=5)
          annotation (extent=[-146, -10; -120, 28], layer="icon");
        Modelica.Blocks.Interfaces.OutPort Out(final n=1)
          annotation (extent=[114, -12; 142, 28], layer="icon");
      algorithm

        sum1 := 0;
        sum2 := 0;

        for i in 1:N loop
          u := u2e + i*(u15e - u2e)/N;

          mD_VSMALL := if u > u2e and u <= u1e then u/(u1e - u2e) - u2e/(u1e -
            u2e) else if u > u1e and u <= uvs[1] then 1 else if u > uvs[1] and
            u <= uvs[2] then -u/(uvs[2] - uvs[1]) + uvs[1]/(uvs[2] - uvs[1]) +
            1 else 0;
          mD_SMALL := if u >= us[1] and u <= us[2] then u/(us[2] - us[1]) - us[
            1]/(us[2] - us[1]) else if u > us[2] and u <= us[3] then 1 else if
            u > us[3] and u <= us[4] then -u/(us[4] - us[3]) + us[3]/(us[4] -
            us[3]) + 1 else 0;
          mD_MEDIUM := if u >= um[1] and u <= um[2] then u/(um[2] - um[1]) - um[
            1]/(um[2] - um[1]) else if u > um[2] and u <= um[3] then 1 else if
            u > um[3] and u <= um[4] then -u/(um[4] - um[3]) + um[3]/(um[4] -
            um[3]) + 1 else 0;
          mD_BIG := if u >= ub[1] and u <= ub[2] then u/(ub[2] - ub[1]) - ub[1]
            /(ub[2] - ub[1]) else if u > ub[2] and u <= ub[3] then 1 else if u
             > ub[3] and u <= ub[4] then -u/(ub[4] - ub[3]) + ub[3]/(ub[4] - ub[
            3]) + 1 else 0;
          mD_VBIG := if u > uvb[1] and u <= uvb[2] then u/(uvb[2] - uvb[1]) -
            uvb[1]/(uvb[2] - uvb[1]) else if u > uvb[2] and u <= u16e then 1 else
                  if u > u16e and u <= u15e then -u/(u15e - u16e) + u16e/(u15e
             - u16e) + 1 else 0;

          if Method == "Max-Min" then
            mR := max(max(max(max(min(mD_VSMALL, In.signal[1]), min(mD_SMALL,
              In.signal[2])), min(mD_MEDIUM, In.signal[3])), min(mD_BIG, In.
              signal[4])), min(mD_VBIG, In.signal[5]));
          end if;

          if Method == "Sum-Prod" then
            mR := In.signal[1]*mD_VSMALL + In.signal[2]*mD_SMALL + In.signal[3]
              *mD_MEDIUM + In.signal[4]*mD_BIG + In.signal[5]*mD_VBIG;
          end if;

          if Method == "Max-Prod" then
            mR := max(max(max(max(mD_VSMALL*In.signal[1], mD_SMALL*In.signal[2]),
               mD_MEDIUM*In.signal[3]), mD_BIG*In.signal[4]), mD_VBIG*In.signal[
              5]);

          end if;

          sum1 := sum1 + u*mR*(u15e - u2e)/N;
          sum2 := sum2 + mR*(u15e - u2e)/N;

        end for;

        Out.signal[1] := if noEvent(sum2 > 0) then sum1/sum2 else
          default_output;

      end v2_output_cog_5;
    end outputs_v2;

    package rules_v2
      extends Icons.Package;
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
      class v2_rules
        annotation (Images(Parameters(name="rbe3", source=
                  "Controller/Images/rule_expl.png")));
        parameter Integer n_In=10 "# of inputs (max. 10)";
        parameter Integer n_Out=5 "# of outputs (max.: 5)";
        parameter Integer n_Rules=50 "# of rules to be evaluated (max.: 50)";
        Real In[n_In, 5];
        Real Out[5, 5];
        Real R[n_Rules];
        constant String InLV[10]={"vsmall","small","medium","big","vbig",
            "nvsmall","nsmall","nmedium","nbig","nvbig"};
        constant String OutLV[5]={"VSMALL","SMALL","MEDIUM","BIG","VBIG"};

        parameter String Rule_1[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P1=1 "Priority";
        parameter String Rule_2[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P2=1 "Priority";
        parameter String Rule_3[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P3=1 "Priority";
        parameter String Rule_4[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P4=1 "Priority";
        parameter String Rule_5[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P5=1 "Priority";
        parameter String Rule_6[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P6=1 "Priority";
        parameter String Rule_7[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P7=1 "Priority";
        parameter String Rule_8[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P8=1 "Priority";
        parameter String Rule_9[:]={"*","*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*"};
        parameter Real P9=1 "Priority";
        parameter String Rule_10[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P10=1 "Priority";
        parameter String Rule_11[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P11=1 "Priority";
        parameter String Rule_12[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P12=1 "Priority";
        parameter String Rule_13[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P13=1 "Priority";
        parameter String Rule_14[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P14=1 "Priority";
        parameter String Rule_15[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P15=1 "Priority";
        parameter String Rule_16[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P16=1 "Priority";
        parameter String Rule_17[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P17=1 "Priority";
        parameter String Rule_18[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P18=1 "Priority";
        parameter String Rule_19[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P19=1 "Priority";
        parameter String Rule_20[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P20=1 "Priority";
        parameter String Rule_21[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P21=1 "Priority";
        parameter String Rule_22[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P22=1 "Priority";
        parameter String Rule_23[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P23=1 "Priority";
        parameter String Rule_24[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P24=1 "Priority";
        parameter String Rule_25[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P25=1 "Priority";
        parameter String Rule_26[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P26=1 "Priority";
        parameter String Rule_27[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P27=1 "Priority";
        parameter String Rule_28[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P28=1 "Priority";
        parameter String Rule_29[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P29=1 "Priority";
        parameter String Rule_30[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P30=1 "Priority";
        parameter String Rule_31[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P31=1 "Priority";
        parameter String Rule_32[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P32=1 "Priority";
        parameter String Rule_33[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P33=1 "Priority";
        parameter String Rule_34[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P34=1 "Priority";
        parameter String Rule_35[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P35=1 "Priority";
        parameter String Rule_36[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P36=1 "Priority";
        parameter String Rule_37[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P37=1 "Priority";
        parameter String Rule_38[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P38=1 "Priority";
        parameter String Rule_39[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P39=1 "Priority";
        parameter String Rule_40[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P40=1 "Priority";
        parameter String Rule_41[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P41=1 "Priority";
        parameter String Rule_42[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P42=1 "Priority";
        parameter String Rule_43[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P43=1 "Priority";
        parameter String Rule_44[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P44=1 "Priority";
        parameter String Rule_45[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P45=1 "Priority";
        parameter String Rule_46[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P46=1 "Priority";
        parameter String Rule_47[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P47=1 "Priority";
        parameter String Rule_48[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P48=1 "Priority";
        parameter String Rule_49[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P49=1 "Priority";
        parameter String Rule_50[:]={"*","*","*","*","*","*","*","*","*","*",
            "*","*","*","*","*"};
        parameter Real P50=1 "Priority";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0,
            y=0.01,
            width=0.85,
            height=0.92),
          Icon(
            Rectangle(extent=[-96, 98; 88, -100], style(color=10, thickness=2)),
            Text(
              extent=[-46, 78; 31, 41],
              string="Rules",
              style(color=10)),
            Text(
              extent=[-47, -78; 34, -98],
              string="\"%name\"",
              style(color=10)),
            Text(
              extent=[36, 77; 84, 58],
              string="Out 1",
              style(color=41)),
            Text(
              extent=[35, 42; 85, 23],
              string="Out 2",
              style(color=41)),
            Text(
              extent=[36, 5; 85, -14],
              string="Out 3",
              style(color=41)),
            Text(
              extent=[-94, 95; -55, 78],
              string="In 1",
              style(color=73)),
            Text(
              extent=[-94, 75; -57, 57],
              string="In 2",
              style(color=73)),
            Text(
              extent=[-94, 56; -57, 39],
              string="In 3",
              style(color=73)),
            Text(
              extent=[-94, 37; -57, 20],
              string="In 4",
              style(color=73)),
            Text(
              extent=[-93, 16; -56, -1],
              string="In 5",
              style(color=73)),
            Text(
              extent=[-93, -4; -57, -21],
              string="In 6",
              style(color=73)),
            Text(
              extent=[-94, -24; -55, -41],
              string="In 7",
              style(color=73)),
            Text(
              extent=[-93, -43; -56, -60],
              string="In 8",
              style(color=73)),
            Text(
              extent=[-94, -61; -54, -79],
              string="In 9",
              style(color=73)),
            Text(
              extent=[-94, -79; -49, -97],
              string="In 10",
              style(color=73)),
            Text(
              extent=[36, -28; 85, -47],
              string="Out 4",
              style(color=41)),
            Text(
              extent=[36, -63; 84, -83],
              string="Out 5",
              style(color=41)),
            Text(
              extent=[-39, 32; 23, 12],
              string="FUZZY",
              style(
                color=45,
                pattern=0,
                fillColor=42)),
            Text(
              extent=[-45, -29; 34, -54],
              string="CONTROL",
              style(
                color=45,
                pattern=0,
                fillColor=42)),
            Rectangle(extent=[-22, -11; 3, -20], style(fillColor=73)),
            Rectangle(extent=[-22, 5; 3, -4], style(fillColor=73)),
            Polygon(points=[3, 2; 10, 2; 10, -17; 3, -17; 3, -14; 7, -14; 7, 0;
                   3, 0; 3, 2], style(fillColor=45)),
            Polygon(points=[-22, 2; -29, 2; -29, -17; -22, -17; -22, -14; -26,
                  -14; -26, 0; -22, 0; -22, 2], style(fillColor=45))),
          Diagram(
            Text(
              extent=[48, 78; 74, 62],
              string="Out 1",
              style(color=41)),
            Text(
              extent=[48, 42; 74, 26],
              string="Out 2",
              style(color=41)),
            Text(
              extent=[46, 6; 72, -10],
              string="Out 3",
              style(color=41)),
            Text(
              extent=[-90, 94; -68, 80],
              string="In 1",
              style(color=73)),
            Text(
              extent=[-90, 76; -68, 62],
              string="In 2",
              style(color=73)),
            Text(
              extent=[-90, 56; -68, 42],
              string="In 3",
              style(color=73)),
            Text(
              extent=[-90, 36; -68, 22],
              string="In 4",
              style(color=73)),
            Text(
              extent=[-90, 16; -68, 2],
              string="In 5",
              style(color=73)),
            Text(
              extent=[-90, -4; -68, -18],
              string="In 6",
              style(color=73)),
            Text(
              extent=[-90, -24; -68, -38],
              string="In 7",
              style(color=73)),
            Text(
              extent=[-90, -44; -68, -58],
              string="In 8",
              style(color=73)),
            Text(
              extent=[-90, -64; -68, -78],
              string="In 9",
              style(color=73)),
            Text(
              extent=[-87, -83; -63, -97],
              string="In 10",
              style(color=73)),
            Text(
              extent=[46, -30; 72, -46],
              string="Out 4",
              style(color=41)),
            Text(
              extent=[46, -66; 72, -82],
              string="Out 5",
              style(color=41))));

        Version_2.cuts_v2.cut_flow_v2 In1(n=5)
          annotation (extent=[-110, 82; -90, 96]);
        Version_2.cuts_v2.cut_flow_v2 In2(n=5)
          annotation (extent=[-110, 62; -90, 76]);
        Version_2.cuts_v2.cut_flow_v2 In3(n=5)
          annotation (extent=[-110, 42; -90, 56]);
        Modelica.Blocks.Interfaces.OutPort Out1(n=5)
          annotation (extent=[88, 61; 108, 81]);
        Modelica.Blocks.Interfaces.OutPort Out2(n=5)
          annotation (extent=[88, 24; 108, 44]);
        Modelica.Blocks.Interfaces.OutPort Out3(n=5)
          annotation (extent=[88, -14; 108, 6]);
        Modelica.Blocks.Interfaces.OutPort Out4(n=5)
          annotation (extent=[88, -49; 108, -29], layer="icon");
        Modelica.Blocks.Interfaces.OutPort Out5(n=5)
          annotation (extent=[88, -82; 108, -62], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 In4(n=5)
          annotation (extent=[-110, 22; -90, 36], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 In5(n=5)
          annotation (extent=[-110, 2; -90, 16], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 In6(n=5)
          annotation (extent=[-110, -18; -90, -4], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 In7(n=5)
          annotation (extent=[-110, -38; -90, -24], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 In8(n=5)
          annotation (extent=[-110, -58; -90, -44], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 In9(n=5)
          annotation (extent=[-110, -78; -90, -64], layer="icon");
        Version_2.cuts_v2.cut_flow_v2 In10(n=5)
          annotation (extent=[-110, -98; -90, -84], layer="icon");
      algorithm
        for i in 1:5 loop
          In[1, i] := In1.s[i];
          if n_In > 1 then
            In[2, i] := In2.s[i];
          end if;
          if n_In > 2 then
            In[3, i] := In3.s[i];
          end if;
          if n_In > 3 then
            In[4, i] := In4.s[i];
          end if;
          if n_In > 4 then
            In[5, i] := In5.s[i];
          end if;
          if n_In > 5 then
            In[6, i] := In6.s[i];
          end if;
          if n_In > 6 then
            In[7, i] := In7.s[i];
          end if;
          if n_In > 7 then
            In[8, i] := In8.s[i];
          end if;
          if n_In > 8 then
            In[9, i] := In9.s[i];
          end if;
          if n_In > 9 then
            In[10, i] := In10.s[i];
          end if;
        end for;

        for i in 1:n_Out loop
          for j in 1:5 loop
            Out[i, j] := 0;
          end for;
        end for;

        for i in 1:n_Rules loop
          R[i] := 1;
        end for;

        /*   translate Rule_1:   */
        for i in 1:n_In loop
          for j in 1:5 loop
            if Rule_1[i] == InLV[j] then
              R[1] := min(R[1], In[i, j]);
            else
              R[1] := R[1];
            end if;
            if Rule_1[i] == InLV[j + 5] then
              R[1] := min(R[1], 1 - In[i, j]);
            else
              R[1] := R[1];
            end if;
          end for;
        end for;

        for i in 1:n_Out loop
          for j in 1:5 loop
            if Rule_1[n_In + i] == OutLV[j] then
              Out[i, j] := max(Out[i, j], P1*R[1]);
            else
              Out[i, j] := Out[i, j];
            end if;
          end for;
        end for;

        if 1 < n_Rules then
          /*   translate Rule_2:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_2[i] == InLV[j] then
                R[2] := min(R[2], In[i, j]);
              else
                R[2] := R[2];
              end if;
              if Rule_2[i] == InLV[j + 5] then
                R[2] := min(R[2], 1 - In[i, j]);
              else
                R[2] := R[2];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_2[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P2*R[2]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 2 < n_Rules then
          /*   translate Rule_3:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_3[i] == InLV[j] then
                R[3] := min(R[3], In[i, j]);
              else
                R[3] := R[3];
              end if;
              if Rule_3[i] == InLV[j + 5] then
                R[3] := min(R[3], 1 - In[i, j]);
              else
                R[3] := R[3];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_3[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P3*R[3]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 3 < n_Rules then
          /*   translate Rule_4:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_4[i] == InLV[j] then
                R[4] := min(R[4], In[i, j]);
              else
                R[4] := R[4];
              end if;
              if Rule_4[i] == InLV[j + 5] then
                R[4] := min(R[4], 1 - In[i, j]);
              else
                R[4] := R[4];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_4[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P4*R[4]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 4 < n_Rules then
          /*   translate Rule_5:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_5[i] == InLV[j] then
                R[5] := min(R[5], In[i, j]);
              else
                R[5] := R[5];
              end if;
              if Rule_5[i] == InLV[j + 5] then
                R[5] := min(R[5], 1 - In[i, j]);
              else
                R[5] := R[5];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_5[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P5*R[5]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 5 < n_Rules then
          /*   translate Rule_6:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_6[i] == InLV[j] then
                R[6] := min(R[6], In[i, j]);
              else
                R[6] := R[6];
              end if;
              if Rule_6[i] == InLV[j + 5] then
                R[6] := min(R[6], 1 - In[i, j]);
              else
                R[6] := R[6];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_6[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P6*R[6]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 6 < n_Rules then
          /*   translate Rule_7:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_7[i] == InLV[j] then
                R[7] := min(R[7], In[i, j]);
              else
                R[7] := R[7];
              end if;
              if Rule_7[i] == InLV[j + 5] then
                R[7] := min(R[7], 1 - In[i, j]);
              else
                R[7] := R[7];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_7[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P7*R[7]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 7 < n_Rules then
          /*   translate Rule_8:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_8[i] == InLV[j] then
                R[8] := min(R[8], In[i, j]);
              else
                R[8] := R[8];
              end if;
              if Rule_8[i] == InLV[j + 5] then
                R[8] := min(R[8], 1 - In[i, j]);
              else
                R[8] := R[8];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_8[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P8*R[8]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 8 < n_Rules then
          /*   translate Rule_9:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_9[i] == InLV[j] then
                R[9] := min(R[9], In[i, j]);
              else
                R[9] := R[9];
              end if;
              if Rule_9[i] == InLV[j + 5] then
                R[9] := min(R[9], 1 - In[i, j]);
              else
                R[9] := R[9];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_9[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P9*R[9]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 9 < n_Rules then
          /*   translate Rule_10:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_10[i] == InLV[j] then
                R[10] := min(R[10], In[i, j]);
              else
                R[10] := R[10];
              end if;
              if Rule_10[i] == InLV[j + 5] then
                R[10] := min(R[10], 1 - In[i, j]);
              else
                R[10] := R[10];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_10[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P10*R[10]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 10 < n_Rules then
          /*   translate Rule_11:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_11[i] == InLV[j] then
                R[11] := min(R[11], In[i, j]);
              else
                R[11] := R[11];
              end if;
              if Rule_11[i] == InLV[j + 5] then
                R[11] := min(R[11], 1 - In[i, j]);
              else
                R[11] := R[11];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_11[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P11*R[11]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 11 < n_Rules then
          /*   translate Rule_12:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_12[i] == InLV[j] then
                R[12] := min(R[12], In[i, j]);
              else
                R[12] := R[12];
              end if;
              if Rule_12[i] == InLV[j + 5] then
                R[12] := min(R[12], 1 - In[i, j]);
              else
                R[12] := R[12];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_12[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P12*R[12]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 12 < n_Rules then
          /*   translate Rule_13:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_13[i] == InLV[j] then
                R[13] := min(R[13], In[i, j]);
              else
                R[13] := R[13];
              end if;
              if Rule_13[i] == InLV[j + 5] then
                R[13] := min(R[13], 1 - In[i, j]);
              else
                R[13] := R[13];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_13[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P13*R[13]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 13 < n_Rules then
          /*   translate Rule_14:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_14[i] == InLV[j] then
                R[14] := min(R[14], In[i, j]);
              else
                R[14] := R[14];
              end if;
              if Rule_14[i] == InLV[j + 5] then
                R[14] := min(R[14], 1 - In[i, j]);
              else
                R[14] := R[14];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_14[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P14*R[14]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 14 < n_Rules then
          /*   translate Rule_15:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_15[i] == InLV[j] then
                R[15] := min(R[15], In[i, j]);
              else
                R[15] := R[15];
              end if;
              if Rule_15[i] == InLV[j + 5] then
                R[15] := min(R[15], 1 - In[i, j]);
              else
                R[15] := R[15];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_15[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P15*R[15]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 15 < n_Rules then
          /*   translate Rule_16:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_16[i] == InLV[j] then
                R[16] := min(R[16], In[i, j]);
              else
                R[16] := R[16];
              end if;
              if Rule_16[i] == InLV[j + 5] then
                R[16] := min(R[16], 1 - In[i, j]);
              else
                R[16] := R[16];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_16[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P16*R[16]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 16 < n_Rules then
          /*   translate Rule_17:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_17[i] == InLV[j] then
                R[17] := min(R[17], In[i, j]);
              else
                R[17] := R[17];
              end if;
              if Rule_17[i] == InLV[j + 5] then
                R[17] := min(R[17], 1 - In[i, j]);
              else
                R[17] := R[17];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_17[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P17*R[17]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 17 < n_Rules then
          /*   translate Rule_18:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_18[i] == InLV[j] then
                R[18] := min(R[18], In[i, j]);
              else
                R[18] := R[18];
              end if;
              if Rule_18[i] == InLV[j + 5] then
                R[18] := min(R[18], 1 - In[i, j]);
              else
                R[18] := R[18];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_18[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P18*R[18]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 18 < n_Rules then
          /*   translate Rule_19:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_19[i] == InLV[j] then
                R[19] := min(R[19], In[i, j]);
              else
                R[19] := R[19];
              end if;
              if Rule_19[i] == InLV[j + 5] then
                R[19] := min(R[19], 1 - In[i, j]);
              else
                R[19] := R[19];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_19[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P19*R[19]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 19 < n_Rules then
          /*   translate Rule_20:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_20[i] == InLV[j] then
                R[20] := min(R[20], In[i, j]);
              else
                R[20] := R[20];
              end if;
              if Rule_20[i] == InLV[j + 5] then
                R[20] := min(R[20], 1 - In[i, j]);
              else
                R[20] := R[20];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_20[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P20*R[20]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 20 < n_Rules then
          /*   translate Rule_21:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_21[i] == InLV[j] then
                R[21] := min(R[21], In[i, j]);
              else
                R[21] := R[21];
              end if;
              if Rule_21[i] == InLV[j + 5] then
                R[21] := min(R[21], 1 - In[i, j]);
              else
                R[21] := R[21];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_21[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P21*R[21]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 21 < n_Rules then
          /*   translate Rule_22:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_22[i] == InLV[j] then
                R[22] := min(R[22], In[i, j]);
              else
                R[22] := R[22];
              end if;
              if Rule_22[i] == InLV[j + 5] then
                R[22] := min(R[22], 1 - In[i, j]);
              else
                R[22] := R[22];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_22[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P22*R[22]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 22 < n_Rules then
          /*   translate Rule_23:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_23[i] == InLV[j] then
                R[23] := min(R[23], In[i, j]);
              else
                R[23] := R[23];
              end if;
              if Rule_23[i] == InLV[j + 5] then
                R[23] := min(R[23], 1 - In[i, j]);
              else
                R[23] := R[23];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_23[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P23*R[23]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 23 < n_Rules then
          /*   translate Rule_24:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_24[i] == InLV[j] then
                R[24] := min(R[24], In[i, j]);
              else
                R[24] := R[24];
              end if;
              if Rule_24[i] == InLV[j + 5] then
                R[24] := min(R[24], 1 - In[i, j]);
              else
                R[24] := R[24];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_24[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P24*R[24]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 24 < n_Rules then
          /*   translate Rule_25:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_25[i] == InLV[j] then
                R[25] := min(R[25], In[i, j]);
              else
                R[25] := R[25];
              end if;
              if Rule_25[i] == InLV[j + 5] then
                R[25] := min(R[25], 1 - In[i, j]);
              else
                R[25] := R[25];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_25[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P25*R[25]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 25 < n_Rules then
          /*   translate Rule_26:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_26[i] == InLV[j] then
                R[26] := min(R[26], In[i, j]);
              else
                R[26] := R[26];
              end if;
              if Rule_26[i] == InLV[j + 5] then
                R[26] := min(R[26], 1 - In[i, j]);
              else
                R[26] := R[26];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_26[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P26*R[26]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 26 < n_Rules then
          /*   translate Rule_27:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_27[i] == InLV[j] then
                R[27] := min(R[27], In[i, j]);
              else
                R[27] := R[27];
              end if;
              if Rule_27[i] == InLV[j + 5] then
                R[27] := min(R[27], 1 - In[i, j]);
              else
                R[27] := R[27];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_27[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P27*R[27]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 27 < n_Rules then
          /*   translate Rule_28:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_28[i] == InLV[j] then
                R[28] := min(R[28], In[i, j]);
              else
                R[28] := R[28];
              end if;
              if Rule_28[i] == InLV[j + 5] then
                R[28] := min(R[28], 1 - In[i, j]);
              else
                R[28] := R[28];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_28[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P28*R[28]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 28 < n_Rules then
          /*   translate Rule_29:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_29[i] == InLV[j] then
                R[29] := min(R[29], In[i, j]);
              else
                R[29] := R[29];
              end if;
              if Rule_29[i] == InLV[j + 5] then
                R[29] := min(R[29], 1 - In[i, j]);
              else
                R[29] := R[29];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_29[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P29*R[29]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 29 < n_Rules then
          /*   translate Rule_30:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_30[i] == InLV[j] then
                R[30] := min(R[30], In[i, j]);
              else
                R[30] := R[30];
              end if;
              if Rule_30[i] == InLV[j + 5] then
                R[30] := min(R[30], 1 - In[i, j]);
              else
                R[30] := R[30];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_30[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P30*R[30]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 30 < n_Rules then
          /*   translate Rule_31:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_31[i] == InLV[j] then
                R[31] := min(R[31], In[i, j]);
              else
                R[31] := R[31];
              end if;
              if Rule_31[i] == InLV[j + 5] then
                R[31] := min(R[31], 1 - In[i, j]);
              else
                R[31] := R[31];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_31[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P31*R[31]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 31 < n_Rules then
          /*   translate Rule_32:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_32[i] == InLV[j] then
                R[32] := min(R[32], In[i, j]);
              else
                R[32] := R[32];
              end if;
              if Rule_32[i] == InLV[j + 5] then
                R[32] := min(R[32], 1 - In[i, j]);
              else
                R[32] := R[32];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_32[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P32*R[32]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 32 < n_Rules then
          /*   translate Rule_33:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_33[i] == InLV[j] then
                R[33] := min(R[33], In[i, j]);
              else
                R[33] := R[33];
              end if;
              if Rule_33[i] == InLV[j + 5] then
                R[33] := min(R[33], 1 - In[i, j]);
              else
                R[33] := R[33];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_33[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P33*R[33]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 33 < n_Rules then
          /*   translate Rule_34:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_34[i] == InLV[j] then
                R[34] := min(R[34], In[i, j]);
              else
                R[34] := R[34];
              end if;
              if Rule_34[i] == InLV[j + 5] then
                R[34] := min(R[34], 1 - In[i, j]);
              else
                R[34] := R[34];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_34[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P34*R[34]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 34 < n_Rules then
          /*   translate Rule_35:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_35[i] == InLV[j] then
                R[35] := min(R[35], In[i, j]);
              else
                R[35] := R[35];
              end if;
              if Rule_35[i] == InLV[j + 5] then
                R[35] := min(R[35], 1 - In[i, j]);
              else
                R[35] := R[35];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_35[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P35*R[35]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 35 < n_Rules then
          /*   translate Rule_36:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_36[i] == InLV[j] then
                R[36] := min(R[36], In[i, j]);
              else
                R[36] := R[36];
              end if;
              if Rule_36[i] == InLV[j + 5] then
                R[36] := min(R[36], 1 - In[i, j]);
              else
                R[36] := R[36];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_36[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P36*R[36]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 36 < n_Rules then
          /*   translate Rule_37:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_37[i] == InLV[j] then
                R[37] := min(R[37], In[i, j]);
              else
                R[37] := R[37];
              end if;
              if Rule_37[i] == InLV[j + 5] then
                R[37] := min(R[37], 1 - In[i, j]);
              else
                R[37] := R[37];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_37[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P37*R[37]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 37 < n_Rules then
          /*   translate Rule_38:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_38[i] == InLV[j] then
                R[38] := min(R[38], In[i, j]);
              else
                R[38] := R[38];
              end if;
              if Rule_38[i] == InLV[j + 5] then
                R[38] := min(R[38], 1 - In[i, j]);
              else
                R[38] := R[38];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_38[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P38*R[38]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 38 < n_Rules then
          /*   translate Rule_39:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_39[i] == InLV[j] then
                R[39] := min(R[39], In[i, j]);
              else
                R[39] := R[39];
              end if;
              if Rule_39[i] == InLV[j + 5] then
                R[39] := min(R[39], 1 - In[i, j]);
              else
                R[39] := R[39];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_39[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P39*R[39]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 39 < n_Rules then
          /*   translate Rule_40:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_40[i] == InLV[j] then
                R[40] := min(R[40], In[i, j]);
              else
                R[40] := R[40];
              end if;
              if Rule_40[i] == InLV[j + 5] then
                R[40] := min(R[40], 1 - In[i, j]);
              else
                R[40] := R[40];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_40[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P40*R[40]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 40 < n_Rules then
          /*   translate Rule_41:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_41[i] == InLV[j] then
                R[41] := min(R[41], In[i, j]);
              else
                R[41] := R[41];
              end if;
              if Rule_41[i] == InLV[j + 5] then
                R[41] := min(R[41], 1 - In[i, j]);
              else
                R[41] := R[41];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_41[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P41*R[41]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 41 < n_Rules then
          /*   translate Rule_42:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_42[i] == InLV[j] then
                R[42] := min(R[42], In[i, j]);
              else
                R[42] := R[42];
              end if;
              if Rule_42[i] == InLV[j + 5] then
                R[42] := min(R[42], 1 - In[i, j]);
              else
                R[42] := R[42];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_42[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P42*R[42]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 42 < n_Rules then
          /*   translate Rule_43:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_43[i] == InLV[j] then
                R[43] := min(R[43], In[i, j]);
              else
                R[43] := R[43];
              end if;
              if Rule_43[i] == InLV[j + 5] then
                R[43] := min(R[43], 1 - In[i, j]);
              else
                R[43] := R[43];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_43[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P43*R[43]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 43 < n_Rules then
          /*   translate Rule_44:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_44[i] == InLV[j] then
                R[44] := min(R[44], In[i, j]);
              else
                R[44] := R[44];
              end if;
              if Rule_44[i] == InLV[j + 5] then
                R[44] := min(R[44], 1 - In[i, j]);
              else
                R[44] := R[44];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_44[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P44*R[44]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 44 < n_Rules then
          /*   translate Rule_45:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_45[i] == InLV[j] then
                R[45] := min(R[45], In[i, j]);
              else
                R[45] := R[45];
              end if;
              if Rule_45[i] == InLV[j + 5] then
                R[45] := min(R[45], 1 - In[i, j]);
              else
                R[45] := R[45];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_45[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P45*R[45]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 45 < n_Rules then
          /*   translate Rule_46:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_46[i] == InLV[j] then
                R[46] := min(R[46], In[i, j]);
              else
                R[46] := R[46];
              end if;
              if Rule_46[i] == InLV[j + 5] then
                R[46] := min(R[46], 1 - In[i, j]);
              else
                R[46] := R[46];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_46[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P46*R[46]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 46 < n_Rules then
          /*   translate Rule_47:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_47[i] == InLV[j] then
                R[47] := min(R[47], In[i, j]);
              else
                R[47] := R[47];
              end if;
              if Rule_47[i] == InLV[j + 5] then
                R[47] := min(R[47], 1 - In[i, j]);
              else
                R[47] := R[47];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_47[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P47*R[47]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 47 < n_Rules then
          /*   translate Rule_48:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_48[i] == InLV[j] then
                R[48] := min(R[48], In[i, j]);
              else
                R[48] := R[48];
              end if;
              if Rule_48[i] == InLV[j + 5] then
                R[48] := min(R[48], 1 - In[i, j]);
              else
                R[48] := R[48];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_48[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P48*R[48]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 48 < n_Rules then
          /*   translate Rule_49:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_49[i] == InLV[j] then
                R[49] := min(R[49], In[i, j]);
              else
                R[49] := R[49];
              end if;
              if Rule_49[i] == InLV[j + 5] then
                R[49] := min(R[49], 1 - In[i, j]);
              else
                R[49] := R[49];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_49[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P49*R[49]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        if 49 < n_Rules then
          /*   translate Rule_50:   */
          for i in 1:n_In loop
            for j in 1:5 loop
              if Rule_50[i] == InLV[j] then
                R[50] := min(R[50], In[i, j]);
              else
                R[50] := R[50];
              end if;
              if Rule_50[i] == InLV[j + 5] then
                R[50] := min(R[50], 1 - In[i, j]);
              else
                R[50] := R[50];
              end if;
            end for;
          end for;

          for i in 1:n_Out loop
            for j in 1:5 loop
              if Rule_50[n_In + i] == OutLV[j] then
                Out[i, j] := max(Out[i, j], P50*R[50]);
              else
                Out[i, j] := Out[i, j];
              end if;
            end for;
          end for;
        end if;

        for i in 1:5 loop
          Out1.signal[i] := Out[1, i];
          Out2.signal[i] := Out[2, i];
          Out3.signal[i] := Out[3, i];
          Out4.signal[i] := Out[4, i];
          Out5.signal[i] := Out[5, i];
        end for;

      end v2_rules;
    end rules_v2;

    package cuts_v2
      extends Icons.Package;
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
      connector cut_flow_v2
        parameter Integer n=5;
        flow Real s[n];
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Diagram(
            Polygon(points=[-102, 100; 32, 2; -102, -102; -102, 100], style(
                  color=10, thickness=2)),
            Line(points=[-88, 0; 0, 0; 0, 0; 0, 0; 0, 0], style(color=0)),
            Line(points=[-42, 12; -58, -16], style(color=0)),
            Text(
              extent=[-72, -22; -44, -46],
              string="%n",
              style(color=0)),
            Text(
              extent=[-88, 46; -38, 26],
              string="Flow",
              style(color=0, pattern=0))),
          Window(
            x=0.33,
            y=0.04,
            width=0.6,
            height=0.6),
          Icon(
            Polygon(points=[-102, 100; 32, 2; -102, -102; -102, 100], style(
                  color=10, thickness=2)),
            Line(points=[-88, 0; 0, 0; 0, 0; 0, 0; 0, 0], style(color=0)),
            Line(points=[-40, 12; -56, -16], style(color=0)),
            Text(
              extent=[-72, -24; -44, -48],
              string="%n",
              style(color=0)),
            Text(
              extent=[-88, 46; -38, 26],
              string="Flow",
              style(color=0, pattern=0))));
      end cut_flow_v2;
    end cuts_v2;
  end Version_2;
end Fuzzy_Control;
