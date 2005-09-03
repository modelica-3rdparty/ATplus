model ExampleFuzzy
  Controller.Fuzzy_Control.Version_2.inputs_v2.v2_input_3 v2_input_3_1(
    emin=0,
    emax=80,
    es={20,40},
    em={20,40,50,60},
    eb={50,60},
    out_minus=1,
    out_plus=1) annotation (extent=[-48,72; -22,96]);
  Controller.Fuzzy_Control.Version_2.inputs_v2.v2_input_3 v2_input_3_2(
    emin=-20,
    emax=20,
    es={-20,10},
    em={-20,10,10,20},
    eb={10,20},
    out_minus=1,
    out_plus=1) annotation (extent=[-48,36; -22,60]);
  Controller.Fuzzy_Control.Version_2.inputs_v2.v2_input_3 v2_input_3_3(
    emin=-30,
    emax=50,
    es={-10,0},
    em={-10,0,20,30},
    eb={20,30},
    out_minus=1,
    out_plus=1,
    SAMPLE=false)
                annotation (extent=[-48,8; -22,32]);
  Controller.Fuzzy_Control.Version_2.outputs_v2.v2_output_cos_3
    v2_output_cos_3_1(
    u1=40,
    u2=60,
    u3=90) annotation (extent=[74,34; 98,62]);
  Controller.Fuzzy_Control.Version_2.rules_v2.v2_rules v2_rules1(
    Rule_1={"small","d","small","MEDIUM"},
    Rule_2={"small","d","medium","SMALL"},
    Rule_3={"small","d","big","SMALL"},
    Rule_4={"medium","small","d","BIG"},
    Rule_5={"big","big","d","MEDIUM"}) annotation (extent=[8,-4; 54,58]);
  annotation (Diagram, Icon(Rectangle(extent=[-78, 100; 78, -100], style(color=
              0, thickness=4)), Text(
        extent=[-74, 98; 82, -84],
        style(color=0, thickness=4),
        string="F")));
  Modelica.Blocks.Interfaces.InPort Tfeedwater
    annotation (extent=[-98, 74; -78, 94]);
  Modelica.Blocks.Interfaces.InPort Tcooledwater
    annotation (extent=[-98, -6; -78, 14]);
  Modelica.Blocks.Interfaces.InPort Toutside
    annotation (extent=[-98, -90; -78, -70]);
  Modelica.Blocks.Interfaces.OutPort OutPort1
    annotation (extent=[78, -24; 98, -4]);
  Modelica.Blocks.Math.Feedback Feedback1 annotation (extent=[-74, 74; -54, 94]);
  Controller.Conventional.Continuous.Delay Delay1(DelayTime=7200)
    annotation (extent=[-30, -62; -10, -42]);
  Modelica.Blocks.Math.Feedback Feedback2 annotation (extent=[-12, -40; 8, -20]);
equation
  connect(v2_output_cos_3_1.In, v2_rules1.Out1) annotation (points=[72.0183,
        48.2667; 70.0015,48.2667; 70.0015,48.3605; 65.6543,48.3605; 65.6543,
        49.01; 53.54,49.01],   style(color=3));
  connect(v2_input_3_1.Out, v2_rules1.In1)
    annotation (points=[-22,84.1154; 8,84.1154; 8,54.59],    style(color=10));
  connect(v2_input_3_2.Out, v2_rules1.In2) annotation (points=[-22,48.1154; -21,
        48.1154; -21,47.7262; -12,47.7262; -12,48.39; 8,48.39],      style(
        color=10));
  connect(v2_input_3_3.Out, v2_rules1.In3) annotation (points=[-22,20.1154; -8,
        20.1154; -8,42.19; 8,42.19],    style(color=10));
  connect(Tfeedwater, Feedback1.inPort1)
    annotation (points=[-88, 84; -72, 84], style(color=45));
  connect(Feedback1.outPort, v2_input_3_1.In) annotation (points=[-55,84;
        -48.5431,84; -48.5431,84.3462; -48.1121,84.3462],
                                                    style(color=45));
  connect(Tcooledwater, Feedback1.inPort2)
    annotation (points=[-88, 4; -64, 4; -64, 76], style(color=45));
  connect(Toutside, v2_input_3_3.In) annotation (points=[-88,-80; -48.1121,-80;
        -48.1121,20.3462],   style(color=3));
  connect(v2_output_cos_3_1.Out, OutPort1) annotation (points=[98,48.8; 100,
        48.8; 100,6; 70,6; 70,-14; 88,-14],         style(color=3));
  connect(Toutside, Delay1.InPort)
    annotation (points=[-88, -80; -88, -52; -30, -52], style(color=83));
  connect(Delay1.OutPort, Feedback2.inPort2)
    annotation (points=[-10, -52; -2, -52; -2, -38], style(color=83));
  connect(Toutside, Feedback2.inPort1)
    annotation (points=[-88, -80; -88, -30; -10, -30], style(color=83));
  connect(Feedback2.outPort, v2_input_3_2.In) annotation (points=[7,-30; 20,-30;
        20,-10; -60,-10; -60,48.3462; -48.1121,48.3462],      style(color=83));
end ExampleFuzzy;
