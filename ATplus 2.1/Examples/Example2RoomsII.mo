class Example2RoomsII

  annotation (
    Coordsys(
      extent=[-220, -238; 244, 218],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.07,
      y=0.01,
      width=0.44,
      height=0.96),
    Diagram,
    experiment(StopTime=85500),
    experimentSetupOutput);
  ATplus.Building.Rooms.room6zonesA2 Room1
    annotation (extent=[-146, 64; -54, 158]);
  ATplus.Building.Rooms.room6zonesA2 Room2(comp_surf_orient_alias="nv")
    annotation (extent=[98, 64; 6, 158]);
  ATplus.Building.Layer.layer layer1 annotation (extent=[-34, 124; -14, 144]);
  ATplus.Building.Layer.layer layer2
    annotation (extent=[76, 30; 96, 50], rotation=90);
  ATplus.Building.Layer.layer layer3
    annotation (extent=[-142, 30; -122, 50], rotation=90);
  ATplus.Building.RoomAttribute.HeatFlow_Airexchange HeatFlow_Airexchange1(
    n=0,
    airex=0,
    men=0) annotation (extent=[-40, 18; -8, 52]);
  ATplus.Building.Sources.FixedTemp FixedTemp2(Ts=8)
    annotation (extent=[-32, -26; -12, -6]);
  ATplus.Hvac.Heating.Advanced.losspipe_long losspipe_long1(
    n=3,
    T0_water=16,
    T0_wall=16,
    T0_iso=16) annotation (extent=[-202, -114; -168, -88]);
  ATplus.Hvac.Heating.Advanced.pump_controlled pump_controlled1(p=1000)
    annotation (extent=[-232, -156; -188, -118]);
  ATplus.Hvac.Heating.Advanced.BoilerFF BoilerFF1(P=10000)
    annotation (extent=[-94, -184; -140, -142]);
  ATplus.Hvac.Heating.Advanced.Base.radiator radiator1(T0=16, surface=10)
    annotation (extent=[-36, -82; -4, -54]);
  ATplus.Hvac.Heating.Advanced.Base.radiator radiator2(T0=16, surface=10)
    annotation (extent=[110, -80; 142, -52]);
  ATplus.Hvac.Heating.Advanced.losspipe_long losspipe_long3(
    l=20,
    n=3,
    T0_water=16,
    T0_wall=16,
    T0_iso=16) annotation (extent=[126, -174; 28, -150]);
  ATplus.Hvac.Heating.Advanced.losspipe_long BypassRad1(
    n=2,
    T0_water=16,
    T0_wall=16,
    T0_iso=16,
    l=5) annotation (extent=[-92, -112; -54, -90]);
  ATplus.Hvac.Heating.Advanced.Base.TMixer TMixer2
    annotation (extent=[190, -106; 218, -60], rotation=0);
  ATplus.Building.Sources.FixedTemp FixedTempBoiler(Ts=16)
    annotation (extent=[-126, -124; -108, -134]);
  ATplus.Building.TempSensor TempSensorRoom1
    annotation (extent=[-200, 84; -176, 114]);
  ATplus.Building.TempSensor TempSensorRoom2
    annotation (extent=[194, 80; 218, 110]);
  ATplus.Building.Sources.VarTemp VarTemp1
    annotation (extent=[-36, 188; -10, 212], rotation=180);
  ATplus.Hvac.Heating.Advanced.Valve2W Valve2W1
    annotation (extent=[-80, -76; -52, -48], rotation=0);
  ATplus.Hvac.Heating.Advanced.Valve2W Valve2W2
    annotation (extent=[65.2, -75.2; 93.2, -47.2], rotation=0);
  Weather.Sky_and_Dewpoint_Temperature.Skytemp Skytemp1(HumidityTable(tableName=
         "humid", fileName="humid.txt"))
    annotation (extent=[166, 146; 146, 166], rotation=0);
  Building.Layer.chalfwall chalfwall1(dWall=0.6)
    annotation (extent=[-110, 172; -90, 192], rotation=270);
  Building.Layer.chalfwall chalfwall2(dWall=0.6)
    annotation (extent=[45.2, 166.8; 65.2, 186.8], rotation=270);
  Building.Layer.chalfwall chalfwall3(dWall=0.6)
    annotation (extent=[106.4, 145.6; 126.4, 125.6], rotation=180);
  Building.Layer.chalfwall chalfwall4(dWall=0.6)
    annotation (extent=[-166.4, 128.4; -146.4, 148.4], rotation=0);
  Building.Layer.chalfwall chalfwall5(dWall=0.6) annotation (
    extent=[-27.2, 77.2; -47.2, 97.2],
    rotation=0,
    style(color=0));
  Building.Layer.chalfwall chalfwall6(dWall=0.6)
    annotation (extent=[-19.2, 77.2; 0.8, 97.2], rotation=0);
  Building.Layer.chalfwall chalfwall8(dWall=0.6) annotation (
    extent=[-88, 26; -108, 46],
    rotation=90,
    style(color=0));
  Building.Layer.chalfwall chalfwall9(dWall=0.6) annotation (
    extent=[65.2, 34.8; 45.2, 54.8],
    rotation=90,
    style(color=0));
  Weather.t_and_sl_rad.global.global_3a global_3a1(
    uf_sim_ini_clt_date=01032003,
    uf_sim_ini_clt_h_of_d=001231,
    uf_ini_date=01032003,
    uf_ini_h_of_d=001231,
    uf_fin_date=31032003,
    uf_fin_h_of_d=234833,
    apply=true,
    table_name="tab_mrz2",
    file_name="tab_mrz2.txt",
    weather_data_t_step=1800,
    rad_col=2,
    more_outputs_col={4}) annotation (extent=[256, 136; 204, 182]);
  Controller.Conventional.Continuous.Cont_PI PIRoom1(
    Kp=0.1,
    Ki=0.001,
    umin=0) annotation (extent=[-114, -38; -94, -58]);
  Controller.Conventional.Continuous.Cont_PI PIRoom2(
    Kp=0.1,
    Ki=0.001,
    umin=0) annotation (extent=[35.2, -37.2; 55.2, -57.2]);
  ExampleFuzzy ExampleFuzzy1(
    v2_rules1(
      n_In=3,
      n_Out=1,
      P1=1,
      Rule_1={"small","medium","medium","SMALL"},
      Rule_2={"medium","medium","medium","MEDIUM"},
      Rule_3={"big","medium","medium","BIG"},
      Rule_4={"small","small","small","BIG"},
      Rule_5={"small","big","small","MEDIUM"},
      Rule_6={"medium","big","small","MEDIUM"},
      Rule_7={"big","big","medium","SMALL"},
      n_Rules=7),
    v2_output_cos_3_1(
      u3=90,
      default_output=90,
      u1=70,
      u2=80),
    v2_input_3_2(
      emin=-5,
      emax=5,
      es={-2,1},
      em={-2,1,1,2},
      eb={1,2}),
    v2_input_3_1(
      es={0,10},
      em={0,10,40,60},
      eb={40,60})) annotation (extent=[94, -214; 74, -194]);
  Modelica.Blocks.Math.Feedback Feedback1
    annotation (extent=[-26, -186; -46, -166]);
  Hvac.Heating.Advanced.TempSensorFlow TCooledWater
    annotation (extent=[-148, -210; -128, -230]);
  Hvac.Heating.Advanced.TempSensorFlow TFeedwater
    annotation (extent=[-106.8, -219.2; -86.8, -239.2]);
  Controller.Conventional.Continuous.Relay RelayBoiler(jp1=-2, jp2=2)
    annotation (extent=[-56, -186; -76, -166]);
  ATplus.Hvac.Heating.Advanced.losspipe_long BypassRad2(
    n=2,
    T0_water=16,
    T0_wall=16,
    T0_iso=16,
    l=5) annotation (extent=[-4.8, -131.2; 33.2, -109.2]);
  Modelica.Blocks.Sources.Pulse SetPoint_Room1(
    period={86400},
    startTime={7*3600},
    width={50},
    amplitude={1},
    offset={20}) annotation (extent=[-218,-62; -196,-38]);
  Modelica.Blocks.Sources.Pulse SetPoint_Room2(
    period={86400},
    startTime={7*3600},
    width={50},
    amplitude={2},
    offset={20}) annotation (extent=[236,-60; 214,-36]);
