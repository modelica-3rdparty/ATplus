class Example2RoomsI
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
    annotation (extent=[-144, 64; -52, 158]);
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
    T0_iso=16) annotation (extent=[-138, -118; -104, -92]);
  ATplus.Hvac.Heating.Advanced.pump_controlled pump_controlled1(p=1000)
    annotation (extent=[-194, -180; -150, -142]);
  ATplus.Hvac.Heating.Advanced.BoilerFF BoilerFF1(P=10000)
    annotation (extent=[-102, -230; -148, -188]);
  ATplus.Hvac.Heating.Advanced.Base.radiator radiator1(T0=16, surface=10)
    annotation (extent=[-36, -82; -4, -54]);
  ATplus.Hvac.Heating.Advanced.Base.radiator radiator2(T0=16, surface=10)
    annotation (extent=[110, -80; 142, -52]);
  ATplus.Hvac.Heating.Advanced.losspipe_long losspipe_long3(
    l=20,
    n=3,
    T0_water=16,
    T0_wall=16,
    T0_iso=16) annotation (extent=[62, -220; -36, -196]);
  ATplus.Hvac.Heating.Advanced.losspipe_long BypassRad1(
    n=2,
    T0_water=16,
    T0_wall=16,
    T0_iso=16,
    l=5) annotation (extent=[-64, -116; -26, -94]);
  ATplus.Hvac.Heating.Advanced.losspipe_long BypassRad2(
    n=2,
    T0_water=16,
    T0_wall=16,
    T0_iso=16,
    l=5) annotation (extent=[-2, -164; 20, -152]);
  ATplus.Hvac.Heating.Advanced.Base.TMixer TMixer2
    annotation (extent=[164, -144; 176, -126], rotation=0);
  ATplus.Building.Sources.FixedTemp FixedTempBoiler(Ts=0)
    annotation (extent=[-138, -156; -112, -178]);
  ATplus.Building.TempSensor TempSensorRoom1
    annotation (extent=[-200, 84; -176, 114]);
  ATplus.Building.TempSensor TempSensorRoom2
    annotation (extent=[194, 80; 218, 110]);
  ATplus.Controller.Conventional.Continuous.RelayInv RelayBoiler(jp1=80, jp2=90)
    annotation (extent=[-174, -236; -200, -208]);
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
  Hvac.Heating.Advanced.Base.pipe_elem Bypass(
    L=1,
    T0=16,
    D=0.001) annotation (extent=[-98, -146; -78, -126]);
  ATplus.Hvac.Heating.Advanced.Base.TMixer TMixer1
    annotation (extent=[-74.8, -215.2; -62.8, -197.2], rotation=180);
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
  Controller.Conventional.Continuous.Cont_PI Cont_PI1(
    Kp=0.1,
    Ki=0.001,
    umin=0) annotation (extent=[-158, -40; -138, -60]);
  Controller.Conventional.Continuous.Cont_PI Cont_PI2(
    Kp=0.1,
    Ki=0.001,
    umin=0) annotation (extent=[201.2, -37.2; 181.2, -57.2]);
  Modelica.Blocks.Sources.Constant Constant1(k={22})
    annotation (extent=[222, -58; 242, -38], rotation=180);
  Modelica.Blocks.Sources.Constant Constant2(k={20})
    annotation (extent=[-218.8, -61.2; -198.8, -41.2], rotation=0);