equation
  connect(layer1.therm1, Room1.therm3) annotation (points=[-33, 134; -49.94,
        134; -49.94, 135.44; -66.88, 135.44], style(color=4));
  connect(layer1.therm2, Room2.therm3) annotation (points=[-15,134; 1.94,134;
        1.94,135.44; 18.88,135.44],    style(color=4));
  connect(layer2.therm2, Room2.therm6)
    annotation (points=[86, 49; 86, 67.78; 86, 86.56; 85.12, 86.56]);
  connect(layer3.therm2, Room1.therm6)
    annotation (points=[-132, 49; -132, 67.78; -132, 86.56; -133.12, 86.56]);
  connect(HeatFlow_Airexchange1.OutPort1, Room2.ic_air_change) annotation (
      points=[-8.08,41.29; 31.76,41.29; 31.76,74.246],    style(color=0));
  connect(Room2.ic_heat_gain, HeatFlow_Airexchange1.OutPort2) annotation (
      points=[37.28, 74.34; 37.28, 28.71; -8.08, 28.71], style(color=0));
  connect(HeatFlow_Airexchange1.OutPort1, Room1.ic_heat_gain) annotation (
      points=[-8.08, 41.29; -2, 41.29; -2, 60; -85.28, 60; -85.28, 74.34],
      style(color=0));
  connect(HeatFlow_Airexchange1.OutPort2, Room1.ic_air_change) annotation (
      points=[-8.08,28.71; 4,28.71; 4,64; -79.76,64; -79.76,74.246],      style(
        color=0));
  connect(FixedTemp2.therm1, layer2.therm1)
    annotation (points=[-22, -7; 86, -7; 86, 31], style(color=65));
  connect(pump_controlled1.IN, BoilerFF1.OUT) annotation (points=[-209.132,
        -148.671; -209.132,-161.11; -139.08,-161.11],
                                               style(color=1, thickness=4));
  connect(layer3.therm1, FixedTemp2.therm1)
    annotation (points=[-132, 31; -132, -7; -22, -7], style(color=65));
  connect(radiator1.therm1, Room1.therm7) annotation (points=[-27.2, -54.7; -27.2,
         -36; -170, -36; -170, 111; -146, 111], style(color=41, thickness=2));
  connect(TempSensorRoom1.therm1, Room1.therm7) annotation (points=[-187.467,
        106.734; -187.467,111; -146,111],   style(color=10));
  connect(Room2.therm7, TempSensorRoom2.therm1) annotation (points=[98,111;
        206.533,111; 206.533,102.734],   style(color=10));
  connect(radiator2.therm2, Room2.therm9) annotation (points=[133.36,-52.7;
        133.36,72.46; 64.88,72.46],   style(thickness=2));
  connect(Room1.therm9, radiator1.therm2) annotation (points=[-112.88,72.46;
        -112.88,-30; -12.64,-30; -12.64,-54.7],
                                           style(thickness=2));
  connect(Valve2W1.OUT, radiator1.IN) annotation (points=[-52.5355,-61.2;
        -48.3217,-61.2; -48.3217,-62.62; -44.1078,-62.62; -44.1078,-61.42;
        -35.84,-61.42],
       style(
      color=1,
      thickness=4,
      gradient=2,
      fillColor=69));
  connect(losspipe_long1.Out, Valve2W1.IN) annotation (points=[-166.81,-100.48;
        -164,-62; -77.5519,-61.4667],    style(
      color=1,
      thickness=4,
      gradient=2,
      fillColor=69));
  connect(BypassRad1.Out, Valve2W2.IN) annotation (points=[-52.67,-100.56; 60,
        -100.56; 60,-60.6667; 67.6481,-60.6667],    style(color=1, thickness=4));
  connect(chalfwall1.therm2, Room1.therm2)
    annotation (points=[-100, 173; -100, 149.54], style(color=4));
  connect(chalfwall1.therm1, VarTemp1.therm1) annotation (points=[-100, 191; -100,
         202; -50, 202; -50, 180; -23, 180; -23, 189.2], style(color=4));
  connect(chalfwall2.therm2, Room2.therm2)
    annotation (points=[55.2, 167.8; 52, 149.54], style(color=4));
  connect(chalfwall2.therm1, VarTemp1.therm1) annotation (points=[55.2, 185.8;
        54, 196; 6, 196; 6, 180; -23, 180; -23, 189.2], style(color=4));
  connect(Skytemp1.therm1, chalfwall2.therm3) annotation (points=[145.6, 157.6;
         94, 157.6; 94, 176.8; 64.2, 176.8], style(color=0));
  connect(chalfwall1.therm3, Skytemp1.therm1) annotation (points=[-91, 182; 42,
         182; 42, 194; 108, 194; 108, 157.6; 145.6, 157.6], style(color=0));
  connect(chalfwall3.therm3, Skytemp1.therm1) annotation (points=[116.4, 144.6;
         116.4, 157.6; 145.6, 157.6], style(color=0));
  connect(chalfwall4.therm2, Room1.therm1) annotation (points=[-147.4, 138.4; -138,
         138.4; -138, 135.44; -133.12, 135.44]);
  connect(chalfwall4.therm1, VarTemp1.therm1) annotation (points=[-165.4, 138.4;
         -180, 138.4; -180, 210; -46, 210; -46, 170; -23, 170; -23, 189.2],
      style(color=4));
  connect(chalfwall3.therm1, VarTemp1.therm1) annotation (points=[125.4, 135.6;
         132, 135.6; 132, 204; 0, 204; 0, 168; -23, 168; -23, 189.2], style(
        color=4));
  connect(chalfwall4.therm3, Skytemp1.therm1) annotation (points=[-156.4, 147.4;
         -156.4, 157.6; 145.6, 157.6], style(color=0));
  connect(chalfwall6.therm2, Room2.therm4) annotation (points=[-0.2,87.2; 4.79,
        87.2; 4.79,85.76; 9.78,85.76; 9.78,86.56; 18.88,86.56],      style(
        color=4));
  connect(Room1.therm4, chalfwall5.therm2) annotation (points=[-66.88, 86.56; -61.71,
         86.56; -61.71, 85.76; -56.54, 85.76; -56.54, 87.2; -46.2, 87.2], style(
        color=4));
  connect(chalfwall5.therm1, VarTemp1.therm1)
    annotation (points=[-28.2,87.2; -23,87.2; -23,189.2],    style(color=4));
  connect(chalfwall6.therm1, VarTemp1.therm1)
    annotation (points=[-18.2, 87.2; -23, 87.2; -23, 189.2], style(color=4));
  connect(chalfwall6.therm3, Skytemp1.therm1) annotation (points=[-9.2, 96.2; -9.2,
         157.6; 145.6, 157.6], style(color=0));
  connect(chalfwall5.therm3, Skytemp1.therm1) annotation (points=[-37.2, 96.2;
        -37.2, 157.6; 145.6, 157.6], style(color=0));
  connect(chalfwall8.therm2, Room1.therm5) annotation (points=[-98,45; -98,
        58.73; -98,72.46; -100,72.46],   style(color=4));
  connect(chalfwall8.therm1, VarTemp1.therm1) annotation (points=[-98, 27; -98,
         12; -56, 12; -56, 172; -23, 172; -23, 189.2], style(color=4));
  connect(Room2.therm5, chalfwall9.therm2) annotation (points=[52,72.46; 52,
        62.9; 55.2,62.9; 55.2,53.8],   style(color=4));
  connect(chalfwall9.therm1, VarTemp1.therm1) annotation (points=[55.2, 35.8;
        55.2, 8; 6, 8; 6, 168; -23, 168; -23, 189.2], style(color=4));
  connect(chalfwall9.therm3, Skytemp1.therm1) annotation (points=[64.2, 44.8;
        74, 44.8; 74, 64; 138, 64; 138, 157.6; 145.6, 157.6], style(color=0));
  connect(chalfwall8.therm3, Skytemp1.therm1) annotation (points=[-89, 36; -70,
         36; -70, 4; 144, 4; 144, 157.6; 145.6, 157.6], style(color=0));
  connect(global_3a1.oc_total_rad_v1, Room2.ic_total_rad_v1) annotation (points=[204,
        168.942; 174,168.942; 174,123.22; 93.4,123.22],         style(color=45));
  connect(global_3a1.oc_total_rad_v1, Room1.ic_total_rad_v1) annotation (points=[204,
        168.942; 174,168.942; 174,218; -208,218; -208,123.22; -141.4,123.22],
                 style(color=45));
  connect(global_3a1.oc_weather_data_table1, VarTemp1.InPort) annotation (
      points=[206.052,139.334; 182,139.334; 182,200; -11.3,200],     style(
        color=0));
  connect(Skytemp1.Tdb1, global_3a1.oc_weather_data_table1) annotation (points=[167,
        164.1; 196,164.1; 196,139.334; 206.052,139.334],          style(color=3));
  connect(PIRoom2.Out, Valve2W2.InPort1) annotation (points=[54.2,-48.2;
        66.3475,-48.6],  style(color=0, thickness=4));
  connect(Skytemp1.ic_diff_rad1, global_3a1.oc_diff_rad_horiz) annotation (
      points=[167.4,152; 185.758,152; 185.758,150.873; 204.115,150.873],
      style(color=45));
  connect(Skytemp1.ic_beam_rad1, global_3a1.oc_beam_rad_horiz) annotation (
      points=[167.5,158.4; 176.683,158.4; 176.683,160.347; 185.865,160.347;
        185.865,159.947; 204.115,159.947],    style(color=45));
  connect(losspipe_long1.Out, BypassRad1.In) annotation (points=[-166.81, -100.48;
         -93.14, -100.56], style(color=1, thickness=4));
  connect(ExampleFuzzy1.OutPort1, Feedback1.inPort1) annotation (points=[75.2,
        -205.4; 23.6, -205.4; 23.6, -176; -28, -176], style(color=0, thickness=
          2));
  connect(pump_controlled1.OUT, losspipe_long1.In) annotation (points=[-210,
        -121.529; -210,-100.48; -203.02,-100.48],
                                           style(color=1, thickness=4));
  connect(BypassRad2.In, radiator1.OUT) annotation (points=[-5.94,-119.76;
        -5.94,-108.47; -4.58,-108.47; -4.58,-97.18; -4.64,-97.18; -4.64,-74.3],
      style(color=73, thickness=4));
  connect(radiator2.OUT, TMixer2.IN1)
    annotation (points=[141.36, -72.3; 190.7, -72.65], style(thickness=4));
  connect(BypassRad2.Out, TMixer2.IN2) annotation (points=[34.53,-119.76; 190.7,
        -119.76; 190.7,-93.35],         style(color=73, thickness=4));
  connect(TMixer2.OUT, losspipe_long3.In) annotation (points=[217.3, -83; 232,
        -83; 232, -161.52; 128.94, -161.52], style(color=73, thickness=4));
  connect(losspipe_long3.Out, BoilerFF1.IN) annotation (points=[24.57, -161.52;
         -94.92, -161.11], style(color=73, thickness=4));
  connect(PIRoom1.Out, Valve2W1.InPort1) annotation (points=[-95,-49; -91.1762,
        -49; -91.1762,-48.4; -87.3525,-48.4; -87.3525,-49.4; -78.8525,-49.4],
       style(color=0, thickness=4));
  connect(TempSensorRoom1.OutPortCelsius, PIRoom1.Act) annotation (points=[-195.333,
        84.7031; -195.333,-28; -178,-28; -178,-43; -113,-43],      style(color=
          0));
  connect(Valve2W2.OUT, radiator2.IN) annotation (points=[92.6645,-60.4;
        97.0782,-60.4; 97.0782,-59.82; 101.492,-59.82; 101.492,-59.42; 110.16,
        -59.42],         style(color=1, thickness=4));
  connect(TempSensorRoom2.OutPortCelsius, PIRoom2.Act) annotation (points=[198.667,
        80.7031; 198.667,-30; 22,-30; 22,-42.2; 36.2,-42.2],              style(
        color=0));
  connect(chalfwall3.therm2, Room2.therm1) annotation (points=[107.4, 135.6;
        102.11, 135.6; 102.11, 135.04; 96.82, 135.04; 96.82, 135.44; 85.12,
        135.44], style(color=0));
  connect(RelayBoiler.Out, BoilerFF1.InPort1) annotation (points=[-75, -175; -80.4,
         -175; -80.4, -174.5; -85.8, -174.5; -85.8, -173.5; -96.3, -173.5],
      style(color=0, thickness=2));
  connect(Feedback1.outPort, RelayBoiler.In) annotation (points=[-45, -176; -51,
         -176; -51, -175; -57, -175], style(color=0, thickness=2));
  connect(BoilerFF1.OutPort1, Feedback1.inPort2) annotation (points=[-137.7, -174.34;
         -168, -174.34; -168, -192; -36, -192; -36, -184], style(color=0,
        thickness=2));
  connect(TFeedwater.ThermoFlow2, BoilerFF1.IN) annotation (points=[-97.4,
        -221.1; -97.4,-205.88; -96.32,-205.88; -96.32,-190.66; -94.92,-190.66;
        -94.92,-161.11],
                   style(color=73));
  connect(FixedTempBoiler.therm1, BoilerFF1.therm1)
    annotation (points=[-117, -133.5; -115.85, -139.9]);
  connect(TFeedwater.OutPort2, ExampleFuzzy1.Tcooledwater) annotation (points=[-87.9,
        -229.3; 112,-229.3; 112,-203.6; 92.8,-203.6]);
  connect(TCooledWater.OutPort2, ExampleFuzzy1.Tfeedwater) annotation (points=[
        -129.1, -220.1; 136, -220; 136, -195.6; 92.8, -195.6], style(color=1));
  connect(ExampleFuzzy1.Toutside, global_3a1.oc_weather_data_table1)
    annotation (points=[92.8,-212; 240,-212; 240,122; 206.052,122; 206.052,
        139.334],  style(color=0));
  connect(TCooledWater.ThermoFlow2, BoilerFF1.OUT) annotation (points=[-138.6,
        -211.9; -138.6, -198.98; -139.68, -198.98; -139.68, -186.06; -139.08, -186.06;
         -139.08, -161.11], style(color=1));
  connect(radiator2.therm1, Room2.therm7) annotation (points=[118.8, -52.7;
        118.8, 111; 98, 111], style(color=1, thickness=2));
  connect(SetPoint_Room1.outPort, PIRoom1.In) annotation (points=[-194.9,-50;
        -154,-50; -154,-49; -113,-49], style(color=3, rgbcolor={0,0,255}));
  connect(SetPoint_Room2.outPort, PIRoom2.In) annotation (points=[212.9,-48;
        124,-48; 124,-48.2; 36.2,-48.2], style(color=3, rgbcolor={0,0,255}));
end Example2RoomsII;