equation
  connect(layer1.therm1, Room1.therm3)
    annotation (points=[-33,134; -48.94,134; -48.94,135.44; -64.88,135.44],
                                                style(color=4));
  connect(layer1.therm2, Room2.therm3)
    annotation (points=[-15,134; 1.94,134; 1.94,135.44; 18.88,135.44],
                                            style(color=4));
  connect(layer2.therm2, Room2.therm6) annotation (points=[86,49; 86,67.78; 86,
        86.56; 85.12,86.56]);
  connect(layer3.therm2, Room1.therm6) annotation (points=[-132,49; -132,67.78;
        -132,86.56; -131.12,86.56]);
  connect(HeatFlow_Airexchange1.OutPort1, Room2.ic_air_change)
    annotation (points=[-8.08,41.29; 31.76,41.29; 31.76,74.246]);
  connect(Room2.ic_heat_gain, HeatFlow_Airexchange1.OutPort2)
    annotation (points=[37.28,74.34; 37.28,28.71; -8.08,28.71]);
  connect(HeatFlow_Airexchange1.OutPort1, Room1.ic_heat_gain)
    annotation (points=[-8.08,41.29; -2,41.29; -2,60; -83.28,60; -83.28,74.34]);
  connect(HeatFlow_Airexchange1.OutPort2, Room1.ic_air_change)
    annotation (points=[-8.08,28.71; 4,28.71; 4,64; -77.76,64; -77.76,74.246]);
  connect(FixedTemp2.therm1, layer2.therm1)
    annotation (points=[-22,-7; 86,-7; 86,31],    style(color=65));
  connect(pump_controlled1.IN, BoilerFF1.OUT) annotation (points=[-171.132,
        -172.671; -171.132,-207.11; -147.08,-207.11],
                                      style(thickness=2));
  connect(pump_controlled1.OUT, losspipe_long1.In) annotation (points=[-172,
        -145.529; -172,-104.48; -139.02,-104.48],
                                     style(thickness=2));
  connect(layer3.therm1, FixedTemp2.therm1)
    annotation (points=[-132,31; -132,-7; -22,-7],    style(color=65));
  connect(FixedTempBoiler.therm1, BoilerFF1.therm1)
    annotation (points=[-125,-176.9; -125,-179.15; -124.85,-179.15; -124.85,
        -181.4; -123.85,-181.4; -123.85,-185.9]);
  connect(radiator1.therm1, Room1.therm7) annotation (points=[-27.2,-54.7;
        -27.2,-36; -170,-36; -170,111; -144,111],
                                               style(color=41));
  connect(radiator2.therm1, Room2.therm7)
    annotation (points=[118.8,-52.7; 118,108; 98,111],     style(color=41));
  connect(TempSensorRoom1.therm1, Room1.therm7)
    annotation (points=[-187.467,106.734; -187.467,111; -144,111],
                                                              style(color=10));
  connect(Room2.therm7, TempSensorRoom2.therm1)
    annotation (points=[98,111; 206.533,111; 206.533,102.734],
                                                       style(color=10));
  connect(BoilerFF1.OutPort1, RelayBoiler.In)
    annotation (points=[-145.7,-220.34; -153.1,-220.34; -153.1,-218.94; -160.5,
        -218.94; -160.5,-220.6; -175.3,-220.6],    style(color=10));
  connect(RelayBoiler.Out, BoilerFF1.InPort1) annotation (points=[-198.7,-220.6;
        -212,-220.6; -212,-244; -90,-244; -90,-219.5; -104.3,-219.5],
                                                              style(color=10));
  connect(radiator2.therm2, Room2.therm9)
    annotation (points=[133.36,-52.7; 133.36,72.46; 64.88,72.46]);
  connect(Room1.therm9, radiator1.therm2)
    annotation (points=[-110.88,72.46; -110.88,-30; -12.64,-30; -12.64,-54.7]);
  connect(Valve2W1.OUT, radiator1.IN) annotation (points=[-52.5355,-61.2;
        -48.3217,-61.2; -48.3217,-62.62; -44.1078,-62.62; -44.1078,-61.42;
        -35.84,-61.42],
      style(
      color=73,
      gradient=2,
      fillColor=69));
  connect(losspipe_long1.Out, Valve2W1.IN) annotation (points=[-102.81,-104.48;
        -102.81,-61.4667; -77.5519,-61.4667],
                         style(
      color=73,
      gradient=2,
      fillColor=69));
  connect(losspipe_long1.Out, BypassRad1.In) annotation (points=[-102.81,
        -104.48; -76.57,-104.48; -76.57,-104.56; -65.14,-104.56],
                                                  style(
      color=73,
      gradient=2,
      fillColor=69));
  connect(Valve2W2.OUT, radiator2.IN) annotation (points=[92.6645,-60.4;
        97.0782,-60.4; 97.0782,-59.82; 101.492,-59.82; 101.492,-59.42; 110.16,
        -59.42],
      style(
      color=73,
      gradient=2,
      fillColor=69));
  connect(radiator1.OUT, BypassRad2.In) annotation (points=[-4.64,-74.3; -4.64,
        -115.03; -2.66,-115.03; -2.66,-157.76],
                                          style(
      color=73,
      gradient=2,
      fillColor=69));
  connect(BypassRad2.Out, TMixer2.IN2) annotation (points=[20.77,-157.76;
        92.325,-157.76; 92.325,-139.05; 164.3,-139.05],     style(
      color=73,
      gradient=2,
      fillColor=69));
  connect(TMixer2.OUT, losspipe_long3.In) annotation (points=[175.7,-135; 194,
        -135; 194,-207.52; 64.94,-207.52],
                                        style(
      color=73,
      gradient=2,
      fillColor=69));
  connect(TMixer2.IN1, radiator2.OUT)
    annotation (points=[164.3,-130.95; 141.36,-130.95; 141.36,-72.3],
                                                         style(color=73));
  connect(BypassRad1.Out, Valve2W2.IN) annotation (points=[-24.67,-104.56; 60,
        -104.56; 60,-60.6667; 67.6481,-60.6667],
                            style(color=73));
  connect(chalfwall1.therm2, Room1.therm2)
    annotation (points=[-100,173; -100,161.27; -100,149.54; -98,149.54],
                                               style(color=4));
  connect(chalfwall1.therm1, VarTemp1.therm1) annotation (points=[-100,191;
        -100,202; -50,202; -50,180; -23,180; -23,189.2],
                                                       style(color=4));
  connect(chalfwall2.therm2, Room2.therm2)
    annotation (points=[55.2,167.8; 52,149.54],
                                             style(color=4));
  connect(chalfwall2.therm1, VarTemp1.therm1) annotation (points=[55.2,185.8;
        54,196; 6,196; 6,180; -23,180; -23,189.2],      style(color=4));
  connect(Skytemp1.therm1, chalfwall2.therm3) annotation (points=[145.6,157.6;
        94,157.6; 94,176.8; 64.2,176.8],
                                   style(color=0));
  connect(chalfwall1.therm3, Skytemp1.therm1) annotation (points=[-91,182; 42,
        182; 42,194; 108,194; 108,157.6; 145.6,157.6],style(color=0));
  connect(chalfwall3.therm2, Room2.therm1) annotation (points=[107.4,135.6; 96,
        135.6; 96,135.44; 85.12,135.44],
                                  style(color=0));
  connect(chalfwall3.therm3, Skytemp1.therm1)
    annotation (points=[116.4,144.6; 116.4,157.6; 145.6,157.6],
                                                           style(color=0));
  connect(chalfwall4.therm2, Room1.therm1)
    annotation (points=[-147.4,138.4; -138,138.4; -138,135.44; -131.12,135.44]);
  connect(chalfwall4.therm1, VarTemp1.therm1) annotation (points=[-165.4,138.4;
        -180,138.4; -180,210; -46,210; -46,170; -23,170; -23,189.2],
                                                                  style(color=4));
  connect(chalfwall3.therm1, VarTemp1.therm1) annotation (points=[125.4,135.6;
        132,135.6; 132,204; 0,204; 0,168; -23,168; -23,189.2],
                                                             style(color=4));
  connect(chalfwall4.therm3, Skytemp1.therm1)
    annotation (points=[-156.4,147.4; -156.4,157.6; 145.6,157.6],
                                                         style(color=0));
  connect(chalfwall6.therm2, Room2.therm4)
    annotation (points=[-0.2,87.2; 4.79,87.2; 4.79,85.76; 9.78,85.76; 9.78,
        86.56; 18.88,86.56],            style(color=4));
  connect(Room1.therm4, chalfwall5.therm2)
    annotation (points=[-64.88,86.56; -60.21,86.56; -60.21,85.76; -55.54,85.76;
        -55.54,87.2; -46.2,87.2],            style(color=4));
  connect(chalfwall5.therm1, VarTemp1.therm1)
    annotation (points=[-28.2,87.2; -23,87.2; -23,189.2],  style(color=4));
  connect(chalfwall6.therm1, VarTemp1.therm1)
    annotation (points=[-18.2,87.2; -23,87.2; -23,189.2],style(color=4));
  connect(chalfwall6.therm3, Skytemp1.therm1)
    annotation (points=[-9.2,96.2; -9.2,157.6; 145.6,157.6],
                                                      style(color=0));
  connect(chalfwall5.therm3, Skytemp1.therm1)
    annotation (points=[-37.2,96.2; -37.2,157.6; 145.6,157.6],
                                                        style(color=0));
  connect(chalfwall8.therm2, Room1.therm5)
    annotation (points=[-98,45; -98,72.46],style(color=4));
  connect(chalfwall8.therm1, VarTemp1.therm1) annotation (points=[-98,27; -98,
        12; -56,12; -56,172; -23,172; -23,189.2],    style(color=4));
  connect(Room2.therm5, chalfwall9.therm2)
    annotation (points=[52,72.46; 52,62.9; 55.2,62.9; 55.2,53.8],
                                                               style(color=4));
  connect(chalfwall9.therm1, VarTemp1.therm1) annotation (points=[55.2,35.8;
        55.2,8; 6,8; 6,168; -23,168; -23,189.2],    style(color=4));
  connect(chalfwall9.therm3, Skytemp1.therm1) annotation (points=[64.2,44.8; 74,
        44.8; 74,64; 138,64; 138,157.6; 145.6,157.6],  style(color=0));
  connect(chalfwall8.therm3, Skytemp1.therm1) annotation (points=[-89,36; -70,
        36; -70,4; 144,4; 144,157.6; 145.6,157.6],    style(color=0));
  connect(Bypass.IN, pump_controlled1.OUT) annotation (points=[-98.3,-136; -134,
        -136; -134,-145.529; -172,-145.529],
                                        style(color=73));
  connect(TMixer1.IN1, losspipe_long3.Out) annotation (points=[-63.1,-210.25;
        -51.265,-210.25; -51.265,-207.52; -39.43,-207.52],
                                                        style(color=73));
  connect(Bypass.OUT, TMixer1.IN2) annotation (points=[-77.7,-136; -77.7,
        -166.075; -63.1,-166.075; -63.1,-202.15],
                                           style(color=73));
  connect(TMixer1.OUT, BoilerFF1.IN)
    annotation (points=[-74.5,-206.2; -102.92,-207.11],
                                                    style(color=73));
  connect(global_3a1.oc_total_rad_v1, Room2.ic_total_rad_v1) annotation (points=[204,
        168.942; 174,168.942; 174,123.22; 93.4,123.22],
                                                style(color=45));
  connect(global_3a1.oc_total_rad_v1, Room1.ic_total_rad_v1) annotation (points=[204,
        168.942; 174,168.942; 174,218; -208,218; -208,123.22; -139.4,123.22],
                                                                        style(
        color=45));
  connect(global_3a1.oc_weather_data_table1, VarTemp1.InPort) annotation (
      points=[206.052,139.334; 182,139.334; 182,200; -11.3,200],
                                                       style(color=3));
  connect(Skytemp1.Tdb1, global_3a1.oc_weather_data_table1) annotation (points=[167,
        164.1; 196,164.1; 196,139.334; 206.052,139.334],
                                                  style(color=3));
  connect(Cont_PI1.Out, Valve2W1.InPort1)
    annotation (points=[-139,-51; -123.676,-51; -123.676,-50.4; -108.352,-50.4;
        -108.352,-49.4; -78.8525,-49.4],      style(color=3));
  connect(Cont_PI1.Act, TempSensorRoom1.OutPortCelsius)
    annotation (points=[-157,-45; -195.333,-45; -195.333,84.7031],
                                                         style(color=3));
  connect(Cont_PI2.Out, Valve2W2.InPort1)
    annotation (points=[182.2,-48.2; 66.3475,-48.6], style(color=3));
  connect(Cont_PI2.Act, TempSensorRoom2.OutPortCelsius)
    annotation (points=[200.2,-42.2; 200,-44; 198.667,80.7031],style(color=3));
  connect(Constant1.outPort, Cont_PI2.In)
    annotation (points=[221, -48; 200.2, -48.2], style(color=3));
  connect(Constant2.outPort, Cont_PI1.In)
    annotation (points=[-197.8,-51.2; -187.35,-51.2; -187.35,-50.2; -176.9,
        -50.2; -176.9,-51; -157,-51],          style(color=3));
  connect(Skytemp1.ic_diff_rad1, global_3a1.oc_diff_rad_horiz)
    annotation (points=[167.4,152; 185.758,152; 185.758,150.873; 204.115,
        150.873],                            style(color=45));
  connect(Skytemp1.ic_beam_rad1, global_3a1.oc_beam_rad_horiz)
    annotation (points=[167.5,158.4; 176.683,158.4; 176.683,160.347; 185.865,
        160.347; 185.865,159.947; 204.115,159.947],
                                             style(color=45));
end Example2RoomsI;
