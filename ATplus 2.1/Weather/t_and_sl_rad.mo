package t_and_sl_rad
  extends Icons.Package;
  extends icons.logos.logo_icon_1;
  constant Integer n_of_surf_orient_def=TOOLS.surf_orient.surf_orient_alias_def.
       n_of_surf_orient_def;
  constant String none="NoName";
  constant Real conv_deg_to_rad=Constants.pi/180;
  constant Real conv_rad_to_deg=180/Constants.pi;
  constant Integer true_boolean_disp=100;
  constant Integer false_boolean_disp=0;
  annotation (
    Coordsys(
      extent=[0, 0; 1017, 724],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.05,
      y=0.04,
      width=0.52,
      height=0.56,
      library=1),
    Icon);
  import Modelica.SIunits;
  import Modelica.Constants;
  package SOLAR
    extends icons.universals.icon_folder;
    annotation (Coordsys(
        extent=[0, 0; 442, 394],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.68,
        y=0,
        width=0.32,
        height=0.56,
        library=1,
        autolayout=1));
    class declination "Earth declination calculator"
      extends icons.specifics.icon_declination;

      SIunits.Angle slt_d_angle_r;

      CUTS.OutPort oc_declination1
        annotation (extent=[222, 172; 258, 212], layer="icon");
      annotation (Coordsys(
          extent=[-99, -14; 260, 316],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.03,
          y=0.01,
          width=0.77,
          height=0.64));
      CUTS.ic_t_point ic_slt_point1 annotation (extent=[-98, 274; -58, 314]);
    equation
      slt_d_angle_r = 2.0*Constants.pi*(ic_slt_point1.d_of_y + ic_slt_point1.
        h_of_d/24 - 1)/365.0;
      oc_declination1.signal[1] = ((0.322003 - 22.984*cos(slt_d_angle_r) -
        0.357898*cos(2*slt_d_angle_r) - 0.14398*cos(3*slt_d_angle_r) + 3.94638*
        sin(slt_d_angle_r) + 0.019334*sin(2*slt_d_angle_r) + 0.05928*sin(3*
        slt_d_angle_r)))*conv_deg_to_rad;
    end declination;

    class position_of_sun "Position of sun calculator"
      extends icons.specifics.icon_position_of_sun;
      parameter Real uf_given_latitude=49.45
        "Latitude angle if not entered via connector (-90°...90°)";
      Real cos_zenith;
      Real zenith;
      Real azimuth;
      Real test_arg_of_acos;

      Real azimuth_without_rectif;
      SIunits.Angle slt_angle=(12 - ic_slt_point1.h_of_d)*2*Constants.pi/24;

      CUTS.InPort ic_declination
        annotation (extent=[-86, 35; -66, 55], layer="icon");
      CUTS.oc_position_of_sun oc_position_of_sun1
        annotation (extent=[58, 32; 82, 58]);
      CUTS.InPort ic_latitude annotation (extent=[-86, -2; -66, 18]);
      annotation (Coordsys(
          extent=[-85, -90; 75, 88],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.33,
          y=0.25,
          width=0.67,
          height=0.69));
      CUTS.ic_t_point ic_slt_point1 annotation (extent=[-86, -40; -65, -17]);
    equation
      if cardinality(ic_latitude) == 0 then
        ic_latitude.signal = {uf_given_latitude*conv_deg_to_rad};
      end if;
      cos_zenith = cos(ic_latitude.signal[1])*cos(ic_declination.signal[1])*cos(
        slt_angle) + sin(ic_latitude.signal[1])*sin(ic_declination.signal[1]);
      zenith = Modelica.Math.acos(cos_zenith);

      if abs(ic_latitude.signal[1]) < (Constants.pi/2 - 10*Constants.EPS) then

        azimuth_without_rectif = if (cos_zenith*sin(ic_latitude.signal[1]) -
          sin(ic_declination.signal[1]))/(sin(zenith)*cos(ic_latitude.signal[1]))
           > 0.99 then 0 else if (cos_zenith*sin(ic_latitude.signal[1]) - sin(
          ic_declination.signal[1]))/(sin(zenith)*cos(ic_latitude.signal[1]))
           < -0.99 then Constants.pi else arccos((cos_zenith*sin(ic_latitude.
          signal[1]) - sin(ic_declination.signal[1]))/(sin(zenith)*cos(
          ic_latitude.signal[1])));

        azimuth = if slt_angle < 0 then -azimuth_without_rectif else
          azimuth_without_rectif;

      else
        if ic_latitude.signal[1] > 0 then
          azimuth_without_rectif = slt_angle;
          azimuth = azimuth_without_rectif;
        else
          azimuth_without_rectif = sign(slt_angle)*Constants.pi - slt_angle;
          azimuth = azimuth_without_rectif;
        end if;
      end if;
      test_arg_of_acos = ((cos_zenith*sin(ic_latitude.signal[1]) - sin(
        ic_declination.signal[1]))/(sin(zenith)*cos(ic_latitude.signal[1])));
      oc_position_of_sun1.sin_zenith = sin(zenith);
      oc_position_of_sun1.cos_zenith = cos_zenith;
      oc_position_of_sun1.sin_azimuth = cos(ic_declination.signal[1])*sin(
        slt_angle)/sin(zenith);
      oc_position_of_sun1.cos_azimuth = (cos_zenith*sin(ic_latitude.signal[1])
         - sin(ic_declination.signal[1]))/(sin(zenith)*cos(ic_latitude.signal[1]));

      oc_position_of_sun1.shadow = (cos_zenith <= 0);
      if initial() and cardinality(ic_latitude) == 0 then
        assert(uf_given_latitude <= 90,
          "Error in class 'position_of_sun': given latitude is greater than 90°.");
        assert(uf_given_latitude >= -90,
          "Error in class 'position_of_sun': given latitude is less than -90°.");
      end if;
    end position_of_sun;

    class sunrise_and_sunset_t_reg "Sunrise and sunset times register"
      extends icons.specifics.icon_sunrise_and_sunset;
      parameter Real elevation=0
        "Elevation above surrounding geographical elements (m)";
      parameter Boolean apparent_sunrise_and_sunset=false
        "Apparent sunrise an sunset (depending on geometry and refraction)?";
      Real last_sunrise_h_of_d;
      Real last_sunset_h_of_d;
      Boolean sunrise;
      Boolean sunset;
      Real last_dlength;
      Real dlength_last_d(start=0);
      Real dlength_last_w(start=0);
      Real dlength_last_m_of_y(start=0);
      Real dlength_last_y(start=0);
      Real dlength_acc_this_w(start=0);
      Real dlength_acc_this_m_of_y(start=0);
      Real dlength_acc_this_y(start=0);
      Integer d_of_w;
      Integer d_of_m;
      Integer m_of_y;
      discrete Real max_zenith_deg;
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[0.5, 0.5],
          component=[20, 20]), Window(
          x=0.25,
          y=0.08,
          width=0.62,
          height=0.82));
      CUTS.ic_position_of_sun ic_position_of_sun1
        annotation (extent=[-134, 6.5; -100, 44.5], layer="icon");
      CUTS.ic_t_point ic_t_point1
        annotation (extent=[-136, -80; -100, -44.5], layer="icon");
      CUTS.OutPort OutPort1(n=4) annotation (extent=[100, -76; 125, -47.5]);
    equation
      sunrise = arccos(ic_position_of_sun1.cos_zenith)*conv_rad_to_deg <= 90 +
        (if apparent_sunrise_and_sunset then (0.8333 + 0.0347*sqrt(elevation)) else
              0);
      sunset = arccos(ic_position_of_sun1.cos_zenith)*conv_rad_to_deg >= 90 + (
        if apparent_sunrise_and_sunset then (0.8333 + 0.0347*sqrt(elevation)) else
              0);
      OutPort1.signal[1] = dlength_last_d;
      OutPort1.signal[2] = dlength_last_w;
      OutPort1.signal[3] = dlength_last_m_of_y;
      OutPort1.signal[4] = dlength_last_y;

    algorithm
      when ic_t_point1.h_of_d >= 12 then
        if ic_t_point1.h_of_d > 11 and ic_t_point1.h_of_d < 13 then
          max_zenith_deg := arccos(ic_position_of_sun1.cos_zenith)*
            conv_rad_to_deg;
        end if;
      end when;
      when edge(sunrise) then
        last_sunrise_h_of_d := ic_t_point1.h_of_d;
      end when;
      when edge(sunset) then
        last_sunset_h_of_d := ic_t_point1.h_of_d;
        last_dlength := last_sunset_h_of_d - last_sunrise_h_of_d;
      end when;
      when ic_t_point1.d_of_y <> pre(ic_t_point1.d_of_y) then
        (d_of_w,d_of_m,m_of_y) := TIME.f_of_date.inc_sdate(d_of_w, d_of_m,
          m_of_y, ic_t_point1.y);
        dlength_acc_this_w := dlength_acc_this_w + last_dlength;
        dlength_acc_this_m_of_y := dlength_acc_this_m_of_y + last_dlength;
        dlength_acc_this_y := dlength_acc_this_y + last_dlength;
      end when;
      when d_of_w == 1 then
        dlength_last_w := dlength_acc_this_w;
        dlength_acc_this_w := 0;
      end when;
      when d_of_m <> pre(d_of_m) then
        dlength_last_d := last_dlength;
      end when;
      when m_of_y <> pre(m_of_y) then
        dlength_last_m_of_y := dlength_acc_this_m_of_y;
        dlength_acc_this_m_of_y := 0;
      end when;
      when ic_t_point1.y <> pre(ic_t_point1.y) then
        dlength_last_y := dlength_acc_this_y;
        dlength_acc_this_y := 0;
      end when;

      if initial() then
        //initialization
        d_of_w := TIME.f_of_date.d_of_w_from_jdate(ic_t_point1.d_of_y,
          ic_t_point1.y);
        d_of_m := TIME.f_of_date.d_of_m_from_jdate(ic_t_point1.d_of_y,
          ic_t_point1.y);
        m_of_y := TIME.f_of_date.m_of_y_from_jdate(ic_t_point1.d_of_y,
          ic_t_point1.y);
      end if;
      if initial() then
        assert(elevation >= 0,
          "Error in class 'sunrise_and_sunset_t_reg': elevation is negative.");
      end if;
    end sunrise_and_sunset_t_reg;

    class extraterr_rad_on_horiz "Extraterrestrial radiation calculator"

      extends icons.specifics.icon_extraterr_rad_on_horiz;
      parameter Real sl_const=1351 "Solar constant (SI units)";

      SIunits.Angle slt_d_angle_r;
      Real D "Square of orbital vector d/dm";

      CUTS.ic_position_of_sun ic_position_of_sun1
        annotation (extent=[-188, 2; -128, 68], layer="icon");
      CUTS.oc_beam_rad oc_extraterr_rad_on_horiz1
        annotation (extent=[156, -42; 212, 16], layer="icon");
      annotation (Coordsys(
          extent=[-186, -178; 188, 68],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.25,
          y=0.27,
          width=0.6,
          height=0.6));
      CUTS.ic_t_point ic_slt_point1
        annotation (extent=[-194, -92; -128, -32], layer="icon");
    equation
      when initial() then
        if cardinality(ic_slt_point1) == 0 then
          ic_slt_point1.d_of_y = 0;
          ic_slt_point1.y = 0;
        end if;
      end when;
      if cardinality(ic_slt_point1) == 0 then
        D = 1;
        slt_d_angle_r = 0;
        ic_slt_point1.h_of_d = 0;
      else
        D = 1.00011 + 0.034221*cos(slt_d_angle_r) + 0.00128*sin(slt_d_angle_r)
           + 0.000719*cos(2*slt_d_angle_r) + 0.000077*sin(2*slt_d_angle_r);
        slt_d_angle_r = 2.0*Constants.pi*(ic_slt_point1.d_of_y + ic_slt_point1.
          h_of_d/24 - 1)/365.0;
      end if;
      oc_extraterr_rad_on_horiz1.I = if not ic_position_of_sun1.shadow then
        sl_const*D*ic_position_of_sun1.cos_zenith else 0;

    end extraterr_rad_on_horiz;

    class atm_att "Atmospheric attenuation"
      extends icons.specifics.icon_atm_att;
      parameter Real kT=0.76
        "Clearness index if not entered via connector (0...1)";
      annotation (Coordsys(
          extent=[-119, -130; 118, 48],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.14,
          y=0.37,
          width=0.68,
          height=0.52));
      CUTS.ic_beam_rad ic_extraterr_rad_on_horiz1
        annotation (extent=[-138, 30; -100, 66]);
      CUTS.oc_total_rad oc_total_rad_on_horiz1
        annotation (extent=[102, -100; 132, -70]);
      CUTS.InPort ic_kT1 annotation (extent=[124, -40; 100, -16]);
    equation
      if cardinality(ic_kT1) == 0 or cardinality(ic_kT1) == 1 then
        ic_kT1.signal[1] = kT;
      end if;
      oc_total_rad_on_horiz1.I = ic_extraterr_rad_on_horiz1.I*ic_kT1.signal[1];
    end atm_att;

    class atm_att_2 "Atmospheric attenuation (reverse causality)"
      extends icons.specifics.icon_atm_att;
      annotation (
        Coordsys(
          extent=[-119, -122; 117, 48],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.1,
          y=0.09,
          width=0.77,
          height=0.63),
        Icon);
      CUTS.ic_beam_rad ic_extraterr_rad1
        annotation (extent=[-138, 30; -100, 66]);
      CUTS.OutPort oc_kT1(final n=1) annotation (extent=[102, -40; 128, -12]);
      CUTS.ic_total_rad ioc_total_rad1 annotation (extent=[134, -98; 104, -68]);
    equation
      oc_kT1.signal[1] = if ic_extraterr_rad1.I > 0 and ioc_total_rad1.I > 0 then
              min(ioc_total_rad1.I, ic_extraterr_rad1.I)/ic_extraterr_rad1.I else
              0;
    end atm_att_2;

    package rad_on_surf
      extends icons.universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 318, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1));
      package horiz
        extends icons.universals.icon_folder;
        annotation (Coordsys(
            extent=[0, 0; 442, 394],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.16,
            y=0.56,
            width=0.52,
            height=0.44,
            library=1,
            autolayout=1));
        class rad_on_horiz_on_clear_d
          "Radiation components on the horizontal on clear day"
          extends icons.specifics.icon_rad_on_horiz_on_clear_d;
          parameter Real c_n=0.9 "Clearness number (0...1)";
          parameter Real atm_extinction_coef=0.142
            "Atmospheric extinction coefficient";
          parameter Real sl_const=1351
            "Solar constant if extraterrestrial radiation not entered via connector (SI units)";
          parameter Real blurring_factor=2 "Blurring factor";

          Real Ibn "Normal beam radiation";
          annotation (
            Coordsys(
              extent=[-120, -100; 118, 36],
              grid=[2, 2],
              component=[20, 20]),
            Window(
              x=0.1,
              y=0.17,
              width=0.68,
              height=0.7),
            Icon);

          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-134, 16; -100, 56], layer="icon");
          CUTS.ic_beam_rad ic_extraterr_rad_on_horiz1
            annotation (extent=[-136, -24; -100, 14]);
          CUTS.oc_beam_rad oc_beam_rad_on_horiz1
            annotation (extent=[100, -40; 136, -8]);
          CUTS.oc_diff_rad oc_diff_rad1 annotation (extent=[100, -72; 132, -42]);
        equation
          if cardinality(ic_extraterr_rad_on_horiz1) == 0 then
            ic_extraterr_rad_on_horiz1.I = if ic_position_of_sun1.cos_zenith >
              0 then sl_const*ic_position_of_sun1.cos_zenith else 0;
          end if;
          Ibn = oc_beam_rad_on_horiz1.I/ic_position_of_sun1.cos_zenith;
          oc_beam_rad_on_horiz1.I = if noEvent(ic_position_of_sun1.cos_zenith
             > 0) then ic_extraterr_rad_on_horiz1.I*c_n/exp(blurring_factor*
            atm_extinction_coef/ic_position_of_sun1.cos_zenith) else 0;

          oc_diff_rad1.I = if noEvent(ic_position_of_sun1.cos_zenith > 0) then
            0.5*ic_extraterr_rad_on_horiz1.I*c_n*(1 - 1/exp(blurring_factor*
            atm_extinction_coef/ic_position_of_sun1.cos_zenith)) else 0;
        end rad_on_horiz_on_clear_d;

        class rad_on_horiz_1 "Radiation components on the horizontal (mode 1)"

          extends icons.specifics.icon_rad_on_horiz_1;
          parameter Real kT=0.76
            "Clearness index if not entered via connector (0...1)";

          Real kd "Diffuse fraction of the total horizontal radiation";
          Real kd_without_rectif;

          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-62, 32; -42, 52], layer="icon");
          CUTS.oc_diff_rad oc_diff_rad_on_horiz1
            annotation (extent=[53, -32; 69, -15], layer="icon");
          CUTS.oc_beam_rad oc_beam_rad_on_horiz1
            annotation (extent=[53, -13; 70, 5], layer="icon");
          annotation (Coordsys(
              extent=[-52, -56; 71, 52],
              grid=[1, 1],
              component=[20, 20]), Window(
              x=0.18,
              y=0.26,
              width=0.6,
              height=0.6));
          CUTS.ic_total_rad ic_total_rad_on_horiz1
            annotation (extent=[-64, -30; -44, -10], layer="icon");
          CUTS.InPort ic_kT1(final n=1)
            annotation (extent=[-61, 2; -45, 19], layer="icon");
        equation
          if cardinality(ic_kT1) == 0 then
            ic_kT1.signal = {kT};
          end if;

          if (0 <= ic_kT1.signal[1] and ic_kT1.signal[1] <= 0.3) then
            kd_without_rectif = 1.020 - 0.254*ic_kT1.signal[1] + 0.0123*
              ic_position_of_sun1.cos_zenith;
            kd = if kd_without_rectif > 1.0 then 1.0 else kd_without_rectif;
          elseif (0.3 < ic_kT1.signal[1] and ic_kT1.signal[1] <= 0.78) then
            kd_without_rectif = 1.400 - 1.749*ic_kT1.signal[1] + 0.177*
              ic_position_of_sun1.cos_zenith;
            kd = if kd_without_rectif < 0.1 then 0.1 else if kd_without_rectif
               > 0.97 then 0.97 else kd_without_rectif;
          elseif (0.78 < ic_kT1.signal[1] and ic_kT1.signal[1] <= 1) then
            kd_without_rectif = 0.486*kT - 0.182*ic_position_of_sun1.cos_zenith;
            kd = if kd_without_rectif < 0.1 then 0.1 else kd_without_rectif;
          elseif ic_kT1.signal[1] < 0 then
            kd_without_rectif = 0;
            kd = 0;
            terminate(
              "Error in class 'rad_on_horiz_1': kT has a negative value.");
          else
            kd_without_rectif = 0;
            kd = 0;
            terminate(
              "Error in class 'rad_on_horiz_1': kT is greater than one.");
          end if;

          oc_diff_rad_on_horiz1.I = kd*ic_total_rad_on_horiz1.I;

          ic_total_rad_on_horiz1.I = oc_beam_rad_on_horiz1.I +
            oc_diff_rad_on_horiz1.I;
        end rad_on_horiz_1;

        class rad_on_horiz_2 "Radiation components on the horizontal (mode 2)"

          extends icons.specifics.icon_rad_on_horiz_2;

          Real kd "Diffuse fraction of the total horizontal radiation";
          Real kd_without_rectif;

          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-62, 32; -42, 52], layer="icon");
          CUTS.oc_diff_rad oc_diff_rad1
            annotation (extent=[53, -32; 69, -15], layer="icon");
          CUTS.oc_beam_rad oc_beam_rad1
            annotation (extent=[53, -13; 70, 5], layer="icon");
          annotation (Coordsys(
              extent=[-52, -56; 71, 52],
              grid=[1, 1],
              component=[20, 20]), Window(
              x=0.38,
              y=0.27,
              width=0.6,
              height=0.6));
          CUTS.ic_total_rad ic_total_rad1
            annotation (extent=[-63, -32; -43, -12], layer="icon");
          CUTS.InPort ic_kT(final n=1)
            annotation (extent=[-61, 2; -45, 19], layer="icon");
          CUTS.InPort ic_T_and_rh(n=2)
            annotation (extent=[-61, -56; -45, -39], layer="icon");
        equation
          if (0 <= ic_kT.signal[1] and ic_kT.signal[1] <= 0.3) then
            kd_without_rectif = 1.000 - 0.232*ic_kT.signal[1] + 0.0239*
              ic_position_of_sun1.cos_zenith - 0.000682*ic_T_and_rh.signal[1]
               + 0.0195*ic_T_and_rh.signal[2]/100;
            kd = if kd_without_rectif > 1.0 then 1.0 else kd_without_rectif;
          elseif (0.3 < ic_kT.signal[1] and ic_kT.signal[1] < 0.78) then
            kd_without_rectif = 1.329 - 1.716*ic_kT.signal[1] + 0.267*
              ic_position_of_sun1.cos_zenith - 0.00357*ic_T_and_rh.signal[1] +
              0.106*ic_T_and_rh.signal[2]/100;
            kd = if kd_without_rectif < 0.1 then 0.1 else if kd_without_rectif
               > 0.97 then 0.97 else kd_without_rectif;
          elseif (0.78 < ic_kT.signal[1]) then
            kd_without_rectif = 0.426*ic_kT.signal[1] - 0.256*
              ic_position_of_sun1.cos_zenith + 0.00349*ic_T_and_rh.signal[1] +
              0.0734*ic_T_and_rh.signal[2]/100;
            kd = if kd_without_rectif < 0.1 then 0.1 else kd_without_rectif;
          else
            kd_without_rectif = 0;
            kd = 0;
            terminate(
              "Error in class 'rad_on_horiz_2': kT has a negative value.");
          end if;

          oc_diff_rad1.I = kd*ic_total_rad1.I;

          ic_total_rad1.I = oc_beam_rad1.I + oc_diff_rad1.I;
        end rad_on_horiz_2;
      end horiz;

      package tilted
        extends icons.universals.icon_folder;
        annotation (Coordsys(
            extent=[0, 0; 523, 292],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.16,
            y=0.56,
            width=0.52,
            height=0.44,
            library=1,
            autolayout=1));
        class rad_on_tilted_surf
          "Radiation components on a tilted surface (modes 1, 2 and 3)"

          extends icons.specifics.icon_rad_on_tilted_surf;
          parameter Real uf_surf_slope=90
            "Slope of the surface if not entered via connector (0°...180°)";
          parameter Real uf_surf_azimuth=0
            "Azimuth angle of the surface if not entered via connector (-180°...180°)";
          parameter Integer mode=1
            "Tilted surface radiation mode (see user manual) (1,2 or 3)";
          parameter Real rho_ground=0.2
            "Ground reflectance in the front area of the surface (0...1)";
          Real IbT "Beam radiation on tilted surface";
          Real IdT "Diffuse radiation on tilted surface";
          Real IgT "Ground reflected radiation on tilted surface";
          SIunits.Angle incidence_angle
            "Angle of incidence of beam radiation on surface";
          Boolean out_of_incidence "Is the sun behind the tilted surface?";

          parameter SIunits.Angle surf_slope=uf_surf_slope*conv_deg_to_rad;
          parameter SIunits.Angle surf_azimuth=uf_surf_azimuth*conv_deg_to_rad;
          Real Rb
            "Ratio of beam radiation on tilted surface to beam on horizontal";
          Real Rd
            "Ratio of diffuse radiation on tilted surface to beam on horizontal";
          Real Rr
            "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
          Real AI
            "Hay and Davies anisotropy index defining a portion of the diffuse radiaton to be treated as circumsolar";
          Real f
            "Reindl's modulating factor for the isotropic diffuse term to take the horizon brightening into account";

          CUTS.ic_diff_rad ic_diff_rad_on_horiz
            annotation (extent=[-57, -38; -43, -25], layer="icon");
          CUTS.oc_total_rad oc_total_rad1 annotation (extent=[47, -26; 67, -6]);
          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-57, 30; -43, 43], layer="icon");
          CUTS.ic_beam_rad ic_beam_rad_on_horiz
            annotation (extent=[-57, -23; -43, -10], layer="icon");
          CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
            annotation (extent=[-57, 13; -43, 27], layer="icon");
          annotation (Coordsys(
              extent=[-50, -55; 72, 60],
              grid=[1, 1],
              component=[20, 20]), Window(
              x=0.36,
              y=0.04,
              width=0.6,
              height=0.77));
          CUTS.InPort ic_surface_s_and_a(n=2)
            annotation (extent=[66, 14; 56, 24], layer="icon");
        equation
          if cardinality(ic_surface_s_and_a) == 0 then
            ic_surface_s_and_a.signal = {surf_slope,surf_azimuth};
          end if;
          if mode == 1 then
            AI = 0;
            f = 0;
          else
            if mode == 2 or mode == 3 then
              AI = if not ic_position_of_sun1.shadow then ic_beam_rad_on_horiz.
                I/ic_extraterr_rad_on_horiz.I else 0;
              if mode == 2 then
                f = 0;
              else
                f = if not ic_position_of_sun1.shadow and noEvent(
                  ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I > 0) then
                  sqrt(ic_beam_rad_on_horiz.I/(ic_beam_rad_on_horiz.I +
                  ic_diff_rad_on_horiz.I)) else 0;
              end if;
            end if;
          end if;

          incidence_angle = arccos(ic_position_of_sun1.cos_zenith*cos(
            ic_surface_s_and_a.signal[1]) + ic_position_of_sun1.sin_zenith*(
            ic_position_of_sun1.sin_azimuth*sin(ic_surface_s_and_a.signal[2])
             + ic_position_of_sun1.cos_azimuth*cos(ic_surface_s_and_a.signal[2]))
            *sin(ic_surface_s_and_a.signal[1]));
          out_of_incidence = incidence_angle > 90*conv_deg_to_rad;

          Rb = if not ic_position_of_sun1.shadow and not out_of_incidence then
            cos(incidence_angle)/ic_position_of_sun1.cos_zenith else 0;
          IbT = Rb*ic_beam_rad_on_horiz.I;

          Rr = 0.5*(1 - cos(ic_surface_s_and_a.signal[1]))*rho_ground;
          IgT = Rr*(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);

          Rd = 0.5*(1 - AI)*(1 + cos(ic_surface_s_and_a.signal[1]))*(1 + f*(sin(
            ic_surface_s_and_a.signal[1]/2)^3)) + AI*Rb;
          IdT = Rd*ic_diff_rad_on_horiz.I;

          oc_total_rad1.I = IbT + IdT + IgT;

          if initial() then
            assert(uf_surf_slope <= 180,
              "Error in class 'rad_on_tilted_surf': parameter surface slope angle greater than 180°.");
            assert(uf_surf_slope >= 0,
              "Error in class 'rad_on_tilted_surf': negative parameter surface slope angle.");
            assert(uf_surf_azimuth <= 180,
              "Error in class 'rad_on_tilted_surf': parameter surface azimuth angle greater than 180°.");
            assert(uf_surf_azimuth >= -180,
              "Error in class 'rad_on_tilted_surf': parameter surface azimuth angle less than -180°.");
            assert(rho_ground <= 1,
              "Error in class 'rad_on_tilted_surf': ground reflectance greater than 1.");
            assert(rho_ground >= 0,
              "Error in class 'rad_on_tilted_surf': negative ground reflectance.");
          end if;
        end rad_on_tilted_surf;

        class rad_on_tilted_surf_mode_4
          "Radiation components on a tilted surface (mode 4)"
          extends icons.specifics.icon_rad_on_tilted_surf_mode_4;
          parameter Real uf_surf_slope=90
            "Slope of the surface if not entered via connector (0°...180°)";
          parameter Real uf_surf_azimuth=0
            "Azimuth angle of the surface if not entered via connector (-180°...180°)";
          parameter Real rho_ground=0.2
            "Ground reflectance in the front area of the surface";
          Real IbT "Bbeam radiation on tilted surface";
          Real IdT "Diffuse radiation on tilted surface";
          Real IgT "Ground reflected radiation on tilted surface";
          SIunits.Angle incidence_angle
            "Angle of incidence of beam radiation on surface";
          Boolean out_of_incidence "Is the sun behind the tilted surface?";

          parameter SIunits.Angle surf_slope=uf_surf_slope*conv_deg_to_rad;
          parameter SIunits.Angle surf_azimuth=uf_surf_azimuth*conv_deg_to_rad;
          Real Rb
            "Ratio of beam radiation on tilted surface to beam on horizontal";
          Real Rd
            "Ratio of diffuse radiation on tilted surface to beam on horizontal";
          Real Rr
            "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
          Real a_c "Weighted circumsolar solid angle";
          Real sky_brightness;
          Real sky_clearness;
          Integer binary_sky_clearness;
          Real F[2, 3];
          Real Fp1 "Reduced brightness coefficient (circumsolar)";
          Real Fp2 "Reduced brightness coefficient (horizon brightening)";
          Real zenith_3=arccos(ic_position_of_sun1.cos_zenith)^3;

          CUTS.ic_diff_rad ic_diff_rad_on_horiz
            annotation (extent=[-57, -42; -43, -29], layer="icon");
          CUTS.oc_total_rad oc_total_rad1 annotation (extent=[46, -25; 66, -5]);
          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-57, 30; -43, 43], layer="icon");
          CUTS.ic_beam_rad ic_beam_rad_on_horiz
            annotation (extent=[-57, -22; -43, -9], layer="icon");
          CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
            annotation (extent=[-57, 13; -43, 27], layer="icon");
          annotation (
            Icon,
            Coordsys(
              extent=[-50, -55; 67, 60],
              grid=[1, 1],
              component=[20, 20]),
            Window(
              x=0,
              y=0,
              width=1,
              height=0.99));
          CUTS.InPort ic_surface_s_and_a(n=2)
            annotation (extent=[66, 14; 56, 24], layer="icon");
        equation
          if cardinality(ic_surface_s_and_a) == 0 then
            ic_surface_s_and_a.signal = {surf_slope,surf_azimuth};
          end if;
          incidence_angle = arccos(ic_position_of_sun1.cos_zenith*cos(
            ic_surface_s_and_a.signal[1]) + ic_position_of_sun1.sin_zenith*(
            ic_position_of_sun1.sin_azimuth*sin(ic_surface_s_and_a.signal[2])
             + ic_position_of_sun1.cos_azimuth*cos(ic_surface_s_and_a.signal[2]))
            *sin(ic_surface_s_and_a.signal[1]));
          out_of_incidence = incidence_angle > 90*conv_deg_to_rad;
          Rb = if noEvent(ic_position_of_sun1.cos_zenith > 0 and not
            out_of_incidence) then cos(incidence_angle)/ic_position_of_sun1.
            cos_zenith else 0;
          IbT = Rb*ic_beam_rad_on_horiz.I;
          Rr = 0.5*(1 - cos(ic_surface_s_and_a.signal[1]))*rho_ground;
          IgT = Rr*(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);

          IdT = Rd*ic_diff_rad_on_horiz.I;
          Rd = 0.5*(1 - Fp1)*(1 + cos(ic_surface_s_and_a.signal[1])) + Fp1*a_c
             + Fp2*sin(ic_surface_s_and_a.signal[1]);
          a_c = max({0,cos(incidence_angle)})/max({cos(85*conv_deg_to_rad),
            ic_position_of_sun1.cos_zenith});
          Fp1 = F[1, 1] + F[1, 2]*sky_brightness + F[1, 3]*arccos(
            ic_position_of_sun1.cos_zenith);
          Fp2 = F[2, 1] + F[2, 2]*sky_brightness + F[2, 3]*arccos(
            ic_position_of_sun1.cos_zenith);
          ic_extraterr_rad_on_horiz.I = ic_diff_rad_on_horiz.I*sky_brightness;
          sky_clearness = if ic_position_of_sun1.cos_zenith > 0 then (((
            ic_diff_rad_on_horiz.I + ic_beam_rad_on_horiz.I/ic_position_of_sun1.
             cos_zenith)/ic_diff_rad_on_horiz.I) + 1.041*zenith_3)/(1 + 1.041*
            zenith_3) else 1;

          oc_total_rad1.I = IbT + IdT + IgT;
        algorithm
          (F,binary_sky_clearness) := peak_perez_coef(sky_clearness);

          if initial() then
            assert(uf_surf_slope <= 180,
              "Error in class 'rad_on_tilted_surf_mode_4': parameter surface slope angle greater than 180°.");
            assert(uf_surf_slope >= 0,
              "Error in class 'rad_on_tilted_surf_mode_4': negative parameter surface slope angle.");
            assert(uf_surf_azimuth < 180,
              "Error in class 'rad_on_tilted_surf_mode_4': parameter surface azimuth angle greater than 180°.");
            assert(uf_surf_azimuth > -180,
              "Error in class 'rad_on_tilted_surf_mode_4': parameter surface azimuth angle less than -180°.");
            assert(rho_ground <= 1,
              "Error in class 'rad_on_tilted_surf_mode_4': ground reflectance greater than 1.");
            assert(rho_ground >= 0,
              "Error in class 'rad_on_tilted_surf_mode_4': negative ground reflectance.");
          end if;
        end rad_on_tilted_surf_mode_4;

        class rad_on_tilted_surf_mux
          "Radiation components on many tilted surfaces (as defined in orientation alias sets) (modes 1, 2 and 3)"

          extends icons.specifics.icon_rad_on_tilted_surf_mux;
          extends TOOLS.surf_orient.surf_orient_alias_def;
          SIunits.Angle surf_slope[n_of_surf_orient_def];
          SIunits.Angle surf_azimuth[n_of_surf_orient_def];
          parameter Integer mode=1
            "Tilted surface radiation mode (see user manual) (1,2 or 3)";
          parameter Real rho_ground=0.2 "Ground reflectance around the area";
          Real IbT[n_of_surf_orient_def] "Beam radiation on tilted surface";
          Real IdT[n_of_surf_orient_def] "Diffuse radiation on tilted surface";
          Real IgT[n_of_surf_orient_def]
            "Ground reflected radiation on tilted surface";
          SIunits.Angle incidence_angle[n_of_surf_orient_def]
            "Angle of incidence of beam radiation on surface";
          Boolean out_of_incidence[n_of_surf_orient_def]
            "Is the sun behind the tilted surface?";

          Real Rb[n_of_surf_orient_def]
            "Ratio of beam radiation on tilted surface to beam on horizontal";
          Real Rd[n_of_surf_orient_def]
            "Ratio of diffuse radiation on tilted surface to beam on horizontal";
          Real Rr[n_of_surf_orient_def]
            "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
          Real AI
            "Hay and Davies anisotropy index defining a portion of the diffuse radiaton to be treated as circumsolar";
          Real f
            "Reindl's modulating factor for the isotropic diffuse term to take the horizon brightening into account";

          CUTS.ic_diff_rad ic_diff_rad_on_horiz
            annotation (extent=[-56, -39; -42, -26], layer="icon");
          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-56, 33; -42, 46], layer="icon");
          CUTS.ic_beam_rad ic_beam_rad_on_horiz
            annotation (extent=[-56, -19; -42, -6], layer="icon");
          CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
            annotation (extent=[-56, 16; -42, 30], layer="icon");
          CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
            annotation (extent=[44, -21; 64, -1]);
          annotation (
            Coordsys(
              extent=[-61, -55; 62, 60],
              grid=[1, 1],
              component=[20, 20]),
            Window(
              x=0.25,
              y=0.14,
              width=0.6,
              height=0.82),
            Diagram);
        equation
          if mode == 1 then
            AI = 0;
            f = 0;
          else
            if mode == 2 or mode == 3 then
              AI = if not ic_position_of_sun1.shadow then ic_beam_rad_on_horiz.
                I/ic_extraterr_rad_on_horiz.I else 0;
              if mode == 2 then
                f = 0;
              else
                f = if not ic_position_of_sun1.shadow and noEvent(
                  ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I > 0) then
                  sqrt(ic_beam_rad_on_horiz.I/(ic_beam_rad_on_horiz.I +
                  ic_diff_rad_on_horiz.I)) else 0;
              end if;
            end if;
          end if;
          for i in 1:n_of_surf_orient_def loop
            surf_azimuth[i] = surf_orient_def[i, 1]*conv_deg_to_rad;
            surf_slope[i] = surf_orient_def[i, 2]*conv_deg_to_rad;
            incidence_angle[i] = arccos(ic_position_of_sun1.cos_zenith*cos(
              surf_slope[i]) + ic_position_of_sun1.sin_zenith*(
              ic_position_of_sun1.sin_azimuth*sin(surf_azimuth[i]) +
              ic_position_of_sun1.cos_azimuth*cos(surf_azimuth[i]))*sin(
              surf_slope[i]));
            out_of_incidence[i] = incidence_angle[i] > 90*conv_deg_to_rad;
            Rb[i] = if not ic_position_of_sun1.shadow and not out_of_incidence[
              i] then cos(incidence_angle[i])/ic_position_of_sun1.cos_zenith else
                    0;
            IbT[i] = Rb[i]*ic_beam_rad_on_horiz.I;
            Rr[i] = 0.5*(1 - cos(surf_slope[i]))*rho_ground;
            IgT[i] = Rr[i]*(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);
            Rd[i] = 0.5*(1 - AI)*(1 + cos(surf_slope[i]))*(1 + f*(sin(
              surf_slope[i]/2)^3)) + AI*Rb[i];
            IdT[i] = Rd[i]*ic_diff_rad_on_horiz.I;
            oc_total_rad_v1.I[i] = IbT[i] + IdT[i] + IgT[i];
          end for;
          if initial() then
            assert(rho_ground <= 1,
              "Error in class 'rad_on_tilted_surf_mux': ground reflectance is greater than 1.");
            assert(rho_ground >= 0,
              "Error in class 'rad_on_tilted_surf_mux': ground reflectance is negative.");
          end if;
        end rad_on_tilted_surf_mux;

        class rad_on_tilted_surf_mode_4_mux
          "Radiation components on many tilted surfaces (as defined in orientation alias sets) (mode 4)"

          extends icons.specifics.icon_rad_on_tilted_surf_mode_4_mux;
          extends TOOLS.surf_orient.surf_orient_alias_def;
          SIunits.Angle surf_slope[n_of_surf_orient_def];
          SIunits.Angle surf_azimuth[n_of_surf_orient_def];
          parameter Real rho_ground=0.2 "Ground reflectance around the area";
          Real IbT[n_of_surf_orient_def] "Beam radiation on tilted surface";
          Real IdT[n_of_surf_orient_def] "Diffuse radiation on tilted surface";
          Real IgT[n_of_surf_orient_def]
            "Ground reflected radiation on tilted surface";
          SIunits.Angle incidence_angle[n_of_surf_orient_def]
            "Angle of incidence of beam radiation on surface";
          Boolean out_of_incidence[n_of_surf_orient_def]
            "Is the sun behind the tilted surface?";

          Real Rb[n_of_surf_orient_def]
            "Ratio of beam radiation on tilted surface to beam on horizontal";
          Real Rd[n_of_surf_orient_def]
            "Ratio of diffuse radiation on tilted surface to beam on horizontal";
          Real Rr[n_of_surf_orient_def]
            "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
          Real a_c[n_of_surf_orient_def] "Weighted circumsolar solid angle";
          Real sky_brightness;
          Real sky_clearness;
          Integer binary_sky_clearness;
          Real F[2, 3];
          Real Fp1 "Reduced brightness coefficient (circumsolar)";
          Real Fp2 "Reduced brightness coefficient (horizon brightening)";
          Real zenith_3=arccos(ic_position_of_sun1.cos_zenith)^3;

          CUTS.ic_diff_rad ic_diff_rad_on_horiz
            annotation (extent=[-56, -39; -42, -26], layer="icon");
          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-56, 33; -42, 46], layer="icon");
          CUTS.ic_beam_rad ic_beam_rad_on_horiz
            annotation (extent=[-56, -19; -42, -6], layer="icon");
          CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
            annotation (extent=[-56, 16; -42, 30], layer="icon");
          CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
            annotation (extent=[44, -21; 64, -1]);
          annotation (Coordsys(
              extent=[-61, -55; 62, 60],
              grid=[1, 1],
              component=[20, 20]), Window(
              x=0.25,
              y=0.14,
              width=0.6,
              height=0.82));
        equation
          for i in 1:n_of_surf_orient_def loop
            incidence_angle[i] = arccos(ic_position_of_sun1.cos_zenith*cos(
              surf_slope[i]) + ic_position_of_sun1.sin_zenith*(
              ic_position_of_sun1.sin_azimuth*sin(surf_azimuth[i]) +
              ic_position_of_sun1.cos_azimuth*cos(surf_azimuth[i]))*sin(
              surf_slope[i]));
            out_of_incidence[i] = incidence_angle[i] > 90*conv_deg_to_rad;

            Rb[i] = if noEvent(ic_position_of_sun1.cos_zenith > 0 and not
              out_of_incidence[i]) then cos(incidence_angle[i])/
              ic_position_of_sun1.cos_zenith else 0;
            IbT[i] = Rb[i]*ic_beam_rad_on_horiz.I;

            Rr[i] = 0.5*(1 - cos(surf_slope[i]))*rho_ground;
            IgT[i] = Rr[i]*(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);

            IdT[i] = Rd[i]*ic_diff_rad_on_horiz.I;
            Rd[i] = 0.5*(1 - Fp1)*(1 + cos(surf_slope[i])) + Fp1*a_c[i] + Fp2*
              sin(surf_slope[i]);
            a_c[i] = max({0,cos(incidence_angle[i])})/max({cos(85*
              conv_deg_to_rad),ic_position_of_sun1.cos_zenith});
            oc_total_rad_v1.I[i] = IbT[i] + IdT[i] + IgT[i];
          end for;
          Fp1 = F[1, 1] + F[1, 2]*sky_brightness + F[1, 3]*arccos(
            ic_position_of_sun1.cos_zenith);
          Fp2 = F[2, 1] + F[2, 2]*sky_brightness + F[2, 3]*arccos(
            ic_position_of_sun1.cos_zenith);
          ic_extraterr_rad_on_horiz.I = ic_diff_rad_on_horiz.I*sky_brightness;
          sky_clearness = if ic_position_of_sun1.cos_zenith > 0 then (((
            ic_diff_rad_on_horiz.I + ic_beam_rad_on_horiz.I/ic_position_of_sun1.
             cos_zenith)/ic_diff_rad_on_horiz.I) + 1.041*zenith_3)/(1 + 1.041*
            zenith_3) else 1;

        algorithm
          (F,binary_sky_clearness) := peak_perez_coef(sky_clearness);
          if initial() then
            assert(rho_ground <= 1,
              "Error in class 'rad_on_tilted_surf_mode_4_mux': ground reflectance greater than 1.");
            assert(rho_ground >= 0,
              "Error in class 'rad_on_tilted_surf_mode_4_mux': negative ground reflectance.");
          end if;
        end rad_on_tilted_surf_mode_4_mux;

        function peak_perez_coef
          "Peak Perez coefficients (to calculate the radiation on tilted surface (mode 4))"

          extends icons.universals.icon_function;
          input Real s_c "Sky clearness";
          output Real coef[2, 3];
          output Integer binary_s_c;
        protected
          constant Real perez_coef[8, 2, 3]={{{-0.196,1.084,-0.006},{-0.114,
              0.180,-0.019}},{{0.236,0.519,-0.180},{-0.011,0.020,-0.038}},{{
              0.454,0.321,-0.255},{0.072,-0.098,-0.046}},{{0.866,-0.381,-0.375},
              {0.203,-0.403,-0.049}},{{1.026,-0.711,-0.426},{0.273,-0.602,-0.061}},
              {{0.978,-0.986,-0.350},{0.280,-0.915,-0.024}},{{0.748,-0.913,-0.236},
              {0.173,-1.045,0.065}},{{0.318,-0.757,0.103},{0.062,-1.698,0.236}}};
          constant Real perez_coef_upper_limit_for_s_c[8]={1.065,1.230,1.500,
              1.950,2.800,4.500,6.200,0};
          annotation (Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[1, 1],
              component=[20, 20]), Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));
        algorithm
          binary_s_c := 1;
          while s_c > perez_coef_upper_limit_for_s_c[binary_s_c] and binary_s_c
               < scalar(size(perez_coef_upper_limit_for_s_c)) loop
            binary_s_c := binary_s_c + 1;
          end while;
          coef := perez_coef[binary_s_c, :, :];
        end peak_perez_coef;

        class extraterr_rad_on_tilted_surf
          "Extraterrestrial radiation on a tilted surface"
          extends icons.specifics.icon_extraterr_rad_on_tilted_surf;
          parameter Real uf_surf_slope=90
            "Slope of the surface if not entered via connector (0°...180°)";
          parameter Real uf_surf_azimuth=0
            "Azimuth angle of the surface if not entered via connector (-180°...180°)";
          SIunits.Angle incidence_angle
            "Angle of incidence of beam radiation on surface";
          Boolean out_of_incidence "Is the sun behind the tilted surface?";

          parameter SIunits.Angle surf_slope=uf_surf_slope*conv_deg_to_rad;
          parameter SIunits.Angle surf_azimuth=uf_surf_azimuth*conv_deg_to_rad;
          Real Rb
            "ratio of beam radiation on tilted surface to beam on horizontal";

          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-247, 1; -191, 56], layer="icon");
          CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
            annotation (extent=[-244, -69; -193, -15], layer="icon");
          annotation (
            Coordsys(
              extent=[-186, -178; 159, 66],
              grid=[1, 1],
              component=[20, 20]),
            Window(
              x=0.2,
              y=0.18,
              width=0.6,
              height=0.6),
            Icon);
          CUTS.InPort ic_surface_s_and_a(n=2)
            annotation (extent=[204, 10; 168, 47], layer="icon");
          CUTS.oc_beam_rad oc_extraterr_rad_on_tilted_surf1
            annotation (extent=[168, -62; 224, -9], layer="icon");
        equation
          if cardinality(ic_surface_s_and_a) == 0 then
            ic_surface_s_and_a.signal = {surf_slope,surf_azimuth};
          end if;
          incidence_angle = arccos(ic_position_of_sun1.cos_zenith*cos(
            ic_surface_s_and_a.signal[1]) + ic_position_of_sun1.sin_zenith*(
            ic_position_of_sun1.sin_azimuth*sin(ic_surface_s_and_a.signal[2])
             + ic_position_of_sun1.cos_azimuth*cos(ic_surface_s_and_a.signal[2]))
            *sin(ic_surface_s_and_a.signal[1]));
          out_of_incidence = incidence_angle > 90*conv_deg_to_rad;

          Rb = if not ic_position_of_sun1.shadow and not out_of_incidence then
            cos(incidence_angle)/ic_position_of_sun1.cos_zenith else 0;
          Rb = oc_extraterr_rad_on_tilted_surf1.I/ic_extraterr_rad_on_horiz.I;

          if initial() then
            assert(uf_surf_slope <= 180,
              "Error in class 'rad_on_tilted_surf': parameter surface slope angle greater than 180°.");
            assert(uf_surf_slope >= 0,
              "Error in class 'rad_on_tilted_surf': negative parameter surface slope angle.");
            assert(uf_surf_azimuth <= 180,
              "Error in class 'rad_on_tilted_surf': parameter surface azimuth angle greater than 180°.");
            assert(uf_surf_azimuth >= -180,
              "Error in class 'rad_on_tilted_surf': parameter surface azimuth angle less than -180°.");
          end if;
        end extraterr_rad_on_tilted_surf;

        class extraterr_rad_on_tilted_surf_mux
          "Extraterrestrial radiation on many tilted surfaces (as defined in orientation alias sets)"

          extends icons.specifics.icon_extraterr_rad_on_tilted_surf_mux;
          extends TOOLS.surf_orient.surf_orient_alias_def;
          SIunits.Angle surf_slope[n_of_surf_orient_def];
          SIunits.Angle surf_azimuth[n_of_surf_orient_def];
          Real Rb[n_of_surf_orient_def]
            "ratio of beam radiation on tilted surface to beam on horizontal";
          SIunits.Angle incidence_angle[n_of_surf_orient_def]
            "angle of incidence of beam radiation on surface";
          Boolean out_of_incidence[n_of_surf_orient_def]
            "is the sun behind the tilted surface?";
          annotation (
            Coordsys(
              extent=[-186, -178; 159, 66],
              grid=[2, 2],
              component=[20, 20]),
            Window(
              x=0.2,
              y=0.18,
              width=0.6,
              height=0.6),
            Icon);
          CUTS.oc_total_rad_v oc_extraterr_rad_on_tilted_surf_v1(final n=
                n_of_surf_orient_def) annotation (extent=[164, -56; 214, -12]);
          CUTS.ic_position_of_sun ic_position_of_sun1
            annotation (extent=[-247, 1; -191, 56], layer="icon");
          CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
            annotation (extent=[-244, -69; -193, -15], layer="icon");
        equation
          for i in 1:n_of_surf_orient_def loop
            surf_azimuth[i] = surf_orient_def[i, 1]*conv_deg_to_rad;
            surf_slope[i] = surf_orient_def[i, 2]*conv_deg_to_rad;
            incidence_angle[i] = arccos(ic_position_of_sun1.cos_zenith*cos(
              surf_slope[i]) + ic_position_of_sun1.sin_zenith*(
              ic_position_of_sun1.sin_azimuth*sin(surf_azimuth[i]) +
              ic_position_of_sun1.cos_azimuth*cos(surf_azimuth[i]))*sin(
              surf_slope[i]));
            out_of_incidence[i] = incidence_angle[i] > 90*conv_deg_to_rad;
            Rb[i] = if not ic_position_of_sun1.shadow and not out_of_incidence[
              i] then cos(incidence_angle[i])/ic_position_of_sun1.cos_zenith else
                    0;
            Rb[i] = oc_extraterr_rad_on_tilted_surf_v1.I[i]/
              ic_extraterr_rad_on_horiz.I;
          end for;
        end extraterr_rad_on_tilted_surf_mux;

        package tracking

          extends icons.universals.icon_folder;
          annotation (Coordsys(
              extent=[0, 0; 442, 394],
              grid=[2, 2],
              component=[20, 20]), Window(
              x=0,
              y=0.56,
              width=0.16,
              height=0.44,
              library=1,
              autolayout=1));
          package normal
            extends icons.universals.icon_folder;
            annotation (Coordsys(
                extent=[0, 0; 156, 383],
                grid=[2, 2],
                component=[20, 20]), Window(
                x=0,
                y=0,
                width=0.16,
                height=0.56,
                library=1,
                autolayout=1));
            class rad_on_normal_surf
              extends icons.specifics.icon_rad_on_normal_surf;
              parameter Integer mode=1
                "Tilted surface radiation mode (see user manual) (1,2 or 3)";
              parameter Real rho_ground=0.2
                "Ground reflectance in the front area of the surface (0...1)";
              Real IbT "Beam radiation on tilted surface";
              Real IdT "Diffuse radiation on tilted surface";
              Real IgT "Ground reflected radiation on tilted surface";

              Real Rb
                "Ratio of beam radiation on tilted surface to beam on horizontal";
              Real Rd
                "Ratio of diffuse radiation on tilted surface to beam on horizontal";
              Real Rr
                "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
              Real AI
                "Hay and Davies anisotropy index defining a portion of the diffuse radiaton to be treated as circumsolar";
              Real f
                "Reindl's modulating factor for the isotropic diffuse term to take the horizon brightening into account";

              CUTS.ic_diff_rad ic_diff_rad_on_horiz
                annotation (extent=[-57, -38; -43, -25], layer="icon");
              CUTS.oc_total_rad oc_total_rad1
                annotation (extent=[47, -26; 67, -6]);
              CUTS.ic_position_of_sun ic_position_of_sun1
                annotation (extent=[-57, 30; -43, 43], layer="icon");
              CUTS.ic_beam_rad ic_beam_rad_on_horiz
                annotation (extent=[-57, -23; -43, -10], layer="icon");
              CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
                annotation (extent=[-57, 13; -43, 27], layer="icon");
              annotation (Coordsys(
                  extent=[-50, -55; 72, 60],
                  grid=[1, 1],
                  component=[20, 20]), Window(
                  x=0.2,
                  y=0.18,
                  width=0.6,
                  height=0.6));
            equation
              if mode == 1 then
                AI = 0;
                f = 0;
              else
                if mode == 2 or mode == 3 then
                  AI = if not ic_position_of_sun1.shadow then
                    ic_beam_rad_on_horiz.I/ic_extraterr_rad_on_horiz.I else 0;
                  if mode == 2 then
                    f = 0;
                  else
                    f = if not ic_position_of_sun1.shadow and noEvent(
                      ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I > 0) then
                            sqrt(ic_beam_rad_on_horiz.I/(ic_beam_rad_on_horiz.I
                       + ic_diff_rad_on_horiz.I)) else 0;
                  end if;
                end if;
              end if;

              Rb = if not ic_position_of_sun1.shadow then 1/ic_position_of_sun1.
                 cos_zenith else 0;
              Rb = IbT/ic_beam_rad_on_horiz.I;

              Rr = 0.5*(1 - ic_position_of_sun1.cos_zenith)*rho_ground;
              Rr = IgT/(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);

              Rd = 0.5*(1 - AI)*(1 + ic_position_of_sun1.cos_zenith)*(1 + f*(
                sin(arccos(ic_position_of_sun1.cos_zenith)/2)^3)) + AI*Rb;
              Rd = IdT/ic_diff_rad_on_horiz.I;

              oc_total_rad1.I = IbT + IdT + IgT;

              if initial() then
                assert(rho_ground <= 1,
                  "Error in class 'rad_on_normal_surf': ground reflectance greater than 1.");
                assert(rho_ground >= 0,
                  "Error in class 'rad_on_normal_surf': negative ground reflectance.");
              end if;
            end rad_on_normal_surf;

            class rad_on_normal_surf_mode_4
              extends icons.specifics.icon_rad_on_normal_surf_mode_4;
              parameter Real rho_ground=0.2
                "Ground reflectance in the front area of the surface";
              Real IbT "Beam radiation on tilted surface";
              Real IdT "Diffuse radiation on tilted surface";
              Real IgT "Ground reflected radiation on tilted surface";

              Real Rb
                "Ratio of beam radiation on tilted surface to beam on horizontal";
              Real Rd
                "Ratio of diffuse radiation on tilted surface to beam on horizontal";
              Real Rr
                "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
              Real a_c "Weighted circumsolar solid angle";
              Real sky_brightness;
              Real sky_clearness;
              Integer binary_sky_clearness;
              Real F[2, 3];
              Real Fp1 "Reduced brightness coefficient (circumsolar)";
              Real Fp2 "Reduced brightness coefficient (horizon brightening)";
              Real zenith_3=arccos(ic_position_of_sun1.cos_zenith)^3;

              CUTS.ic_diff_rad ic_diff_rad_on_horiz
                annotation (extent=[-57, -42; -43, -29], layer="icon");
              CUTS.oc_total_rad oc_total_rad1
                annotation (extent=[46, -25; 66, -5]);
              CUTS.ic_position_of_sun ic_position_of_sun1
                annotation (extent=[-57, 30; -43, 43], layer="icon");
              CUTS.ic_beam_rad ic_beam_rad_on_horiz
                annotation (extent=[-57, -22; -43, -9], layer="icon");
              CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
                annotation (extent=[-57, 13; -43, 27], layer="icon");
              annotation (
                Icon,
                Coordsys(
                  extent=[-50, -55; 67, 60],
                  grid=[1, 1],
                  component=[20, 20]),
                Window(
                  x=0,
                  y=0,
                  width=0.64,
                  height=0.98));
            equation
              Rb = if noEvent(ic_position_of_sun1.cos_zenith > 0) then 1/
                ic_position_of_sun1.cos_zenith else 0;
              Rb = IbT/ic_beam_rad_on_horiz.I;
              Rr = 0.5*(1 - ic_position_of_sun1.cos_zenith)*rho_ground;
              Rr = IgT/(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);

              Rd = IdT/ic_diff_rad_on_horiz.I;
              Rd = 0.5*(1 - Fp1)*(1 + ic_position_of_sun1.cos_zenith) + Fp1*a_c
                 + Fp2*ic_position_of_sun1.sin_zenith;
              a_c = 1/max({cos(85*conv_deg_to_rad),ic_position_of_sun1.
                cos_zenith});
              Fp1 = F[1, 1] + F[1, 2]*sky_brightness + F[1, 3]*arccos(
                ic_position_of_sun1.cos_zenith);
              Fp2 = F[2, 1] + F[2, 2]*sky_brightness + F[2, 3]*arccos(
                ic_position_of_sun1.cos_zenith);
              sky_brightness = ic_diff_rad_on_horiz.I/ic_extraterr_rad_on_horiz.
                 I;
              sky_clearness = if ic_position_of_sun1.cos_zenith > 0 then (((
                ic_diff_rad_on_horiz.I + ic_beam_rad_on_horiz.I/
                ic_position_of_sun1.cos_zenith)/ic_diff_rad_on_horiz.I) + 1.041
                *zenith_3)/(1 + 1.041*zenith_3) else 1;
              oc_total_rad1.I = IbT + IdT + IgT;
            algorithm
              (F,binary_sky_clearness) := peak_perez_coef(sky_clearness);

              if initial() then
                assert(rho_ground <= 1,
                  "Error in class 'rad_on_normal_surf_mode_4': ground reflectance greater than 1.");
                assert(rho_ground >= 0,
                  "Error in class 'rad_on_normal_surf_mode_4': negative ground reflectance.");
              end if;
            end rad_on_normal_surf_mode_4;
          end normal;

          package vert_axis
            extends icons.universals.icon_folder;
            annotation (Coordsys(
                extent=[0, 0; 156, 383],
                grid=[2, 2],
                component=[20, 20]), Window(
                x=0,
                y=0,
                width=0.16,
                height=0.56,
                library=1,
                autolayout=1));
            class rad_on_tracking_surf_vert_axis
              extends icons.specifics.icon_rad_on_tracking_surf_vert_axis;
              parameter Real uf_surf_slope=90
                "Slope of the surface (0°...180°)";
              parameter Integer mode=1
                "Tilted surface radiation mode (see user manual) (1,2 or 3)";
              parameter Real rho_ground=0.2
                "Ground reflectance in the front area of the surface (0...1)";
              Real IbT "Beam radiation on tilted surface";
              Real IdT "Diffuse radiation on tilted surface";
              Real IgT "Ground reflected radiation on tilted surface";
              SIunits.Angle incidence_angle
                "Angle of incidence of beam radiation on surface";

              parameter SIunits.Angle surf_slope=uf_surf_slope*conv_deg_to_rad;
              Real Rb
                "Ratio of beam radiation on tilted surface to beam on horizontal";
              Real Rd
                "Ratio of diffuse radiation on tilted surface to beam on horizontal";
              Real Rr
                "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
              Real AI
                "Hay and Davies anisotropy index defining a portion of the diffuse radiaton to be treated as circumsolar";
              Real f
                "Reindl's modulating factor for the isotropic diffuse term to take the horizon brightening into account";

              CUTS.ic_diff_rad ic_diff_rad_on_horiz
                annotation (extent=[-57, -38; -43, -25], layer="icon");
              CUTS.oc_total_rad oc_total_rad1
                annotation (extent=[47, -26; 67, -6]);
              CUTS.ic_position_of_sun ic_position_of_sun1
                annotation (extent=[-57, 30; -43, 43], layer="icon");
              CUTS.ic_beam_rad ic_beam_rad_on_horiz
                annotation (extent=[-57, -23; -43, -10], layer="icon");
              CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
                annotation (extent=[-57, 13; -43, 27], layer="icon");
              annotation (Coordsys(
                  extent=[-50, -55; 72, 60],
                  grid=[1, 1],
                  component=[20, 20]), Window(
                  x=0.2,
                  y=0.18,
                  width=0.6,
                  height=0.6));
            equation
              if mode == 1 then
                AI = 0;
                f = 0;
              else
                if mode == 2 or mode == 3 then
                  AI = if not ic_position_of_sun1.shadow then
                    ic_beam_rad_on_horiz.I/ic_extraterr_rad_on_horiz.I else 0;
                  if mode == 2 then
                    f = 0;
                  else
                    f = if not ic_position_of_sun1.shadow and noEvent(
                      ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I > 0) then
                            sqrt(ic_beam_rad_on_horiz.I/(ic_beam_rad_on_horiz.I
                       + ic_diff_rad_on_horiz.I)) else 0;
                  end if;
                end if;
              end if;

              incidence_angle = arccos(ic_position_of_sun1.cos_zenith*cos(
                surf_slope) + ic_position_of_sun1.sin_zenith*sin(surf_slope));

              Rb = if not ic_position_of_sun1.shadow then cos(incidence_angle)/
                ic_position_of_sun1.cos_zenith else 0;
              Rb = IbT/ic_beam_rad_on_horiz.I;

              Rr = 0.5*(1 - cos(surf_slope))*rho_ground;
              Rr = IgT/(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);

              Rd = 0.5*(1 - AI)*(1 + cos(surf_slope))*(1 + f*(sin(surf_slope/2)
                ^3)) + AI*Rb;
              Rd = IdT/ic_diff_rad_on_horiz.I;

              oc_total_rad1.I = IbT + IdT + IgT;

              if initial() then
                assert(uf_surf_slope <= 180,
                  "Error in class 'rad_on_tracking_surf_vert_axis': parameter surface slope angle greater than 180°.");
                assert(uf_surf_slope >= 0,
                  "Error in class 'rad_on_tracking_surf_vert_axis': negative parameter surface slope angle.");
                assert(rho_ground <= 1,
                  "Error in class 'rad_on_tracking_surf_vert_axis': ground reflectance greater than 1.");
                assert(rho_ground >= 0,
                  "Error in class 'rad_on_tracking_surf_vert_axis': negative ground reflectance.");
              end if;
            end rad_on_tracking_surf_vert_axis;

            class rad_on_tracking_surf_vert_axis_mode_4
              extends
                icons.specifics.icon_rad_on_tracking_surf_vert_axis_mode_4;
              parameter Real uf_surf_slope=90
                "Slope of the surface (0°...180°)";
              parameter Real rho_ground=0.2
                "Ground reflectance in the front area of the surface";
              Real IbT "Beam radiation on tilted surface";
              Real IdT "Diffuse radiation on tilted surface";
              Real IgT "Ground reflected radiation on tilted surface";
              SIunits.Angle incidence_angle
                "Angle of incidence of beam radiation on surface";

              parameter SIunits.Angle surf_slope=uf_surf_slope*conv_deg_to_rad;
              Real Rb
                "Ratio of beam radiation on tilted surface to beam on horizontal";
              Real Rd
                "Ratio of diffuse radiation on tilted surface to beam on horizontal";
              Real Rr
                "Ratio of reflected radiation on tilted surface to total radiation on horizontal";
              Real a_c "Weighted circumsolar solid angle";
              Real sky_brightness;
              Real sky_clearness;
              Integer binary_sky_clearness;
              Real F[2, 3];
              Real Fp1 "Reduced brightness coefficient (circumsolar)";
              Real Fp2 "Reduced brightness coefficient (horizon brightening)";
              Real zenith_3=arccos(ic_position_of_sun1.cos_zenith)^3;

              CUTS.ic_diff_rad ic_diff_rad_on_horiz
                annotation (extent=[-57, -42; -43, -29], layer="icon");
              CUTS.oc_total_rad oc_total_rad1
                annotation (extent=[46, -25; 66, -5]);
              CUTS.ic_position_of_sun ic_position_of_sun1
                annotation (extent=[-57, 30; -43, 43], layer="icon");
              CUTS.ic_beam_rad ic_beam_rad_on_horiz
                annotation (extent=[-57, -22; -43, -9], layer="icon");
              CUTS.ic_beam_rad ic_extraterr_rad_on_horiz
                annotation (extent=[-57, 13; -43, 27], layer="icon");
              annotation (
                Icon,
                Coordsys(
                  extent=[-50, -55; 67, 60],
                  grid=[1, 1],
                  component=[20, 20]),
                Window(
                  x=0.32,
                  y=0.34,
                  width=0.6,
                  height=0.6));
            equation
              incidence_angle = arccos(ic_position_of_sun1.cos_zenith*cos(
                surf_slope) + ic_position_of_sun1.sin_zenith*sin(surf_slope));
              Rb = if noEvent(ic_position_of_sun1.cos_zenith > 0) then cos(
                incidence_angle)/ic_position_of_sun1.cos_zenith else 0;
              Rb = IbT/ic_beam_rad_on_horiz.I;
              Rr = 0.5*(1 - cos(surf_slope))*rho_ground;
              Rr = IgT/(ic_beam_rad_on_horiz.I + ic_diff_rad_on_horiz.I);

              Rd = IdT/ic_diff_rad_on_horiz.I;
              Rd = 0.5*(1 - Fp1)*(1 + cos(surf_slope)) + Fp1*a_c + Fp2*sin(
                surf_slope);
              a_c = max({0,cos(incidence_angle)})/max({cos(85*conv_deg_to_rad),
                ic_position_of_sun1.cos_zenith});
              Fp1 = F[1, 1] + F[1, 2]*sky_brightness + F[1, 3]*arccos(
                ic_position_of_sun1.cos_zenith);
              Fp2 = F[2, 1] + F[2, 2]*sky_brightness + F[2, 3]*arccos(
                ic_position_of_sun1.cos_zenith);
              sky_brightness = ic_diff_rad_on_horiz.I/ic_extraterr_rad_on_horiz.
                 I;
              sky_clearness = if ic_position_of_sun1.cos_zenith > 0 then (((
                ic_diff_rad_on_horiz.I + ic_beam_rad_on_horiz.I/
                ic_position_of_sun1.cos_zenith)/ic_diff_rad_on_horiz.I) + 1.041
                *zenith_3)/(1 + 1.041*zenith_3) else 1;

              oc_total_rad1.I = IbT + IdT + IgT;
            algorithm
              (F,binary_sky_clearness) := peak_perez_coef(sky_clearness);

              if initial() then
                assert(uf_surf_slope <= 180,
                  "Error in class 'rad_on_tracking_surf_vert_axis_mode_4': parameter surface slope angle greater than 180°.");
                assert(uf_surf_slope >= 0,
                  "Error in class 'rad_on_tracking_surf_vert_axis_mode_4': negative parameter surface slope angle.");
                assert(rho_ground <= 1,
                  "Error in class 'rad_on_tracking_surf_vert_axis_mode_4': ground reflectance greater than 1.");
                assert(rho_ground >= 0,
                  "Error in class 'rad_on_tracking_surf_vert_axis_mode_4': negative ground reflectance.");
              end if;
            end rad_on_tracking_surf_vert_axis_mode_4;
          end vert_axis;
        end tracking;
      end tilted;
    end rad_on_surf;
  end SOLAR;

  package TIME
    extends icons.universals.icon_folder;
    annotation (Coordsys(
        extent=[0, 0; 442, 394],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.68,
        y=0,
        width=0.32,
        height=0.56,
        library=1,
        autolayout=1));
    class t_and_date_processor
      "Time and date processor to keep track of solar, civil, standard meridian and clock hour of day and date"

      //"chip pins" assignment

      //extends
      //abs.time vars.
      //st.date vars.
      //st.local meridian vars.
      //sl.date vars.
      //real st.date vars.
      //real sl.date vars.
      //real st.local meridian vars.
      //time vars.
      //events inductor time vars.
      //auxiliary vars.
      extends icons.specifics.icon_t_and_date_processor;
      extends TIME.t_and_date.sim_ini_clt_h_of_d_and_date;
      parameter Integer forwarded_clock_t_gap=3600
        "Forwarded clock time gap (s)";
      parameter Real uf_given_longitude=7.75
        "Longitude angle if not entered via connector (-180°...180°)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if not entered via connector (-180°...180°)";
      parameter Boolean force_lct=false
        "Force clock time to be local civil time?";
      Real clk_abs_t=time/(60*60);
      Real abs_clt;
      Real abs_slt;
      Real abs_aslt;
      Integer clt_d_of_w;
      Integer clt_d_of_m;
      Integer clt_m_of_y;
      Integer clt_y;
      Integer clt_d_of_y;
      Integer lsmt_y;
      Integer lsmt_d_of_y;
      Integer slt_d_of_w;
      Integer slt_d_of_m;
      Integer slt_m_of_y;
      Integer slt_y;
      Integer slt_d_of_y;
      Integer aslt_y;
      Integer aslt_d_of_y;
      Real clt_d_of_w_r;
      Real clt_d_of_m_r;
      Real clt_m_of_y_r;
      Real clt_y_r;
      Real clt_d_of_y_r;
      Real slt_d_of_m_r;
      Real slt_m_of_y_r;
      Real slt_y_r;
      Real slt_d_of_y_r;
      Real clt_h_of_d "(in hours)";
      Real slt_h_of_d "(in hours)";
      Real lsmt_h_of_d "(in hours)";
      Real aslt_h_of_d "(in hours)";
      Real clt_h_of_y;
      Real slt_h_of_y;
      Real E "equation of time (in hours)";
      Boolean clt_d_change_p(start=false);
      Boolean clt_d_change_n(start=false);
      Boolean slt_d_change_p(start=false);
      Boolean slt_d_change_n(start=false);
      Boolean lsmt_d_change_p(start=false);
      Boolean lsmt_d_change_n(start=false);
      Boolean aslt_d_change_p(start=false);
      Boolean aslt_d_change_n(start=false);
      Integer clt_d_change_since_sim_start(start=0);
      Integer slt_d_change_since_sim_start(start=0);
      Integer lsmt_d_change_since_sim_start(start=0);
      Integer aslt_d_change_since_sim_start(start=0);
      Integer clt_max_d_of_m;
      Integer slt_max_d_of_m;
      Integer clt_max_d_of_y;
      Integer slt_max_d_of_y;
      annotation (Coordsys(
          extent=[-156, -148; 230, 252],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.1,
          y=0.1,
          width=0.83,
          height=0.84));
      CUTS.InPort ic_meridians(n=2)
        annotation (extent=[-45, 204; 1, 238], rotation=-90);
      CUTS.oc_t_point oc_clt_point annotation (
        extent=[162, 204; 201, 238],
        rotation=90,
        layer="icon");
      CUTS.oc_t_point oc_slt_point annotation (
        extent=[56, 204; 100, 238],
        rotation=90,
        layer="icon");
      CUTS.InPort ic_dlight_svngs_t_shift(n=2) annotation (
        extent=[-146, 204; -100, 238],
        rotation=-90,
        layer="icon");
      CUTS.oc_t_point oc_lsmt_point annotation (
        extent=[110, 204; 146, 238],
        rotation=90,
        layer="icon");
      CUTS.InPort ic_meridians_a(n=2) annotation (
        extent=[-95, 204; -49, 238],
        rotation=-90,
        layer="icon");
      CUTS.oc_t_point oc_aslt_point annotation (
        extent=[8, 204; 47, 238],
        rotation=90,
        layer="icon");
    equation
      if cardinality(ic_dlight_svngs_t_shift) == 0 then
        ic_dlight_svngs_t_shift.signal = {0,0};
      end if;
      if cardinality(ic_meridians) == 0 or cardinality(ic_meridians_a) == 0 then
        ic_meridians.signal = ic_meridians_a.signal;
      end if;
      if cardinality(ic_meridians) == 0 and cardinality(ic_meridians_a) == 0 then
        ic_meridians.signal = {uf_given_longitude*conv_deg_to_rad,
          uf_given_ref_meridian*conv_deg_to_rad};
      end if;

      //equations of clock date in their continuous version
      clt_d_of_w_r = clt_d_of_w + clt_h_of_d/24;
      clt_d_of_m_r = clt_d_of_m + clt_h_of_d/24;
      clt_m_of_y_r = clt_m_of_y + (clt_d_of_m_r - 1)/clt_max_d_of_m;
      clt_y_r = clt_y + ((clt_d_of_y - 1) + clt_h_of_d/24)/clt_max_d_of_y;
      clt_d_of_y_r = clt_d_of_y + clt_h_of_d/24;
      clt_h_of_y = (clt_d_of_y - 1)*24 + clt_h_of_d;

      //equations of solar date in their continuous version
      slt_d_of_m_r = slt_d_of_m + slt_h_of_d/24;
      slt_m_of_y_r = slt_m_of_y + (slt_d_of_m_r - 1)/slt_max_d_of_m;
      slt_y_r = slt_y + ((slt_d_of_y - 1) + slt_h_of_d/24)/slt_max_d_of_y;
      slt_d_of_y_r = slt_d_of_y + slt_h_of_d/24;
      slt_h_of_y = (slt_d_of_y - 1)*24 + slt_h_of_d;

      //equations of local standard meridian date in their continuous version
      //removed!

    algorithm
      if initial() then
        //initialization
        clt_d_of_w := sim_ini_clt_d_of_w;
        clt_d_of_m := sim_ini_clt_d_of_m;
        clt_m_of_y := sim_ini_clt_m_of_y;
        clt_y := sim_ini_clt_y;
        clt_d_of_y := sim_ini_clt_d_of_y;
        slt_y := clt_y;
        slt_d_of_y := clt_d_of_y;
        lsmt_y := clt_y;
        lsmt_d_of_y := clt_d_of_y;
        aslt_y := clt_y;
        aslt_d_of_y := clt_d_of_y;
      end if;
      E := equation_of_t(lsmt_d_of_y);
      //abs.time equations
      abs_clt := clk_abs_t;
      abs_slt := clk_abs_t + E + (if not force_lct then (ic_meridians.signal[1]
         - ic_meridians.signal[2])*24/(2*Constants.pi) else 0);
      abs_aslt := clk_abs_t + E + forwarded_clock_t_gap/3600 + (if not
        force_lct then (ic_meridians_a.signal[1] - ic_meridians_a.signal[2])*24
        /(2*Constants.pi) else 0);

      //hour-of-day equations
      clt_h_of_d := sim_ini_clt_h_of_d + abs_clt - clt_d_change_since_sim_start
        *24;
      slt_h_of_d := sim_ini_clt_h_of_d + abs_slt - slt_d_change_since_sim_start
        *24;
      lsmt_h_of_d := sim_ini_clt_h_of_d + abs_clt -
        lsmt_d_change_since_sim_start*24;
      aslt_h_of_d := sim_ini_clt_h_of_d + abs_aslt -
        aslt_d_change_since_sim_start*24;

      //events inductor
      clt_d_change_p := clt_h_of_d >= 24;
      clt_d_change_n := clt_h_of_d < 0;
      slt_d_change_p := slt_h_of_d >= 24;
      slt_d_change_n := slt_h_of_d < 0;
      lsmt_d_change_p := lsmt_h_of_d >= 24;
      lsmt_d_change_n := lsmt_h_of_d < 0;
      aslt_d_change_p := aslt_h_of_d >= 24;
      aslt_d_change_n := aslt_h_of_d < 0;

      //events selector
      if edge(clt_d_change_p) then
        (clt_d_of_y,clt_d_of_w,clt_d_of_m,clt_m_of_y,clt_y) :=
          f_of_date.inc_wdate(clt_d_of_y, clt_d_of_w, clt_d_of_m, clt_m_of_y,
          clt_y);
        clt_d_change_since_sim_start := pre(clt_d_change_since_sim_start) + 1;
      end if;
      if edge(clt_d_change_n) then
        (clt_d_of_y,clt_d_of_w,clt_d_of_m,clt_m_of_y,clt_y) :=
          f_of_date.dec_wdate(clt_d_of_y, clt_d_of_w, clt_d_of_m, clt_m_of_y,
          clt_y);
        clt_d_change_since_sim_start := pre(clt_d_change_since_sim_start) - 1;
      end if;
      if edge(slt_d_change_p) then
        (slt_d_of_y,slt_d_of_w,slt_d_of_m,slt_m_of_y,slt_y) :=
          f_of_date.inc_wdate(slt_d_of_y, slt_d_of_w, slt_d_of_m, slt_m_of_y,
          slt_y);
        slt_d_change_since_sim_start := pre(slt_d_change_since_sim_start) + 1;
      end if;
      if edge(slt_d_change_n) then
        (slt_d_of_y,slt_d_of_w,slt_d_of_m,slt_m_of_y,slt_y) :=
          f_of_date.dec_wdate(slt_d_of_y, slt_d_of_w, slt_d_of_m, slt_m_of_y,
          slt_y);
        slt_d_change_since_sim_start := pre(slt_d_change_since_sim_start) - 1;
      end if;
      if edge(lsmt_d_change_p) then
        (lsmt_d_of_y,lsmt_y) := f_of_date.inc_jdate(lsmt_d_of_y, lsmt_y);
        lsmt_d_change_since_sim_start := pre(lsmt_d_change_since_sim_start) + 1;
      end if;
      if edge(lsmt_d_change_n) then
        (lsmt_d_of_y,lsmt_y) := f_of_date.dec_jdate(lsmt_d_of_y, lsmt_y);
        lsmt_d_change_since_sim_start := pre(lsmt_d_change_since_sim_start) - 1;
      end if;
      if edge(aslt_d_change_p) then
        (aslt_d_of_y,aslt_y) := f_of_date.inc_jdate(aslt_d_of_y, aslt_y);
        aslt_d_change_since_sim_start := pre(aslt_d_change_since_sim_start) + 1;
      end if;
      if edge(aslt_d_change_n) then
        (aslt_d_of_y,aslt_y) := f_of_date.dec_jdate(aslt_d_of_y, aslt_y);
        aslt_d_change_since_sim_start := pre(aslt_d_change_since_sim_start) - 1;
      end if;
      if edge(clt_d_change_p) or edge(clt_d_change_n) or initial() then
        clt_max_d_of_m := f_of_date.max_d_of_m(clt_m_of_y, clt_y);
        clt_max_d_of_y := f_of_date.max_d_of_y(clt_y);
      end if;
      if edge(slt_d_change_p) or edge(slt_d_change_n) or initial() then
        slt_max_d_of_m := f_of_date.max_d_of_m(slt_m_of_y, slt_y);
        slt_max_d_of_y := f_of_date.max_d_of_y(slt_y);
      end if;

      //hour-of-day equations with up-to-date values
      clt_h_of_d := sim_ini_clt_h_of_d + abs_clt - clt_d_change_since_sim_start
        *24;
      slt_h_of_d := sim_ini_clt_h_of_d + abs_slt - slt_d_change_since_sim_start
        *24;
      lsmt_h_of_d := sim_ini_clt_h_of_d + abs_clt - (if not force_lct then (
        ic_dlight_svngs_t_shift.signal[1]) else 0) -
        lsmt_d_change_since_sim_start*24;
      aslt_h_of_d := sim_ini_clt_h_of_d + abs_aslt -
        aslt_d_change_since_sim_start*24;

      //"chip pins" assignment

      oc_slt_point.h_of_d := slt_h_of_d;
      oc_slt_point.d_of_y := slt_d_of_y;
      oc_slt_point.y := slt_y;

      oc_clt_point.h_of_d := clt_h_of_d;
      oc_clt_point.d_of_y := clt_d_of_y;
      oc_clt_point.y := clt_y;

      oc_lsmt_point.h_of_d := lsmt_h_of_d;
      oc_lsmt_point.d_of_y := lsmt_d_of_y;
      oc_lsmt_point.y := lsmt_y;

      oc_aslt_point.h_of_d := aslt_h_of_d;
      oc_aslt_point.d_of_y := aslt_d_of_y;
      oc_aslt_point.y := aslt_y;
      if initial() and cardinality(ic_meridians) == 0 and cardinality(
          ic_meridians_a) == 0 then
        assert(uf_given_longitude <= 180,
          "Error in class 't_and_date_processor': given longitude is greater than 180°.");
        assert(uf_given_longitude >= -180,
          "Error in class 't_and_date_processor': given longitude is less than -180°.");
        assert(uf_given_ref_meridian <= 180,
          "Error in class 't_and_date_processor': given local standard time meridian is greater than 180°.");
        assert(uf_given_ref_meridian >= -180,
          "Error in class 't_and_date_processor': given local standard time meridian is less than -180°.");
      end if;
    end t_and_date_processor;

    function equation_of_t "Equation of time as per Carruthers et al."
      extends icons.specifics.icon_equation_of_t;
      input Integer lsmt_d_of_y;
      output Real E "(h)";
    protected
      Real help;
      annotation (Coordsys(
          extent=[-108, -114; 160, 100],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.23,
          y=0.35,
          width=0.6,
          height=0.6));
    algorithm
      help := (279.134 + 0.985647*lsmt_d_of_y)*conv_deg_to_rad;
      E := (5.0323 - 100.976*sin(help) + 595.275*sin(2*help) + 3.6858*sin(3*
        help) - 12.47*sin(4*help) - 430.847*cos(help) + 12.5024*cos(2*help) +
        18.25*cos(3*help))/3600;
    end equation_of_t;

    package dlight_svngs
      extends icons.universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 318, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1));
      class dlight_svngs_t_sw "Daylight savings time switcher"
        //extends icons.specifics.icon_dlight_svngs_t_sw;
        parameter Boolean apply=true
          "Apply daylight savings time rules ? {true,false}";
        extends t_dir_reader;
        parameter Integer own_rule[2, 3]=[x, x, x; x, x, x]
          "Enter own rule (optional)";
        constant Integer x=0;
        parameter Integer uf_switch_t_gap=0100 "Time gap (hhmm)";
        parameter Integer uf_switch_on_clt_h_of_d=0200 "Switch-on time (hhmm)";
        parameter Integer uf_switch_off_clt_h_of_d=0300
          "Switch-off time (hhmm)";
        parameter Integer uf_switch_on_clt_date=3103 "Switch-on date (ddmm)";
        parameter Integer uf_switch_off_clt_date=2710 "Switch-off date (ddmm)";
        Real switch_t_gap;
        Real switch_on_clt_h_of_d;
        Real switch_off_clt_h_of_d;
        Integer switch_on_clt_d_of_y;
        Integer switch_off_clt_d_of_y;
        Boolean currently_on(start=false);
        Boolean initially_on;
        Boolean switch_on_g_t_off;
        Boolean sim_ini_clt_date_g_t_switch_on;
        Boolean sim_ini_clt_date_l_t_switch_off;

        parameter Integer given_switch_on_clt_d_of_y=f_of_date.d_of_y_from_date(
            div(uf_switch_on_clt_date, 100), rem(uf_switch_on_clt_date, 100),
            2000);
        parameter Integer given_switch_off_clt_d_of_y=
            f_of_date.d_of_y_from_date(div(uf_switch_off_clt_date, 100), rem(
            uf_switch_off_clt_date, 100), 2000);
        parameter Real given_switch_t_gap=div(uf_switch_t_gap, 100) + rem(
            uf_switch_t_gap, 100)/60;
        parameter Real given_switch_on_clt_h_of_d=div(uf_switch_on_clt_h_of_d,
            100) + rem(uf_switch_on_clt_h_of_d, 100)/60;
        parameter Real given_switch_off_clt_h_of_d=div(uf_switch_off_clt_h_of_d,
             100) + rem(uf_switch_off_clt_h_of_d, 100)/60;

        CUTS.OutPort oc_dlight_svngs_t_shift(n=2)
          annotation (extent=[83, 91; 91, 98]);
        CUTS.ic_t_point ic_clt_point1 annotation (extent=[94, 39; 83, 51]);
        annotation (
          Coordsys(
            extent=[-100, -90; 80, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.17,
            y=0.33,
            width=0.6,
            height=0.6),
          Diagram,
          Icon(Rectangle(extent=[-100, 102; 83, -51], style(color=0))));
      algorithm
        if apply then
          if currently_on then
            if initially_on then
              if ic_clt_point1.d_of_y == switch_off_clt_d_of_y and
                  ic_clt_point1.h_of_d >= switch_off_clt_h_of_d then
                currently_on := false;
              end if;
            else
              if ic_clt_point1.d_of_y == switch_off_clt_d_of_y and
                  ic_clt_point1.h_of_d + switch_t_gap >= switch_off_clt_h_of_d then
                currently_on := false;
              end if;
            end if;
          else
            if ic_clt_point1.d_of_y == switch_on_clt_d_of_y and ic_clt_point1.
                h_of_d >= switch_on_clt_h_of_d then
              currently_on := true;
            end if;
          end if;
        end if;
        oc_dlight_svngs_t_shift.signal[1] := if currently_on then switch_t_gap else
                0;
        oc_dlight_svngs_t_shift.signal[2] := if initially_on then switch_t_gap else
                0;

        if apply and (initial() or ic_clt_point1.y <> pre(ic_clt_point1.y)) then
          if given_t_dir_name == none then
            switch_t_gap := given_switch_t_gap;
            switch_on_clt_h_of_d := given_switch_on_clt_h_of_d;
            switch_off_clt_h_of_d := given_switch_off_clt_h_of_d;
            if own_rule[1, 1] == x and own_rule[1, 2] == x and own_rule[1, 3]
                 == x and own_rule[2, 1] == x and own_rule[2, 2] == x and
                own_rule[2, 3] == x then
              switch_on_clt_d_of_y := given_switch_on_clt_d_of_y;
              switch_off_clt_d_of_y := given_switch_off_clt_d_of_y;
            else
              switch_on_clt_d_of_y := f_of_date.d_of_y_from_mdate(own_rule[1, 1],
                 own_rule[1, 2], own_rule[1, 3], ic_clt_point1.y);
              switch_off_clt_d_of_y := f_of_date.d_of_y_from_mdate(own_rule[2,
                1], own_rule[2, 2], own_rule[2, 3], ic_clt_point1.y);

            end if;
          else
            switch_t_gap := sel_t_dir_h_of_d_def[3];
            switch_on_clt_h_of_d := sel_t_dir_h_of_d_def[1];
            switch_off_clt_h_of_d := sel_t_dir_h_of_d_def[2];
            switch_on_clt_d_of_y := f_of_date.d_of_y_from_mdate(
              sel_t_dir_date_def[1, 1], sel_t_dir_date_def[1, 2],
              sel_t_dir_date_def[1, 3], ic_clt_point1.y);
            switch_off_clt_d_of_y := f_of_date.d_of_y_from_mdate(
              sel_t_dir_date_def[2, 1], sel_t_dir_date_def[2, 2],
              sel_t_dir_date_def[2, 3], ic_clt_point1.y);
          end if;
        end if;
        if apply and initial() then
          switch_on_g_t_off := switch_on_clt_d_of_y > switch_off_clt_d_of_y;
          sim_ini_clt_date_g_t_switch_on := ic_clt_point1.d_of_y >
            switch_on_clt_d_of_y or (ic_clt_point1.d_of_y ==
            switch_on_clt_d_of_y and ic_clt_point1.h_of_d + switch_t_gap >
            switch_on_clt_h_of_d);
          sim_ini_clt_date_l_t_switch_off := ic_clt_point1.d_of_y <
            switch_off_clt_d_of_y or (ic_clt_point1.d_of_y ==
            switch_off_clt_d_of_y and ic_clt_point1.h_of_d <
            switch_off_clt_h_of_d);
          initially_on := ((switch_on_g_t_off and (
            sim_ini_clt_date_g_t_switch_on or sim_ini_clt_date_l_t_switch_off))
             or (not switch_on_g_t_off and (sim_ini_clt_date_g_t_switch_on and
            sim_ini_clt_date_l_t_switch_off)));
          currently_on := initially_on;
          if ic_clt_point1.d_of_y == switch_off_clt_d_of_y and ic_clt_point1.
              h_of_d > switch_off_clt_h_of_d then
            assert(ic_clt_point1.h_of_d > switch_off_clt_h_of_d + switch_t_gap,
              "Error in class 'dlight_svngs_t_sw': simulation initial clock time does not exist.");

          end if;
          assert(not switch_on_clt_d_of_y == switch_off_clt_d_of_y,
            "Error in class 'dlight_svngs_t_sw': change-over days are the same.");
          assert(switch_t_gap < 24,
            "Error in class 'dlight_svngs_t_sw': time gap too high. A typical value would be 1 hour.");
          assert(f_of_date.valid_date(div(uf_switch_on_clt_date, 100), rem(
            uf_switch_on_clt_date, 100), 2000),
            "Error in class 'dlight_svngs_t_sw': switch-on day does not exist.");
          assert(f_of_date.valid_date(div(uf_switch_off_clt_date, 100), rem(
            uf_switch_off_clt_date, 100), 2000),
            "Error in class 'dlight_svngs_t_sw': switch-off day does not exist.");
          assert(switch_on_clt_h_of_d >= 0,
            "Error in class 'dlight_svngs_t_sw': switch-on time negative.");
          assert(switch_on_clt_h_of_d < 24,
            "Error in class 'dlight_svngs_t_sw': switch-on time is not less than 24.");
          assert(switch_off_clt_h_of_d >= 0,
            "Error in class 'dlight_svngs_t_sw': switch-off time negative.");
          assert(switch_off_clt_h_of_d < 24,
            "Error in class 'dlight_svngs_t_sw': switch-off time is not less than 24.");
        end if;
      end dlight_svngs_t_sw;

      model t_dir_reader "Daylight savings time directive reader"
        extends icons.specifics.icon_t_dir_reader;
        extends usr_settings.t_dir_inheritable;
        parameter String given_t_dir_name="europe"
          "Daylight savings time directive name from database (\"NoName\"=not registered directive)";
        constant Integer n_of_t_dir=size(t_dir_name, 1);
        Integer sel_t_dir_date_def[2, 3];
        Real sel_t_dir_h_of_d_def[3];
        Integer i;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.2,
            y=0.07,
            width=0.6,
            height=0.6));
      algorithm
        if initial() then
          i := 1;
          if given_t_dir_name <> none then
            while t_dir_name[i] <> given_t_dir_name loop
              i := i + 1;
              assert(i <= n_of_t_dir,
                "Error in class 't_dir_reader': directive name does not exist");
            end while;
          end if;
          sel_t_dir_date_def[:, :] := t_dir_date_def[i, :, :];
          for j in 1:3 loop
            sel_t_dir_h_of_d_def[j] := div(uf_t_dir_h_of_d_def[i, j], 100) +
              rem(uf_t_dir_h_of_d_def[i, j], 100)/60;
          end for;
          assert(size(t_dir_name, 1) == size(t_dir_date_def, 1),
            "Error in class 't_dir_reader': 't_dir_name' should have as many elements as 't_dir_def'");
          assert(size(t_dir_name, 1) == size(uf_t_dir_h_of_d_def, 1),
            "Error in class 't_dir_reader': 't_dir_name' should have as many elements as 'uf_t_dir_h_of_d_def'");
          for i in 1:n_of_t_dir loop
            assert(not (t_dir_date_def[i, 1, 1] == t_dir_date_def[i, 2, 1] and
              t_dir_date_def[i, 1, 2] == t_dir_date_def[i, 2, 2] and
              t_dir_date_def[i, 1, 3] == t_dir_date_def[i, 2, 3]),
              "Error in class 't_dir_reader': change-over days are the same.");
            assert(t_dir_date_def[i, 1, 1] <> 0,
              "Error in class 't_dir_reader': zero value in component 'w_of_m_on' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 2, 1] <> 0,
              "Error in class 't_dir_reader': zero value in component 'w_of_m_off' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 1, 1] < 5,
              "Error in class 't_dir_reader': too high value in component 'w_of_m_on' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 2, 1] < 5,
              "Error in class 't_dir_reader': too high value in component 'w_of_m_off' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 1, 1] > -5,
              "Error in class 't_dir_reader': too low value in component 'w_of_m_on' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 2, 1] > -5,
              "Error in class 't_dir_reader': too low value in component 'w_of_m_off' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 1, 2] >= 1,
              "Error in class 't_dir_reader': too low value in component 'd_of_w_on' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 2, 2] >= 1,
              "Error in class 't_dir_reader': too low value in component 'd_of_w_off' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 1, 2] <= 7,
              "Error in class 't_dir_reader': too high value in component 'd_of_w_on' in variable 't_dir_def'");
            assert(t_dir_date_def[i, 2, 2] <= 7,
              "Error in class 't_dir_reader': too high value in component 'd_of_w_off' in variable 't_dir_def'");
            assert(uf_t_dir_h_of_d_def[i, 3] < 2400,
              "Error in class 't_dir_reader': time gap too high. A typical value would be 1 hour.");
            assert(uf_t_dir_h_of_d_def[i, 1] >= 0,
              "Error in class 't_dir_reader': switch-on time negative.");
            assert(uf_t_dir_h_of_d_def[i, 1] < 2400,
              "Error in class 't_dir_reader': switch-on time is not less than 24.");
            assert(uf_t_dir_h_of_d_def[i, 2] >= 0,
              "Error in class 't_dir_reader': switch-off time negative.");
            assert(uf_t_dir_h_of_d_def[i, 2] < 2400,
              "Error in class 't_dir_reader': switch-off time is not less than 24.");
          end for;
        end if;

          // passing this assert commands does not imply that the time directive definitions are right

          // they can still fail whilst evaluating the function of date 'd_of_m_from_mdate'

      end t_dir_reader;

      package usr_settings
        extends icons.universals.icon_usr_folder;
        annotation (Coordsys(
            extent=[0, 0; 247, 292],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.43,
            y=0.56,
            width=0.25,
            height=0.44,
            library=1,
            autolayout=1));
        model t_dir "Daylight savings time directives definitions"
          extends icons.specifics.icon_t_dir;
          constant Integer t_dir_date_def[:, 2, 3]={{{-1,7,3},{-1,7,10}},{{1,7,
              4},{-1,7,10}}}
            "definition of daylight savings time directives: occurrence order in the month, day of the week, month of the year (for switch on an switch off)";
          constant Integer uf_t_dir_h_of_d_def[:, 3]={{0200,0300,0100},{0200,
              0300,0100}} "switch on time, switch off time, time gap (hhmm)";
          constant String t_dir_name[:]={"europe","usa"} "directive name";
          annotation (Coordsys(
              extent=[-98.5, -98.5; 42, 98.5],
              grid=[0.5, 0.5],
              component=[20, 20]), Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));
        end t_dir;

        model t_dir_inheritable "Daylight savings time directives definitions"
          // extends icons.specifics.icon_t_dir;
          constant Integer t_dir_date_def[:, 2, 3]={{{-1,7,3},{-1,7,10}},{{1,7,
              4},{-1,7,10}}}
            "definition of daylight savings time directives: occurrence order in the month, day of the week, month of the year (for switch on an switch off)";
          constant Integer uf_t_dir_h_of_d_def[:, 3]={{0200,0300,0100},{0200,
              0300,0100}} "switch on time, switch off time, time gap (hhmm)";
          constant String t_dir_name[:]={"europe","usa"} "directive name";
          annotation (Coordsys(
              extent=[-98.5, -98.5; 42, 98.5],
              grid=[0.5, 0.5],
              component=[20, 20]), Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));
        end t_dir_inheritable;
      end usr_settings;

      block daylight_svngs_adder "Adds daylight savings time offset"

        parameter Boolean force_lct=false
          "Force clock time to be local civil time?";
      protected
        Real shifted_slt_h_of_d;
        Real shifted_aslt_h_of_d;
        Real shifted_clt_h_of_d;
        Real shifted_lsmt_h_of_d;
        Integer shifted_slt_d_of_y;
        Integer shifted_aslt_d_of_y;
        Integer shifted_clt_d_of_y;
        Integer shifted_lsmt_d_of_y;
        Integer shifted_slt_y;
        Integer shifted_clt_y;
        Integer shifted_aslt_y;
        Integer shifted_lsmt_y;

      public
        CUTS.oc_t_point oc_clt_point
          annotation (extent=[72, 74; 92, 94], rotation=90);
        CUTS.oc_t_point oc_aslt_point
          annotation (extent=[0, 74; 20, 94], rotation=90);
        CUTS.oc_t_point oc_lsmt_point
          annotation (extent=[48, 74; 68, 94], rotation=90);
        CUTS.ic_t_point ic_slt_point
          annotation (extent=[-74, 76; -54, 96], rotation=90);
        CUTS.ic_t_point ic_clt_point
          annotation (extent=[-28, 76; -8, 96], rotation=90);
        CUTS.ic_t_point ic_lsmt_point
          annotation (extent=[-50, 76; -32, 96], rotation=90);
        CUTS.ic_t_point ic_aslt_point
          annotation (extent=[-96, 76; -76, 96], rotation=90);
        CUTS.InPort ic_dlight_svngs_t_shift(n=2)
          annotation (extent=[-96, 14; -76, 34]);
        CUTS.oc_t_point oc_slt_point
          annotation (extent=[24, 74; 44, 94], rotation=90);
      algorithm

        shifted_clt_h_of_d := ic_clt_point.h_of_d + (if not force_lct then ((
          ic_dlight_svngs_t_shift.signal[1]) - (ic_dlight_svngs_t_shift.signal[
          2])) else 0);

        shifted_slt_h_of_d := ic_slt_point.h_of_d - (if not force_lct then
          ic_dlight_svngs_t_shift.signal[2] else 0);
        shifted_aslt_h_of_d := ic_aslt_point.h_of_d - (if not force_lct then
          ic_dlight_svngs_t_shift.signal[2] else 0);
        shifted_lsmt_h_of_d := ic_lsmt_point.h_of_d - (if not force_lct then
          ic_dlight_svngs_t_shift.signal[1] else 0);

        shifted_slt_d_of_y := ic_slt_point.d_of_y;
        shifted_slt_y := ic_slt_point.y;
        shifted_aslt_d_of_y := ic_aslt_point.d_of_y;
        shifted_aslt_y := ic_aslt_point.y;
        shifted_clt_d_of_y := ic_clt_point.d_of_y;
        shifted_clt_y := ic_clt_point.y;
        shifted_lsmt_d_of_y := ic_lsmt_point.d_of_y;
        shifted_lsmt_y := ic_lsmt_point.y;

        if shifted_slt_h_of_d < 0 then
          shifted_slt_h_of_d := shifted_slt_h_of_d + 24;
          (shifted_slt_d_of_y,shifted_slt_y) := f_of_date.dec_jdate(
            ic_slt_point.d_of_y, ic_slt_point.y);
        end if;

        if shifted_slt_h_of_d >= 24 then
          shifted_slt_h_of_d := shifted_slt_h_of_d - 24;
          (shifted_slt_d_of_y,shifted_slt_y) := f_of_date.inc_jdate(
            ic_slt_point.d_of_y, ic_slt_point.y);
        end if;

        if shifted_aslt_h_of_d < 0 then
          shifted_aslt_h_of_d := shifted_aslt_h_of_d + 24;
          (shifted_aslt_d_of_y,shifted_aslt_y) := f_of_date.dec_jdate(
            ic_aslt_point.d_of_y, ic_aslt_point.y);
        end if;

        if shifted_aslt_h_of_d >= 24 then
          shifted_aslt_h_of_d := shifted_aslt_h_of_d - 24;
          (shifted_aslt_d_of_y,shifted_aslt_y) := f_of_date.inc_jdate(
            ic_aslt_point.d_of_y, ic_aslt_point.y);
        end if;

        if shifted_clt_h_of_d < 0 then
          shifted_clt_h_of_d := shifted_clt_h_of_d + 24;
          (shifted_clt_d_of_y,shifted_clt_y) := f_of_date.dec_jdate(
            ic_clt_point.d_of_y, ic_clt_point.y);
        end if;

        if shifted_clt_h_of_d >= 24 then
          shifted_clt_h_of_d := shifted_clt_h_of_d - 24;
          (shifted_clt_d_of_y,shifted_clt_y) := f_of_date.inc_jdate(
            ic_clt_point.d_of_y, ic_clt_point.y);
        end if;

        if shifted_lsmt_h_of_d < 0 then
          shifted_lsmt_h_of_d := shifted_lsmt_h_of_d + 24;
          (shifted_lsmt_d_of_y,shifted_lsmt_y) := f_of_date.dec_jdate(
            ic_lsmt_point.d_of_y, ic_lsmt_point.y);
        end if;

        if shifted_lsmt_h_of_d >= 24 then
          shifted_lsmt_h_of_d := shifted_lsmt_h_of_d - 24;
          (shifted_lsmt_d_of_y,shifted_lsmt_y) := f_of_date.inc_jdate(
            ic_lsmt_point.d_of_y, ic_lsmt_point.y);
        end if;

        oc_slt_point.h_of_d := shifted_slt_h_of_d;
        oc_slt_point.d_of_y := shifted_slt_d_of_y;
        oc_slt_point.y := shifted_slt_y;
        oc_aslt_point.h_of_d := shifted_aslt_h_of_d;
        oc_aslt_point.d_of_y := shifted_aslt_d_of_y;
        oc_aslt_point.y := shifted_aslt_y;
        oc_clt_point.h_of_d := shifted_clt_h_of_d;
        oc_clt_point.d_of_y := shifted_clt_d_of_y;
        oc_clt_point.y := shifted_clt_y;
        oc_lsmt_point.h_of_d := shifted_lsmt_h_of_d;
        oc_lsmt_point.d_of_y := shifted_lsmt_d_of_y;
        oc_lsmt_point.y := shifted_lsmt_y;

        annotation (Diagram, Icon(
            Rectangle(extent=[-96, 74; 102, -98], style(gradient=1, fillColor=
                    62)),
            Line(points=[-72, 40; 48, 40; 48, 60; 82, 20; 48, -20; 48, 0; -36,
                  0; -72, 0; -72, 40], style(color=6, thickness=2)),
            Text(extent=[-34, -72; 86, -92], string="daylight_svngs_adder"),
            Line(points=[82, -20; -38, -20; -38, 0; -72, -40; -38, -80; -38, -60;
                   -38, -60; 82, -60; 82, -20], style(
                color=6,
                thickness=2,
                fillPattern=1)),
            Text(
              extent=[-56, 34; 58, 0],
              style(fillPattern=1),
              string="+1h "),
            Text(
              extent=[-52, -24; 62, -58],
              style(fillPattern=1),
              string="-1h ")));
      end daylight_svngs_adder;
    end dlight_svngs;

    package t_and_date
      extends icons.universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 577, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.43,
          y=0.56,
          width=0.57,
          height=0.44,
          library=1,
          autolayout=1));
      class sim_ini_clt_h_of_d "Simulation initial clock hour of day"

        // extends icons.specifics.icon_sim_ini_clt_h_of_d;
        parameter Integer uf_sim_ini_clt_h_of_d=000000
          "Simulation initial clock time (hhmmss)";

        parameter Real sim_ini_clt_h_of_d=div(uf_sim_ini_clt_h_of_d, 10000) +
            div(rem(uf_sim_ini_clt_h_of_d, 10000), 100)/60 + rem(
            uf_sim_ini_clt_h_of_d, 100)/3600 "(hours)";
        annotation (Coordsys(
            extent=[-95, 32; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.19,
            y=0.19,
            width=0.6,
            height=0.6));
      equation
        if initial() then
          assert(sim_ini_clt_h_of_d >= 0,
            "Error in class 'sim_ini_clt_h_of_d': negative simulation initial clock TIME.");
          assert(sim_ini_clt_h_of_d < 24,
            "Error in class 'sim_ini_clt_h_of_d': simulation initial clock time is not less than 24.");
        end if;
      end sim_ini_clt_h_of_d;

      class ini_h_of_d "Initial hour of day"
        //extends icons.specifics.icon_ini_h_of_d;
        parameter Integer uf_ini_h_of_d=000000 "Initial time (hhmmss)";

        parameter Real ini_h_of_d=div(uf_ini_h_of_d, 10000) + div(rem(
            uf_ini_h_of_d, 10000), 100)/60 + rem(uf_ini_h_of_d, 100)/3600 "(hours)";
        annotation (Coordsys(
            extent=[-95, 32; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.19,
            y=0.19,
            width=0.6,
            height=0.6));
      equation
        if initial() then
          assert(ini_h_of_d >= 0,
            "Error in class 'ini_h_of_d': negative initial TIME.");
          assert(ini_h_of_d < 24,
            "Error in class 'ini_h_of_d': initial time is not less than 24.");
        end if;
      end ini_h_of_d;

      class fin_h_of_d "Final hour of day"
        // extends icons.specifics.icon_fin_h_of_d;
        parameter Integer uf_fin_h_of_d=000000 "Final time (hhmmss)";

        parameter Real fin_h_of_d=div(uf_fin_h_of_d, 10000) + div(rem(
            uf_fin_h_of_d, 10000), 100)/60 + rem(uf_fin_h_of_d, 100)/3600 "(hours)";
        annotation (Coordsys(
            extent=[-95, 32; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.33,
            y=0.36,
            width=0.6,
            height=0.6));
      equation
        if initial() then
          assert(fin_h_of_d >= 0,
            "Error in class 'fin_h_of_d': negative final TIME.");
          assert(fin_h_of_d < 24,
            "Error in class 'fin_h_of_d': final time is not less than 24.");
        end if;
      end fin_h_of_d;

      class ini_and_fin_h_of_d "Initial and final hour of day"
        // extends icons.specifics.icon_ini_and_fin_h_of_d;
        extends ini_h_of_d;
        extends fin_h_of_d;

        parameter Real period_length=if ini_h_of_d <> fin_h_of_d then abs(
            ini_h_of_d - fin_h_of_d)*60*60 else 24*60*60;
        annotation (Coordsys(
            extent=[-95, 20.6; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end ini_and_fin_h_of_d;

      class sim_ini_clt_h_of_d_and_date
        "Simulation initial clock hour of day and date"
        // extends icons.specifics.icon_sim_ini_clt_h_of_d_and_date;
        parameter Integer uf_sim_ini_clt_date=01012001
          "Simulaton initial clock date (ddmmyyyy or jjjyy)";
        extends sim_ini_clt_h_of_d;

        parameter Boolean jjjyy_format=uf_sim_ini_clt_date <= 99999;
        parameter Integer sim_ini_clt_y=if not jjjyy_format then rem(
            uf_sim_ini_clt_date, 10000) else rem(uf_sim_ini_clt_date, 100) + (
            if rem(uf_sim_ini_clt_date, 100) >= 30 then 1900 else 2000);
        parameter Integer sim_ini_clt_d_of_m=if not jjjyy_format then div(
            uf_sim_ini_clt_date, 1000000) else f_of_date.d_of_m_from_jdate(div(
            uf_sim_ini_clt_date, 100), sim_ini_clt_y);
        parameter Integer sim_ini_clt_m_of_y=if not jjjyy_format then div(rem(
            uf_sim_ini_clt_date, 1000000), 10000) else
            f_of_date.m_of_y_from_jdate(div(uf_sim_ini_clt_date, 100),
            sim_ini_clt_y);
        parameter Integer sim_ini_clt_d_of_y=if not jjjyy_format then
            f_of_date.d_of_y_from_date(sim_ini_clt_d_of_m, sim_ini_clt_m_of_y,
            sim_ini_clt_y) else div(uf_sim_ini_clt_date, 100);
        parameter Integer sim_ini_clt_d_of_w=f_of_date.d_of_w_from_date(
            sim_ini_clt_d_of_m, sim_ini_clt_m_of_y, sim_ini_clt_y);
        annotation (Coordsys(
            extent=[-98, -88; 116, 99],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.03,
            y=0.06,
            width=0.79,
            height=0.6));
      algorithm
        if initial() then
          assert(uf_sim_ini_clt_date >= 0,
            "Error in class 'sim_ini_clt_h_of_d_and_date': simulation initial clock date negative.");
          assert(not (uf_sim_ini_clt_date > 99999 and uf_sim_ini_clt_date <
            01010000),
            "Error in class 'sim_ini_clt_h_of_d_and_date': undefined format of simulation initial clock date. Only ddmmyyyy and jjjyy are valid formats.");
          assert(uf_sim_ini_clt_date >= 0100,
            "Error in class 'sim_ini_clt_h_of_d_and_date': too few digits for simulation initial clock date. Only ddmmyyyy and jjjyy are valid formats.");
          assert(not (jjjyy_format and not f_of_date.valid_date(
            sim_ini_clt_d_of_m, sim_ini_clt_m_of_y, sim_ini_clt_y)),
            "Error in class 'sim_ini_clt_h_of_d_and_date': simulation initial clock date (given in jjjyy format) does not exist.");
          assert(not (not jjjyy_format and not f_of_date.valid_date(
            sim_ini_clt_d_of_m, sim_ini_clt_m_of_y, sim_ini_clt_y)),
            "Error in class 'sim_ini_clt_h_of_d_and_date': simulation initial clock date (given in ddmmyyyy format) does not exist.");
        end if;
      end sim_ini_clt_h_of_d_and_date;

      class ini_h_of_d_and_date "Initial hour of day and date"
        //extends icons.specifics.icon_ini_h_of_d_and_date;
        parameter Integer uf_ini_date=01012001
          "Initial date (ddmmyyyy or jjjyy)";
        extends ini_h_of_d;

        parameter Boolean ini_jjjyy_format=uf_ini_date <= 99999;
        parameter Integer ini_y=if not ini_jjjyy_format then rem(uf_ini_date,
            10000) else rem(uf_ini_date, 100) + (if rem(uf_ini_date, 100) >= 30 then
                  1900 else 2000);
        parameter Integer ini_d_of_m=if not ini_jjjyy_format then div(
            uf_ini_date, 1000000) else f_of_date.d_of_m_from_jdate(div(
            uf_ini_date, 100), ini_y);
        parameter Integer ini_m_of_y=if not ini_jjjyy_format then div(rem(
            uf_ini_date, 1000000), 10000) else f_of_date.m_of_y_from_jdate(div(
            uf_ini_date, 100), ini_y);
        parameter Integer ini_d_of_y=if not ini_jjjyy_format then
            f_of_date.d_of_y_from_date(ini_d_of_m, ini_m_of_y, ini_y) else div(
            uf_ini_date, 100);
        parameter Integer ini_d_of_w=f_of_date.d_of_w_from_date(ini_d_of_m,
            ini_m_of_y, ini_y);
        annotation (Coordsys(
            extent=[-98, -88; 116, 99],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.22,
            y=0.29,
            width=0.6,
            height=0.6));
      algorithm
        if initial() then
          assert(uf_ini_date >= 0,
            "Error in class 'ini_h_of_d_and_date': initial date negative.");
          assert(not (uf_ini_date > 99999 and uf_ini_date < 01010000),
            "Error in class 'ini_h_of_d_and_date': undefined format of initial date. Only ddmmyyyy and jjjyy are valid formats.");
          assert(uf_ini_date >= 0100,
            "Error in class 'ini_h_of_d_and_date': too few digits for initial date. Only ddmmyyyy and jjjyy are valid formats.");
          assert(not (ini_jjjyy_format and not f_of_date.valid_date(ini_d_of_m,
             ini_m_of_y, ini_y)),
            "Error in class 'ini_h_of_d_and_date': initial date (given in jjjyy format) does not exist.");
          assert(not (not ini_jjjyy_format and not f_of_date.valid_date(
            ini_d_of_m, ini_m_of_y, ini_y)),
            "Error in class 'ini_h_of_d_and_date': initial date (given in ddmmyyyy format) does not exist.");
        end if;
      end ini_h_of_d_and_date;

      class fin_h_of_d_and_date "Final hour of day and date"
        // extends icons.specifics.icon_fin_h_of_d_and_date;
        parameter Integer uf_fin_date=01012002 "Final date (ddmmyyyy or jjjyy)";
        extends fin_h_of_d;

        parameter Boolean fin_jjjyy_format=uf_fin_date <= 99999;
        parameter Integer fin_y=if not fin_jjjyy_format then rem(uf_fin_date,
            10000) else rem(uf_fin_date, 100) + (if rem(uf_fin_date, 100) >= 30 then
                  1900 else 2000);
        parameter Integer fin_d_of_m=if not fin_jjjyy_format then div(
            uf_fin_date, 1000000) else f_of_date.d_of_m_from_jdate(div(
            uf_fin_date, 100), fin_y);
        parameter Integer fin_m_of_y=if not fin_jjjyy_format then div(rem(
            uf_fin_date, 1000000), 10000) else f_of_date.m_of_y_from_jdate(div(
            uf_fin_date, 100), fin_y);
        parameter Integer fin_d_of_y=if not fin_jjjyy_format then
            f_of_date.d_of_y_from_date(fin_d_of_m, fin_m_of_y, fin_y) else div(
            uf_fin_date, 100);
        parameter Integer fin_d_of_w=f_of_date.d_of_w_from_date(fin_d_of_m,
            fin_m_of_y, fin_y);
        annotation (Coordsys(
            extent=[-98, -88; 116, 99],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.34,
            y=0.36,
            width=0.6,
            height=0.6));
      algorithm
        if initial() then
          assert(uf_fin_date >= 0,
            "Error in class 'fin_h_of_d_and_date': final date negative.");
          assert(not (uf_fin_date > 99999 and uf_fin_date < 01010000),
            "Error in class 'fin_h_of_d_and_date': undefined format of final date. Only ddmmyyyy and jjjyy are valid formats.");
          assert(uf_fin_date >= 0100,
            "Error in class 'fin_h_of_d_and_date': too few digits for final date. Only ddmmyyyy and jjjyy are valid formats.");
          assert(not (fin_jjjyy_format and not f_of_date.valid_date(fin_d_of_m,
             fin_m_of_y, fin_y)),
            "Error in class 'fin_h_of_d_and_date': final date (given in jjjyy format) does not exist.");
          assert(not (not fin_jjjyy_format and not f_of_date.valid_date(
            fin_d_of_m, fin_m_of_y, fin_y)),
            "Error in class 'fin_h_of_d_and_date': final date (given in ddmmyyyy format) does not exist.");
        end if;
      end fin_h_of_d_and_date;

      class ini_and_fin_h_of_d_and_date
        "Initial and final hour of day and date"
        // extends icons.specifics.icon_ini_and_fin_h_of_d_and_date;
        extends ini_h_of_d_and_date;
        extends fin_h_of_d_and_date;

        parameter Real period_length=f_of_date.date_1_m_date_2(fin_d_of_m,
            fin_m_of_y, fin_y, ini_d_of_m, ini_m_of_y, ini_y)*24*60*60 + (
            fin_h_of_d - ini_h_of_d)*60*60 "(seconds)";
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      equation
        if initial() then
          assert(not f_of_date.date_1_g_t_date_2(ini_d_of_m, ini_m_of_y, ini_y,
             fin_d_of_m, fin_m_of_y, fin_y),
            "Error in class 'ini_and_fin_h_of_d_and_date: initial date is later than final date.");
          assert(not (f_of_date.date_1_e_date_2(ini_d_of_m, ini_m_of_y, ini_y,
            fin_d_of_m, fin_m_of_y, fin_y) and ini_h_of_d > fin_h_of_d),
            "Error in class 'ini_and_fin_h_of_d_and_date: initial time is later than final time on the same day.");
        end if;
      end ini_and_fin_h_of_d_and_date;

    end t_and_date;

    package f_of_date
      extends icons.universals.icon_folder;
      function valid_date
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_m;
        input Integer m_of_y;
        input Integer y;
        output Boolean valid_date;
      algorithm
        valid_date := (m_of_y >= 1 and m_of_y <= 12) and (d_of_m >= 1 and
          d_of_m <= max_d_of_m(m_of_y, y));
      end valid_date;

      function valid_jdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y;
        input Integer y;
        output Boolean valid_jdate;
      algorithm
        valid_jdate := (d_of_y >= 1 and d_of_y <= max_d_of_y(y));
      end valid_jdate;

      function leap_y
        extends icons.specifics.icon_f_of_date;
        input Integer y;
        output Boolean leap_y;
      protected
        Boolean divisible_by_4;
        Boolean divisible_by_100;
        Boolean divisible_by_400;
      equation
        // All equations and assignment statements within when
        // clauses and all assignment statements within function
        // classes are implicitly treated with the noEvent function,
        // i.e., relations within the scope of these operators never
        // induce state or time events.

      algorithm
        divisible_by_4 := (rem(y, 4) == 0);
        divisible_by_100 := (rem(y, 100) == 0);
        divisible_by_400 := (rem(y, 400) == 0);
        // remember: orbital period of Earth = 365.2425 d
        leap_y := divisible_by_4 and (not divisible_by_100 or divisible_by_400);
      end leap_y;

      function inc_jdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer y_i;
        output Integer d_of_y_o;
        output Integer y_o;
      algorithm
        if d_of_y_i == max_d_of_y(y_i) then
          d_of_y_o := 1;
          y_o := y_i + 1;
        else
          d_of_y_o := d_of_y_i + 1;
          y_o := y_i;
        end if;
      end inc_jdate;

      function dec_jdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer y_i;
        output Integer d_of_y_o;
        output Integer y_o;
      algorithm
        if d_of_y_i == 1 then
          d_of_y_o := max_d_of_y(y_i - 1);
          y_o := y_i - 1;
        else
          d_of_y_o := d_of_y_i - 1;
          y_o := y_i;
        end if;
      end dec_jdate;

      function inc_wdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer d_of_w_i;
        input Integer d_of_m_i;
        input Integer m_of_y_i;
        input Integer y_i;
        output Integer d_of_y_o;
        output Integer d_of_w_o;
        output Integer d_of_m_o;
        output Integer m_of_y_o;
        output Integer y_o;
      algorithm
        d_of_y_o := inc_d_of_y(d_of_y_i, y_i);
        y_o := y_i;
        m_of_y_o := m_of_y_i;
        d_of_m_o := d_of_m_i + 1;
        if (d_of_m_o > max_d_of_m(m_of_y_i, y_i)) then
          d_of_m_o := 1;
          m_of_y_o := m_of_y_o + 1;
          if m_of_y_o > 12 then
            m_of_y_o := 1;
            y_o := y_o + 1;
          end if;
        end if;
        d_of_w_o := rem(d_of_w_i + 1 - 1, 7) + 1;
      end inc_wdate;

      function dec_wdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer d_of_w_i;
        input Integer d_of_m_i;
        input Integer m_of_y_i;
        input Integer y_i;
        output Integer d_of_y_o;
        output Integer d_of_w_o;
        output Integer d_of_m_o;
        output Integer m_of_y_o;
        output Integer y_o;
      algorithm
        d_of_y_o := dec_d_of_y(d_of_y_i, y_i);
        y_o := y_i;
        m_of_y_o := m_of_y_i;
        d_of_m_o := d_of_m_i - 1;
        if (d_of_m_o < 1) then
          m_of_y_o := m_of_y_o - 1;
          if m_of_y_o < 1 then
            m_of_y_o := 12;
            y_o := y_o - 1;
          end if;
          d_of_m_o := max_d_of_m(m_of_y_o, y_o);
        end if;
        d_of_w_o := rem(d_of_w_i - 1 + 7 - 1, 7) + 1;
      end dec_wdate;

      function inc_sdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_w_i;
        input Integer d_of_m_i;
        input Integer m_of_y_i;
        input Integer y_i;
        output Integer d_of_w_o;
        output Integer d_of_m_o;
        output Integer m_of_y_o;
      algorithm
        m_of_y_o := m_of_y_i;
        d_of_m_o := d_of_m_i + 1;
        if (d_of_m_o > max_d_of_m(m_of_y_i, y_i)) then
          d_of_m_o := 1;
          m_of_y_o := m_of_y_o + 1;
          if m_of_y_o > 12 then
            m_of_y_o := 1;
          end if;
        end if;
        d_of_w_o := inc_d_of_w(d_of_w_i);
      end inc_sdate;

      function inc_d_of_w
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_w_i;
        output Integer d_of_w_o;
      algorithm
        d_of_w_o := rem(d_of_w_i + 1 - 1, 7) + 1;
      end inc_d_of_w;

      function inc_d_of_y
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer y_i;
        output Integer d_of_y_o;
      algorithm
        if d_of_y_i == max_d_of_y(y_i) then
          d_of_y_o := 1;
        else
          d_of_y_o := d_of_y_i + 1;
        end if;
      end inc_d_of_y;

      function dec_d_of_y
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer y_i;
        output Integer d_of_y_o;
      algorithm
        if d_of_y_i == 1 then
          d_of_y_o := max_d_of_y(y_i - 1);
        else
          d_of_y_o := d_of_y_i - 1;
        end if;
      end dec_d_of_y;

      function d_of_w_from_date
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_m;
        input Integer m_of_y;
        input Integer y;
        output Integer d_of_w;
      protected
        Integer d_of_y;
      algorithm
        d_of_y := d_of_y_from_date(d_of_m, m_of_y, y);
        d_of_w := d_of_w_from_jdate(d_of_y, y);
      end d_of_w_from_date;

      function d_of_w_from_jdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y;
        input Integer y;
        output Integer d_of_w;
      protected
        Integer ini_d_of_m=9;
        Integer ini_m_of_y=9;
        Integer ini_y=2001;
        Integer ini_d_of_y=d_of_y_from_date(ini_d_of_m, ini_m_of_y, ini_y);
        Integer ini_d_of_w=7;
        Integer dif;
      algorithm
        dif := jdate_1_m_jdate_2(d_of_y, y, ini_d_of_y, ini_y);
        d_of_w := rem((rem(ini_d_of_w + dif - 1, 7) + 1) + 7 - 1, 7) + 1;

          // as on Sept. 9, 2001 I was working at my laptop writing this function and it was Sunday.
      end d_of_w_from_jdate;

      function d_of_y_from_date
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_m;
        input Integer m_of_y;
        input Integer y;
        output Integer d_of_y;
      protected
        Integer i;
      algorithm
        d_of_y := 0;
        i := 1;
        while i <= m_of_y - 1 and i <= 12 loop
          d_of_y := d_of_y + max_d_of_m(i, y);
          i := i + 1;
        end while;
        d_of_y := d_of_y + d_of_m;
      end d_of_y_from_date;

      function d_of_m_from_jdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer y_i;
        output Integer d_of_m_o;
      protected
        Integer m_of_y;
        Integer max;
      algorithm
        d_of_m_o := d_of_y_i;
        m_of_y := 1;
        max := max_d_of_m(m_of_y, y_i);
        while d_of_m_o > max and m_of_y < 12 loop
          d_of_m_o := d_of_m_o - max;
          m_of_y := m_of_y + 1;
          max := max_d_of_m(m_of_y, y_i);
        end while;
      end d_of_m_from_jdate;

      function m_of_y_from_jdate
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_i;
        input Integer y_i;
        output Integer m_of_y_o;
      protected
        Integer d_of_m;
        Integer max;
      algorithm
        d_of_m := d_of_y_i;
        m_of_y_o := 1;
        max := max_d_of_m(m_of_y_o, y_i);
        while d_of_m > max and m_of_y_o < 12 loop
          d_of_m := d_of_m - max;
          m_of_y_o := m_of_y_o + 1;
          max := max_d_of_m(m_of_y_o, y_i);
        end while;
      end m_of_y_from_jdate;

      function d_of_m_from_mdate
        extends icons.specifics.icon_f_of_date;
        input Integer w_of_m_i;
        input Integer d_of_w_i;
        input Integer m_of_y_i;
        input Integer y_i;
        output Integer d_of_m_o;
      protected
        Integer ini_search_d_of_m;
        Integer ini_search_d_of_w;
      algorithm
        assert(w_of_m_i < 5,
          "Error in class 'd_of_m_from_mdate': function was called with a too high value of argument 'w_of_m'");
        assert(w_of_m_i > -5,
          "Error in class 'd_of_m_from_mdate': function was called with a too low value of argument 'w_of_m'");
        if w_of_m_i > 0 then
          ini_search_d_of_m := 1;
          ini_search_d_of_w := d_of_w_from_date(ini_search_d_of_m, m_of_y_i,
            y_i);
          d_of_m_o := ini_search_d_of_m + 7*(w_of_m_i - 1) + (d_of_w_i -
            ini_search_d_of_w);
          if d_of_m_o < ini_search_d_of_m then
            d_of_m_o := d_of_m_o + 7;
          end if;
          assert(d_of_m_o <= max_d_of_m(m_of_y_i, y_i),
            "Error in class 'd_of_m_from_mdate': function was called with a too high value of argument 'w_of_m' for the given month and year");
        elseif w_of_m_i < 0 then
          ini_search_d_of_m := max_d_of_m(m_of_y_i, y_i);
          ini_search_d_of_w := d_of_w_from_date(ini_search_d_of_m, m_of_y_i,
            y_i);
          d_of_m_o := ini_search_d_of_m + 7*(w_of_m_i + 1) + (d_of_w_i -
            ini_search_d_of_w);
          if d_of_m_o > ini_search_d_of_m then
            d_of_m_o := d_of_m_o - 7;
          end if;
          assert(d_of_m_o >= 1,
            "Error in class 'd_of_m_from_mdate': function was called with a too low value of argument 'w_of_m' for the given month and year");
        else
          terminate(
            "Error in class 'd_of_m_from_mdate': function was called with a zero value of argument 'w_of_m'");
        end if;
      end d_of_m_from_mdate;

      function d_of_y_from_mdate
        extends icons.specifics.icon_f_of_date;
        input Integer w_of_m_i;
        input Integer d_of_w_i;
        input Integer m_of_y_i;
        input Integer y_i;
        output Integer d_of_y_o;
      algorithm
        d_of_y_o := d_of_y_from_date(d_of_m_from_mdate(w_of_m_i, d_of_w_i,
          m_of_y_i, y_i), m_of_y_i, y_i);
      end d_of_y_from_mdate;

      function max_d_of_m
        extends icons.specifics.icon_f_of_date;
        input Integer m_of_y;
        input Integer y;
        output Integer n_of_d_of_m;
      algorithm
        n_of_d_of_m := if m_of_y == 1 then 31 else if m_of_y == 2 then if
          leap_y(y) then 29 else 28 else if m_of_y == 3 then 31 else if m_of_y
           == 4 then 30 else if m_of_y == 5 then 31 else if m_of_y == 6 then 30 else
                if m_of_y == 7 then 31 else if m_of_y == 8 then 31 else if
          m_of_y == 9 then 30 else if m_of_y == 10 then 31 else if m_of_y == 11 then
                30 else if m_of_y == 12 then 31 else if m_of_y < 1 then -1 else
                1;
      end max_d_of_m;

      function max_d_of_y
        extends icons.specifics.icon_f_of_date;
        input Integer y;
        output Integer n_of_d_of_y;
      algorithm
        n_of_d_of_y := if leap_y(y) then 366 else 365;
      end max_d_of_y;

      function date_1_l_t_date_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_m_1;
        input Integer m_of_y_1;
        input Integer y_1;
        input Integer d_of_m_2;
        input Integer m_of_y_2;
        input Integer y_2;
        output Boolean comp_result;
      algorithm
        comp_result := (y_1 < y_2 or (y_1 == y_2 and m_of_y_1 < m_of_y_2) or (
          y_1 == y_2 and m_of_y_1 == m_of_y_2 and d_of_m_1 < d_of_m_2));
      end date_1_l_t_date_2;

      function jdate_1_l_t_jdate_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_1;
        input Integer y_1;
        input Integer d_of_y_2;
        input Integer y_2;
        output Boolean comp_result;
      algorithm
        comp_result := (y_1 < y_2 or (y_1 == y_2 and d_of_y_1 < d_of_y_2));
      end jdate_1_l_t_jdate_2;

      function date_1_e_date_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_m_1;
        input Integer m_of_y_1;
        input Integer y_1;
        input Integer d_of_m_2;
        input Integer m_of_y_2;
        input Integer y_2;
        output Boolean comp_result;
      algorithm
        comp_result := (y_1 == y_2 and m_of_y_1 == m_of_y_2 and d_of_m_1 ==
          d_of_m_2);
      end date_1_e_date_2;

      function jdate_1_e_jdate_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_1;
        input Integer y_1;
        input Integer d_of_y_2;
        input Integer y_2;
        output Boolean comp_result;
      algorithm
        comp_result := (y_1 == y_2 and d_of_y_1 == d_of_y_2);
      end jdate_1_e_jdate_2;

      function date_1_g_t_date_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_m_1;
        input Integer m_of_y_1;
        input Integer y_1;
        input Integer d_of_m_2;
        input Integer m_of_y_2;
        input Integer y_2;
        output Boolean comp_result;
      algorithm
        comp_result := (y_1 > y_2 or (y_1 == y_2 and m_of_y_1 > m_of_y_2) or (
          y_1 == y_2 and m_of_y_1 == m_of_y_2 and d_of_m_1 > d_of_m_2));
      end date_1_g_t_date_2;

      function jdate_1_g_t_jdate_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_1;
        input Integer y_1;
        input Integer d_of_y_2;
        input Integer y_2;
        output Boolean comp_result;
      algorithm
        comp_result := (y_1 > y_2 or (y_1 == y_2 and d_of_y_1 > d_of_y_2));
      end jdate_1_g_t_jdate_2;

      function date_1_m_date_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_m_1;
        input Integer m_of_y_1;
        input Integer y_1;
        input Integer d_of_m_2;
        input Integer m_of_y_2;
        input Integer y_2;
        output Integer n_of_d;
      protected
        Integer d_of_y_1;
        Integer d_of_y_2;
      algorithm
        n_of_d := 0;
        d_of_y_1 := d_of_y_from_date(d_of_m_1, m_of_y_1, y_1);
        d_of_y_2 := d_of_y_from_date(d_of_m_2, m_of_y_2, y_2);
        n_of_d := jdate_1_m_jdate_2(d_of_y_1, y_1, d_of_y_2, y_2);
      end date_1_m_date_2;

      function jdate_1_m_jdate_2
        extends icons.specifics.icon_f_of_date;
        input Integer d_of_y_1;
        input Integer y_1;
        input Integer d_of_y_2;
        input Integer y_2;
        output Integer n_of_d;
      algorithm
        n_of_d := 0;
        n_of_d := d_of_y_1 - d_of_y_2;
        if y_1 > y_2 then
          for i in y_2:(y_1 - 1) loop
            n_of_d := n_of_d + max_d_of_y(i);
          end for;
        elseif y_1 < y_2 then
          for i in y_1:(y_2 - 1) loop
            n_of_d := n_of_d - max_d_of_y(i);
          end for;
        end if;
      end jdate_1_m_jdate_2;

      function d_of_w_in_v
        extends icons.specifics.icon_f_of_date;
        input Integer value;
        input Integer[:] v;
        output Boolean included;
      protected
        Integer i;
      algorithm
        included := false;
        i := 0;
        while not included and i < size(v, 1) loop
          i := i + 1;
          included := v[i] == value;
        end while;
      end d_of_w_in_v;
      annotation (Coordsys(
          extent=[0, 0; 850, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.16,
          y=0.56,
          width=0.84,
          height=0.44,
          library=1,
          autolayout=1));
    end f_of_date;

    block daylight_svngs_adder "Adds daylight savings time offset"

      parameter Boolean force_lct=false
        "Force clock time to be local civil time?";
    protected
      Real shifted_slt_h_of_d;
      Real shifted_aslt_h_of_d;
      Real shifted_clt_h_of_d;
      Real shifted_lsmt_h_of_d;
      Integer shifted_slt_d_of_y;
      Integer shifted_aslt_d_of_y;
      Integer shifted_clt_d_of_y;
      Integer shifted_lsmt_d_of_y;
      Integer shifted_slt_y;
      Integer shifted_clt_y;
      Integer shifted_aslt_y;
      Integer shifted_lsmt_y;

    public
      CUTS.oc_t_point oc_clt_point
        annotation (extent=[72, 74; 92, 94], rotation=90);
      CUTS.oc_t_point oc_aslt_point
        annotation (extent=[0, 74; 20, 94], rotation=90);
      CUTS.oc_t_point oc_lsmt_point
        annotation (extent=[48, 74; 68, 94], rotation=90);
      CUTS.ic_t_point ic_slt_point
        annotation (extent=[-74, 76; -54, 96], rotation=90);
      CUTS.ic_t_point ic_clt_point
        annotation (extent=[-28, 76; -8, 96], rotation=90);
      CUTS.ic_t_point ic_lsmt_point
        annotation (extent=[-50, 76; -32, 96], rotation=90);
      CUTS.ic_t_point ic_aslt_point
        annotation (extent=[-96, 76; -76, 96], rotation=90);
      CUTS.InPort ic_dlight_svngs_t_shift(n=2)
        annotation (extent=[-96, 14; -76, 34]);
      CUTS.oc_t_point oc_slt_point
        annotation (extent=[24, 74; 44, 94], rotation=90);
    algorithm

      shifted_clt_h_of_d := ic_clt_point.h_of_d + (if not force_lct then ((
        ic_dlight_svngs_t_shift.signal[1]) - (ic_dlight_svngs_t_shift.signal[2])) else
              0);

      shifted_slt_h_of_d := ic_slt_point.h_of_d - (if not force_lct then
        ic_dlight_svngs_t_shift.signal[2] else 0);
      shifted_aslt_h_of_d := ic_aslt_point.h_of_d - (if not force_lct then
        ic_dlight_svngs_t_shift.signal[2] else 0);
      shifted_lsmt_h_of_d := ic_lsmt_point.h_of_d - (if not force_lct then
        ic_dlight_svngs_t_shift.signal[1] else 0);

      shifted_slt_d_of_y := ic_slt_point.d_of_y;
      shifted_slt_y := ic_slt_point.y;
      shifted_aslt_d_of_y := ic_aslt_point.d_of_y;
      shifted_aslt_y := ic_aslt_point.y;
      shifted_clt_d_of_y := ic_clt_point.d_of_y;
      shifted_clt_y := ic_clt_point.y;
      shifted_lsmt_d_of_y := ic_lsmt_point.d_of_y;
      shifted_lsmt_y := ic_lsmt_point.y;

      if shifted_slt_h_of_d < 0 then
        shifted_slt_h_of_d := shifted_slt_h_of_d + 24;
        (shifted_slt_d_of_y,shifted_slt_y) := f_of_date.dec_jdate(ic_slt_point.
          d_of_y, ic_slt_point.y);
      end if;

      if shifted_slt_h_of_d >= 24 then
        shifted_slt_h_of_d := shifted_slt_h_of_d - 24;
        (shifted_slt_d_of_y,shifted_slt_y) := f_of_date.inc_jdate(ic_slt_point.
          d_of_y, ic_slt_point.y);
      end if;

      if shifted_aslt_h_of_d < 0 then
        shifted_aslt_h_of_d := shifted_aslt_h_of_d + 24;
        (shifted_aslt_d_of_y,shifted_aslt_y) := f_of_date.dec_jdate(
          ic_aslt_point.d_of_y, ic_aslt_point.y);
      end if;

      if shifted_aslt_h_of_d >= 24 then
        shifted_aslt_h_of_d := shifted_aslt_h_of_d - 24;
        (shifted_aslt_d_of_y,shifted_aslt_y) := f_of_date.inc_jdate(
          ic_aslt_point.d_of_y, ic_aslt_point.y);
      end if;

      if shifted_clt_h_of_d < 0 then
        shifted_clt_h_of_d := shifted_clt_h_of_d + 24;
        (shifted_clt_d_of_y,shifted_clt_y) := f_of_date.dec_jdate(ic_clt_point.
          d_of_y, ic_clt_point.y);
      end if;

      if shifted_clt_h_of_d >= 24 then
        shifted_clt_h_of_d := shifted_clt_h_of_d - 24;
        (shifted_clt_d_of_y,shifted_clt_y) := f_of_date.inc_jdate(ic_clt_point.
          d_of_y, ic_clt_point.y);
      end if;

      if shifted_lsmt_h_of_d < 0 then
        shifted_lsmt_h_of_d := shifted_lsmt_h_of_d + 24;
        (shifted_lsmt_d_of_y,shifted_lsmt_y) := f_of_date.dec_jdate(
          ic_lsmt_point.d_of_y, ic_lsmt_point.y);
      end if;

      if shifted_lsmt_h_of_d >= 24 then
        shifted_lsmt_h_of_d := shifted_lsmt_h_of_d - 24;
        (shifted_lsmt_d_of_y,shifted_lsmt_y) := f_of_date.inc_jdate(
          ic_lsmt_point.d_of_y, ic_lsmt_point.y);
      end if;

      oc_slt_point.h_of_d := shifted_slt_h_of_d;
      oc_slt_point.d_of_y := shifted_slt_d_of_y;
      oc_slt_point.y := shifted_slt_y;
      oc_aslt_point.h_of_d := shifted_aslt_h_of_d;
      oc_aslt_point.d_of_y := shifted_aslt_d_of_y;
      oc_aslt_point.y := shifted_aslt_y;
      oc_clt_point.h_of_d := shifted_clt_h_of_d;
      oc_clt_point.d_of_y := shifted_clt_d_of_y;
      oc_clt_point.y := shifted_clt_y;
      oc_lsmt_point.h_of_d := shifted_lsmt_h_of_d;
      oc_lsmt_point.d_of_y := shifted_lsmt_d_of_y;
      oc_lsmt_point.y := shifted_lsmt_y;

      annotation (Diagram, Icon(
          Rectangle(extent=[-96, 74; 102, -98], style(gradient=1, fillColor=62)),
          Line(points=[-72, 40; 48, 40; 48, 60; 82, 20; 48, -20; 48, 0; -36, 0;
                 -72, 0; -72, 40], style(color=6, thickness=2)),
          Text(extent=[-34, -72; 86, -92], string="daylight_svngs_adder"),
          Line(points=[82, -20; -38, -20; -38, 0; -72, -40; -38, -80; -38, -60;
                 -38, -60; 82, -60; 82, -20], style(
              color=6,
              thickness=2,
              fillPattern=1)),
          Text(
            extent=[-56, 34; 58, 0],
            style(fillPattern=1),
            string="+1h "),
          Text(
            extent=[-52, -24; 62, -58],
            style(fillPattern=1),
            string="-1h ")));

    end daylight_svngs_adder;
  end TIME;

  package TOOLS
    extends icons.universals.icon_folder;
    annotation (Coordsys(
        extent=[0, 0; 317, 382],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.68,
        y=0,
        width=0.32,
        height=0.56,
        library=1,
        autolayout=1));
    package location
      extends icons.universals.icon_folder;
      class location_sel "Location selector"
        extends icons.specifics.icon_location;
        extends city_coords_database_reader_inheritable;
        parameter Real uf_given_latitude=49.45
          "Latitude angle if no city name entered (-90°...90°)";
        parameter Real uf_given_longitude=7.75
          "Longitude angle if no city name entered (-180°...180°)";
        parameter Real uf_given_ref_meridian=15
          "Local standard time meridian if no city name entered (-180°...180° or unknown)";
        annotation (Coordsys(
            extent=[-99, -97; 149, 138],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.13,
            y=0.04,
            width=0.79,
            height=0.6));
        CUTS.OutPort oc_latitude
          annotation (extent=[120, 110; 147, 132], layer="icon");
        CUTS.OutPort oc_meridians(n=2)
          annotation (extent=[120, -53; 147, -29], layer="icon");
      algorithm
        if given_city_name == none then
          oc_latitude.signal[1] := uf_given_latitude*conv_deg_to_rad;
          oc_meridians.signal[1] := uf_given_longitude*conv_deg_to_rad;
          oc_meridians.signal[2] := if uf_given_ref_meridian < unknown then
            uf_given_ref_meridian*conv_deg_to_rad else div((uf_given_longitude
             + 7.5), 15)*15*conv_deg_to_rad;
        else
          oc_latitude.signal[1] := database_latitude;
          oc_meridians.signal[1] := database_longitude;
          oc_meridians.signal[2] := if database_ref_meridian < unknown*
            conv_deg_to_rad then database_ref_meridian else div((
            database_longitude + 7.5*conv_deg_to_rad), 15*conv_deg_to_rad)*15*
            conv_deg_to_rad;
        end if;
        if initial() and given_city_name == none then
          assert(uf_given_latitude <= 90,
            "Error in class 'location_sel': latitude is greater than 90°.");
          assert(uf_given_latitude >= -90,
            "Error in class 'location_sel': latitude is less than -90°.");
          assert(uf_given_longitude <= 180,
            "Error in class 'location_sel': longitude is greater than 180°.");
          assert(uf_given_longitude >= -180,
            "Error in class 'location_sel': longitude is less than -180°.");
          assert(uf_given_ref_meridian <= 180,
            "Error in class 'location_sel': local standard time meridian is greater than 180°.");
          assert(uf_given_ref_meridian >= -180,
            "Error in class 'location_sel': local standard time meridian is less than -180°.");
        end if;
      end location_sel;

      model city_coords_database_reader "City coordinates database reader"
        extends icons.specifics.icon_city_coords_database_reader;
        extends usr_settings.database_sel;
        parameter String given_city_name="kaiserslautern"
          "City name from database (\"NoName\"=not registered location)";
        constant Integer n_of_cities=size(city_name, 1);
        Real database_longitude;
        Real database_latitude;
        Real database_ref_meridian;
        Integer i;
        annotation (Coordsys(
            extent=[-99, -98; 99, 138],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.17,
            y=0.24,
            width=0.73,
            height=0.6));
      algorithm
        if initial() then
          i := 1;
          if given_city_name <> none then
            while city_name[i] <> given_city_name loop
              i := i + 1;
              assert(i <= n_of_cities,
                "Error in class 'city_coords_database_reader': city name does not exist.");
            end while;
          end if;
          database_latitude := uf_city_coords[i, 1]*conv_deg_to_rad;
          database_longitude := uf_city_coords[i, 2]*conv_deg_to_rad;
          database_ref_meridian := uf_city_coords[i, 3]*conv_deg_to_rad;
          assert(size(city_name, 1) == size(uf_city_coords, 1),
            "Error in class 'city_coords_database_reader': 'city_name' should have as many elements as 'city_coords'.");
          for i in 1:n_of_cities loop
            assert(uf_city_coords[i, 1] <= 90,
              "Error in class 'city_coords_database_reader': latitude is greater than 180°. Please review settings.");
            assert(uf_city_coords[i, 1] >= -90,
              "Error in class 'city_coords_database_reader': latitude is less than -90°. Please review settings.");
            assert(uf_city_coords[i, 2] <= 180,
              "Error in class 'city_coords_database_reader': longitude is greater than 180°. Please review settings.");
            assert(uf_city_coords[i, 2] >= -180,
              "Error in class 'city_coords_database_reader': longitude is less than -180°. Please review settings.");
            assert(uf_city_coords[i, 3] <= 180 or uf_city_coords[i, 3] ==
              unknown,
              "Error in class 'city_coords_database_reader': local standard time meridian is greater than 180°. Please review settings.");
            assert(uf_city_coords[i, 3] >= -180 or uf_city_coords[i, 3] ==
              unknown,
              "Error in class 'city_coords_database_reader': local standard time meridian is less than -180°. Please review settings.");
          end for;
        end if;
      end city_coords_database_reader;

      package usr_settings
        extends icons.universals.icon_usr_folder;
        package database_sel
          annotation (Window(library=1, autolayout=1), Invisible=true);
          extends icons.specifics.icon_city_coords_database_sel;
          extends usr;
        end database_sel;

        model usr "User defined city coordinates database"
          annotation (
            Window(
              x=0.23,
              y=0.01,
              width=0.67,
              height=0.79,
              library=1,
              autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 673, 499],
              grid=[2, 2],
              component=[20, 20]));
          // extends icons.specifics.icon_city_coords_database_usr;
          constant Real unknown=1000;
          constant Real uf_city_coords[:, 3]=[49.45, 7.75, 15; 49.8, 9.9, 15;
              48.1325, 11.5794, 15; 39.767, 3.017, 15; -6.167, 106.800, unknown;
               39.567, 2.650, 15; 41.383, 2.183, 15; 40.400, -3.683, 15; 39.633,
               2.617, 15; 53.517, 13.983, 15; 48.767, 9.183, 15; 50.117, 8.683,
               15; 52.517, 13.400, 15; 49.387, 8.375, 15; 18.000, -76.800,
              unknown; 18.467, -77.917, unknown; 20.617, -87.067, unknown;
              19.400, -99.150, unknown; 21.167, -86.833, unknown; 18.467, -69.900,
               unknown; 18.800, -71.567, unknown; 48.867, 2.333, 15; 48.683,
              6.200, 15; 43.600, 1.433, 15; 51.517, -0.105, 0; 52.050, 5.283,
              15; 0, 0, 0; 90, 0, unknown; 68.967, 33.083, unknown];
          constant String city_name[:]={"kaiserslautern","wuerzburg","muenchen",
              "sa pobla","jakarta","palma de mallorca","barcelona","madrid",
              "establiments","pasewalk","stuttgart","frankfurt","berlin",
              "schifferstadt","kingston","montego bay","playa del carmen",
              "mexico df","cancun","santo domingo","punta cana","paris","nancy",
              "toulouse","london","driebergen","equator","north pole",
              "murmansk"};
        end usr;
        annotation (Coordsys(
            extent=[0, 0; 522, 292],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.16,
            y=0.56,
            width=0.52,
            height=0.44,
            library=1,
            autolayout=1));
        model rheinland_palatinate "Pre-defined city coordinates database"

          extends icons.specifics.icon_city_coords_database_usr;
          constant Real uf_city_coords[:, 3]=[49.45, 7.75, 15; 49.387, 8.375,
              15];
          constant String city_name[:]={"kaiserslautern","schifferstadt"};
          annotation (Window(
              x=0.45,
              y=0.01,
              width=0.44,
              height=0.65,
              library=1,
              autolayout=1), Coordsys(
              extent=[0, 0; 443, 393],
              grid=[2, 2],
              component=[20, 20]));
        end rheinland_palatinate;

        model german_cities "Pre-defined city coordinates database"
          extends icons.specifics.icon_city_coords_database_usr;
          constant Real uf_city_coords[:, 3]=[49.45, 7.75, 15; 49.8, 9.9, 15;
              48.1325, 11.5794, 15; 53.517, 13.983, 15; 48.767, 9.183, 15;
              50.117, 8.683, 15; 49.387, 8.375, 15];
          constant String city_name[:]={"kaiserslautern","wuerzburg","muenchen",
              "pasewalk","stuttgart","frankfurt","shifferstadt"};
          annotation (
            Window(
              x=0.45,
              y=0.01,
              width=0.44,
              height=0.65,
              library=1,
              autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 1024, 670],
              grid=[2, 2],
              component=[20, 20]));
        end german_cities;

        model european_capitals "Pre-defined city coordinates database"
          extends icons.specifics.icon_city_coords_database_usr;
          constant Real uf_city_coords[:, 3]=[40.400, -3.683, 15; 52.517,
              13.400, 15; 48.867, 2.333, 15; 51.517, -0.105, 15];
          constant String city_name[:]={"madrid","berlin","paris","london"};
          annotation (
            Window(
              x=0.45,
              y=0.01,
              width=0.44,
              height=0.65,
              library=1,
              autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 443, 393],
              grid=[2, 2],
              component=[20, 20]));
        end european_capitals;

        model world_capitals "Pre-defined city coordinates database"
          extends icons.specifics.icon_city_coords_database_usr;
          constant Real unknown=1000;
          constant Real uf_city_coords[:, 3]=[-6.167, 106.800, unknown; 20.617,
               -87.067, unknown; 19.400, -99.150, unknown; 18.467, -69.900,
              unknown];
          constant String city_name[:]={"jakarta","kingston","mexico df",
              "santo domingo"};
          annotation (
            Window(
              x=0.45,
              y=0.01,
              width=0.44,
              height=0.65,
              library=1,
              autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 1024, 670],
              grid=[2, 2],
              component=[20, 20]));
        end world_capitals;

        package database_sel_inheritable
          annotation (Window(library=1, autolayout=1), Invisible=true);
          //extends icons.specifics.icon_city_coords_database_sel;
          extends usr;
        end database_sel_inheritable;
      end usr_settings;
      annotation (Coordsys(
          extent=[0, 0; 318, 291],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1));
      model city_coords_database_reader_inheritable
        "City coordinates database reader"
        //extends icons.specifics.icon_city_coords_database_reader;
        extends usr_settings.database_sel_inheritable;
        parameter String given_city_name="kaiserslautern"
          "City name from database (\"NoName\"=not registered location)";
        constant Integer n_of_cities=size(city_name, 1);
        Real database_longitude;
        Real database_latitude;
        Real database_ref_meridian;
        Integer i;
        annotation (Coordsys(
            extent=[-99, -98; 99, 138],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.17,
            y=0.24,
            width=0.73,
            height=0.6));
      algorithm
        if initial() then
          i := 1;
          if given_city_name <> none then
            while city_name[i] <> given_city_name loop
              i := i + 1;
              assert(i <= n_of_cities,
                "Error in class 'city_coords_database_reader': city name does not exist.");
            end while;
          end if;
          database_latitude := uf_city_coords[i, 1]*conv_deg_to_rad;
          database_longitude := uf_city_coords[i, 2]*conv_deg_to_rad;
          database_ref_meridian := uf_city_coords[i, 3]*conv_deg_to_rad;
          assert(size(city_name, 1) == size(uf_city_coords, 1),
            "Error in class 'city_coords_database_reader': 'city_name' should have as many elements as 'city_coords'.");
          for i in 1:n_of_cities loop
            assert(uf_city_coords[i, 1] <= 90,
              "Error in class 'city_coords_database_reader': latitude is greater than 180°. Please review settings.");
            assert(uf_city_coords[i, 1] >= -90,
              "Error in class 'city_coords_database_reader': latitude is less than -90°. Please review settings.");
            assert(uf_city_coords[i, 2] <= 180,
              "Error in class 'city_coords_database_reader': longitude is greater than 180°. Please review settings.");
            assert(uf_city_coords[i, 2] >= -180,
              "Error in class 'city_coords_database_reader': longitude is less than -180°. Please review settings.");
            assert(uf_city_coords[i, 3] <= 180 or uf_city_coords[i, 3] ==
              unknown,
              "Error in class 'city_coords_database_reader': local standard time meridian is greater than 180°. Please review settings.");
            assert(uf_city_coords[i, 3] >= -180 or uf_city_coords[i, 3] ==
              unknown,
              "Error in class 'city_coords_database_reader': local standard time meridian is less than -180°. Please review settings.");
          end for;
        end if;
      end city_coords_database_reader_inheritable;
    end location;

    package surf_orient
      // extends icons.universals.icon_folder;
      class surf_orient_alias_def "Surface orientation alias definitions"
        // extends icons.specifics.icon_surf_orient_alias_def;
        extends usr_settings.usr_settings_sel;
        constant Integer n_of_surf_orient_def=size(surf_orient_def, 1);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.28,
            y=0.27,
            width=0.6,
            height=0.6));
      algorithm
        if initial() then
          assert(size(surf_orient_alias, 1) == size(surf_orient_def, 1),
            "Error in class 'surf_orient_alias_def': orientation_alias should have as many elements as surface orientation definitions");
          for i in 1:n_of_surf_orient_def loop
            assert(surf_orient_def[i, 2] <= 180,
              "Error in class 'surf_orient_alias_def': surface slope angle is greater than 180°. Please review user settings.");
            assert(surf_orient_def[i, 2] >= 0,
              "Error in class 'surf_orient_alias_def': surface slope angle is negative. Please review user settings.");
            assert(surf_orient_def[i, 1] <= 180,
              "Error in class 'surf_orient_alias_def': surface azimuth angle is greater than 180°. Please review user settings.");
            assert(surf_orient_def[i, 1] >= -180,
              "Error in class 'surf_orient_alias_def': surface azimuth angle is less than -180°. Please review user settings.");
          end for;
        end if;
      end surf_orient_alias_def;

      class surf_orient_alias_inheritable_sel
        "Surface orientation alias inheritable selector"
        extends surf_orient_alias_def;
        extends surf_orient_alias_inheritable_par;

        Real total_rad;

        Integer i;

        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n_of_surf_orient_def)
          annotation (extent=[-128, -12; -100, 12], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      algorithm
        i := 1;
        while surf_orient_alias[i] <> comp_surf_orient_alias loop
          i := i + 1;
          assert(i <= n_of_surf_orient_def, "alias name does not exist");
        end while;
        total_rad := ic_total_rad_v1.I[i];
      end surf_orient_alias_inheritable_sel;

      class surf_orient_alias_aggregable_sel
        "Surface orientation alias aggregable selector"
        extends surf_orient_alias_inheritable_sel;
        extends icons.specifics.icon_surf_orient_alias_usr_settings;
        CUTS.oc_total_rad oc_total_rad1 annotation (extent=[102, -12; 130, 14]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      equation
        oc_total_rad1.I = total_rad;

      end surf_orient_alias_aggregable_sel;

      package surf_orient_alias_inheritable_par
        "Surface orientation alias inheritable parameter"
        annotation (Window(library=1, autolayout=1), Invisible=true);
        parameter String comp_surf_orient_alias="sv"
          "Surface orientation alias";
      end surf_orient_alias_inheritable_par;

      package usr_settings

        extends icons.universals.icon_usr_folder;
        annotation (Coordsys(
            extent=[0, 0; 442, 394],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.16,
            y=0.56,
            width=0.52,
            height=0.44,
            library=1,
            autolayout=1));
        package usr_settings_sel "Surface orientation alias set selector"
          // extends icons.specifics.icon_surf_orient_alias_usr_settings_sel;
          extends usr;
          annotation (
            Window(
              x=0.45,
              y=0.01,
              width=0.44,
              height=0.65,
              library=1,
              autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 442, 394],
              grid=[2, 2],
              component=[20, 20]));
        end usr_settings_sel;

        model basic_default "Pre-defined surface orientation alias set"
          //  extends icons.specifics.icon_surf_orient_alias_usr_settings;
          constant Real surf_orient_def[:, 2]=[180, 90; 90, 90; 0, 90; -90, 90;
               180, 45; 90, 45; 0, 45; -90, 45];
          constant String surf_orient_alias[:]={"nv","ev","sv","wv","nt","et",
              "st","wt"};
          annotation (
            Window(library=1, autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 1024, 670],
              grid=[2, 2],
              component=[20, 20]));
        end basic_default;

        model ext_default "Pre-defined surface orientation alias set"

          //    extends icons.specifics.icon_surf_orient_alias_usr_settings;
          constant Real surf_orient_def[:, 2]=[180, 90; 135, 90; 90, 90; 45, 90;
               0, 90; -45, 90; -90, 90; -135, 90; 180, 45; 135, 45; 90, 45; 45,
               45; 0, 45; -45, 45; -90, 45; -135, 45];
          constant String surf_orient_alias[:]={"nv","nev","ev","sev","sv",
              "swv","wv","nwv","nt","net","et","set","st","swt","wt","nwt"};
          annotation (
            Window(library=1, autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 1024, 670],
              grid=[2, 2],
              component=[20, 20]));
        end ext_default;

        model usr "User defined surface orientation alias set"
          // extends icons.specifics.icon_surf_orient_alias_usr_settings;
          constant Real surf_orient_def[:, 2]=[0, 90; -180, 90; 90, 90; -90, 90;
               0, 45];
          constant String surf_orient_alias[:]={"sv","nv","ov","wv","sd"};
          annotation (
            Window(
              x=0,
              y=0.6,
              width=0.4,
              height=0.4,
              library=1,
              autolayout=1),
            Invisible=true,
            Coordsys(
              extent=[0, 0; 1024, 670],
              grid=[2, 2],
              component=[20, 20]));
        end usr;
      end usr_settings;
      annotation (
        Coordsys(
          extent=[0, 0; 320, 292],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1),
        Icon(
          Rectangle(extent=[-54, 62.6; 88, -75.4], style(color=10, fillColor=10)),
          Rectangle(extent=[-38, 58.6; 94, -69.4], style(color=10, fillColor=10)),
          Polygon(points=[-58, -69.4; -58, 70.6; -44, 80.6; -8, 80.6; 0, 72.6;
                0, 66.6; 70, 66.6; 88, 56.6; 88, -69.4; -58, -69.4], style(
              color=45,
              thickness=4,
              fillColor=52)),
          Polygon(points=[-42, 27.6; 26, 95.6; 116, 4.6; 50, -62.4; -42, 27.6],
               style(color=9, fillColor=8)),
          Polygon(points=[-49, 28.6; 19, 96.6; 109, 5.6; 43, -61.4; -49, 28.6],
               style(
              color=8,
              fillColor=7,
              fillPattern=10)),
          Line(points=[4, 58.6; 1, 71.6; 13, 67.6], style(color=0)),
          Line(points=[3, 64.6; 8, 69.6], style(color=0)),
          Line(points=[16, 70.6; 9, 78.6], style(color=0)),
          Line(points=[5, 74.6; 12, 81.6], style(color=0)),
          Line(points=[17, 79.6; 23, 85.6], style(color=0)),
          Line(points=[17, 85.6; 23, 79.6], style(color=0)),
          Line(points=[-32, 27.6; -8, 51.6], style(thickness=2)),
          Line(points=[-21, 17.6; 27, 65.6], style(thickness=2)),
          Line(points=[-11, 6.6; 32, 49.6], style(thickness=2)),
          Line(points=[3, -5.4; 53, 44.6], style(thickness=2)),
          Polygon(points=[88, -69.4; -62, -69.4; -74, -17.4; -80, 36.6; 68,
                36.6; 82, -11.4; 88, -69.4], style(
              color=45,
              thickness=4,
              fillColor=51)),
          Text(extent=[-63, 3.6; 77, -54.4], string="%name")));

    end surf_orient;

    package rad_integ
      extends icons.universals.icon_folder;
      class per_rad_integ_ini_and_length
        "Periodic radiation integrator with parametrizable initial time and period"

        extends icons.specifics.icon_per_rad_integ_ini_and_length;
        extends TIME.t_and_date.ini_h_of_d_and_date;
        parameter Boolean integ_before_ini_t_and_date=false
          "Integrate before initial time and date?";
        parameter Integer p=3600
          "Time interval over which radiation must be periodically integrated (s)";
        Real energy(start=0);
        Real energy_acc_last_period(start=0);
        Real energy_with_rst_this_period(start=0);
        Boolean trigger_on;
        Real next_shot_t;
        Boolean shot;
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.01,
            y=0.05,
            width=0.5,
            height=0.85));
      equation
        der(energy) = if trigger_on or integ_before_ini_t_and_date then
          ic_total_rad1.I else 0;
        energy_with_rst_this_period = energy - energy_acc_last_period;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        when trigger_on or integ_before_ini_t_and_date then
          next_shot_t := time + p - rem(TIME.f_of_date.jdate_1_m_jdate_2(
            ic_t_point1.d_of_y, ic_t_point1.y, ini_d_of_y, ini_y)*24*60*60 + (
            ic_t_point1.h_of_d - ini_h_of_d)*60*60, p)*(if trigger_on then 1 else
                  -1);
        end when;
        shot := time - next_shot_t >= 0;
        when shot then
          next_shot_t := next_shot_t + p;
          energy_acc_last_period := energy;
        end when;
        if initial() then
          assert(p > 0,
            "Error in class 'per_rad_integ_ini_and_length': time interval not greater than zero.");
        end if;
      end per_rad_integ_ini_and_length;

      class per_rad_integ_ini_and_length_demux
        "Periodic radiation integrator with parametrizable initial time and period (as defined in orientation alias sets)"

        extends icons.specifics.icon_per_rad_integ_ini_and_length_demux;
        extends surf_orient.surf_orient_alias_inheritable_par;
        parameter Integer uf_ini_date=01012001
          "Initial date (ddmmyyyy or jjjyy)";
        parameter Integer uf_ini_h_of_d=000000 "Final time (hhmmss)";
        parameter Boolean integ_before_ini_t_and_date=false
          "Integrate before initial time and date?";
        parameter Integer p=3600
          "Time interval over which radiation must be periodically integrated (s)";
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n_of_surf_orient_def)
          annotation (extent=[-139, 4.5; -100.5, 43.5], layer="icon");
        surf_orient.surf_orient_alias_aggregable_sel
          surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
              comp_surf_orient_alias) annotation (extent=[-75.5, -1.5; -18, 61]);
        per_rad_integ_ini_and_length per_rad_integ_ini_and_length1(
          uf_ini_date=uf_ini_date,
          uf_ini_h_of_d=uf_ini_h_of_d,
          integ_before_ini_t_and_date=integ_before_ini_t_and_date,
          p=p) annotation (extent=[27.5, -19; 104.5, 65]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.08,
            y=0.26,
            width=0.6,
            height=0.6));
      equation
        connect(ic_t_point1, per_rad_integ_ini_and_length1.ic_t_point1)
          annotation (points=[-103.5, -46; 3.5, -46; 3.5, 6; 19, 6]);
        connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
          per_rad_integ_ini_and_length1.ic_total_rad1)
          annotation (points=[-16.5, 30; 15.5, 30]);
        connect(surf_orient_alias_aggregable_sel1.ic_total_rad_v1,
          ic_total_rad_v1) annotation (points=[-80.5, 30; -102.5, 30]);
      end per_rad_integ_ini_and_length_demux;

      model per_rad_integ_ini_and_length_mux
        "Periodic integrator of many radiation signals with parametrizable initial time and period"

        extends icons.specifics.icon_per_rad_integ_ini_and_length_mux;
        extends TIME.t_and_date.ini_h_of_d_and_date;
        parameter Boolean integ_before_ini_t_and_date=false
          "Integrate before initial time and date?";
        parameter Integer p=3600
          "Time interval over which radiation must be periodically integrated (s)";
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector";
        Real energy[n](start=fill(0, n));
        Real energy_acc_last_period[n](start=fill(0, n));
        Real energy_with_rst_this_period[n](start=fill(0, n));
        Boolean trigger_on;
        Real next_shot_t;
        Boolean shot;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.34,
            y=0.25,
            width=0.6,
            height=0.6));
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-143, -3.5; -100.5, 39.5], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
      equation
        for i in 1:n loop
          der(energy[i]) = if trigger_on or integ_before_ini_t_and_date then
            ic_total_rad_v1.I[i] else 0;
          energy_with_rst_this_period[i] = energy[i] - energy_acc_last_period[i];
        end for;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        when trigger_on or integ_before_ini_t_and_date then
          next_shot_t := time + p - rem(TIME.f_of_date.jdate_1_m_jdate_2(
            ic_t_point1.d_of_y, ic_t_point1.y, ini_d_of_y, ini_y)*24*60*60 + (
            ic_t_point1.h_of_d - ini_h_of_d)*60*60, p)*(if trigger_on then 1 else
                  -1);
        end when;
        shot := time - next_shot_t >= 0;
        when shot then
          next_shot_t := next_shot_t + p;
          for i in 1:n loop
            energy_acc_last_period[i] := energy[i];
          end for;
        end when;
        if initial() then
          assert(p > 0,
            "Error in class 'per_rad_integ_ini_and_length': time interval not greater than zero.");
        end if;
      end per_rad_integ_ini_and_length_mux;

      class per_rad_integ_cal
        "Daily, weekly, monthly and yearly radiation integrator"
        extends icons.specifics.icon_per_rad_integ_cal;
        Real energy(start=0);
        Real energy_acc_last_d_of_m(start=0);
        Real energy_acc_last_w(start=0);
        Real energy_acc_last_m_of_y(start=0);
        Real energy_acc_last_y(start=0);
        Real energy_with_rst_this_d_of_m(start=0);
        Real energy_with_rst_this_w(start=0);
        Real energy_with_rst_this_m_of_y(start=0);
        Real energy_with_rst_this_y(start=0);
        Integer d_of_w;
        Integer d_of_m;
        Integer m_of_y;
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.31,
            y=0.2,
            width=0.64,
            height=0.69));
      equation
        der(energy) = ic_total_rad1.I;
        energy_with_rst_this_d_of_m = energy - energy_acc_last_d_of_m;
        energy_with_rst_this_w = energy - energy_acc_last_w;
        energy_with_rst_this_m_of_y = energy - energy_acc_last_m_of_y;
        energy_with_rst_this_y = energy - energy_acc_last_y;
      algorithm
        when ic_t_point1.d_of_y <> pre(ic_t_point1.d_of_y) then
          (d_of_w,d_of_m,m_of_y) := TIME.f_of_date.inc_sdate(d_of_w, d_of_m,
            m_of_y, ic_t_point1.y);
        end when;
        when d_of_w == 1 then
          energy_acc_last_w := energy;
        end when;
        when d_of_m <> pre(d_of_m) then
          energy_acc_last_d_of_m := energy;
        end when;
        when m_of_y <> pre(m_of_y) then
          energy_acc_last_m_of_y := energy;
        end when;
        when ic_t_point1.y <> pre(ic_t_point1.y) then
          energy_acc_last_y := energy;
        end when;
        if initial() then
          //initialization
          d_of_w := TIME.f_of_date.d_of_w_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          d_of_m := TIME.f_of_date.d_of_m_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          m_of_y := TIME.f_of_date.m_of_y_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
        end if;
      end per_rad_integ_cal;

      class per_rad_integ_cal_demux
        "Daily, weekly, monthly and yearly radiation integrator (as defined in orientation alias sets)"

        extends icons.specifics.icon_per_rad_integ_cal_demux;
        extends surf_orient.surf_orient_alias_inheritable_par;
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n_of_surf_orient_def)
          annotation (extent=[-139, 4.5; -100.5, 43.5], layer="icon");
        per_rad_integ_cal per_rad_integ_cal1
          annotation (extent=[26.5, -16; 98.5, 63]);
        surf_orient.surf_orient_alias_aggregable_sel
          surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
              comp_surf_orient_alias) annotation (extent=[-75.5, -1.5; -18, 61]);
      equation
        connect(ic_t_point1, per_rad_integ_cal1.ic_t_point1)
          annotation (points=[-103.5, -46; 3.5, -46; 3.5, 6; 19, 6]);
        connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
          per_rad_integ_cal1.ic_total_rad1)
          annotation (points=[-16.5, 30; 15.5, 30]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        connect(surf_orient_alias_aggregable_sel1.ic_total_rad_v1,
          ic_total_rad_v1) annotation (points=[-83, 30; -103.5, 30]);
      end per_rad_integ_cal_demux;

      class per_rad_integ_cal_mux
        "Daily, weekly, monthly and yearly integrator of many radiation signals"

        extends icons.specifics.icon_per_rad_integ_cal_mux;
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector";
        Real energy[n](start=fill(0, n));
        Real energy_acc_last_d_of_m[n](start=fill(0, n));
        Real energy_acc_last_w[n](start=fill(0, n));
        Real energy_acc_last_m_of_y[n](start=fill(0, n));
        Real energy_acc_last_y[n](start=fill(0, n));
        Real energy_with_rst_this_d_of_m[n](start=fill(0, n));
        Real energy_with_rst_this_w[n](start=fill(0, n));
        Real energy_with_rst_this_m_of_y[n](start=fill(0, n));
        Real energy_with_rst_this_y[n](start=fill(0, n));
        Integer d_of_w;
        Integer d_of_m;
        Integer m_of_y;
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-143, -3.5; -100.5, 39.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.23,
            y=0.12,
            width=0.68,
            height=0.77));
      equation
        for i in 1:n loop
          der(energy[i]) = ic_total_rad_v1.I[i];
          energy_with_rst_this_d_of_m[i] = energy[i] - energy_acc_last_d_of_m[i];
          energy_with_rst_this_w[i] = energy[i] - energy_acc_last_w[i];
          energy_with_rst_this_m_of_y[i] = energy[i] - energy_acc_last_m_of_y[i];
          energy_with_rst_this_y[i] = energy[i] - energy_acc_last_y[i];
        end for;

      algorithm
        if initial() then
          //initialization
          d_of_w := TIME.f_of_date.d_of_w_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          d_of_m := TIME.f_of_date.d_of_m_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          m_of_y := TIME.f_of_date.m_of_y_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
        end if;
        when ic_t_point1.d_of_y <> pre(ic_t_point1.d_of_y) then
          (d_of_w,d_of_m,m_of_y) := TIME.f_of_date.inc_sdate(d_of_w, d_of_m,
            m_of_y, ic_t_point1.y);
        end when;
        for i in 1:n loop
          when d_of_w == 1 then
            energy_acc_last_w[i] := energy[i];
          end when;
          when d_of_m <> pre(d_of_m) then
            energy_acc_last_d_of_m[i] := energy[i];
          end when;
          when m_of_y <> pre(m_of_y) then
            energy_acc_last_m_of_y[i] := energy[i];
          end when;
          when ic_t_point1.y <> pre(ic_t_point1.y) then
            energy_acc_last_y[i] := energy[i];
          end when;
        end for;

      end per_rad_integ_cal_mux;

      class int_rad_integ_ini_and_length
        "Radiation integrator over parametrizable interval (initial time and duration)"

        extends icons.specifics.icon_int_rad_integ_ini_and_length;
        extends TIME.t_and_date.ini_h_of_d_and_date;
        parameter Integer it=24 "Integration time (h) (0=endless)";
        Real energy_ltd(start=0);
        Boolean trigger_on;
        Boolean trigger_off;
        Boolean within_period;
        Real trigger_off_t;
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0,
            y=0,
            width=0.6,
            height=0.78));
      equation
        der(energy_ltd) = if within_period then ic_total_rad1.I else 0;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        when trigger_on then
          trigger_off_t := time + it*60*60 - (TIME.f_of_date.jdate_1_m_jdate_2(
            ic_t_point1.d_of_y, ic_t_point1.y, ini_d_of_y, ini_y)*24*60*60 + (
            ic_t_point1.h_of_d - ini_h_of_d)*60*60);
        end when;
        trigger_off := time >= trigger_off_t and trigger_on and it > 0;
        within_period := trigger_on and not trigger_off;
        if initial() then
          assert(it >= 0,
            "Error in class 'int_rad_integ_ini_and_length': negative integration TIME.");
        end if;
      end int_rad_integ_ini_and_length;

      class int_rad_integ_ini_and_length_demux
        "Radiation integrator over parametrizable interval (initial time and duration) (as defined in orientation alias sets)"

        extends icons.specifics.icon_int_rad_integ_ini_and_length_demux;
        extends surf_orient.surf_orient_alias_inheritable_par;
        parameter Integer uf_ini_date=01012001
          "Initial date (ddmmyyyy or jjjyy)";
        parameter Integer uf_ini_h_of_d=000000 "Initial time (hhmmss)";
        parameter Integer it=24 "Integration time (h) (0=endless)";
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n_of_surf_orient_def)
          annotation (extent=[-139, 4.5; -100.5, 43.5], layer="icon");
        surf_orient.surf_orient_alias_aggregable_sel
          surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
              comp_surf_orient_alias) annotation (extent=[-75.5, -1.5; -18, 61]);
        int_rad_integ_ini_and_length int_rad_integ_ini_and_length1(
          uf_ini_date=uf_ini_date,
          uf_ini_h_of_d=uf_ini_h_of_d,
          it=it) annotation (extent=[27.5, -19; 104.5, 65]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.33,
            y=0.26,
            width=0.6,
            height=0.6));
      equation
        connect(ic_t_point1, int_rad_integ_ini_and_length1.ic_t_point1)
          annotation (points=[-103.5, -46; 3.5, -46; 3.5, 6; 19, 6]);
        connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
          int_rad_integ_ini_and_length1.ic_total_rad1)
          annotation (points=[-16.5, 30; 15.5, 30]);
        connect(surf_orient_alias_aggregable_sel1.ic_total_rad_v1,
          ic_total_rad_v1) annotation (points=[-82, 30; -102.5, 30]);
      end int_rad_integ_ini_and_length_demux;

      class int_rad_integ_ini_and_length_mux
        "Integrator of many radiation signals over parametrizable interval (initial time and duration)"

        extends icons.specifics.icon_int_rad_integ_ini_and_length_mux;
        extends TIME.t_and_date.ini_h_of_d_and_date;
        parameter Integer it=24 "Integration time (h) (0=endless)";
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector";
        Real energy_ltd[n](start=fill(0, n));
        Boolean trigger_on;
        Boolean trigger_off;
        Boolean within_period;
        Real trigger_off_t;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.32,
            y=0.09,
            width=0.62,
            height=0.81));
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
      equation
        for i in 1:n loop
          der(energy_ltd[i]) = if within_period then ic_total_rad_v1.I[i] else
            0;
        end for;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        when trigger_on then
          trigger_off_t := time + it*60*60 - (TIME.f_of_date.jdate_1_m_jdate_2(
            ic_t_point1.d_of_y, ic_t_point1.y, ini_d_of_y, ini_y)*24*60*60 + (
            ic_t_point1.h_of_d - ini_h_of_d)*60*60);
        end when;
        trigger_off := time >= trigger_off_t and trigger_on and it > 0;
        within_period := trigger_on and not trigger_off;
        if initial() then
          assert(it >= 0,
            "Error in class 'int_rad_integ_ini_and_length': negative integration TIME.");
        end if;
      end int_rad_integ_ini_and_length_mux;

      class int_rad_integ_ini_and_fin
        "Radiation integrator over parametrizable interval (initial and final times)"

        extends icons.specifics.icon_int_rad_integ_ini_and_fin;
        extends TIME.t_and_date.ini_and_fin_h_of_d_and_date;
        Real energy_ltd(start=0);
        Boolean trigger_on;
        Boolean trigger_off;
        Boolean within_period;
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      equation
        der(energy_ltd) = if within_period then ic_total_rad1.I else 0;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        trigger_off := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, fin_d_of_y, fin_y) and ic_t_point1.h_of_d > fin_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, fin_d_of_y, fin_y);
        within_period := trigger_on and not trigger_off;
      end int_rad_integ_ini_and_fin;

      class int_rad_integ_ini_and_fin_demux
        "Radiation integrator over parametrizable interval (initial and final times) (as defined in orientation alias sets)"

        extends icons.specifics.icon_int_rad_integ_ini_and_fin_demux;
        extends surf_orient.surf_orient_alias_inheritable_par;
        parameter Integer uf_ini_date=01012001
          "Initial date (ddmmyyyy or jjjyy)";
        parameter Integer uf_ini_h_of_d=000000 "Final time (hhmmss)";
        parameter Integer uf_fin_date=01012002
          "Initial date (ddmmyyyy or jjjyy)";
        parameter Integer uf_fin_h_of_d=000000 "Final time (hhmmss)";
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n_of_surf_orient_def)
          annotation (extent=[-139, 4.5; -100.5, 43.5], layer="icon");
        surf_orient.surf_orient_alias_aggregable_sel
          surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
              comp_surf_orient_alias) annotation (extent=[-75.5, -1.5; -18, 61]);
        int_rad_integ_ini_and_fin int_rad_integ_ini_and_fin1(
          uf_ini_date=uf_ini_date,
          uf_ini_h_of_d=uf_ini_h_of_d,
          uf_fin_date=uf_fin_date,
          uf_fin_h_of_d=uf_fin_h_of_d)
          annotation (extent=[27.5, -19; 104.5, 65]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      equation
        connect(ic_t_point1, int_rad_integ_ini_and_fin1.ic_t_point1)
          annotation (points=[-103.5, -46; 3.5, -46; 3.5, 6; 19, 6]);
        connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
          int_rad_integ_ini_and_fin1.ic_total_rad1)
          annotation (points=[-16.5, 30; 15.5, 30]);
        connect(surf_orient_alias_aggregable_sel1.ic_total_rad_v1,
          ic_total_rad_v1) annotation (points=[-80, 30; -103, 30]);
      end int_rad_integ_ini_and_fin_demux;

      class int_rad_integ_ini_and_fin_mux
        "Integrator of many radiation signals over parametrizable interval (initial and final times)"

        extends icons.specifics.icon_int_rad_integ_ini_and_fin_mux;
        extends TIME.t_and_date.ini_and_fin_h_of_d_and_date;
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector";
        Real energy_ltd[n](start=fill(0, n));
        Boolean trigger_on;
        Boolean trigger_off;
        Boolean within_period;
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.44,
            y=0.15,
            width=0.54,
            height=0.66));
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-141.5, -2.5; -100, 37.5]);
      equation
        for i in 1:n loop
          der(energy_ltd[i]) = if within_period then ic_total_rad_v1.I[i] else
            0;
        end for;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        trigger_off := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, fin_d_of_y, fin_y) and ic_t_point1.h_of_d > fin_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, fin_d_of_y, fin_y);
        within_period := trigger_on and not trigger_off;
      end int_rad_integ_ini_and_fin_mux;

      class aver_rad_integ_ini_and_length
        "Radiation average calculator over parametrizable interval (initial time and duration)"

        extends icons.specifics.icon_aver_rad_integ_ini_and_length;
        extends TIME.t_and_date.ini_h_of_d_and_date;
        parameter Boolean integ_before_ini_t_and_date=false
          "Integrate before initial time and date?";
        parameter Integer p=3600
          "Time interval over which radiation must be periodically averaged (s)";
        Real energy(start=0);
        Real energy_acc_last_period(start=0);
        Real energy_acc_last_but_1_period(start=0);
        Boolean trigger_on;
        Real next_shot_t;
        Boolean shot;
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.33,
            y=0.03,
            width=0.63,
            height=0.92));
        CUTS.oc_total_rad oc_total_rad1
          annotation (extent=[101, -3.5; 136.5, 39], layer="icon");
      equation
        der(energy) = if trigger_on or integ_before_ini_t_and_date then
          ic_total_rad1.I else 0;
        oc_total_rad1.I = (energy_acc_last_period -
          energy_acc_last_but_1_period)/p;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        when trigger_on or integ_before_ini_t_and_date then
          next_shot_t := time + p - rem(TIME.f_of_date.jdate_1_m_jdate_2(
            ic_t_point1.d_of_y, ic_t_point1.y, ini_d_of_y, ini_y)*24*60*60 + (
            ic_t_point1.h_of_d - ini_h_of_d)*60*60, p)*(if trigger_on then 1 else
                  -1);
        end when;
        shot := time - next_shot_t >= 0;
        when shot then
          next_shot_t := next_shot_t + p;
          energy_acc_last_but_1_period := energy_acc_last_period;
          energy_acc_last_period := energy;
        end when;
        if initial() then
          assert(p > 0,
            "Error in class 'aver_rad_integ_ini_and_length': time interval not greater than zero.");
        end if;
      end aver_rad_integ_ini_and_length;

      class aver_rad_integ_ini_and_length_demux
        "Radiation average calculator over parametrizable interval (initial time and duration) (as defined in orientation alias sets)"

        extends icons.specifics.icon_aver_rad_integ_ini_and_length_demux;
        extends surf_orient.surf_orient_alias_inheritable_par;
        parameter Integer uf_ini_date=01012001
          "Initial date (ddmmyyyy or jjjyy)";
        parameter Integer uf_ini_h_of_d=000000 "Initial time (hhmmss)";
        parameter Boolean integ_before_ini_t_and_date=false
          "Integrate before initial time and date?";
        parameter Integer p=3600
          "Time interval over which radiation must be periodically averaged (s)";
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n_of_surf_orient_def)
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
        surf_orient.surf_orient_alias_aggregable_sel
          surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
              comp_surf_orient_alias)
          annotation (extent=[-81.5, 7.5; -40, 51.5]);
        aver_rad_integ_ini_and_length aver_rad_integ_ini_and_length1(
          uf_ini_date=uf_ini_date,
          uf_ini_h_of_d=uf_ini_h_of_d,
          integ_before_ini_t_and_date=integ_before_ini_t_and_date,
          p=p) annotation (extent=[-2, -19.5; 75, 64.5]);
        CUTS.oc_total_rad oc_total_rad1
          annotation (extent=[101, -3.5; 136.5, 39]);
      equation
        connect(surf_orient_alias_aggregable_sel1.ic_total_rad_v1,
          ic_total_rad_v1) annotation (points=[-84.405, 29.5; -106.5, 29.5]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.09,
            y=0.04,
            width=0.6,
            height=0.6));
        connect(ic_t_point1, aver_rad_integ_ini_and_length1.ic_t_point1)
          annotation (points=[-133.5, -44; -26.5, -44; -26.5, 8; -14.1813, 8]);
        connect(aver_rad_integ_ini_and_length1.oc_total_rad1, oc_total_rad1)
          annotation (points=[85.5, 28.5; 107.5, 28.5]);
        connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
          aver_rad_integ_ini_and_length1.ic_total_rad1)
          annotation (points=[-37, 30; -12.5, 30]);
      end aver_rad_integ_ini_and_length_demux;

      class aver_rad_integ_ini_and_length_mux
        "Average calculator of many radiation signals over parametrizable interval (initial time and duration)"

        extends icons.specifics.icon_aver_rad_integ_ini_and_length_mux;
        extends TIME.t_and_date.ini_h_of_d_and_date;
        parameter Boolean integ_before_ini_t_and_date=false
          "Integrate before initial time and date?";
        parameter Integer p=3600
          "Time interval over which radiation must be periodically averaged (s)";
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector";
        Real energy[n](start=fill(0, n));
        Real energy_acc_last_period[n](start=fill(0, n));
        Real energy_acc_last_but_1_period[n](start=fill(0, n));
        Boolean trigger_on;
        Real next_shot_t;
        Boolean shot;
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.51,
            y=0.09,
            width=0.44,
            height=0.87));
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-142, -3.5; -100.5, 39], layer="icon");
        CUTS.oc_total_rad_v oc_total_rad_v1(final n=n)
          annotation (extent=[101, -4; 136.5, 34], layer="icon");
      equation
        for i in 1:n loop
          der(energy[i]) = if trigger_on or integ_before_ini_t_and_date then
            ic_total_rad_v1.I[i] else 0;
          oc_total_rad_v1.I[i] = (energy_acc_last_period[i] -
            energy_acc_last_but_1_period[i])/p;
        end for;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d > ini_h_of_d)
           or TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y);
        when trigger_on or integ_before_ini_t_and_date then
          next_shot_t := time + p - rem(TIME.f_of_date.jdate_1_m_jdate_2(
            ic_t_point1.d_of_y, ic_t_point1.y, ini_d_of_y, ini_y)*24*60*60 + (
            ic_t_point1.h_of_d - ini_h_of_d)*60*60, p)*(if trigger_on then 1 else
                  -1);
        end when;
        shot := time - next_shot_t >= 0;
        when shot then
          next_shot_t := next_shot_t + p;
          for i in 1:n loop
            energy_acc_last_but_1_period[i] := energy_acc_last_period[i];
            energy_acc_last_period[i] := energy[i];
          end for;
        end when;
        if initial() then
          assert(p > 0,
            "Error in class 'aver_rad_integ_ini_and_length_mux': time interval not greater than zero.");
        end if;
      end aver_rad_integ_ini_and_length_mux;

      class aver_rad_integ_cal
        "Daily, weekly, monthly and yearly radiation average calculator"

        extends icons.specifics.icon_aver_rad_integ_cal;
        Real energy(start=0);
        Real energy_acc_last_d_of_m(start=0);
        Real energy_acc_last_w(start=0);
        Real energy_acc_last_m_of_y(start=0);
        Real energy_acc_last_y(start=0);
        Real energy_acc_last_but_1_d_of_m(start=0);
        Real energy_acc_last_but_1_w(start=0);
        Real energy_acc_last_but_1_m_of_y(start=0);
        Real energy_acc_last_but_1_y(start=0);
        Integer d_of_w;
        Integer d_of_m;
        Integer m_of_y;
        Integer max_d_of_last_m(start=1);
        Integer max_d_of_last_y(start=1);
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-142.5, 57; -101, 99.5], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.02,
            y=0.09,
            width=0.87,
            height=0.92));
        CUTS.oc_total_rad oc_total_rad_last_d_of_m
          annotation (extent=[105, 60; 140, 100], layer="icon");
        CUTS.oc_total_rad oc_total_rad_last_w
          annotation (extent=[105, 15; 140, 55], layer="icon");
        CUTS.oc_total_rad oc_total_rad_last_m_of_y
          annotation (extent=[105, -30; 140, 10], layer="icon");
        CUTS.oc_total_rad oc_total_rad_last_y
          annotation (extent=[105, -75; 140, -35], layer="icon");
        CUTS.InPort InPort1(n=4)
          annotation (extent=[-131, 3; -100.5, 33], layer="icon");
      equation
        if cardinality(InPort1) == 0 then
          InPort1.signal[1] = 24;
          InPort1.signal[2] = 7*24;
          InPort1.signal[3] = max_d_of_last_m*24;
          InPort1.signal[4] = max_d_of_last_y*24;
        end if;
        der(energy) = ic_total_rad1.I;
        oc_total_rad_last_d_of_m.I = if InPort1.signal[1] > 0 then (
          energy_acc_last_d_of_m - energy_acc_last_but_1_d_of_m)/(InPort1.
          signal[1]*60*60) else 0;
        oc_total_rad_last_w.I = if InPort1.signal[2] > 0 then (
          energy_acc_last_w - energy_acc_last_but_1_w)/(InPort1.signal[2]*60*60) else
                0;
        oc_total_rad_last_m_of_y.I = if InPort1.signal[3] > 0 then (
          energy_acc_last_m_of_y - energy_acc_last_but_1_m_of_y)/(InPort1.
          signal[3]*60*60) else 0;
        oc_total_rad_last_y.I = if InPort1.signal[4] > 0 then (
          energy_acc_last_y - energy_acc_last_but_1_y)/(InPort1.signal[4]*60*60) else
                0;
      algorithm
        when ic_t_point1.d_of_y <> pre(ic_t_point1.d_of_y) then
          (d_of_w,d_of_m,m_of_y) := TIME.f_of_date.inc_sdate(d_of_w, d_of_m,
            m_of_y, ic_t_point1.y);
        end when;
        when d_of_w == 1 then
          energy_acc_last_but_1_w := energy_acc_last_w;
          energy_acc_last_w := energy;
        end when;
        when d_of_m <> pre(d_of_m) then
          energy_acc_last_but_1_d_of_m := energy_acc_last_d_of_m;
          energy_acc_last_d_of_m := energy;
        end when;
        when m_of_y <> pre(m_of_y) then
          energy_acc_last_but_1_m_of_y := energy_acc_last_m_of_y;
          energy_acc_last_m_of_y := energy;
          max_d_of_last_m := TIME.f_of_date.max_d_of_m(pre(m_of_y), pre(
            ic_t_point1.y));
        end when;
        when ic_t_point1.y <> pre(ic_t_point1.y) then
          energy_acc_last_but_1_y := energy_acc_last_y;
          energy_acc_last_y := energy;
          max_d_of_last_y := TIME.f_of_date.max_d_of_y(ic_t_point1.y - 1);
        end when;
        if initial() then
          //initialization
          d_of_w := TIME.f_of_date.d_of_w_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          d_of_m := TIME.f_of_date.d_of_m_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          m_of_y := TIME.f_of_date.m_of_y_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
        end if;
      end aver_rad_integ_cal;

      class aver_rad_integ_cal_demux
        "Daily, weekly, monthly and yearly radiation average calculator (as defined in orientation alias sets)"

        extends icons.specifics.icon_aver_rad_integ_cal_demux;
        extends surf_orient.surf_orient_alias_inheritable_par;
        parameter Integer uf_ini_date=01012001
          "Initial date (ddmmyyyy or jjjyy)";
        parameter Integer uf_ini_h_of_d=000000 "Initial time (hhmmss)";
        parameter Integer p=3600
          "Time interval over which radiation must be periodically averaged (s)";
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n_of_surf_orient_def)
          annotation (extent=[-142, 56.5; -100.5, 99], layer="icon");
        surf_orient.surf_orient_alias_aggregable_sel
          surf_orient_alias_aggregable_sel1(comp_surf_orient_alias=
              comp_surf_orient_alias) annotation (extent=[-80, 55; -38.5, 99]);
        aver_rad_integ_cal aver_rad_integ_cal1
          annotation (extent=[-2, -19.5; 75, 64.5]);
        CUTS.oc_total_rad oc_total_rad_last_w
          annotation (extent=[105, 15; 140, 55]);
        CUTS.oc_total_rad oc_total_rad_last_m_of_y
          annotation (extent=[105, -30; 140, 10]);
        CUTS.oc_total_rad oc_total_rad_last_y
          annotation (extent=[105, -75; 140, -35]);
        CUTS.oc_total_rad oc_total_rad_last_d_of_m
          annotation (extent=[105, 60; 140, 100]);
        CUTS.InPort InPort1(n=4) annotation (extent=[-131, 3; -100.5, 33]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.31,
            y=0.07,
            width=0.6,
            height=0.6));
      equation
        connect(ic_t_point1, aver_rad_integ_cal1.ic_t_point1)
          annotation (points=[-133.5, -44; -26.5, -44; -26.5, 8; -14.1813, 8]);
        connect(aver_rad_integ_cal1.oc_total_rad_last_w, oc_total_rad_last_w)
          annotation (points=[87, 37; 110, 37]);
        connect(aver_rad_integ_cal1.oc_total_rad_last_m_of_y,
          oc_total_rad_last_m_of_y)
          annotation (points=[85, 17.5; 99, 17.5; 99, -10.5; 110, -10.5]);
        connect(aver_rad_integ_cal1.oc_total_rad_last_y, oc_total_rad_last_y)
          annotation (points=[86, -1; 94.5, -1; 94.5, -55; 108.5, -55]);
        connect(aver_rad_integ_cal1.oc_total_rad_last_d_of_m,
          oc_total_rad_last_d_of_m)
          annotation (points=[85, 55.5; 96, 55.5; 96, 78.5; 108, 78.5]);
        connect(InPort1, aver_rad_integ_cal1.InPort1)
          annotation (points=[-113, 19; -61, 19; -61, 30; -9, 30]);
        connect(ic_total_rad_v1, surf_orient_alias_aggregable_sel1.
          ic_total_rad_v1) annotation (points=[-103, 78; -83, 78]);
        connect(surf_orient_alias_aggregable_sel1.oc_total_rad1,
          aver_rad_integ_cal1.ic_total_rad1)
          annotation (points=[-35.5, 77; -23, 77; -23, 55.5; -16.5, 55.5]);
      end aver_rad_integ_cal_demux;
      annotation (Coordsys(
          extent=[0, 0; 576, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.43,
          y=0.56,
          width=0.57,
          height=0.44,
          library=1,
          autolayout=1));
      class aver_rad_integ_cal_mux
        "Daily, weekly, monthly and yearly average calculator of many radiation signals"

        extends icons.specifics.icon_aver_rad_integ_cal_mux;
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector";
        Real energy[n](start=fill(0, n));
        Real energy_acc_last_d_of_m[n](start=fill(0, n));
        Real energy_acc_last_w[n](start=fill(0, n));
        Real energy_acc_last_m_of_y[n](start=fill(0, n));
        Real energy_acc_last_y[n](start=fill(0, n));
        Real energy_acc_last_but_1_d_of_m[n](start=fill(0, n));
        Real energy_acc_last_but_1_w[n](start=fill(0, n));
        Real energy_acc_last_but_1_m_of_y[n](start=fill(0, n));
        Real energy_acc_last_but_1_y[n](start=fill(0, n));
        Integer d_of_w;
        Integer d_of_m;
        Integer m_of_y;
        Integer max_d_of_last_m(start=1);
        Integer max_d_of_last_y(start=1);
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-142.5, 54; -101, 96.5], layer="icon");
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-142, -63; -100.5, -19.5], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.12,
            y=0.03,
            width=0.78,
            height=0.92));
        CUTS.oc_total_rad_v oc_total_rad_v_last_d_of_m(final n=n)
          annotation (extent=[105, 60; 140, 100], layer="icon");
        CUTS.oc_total_rad_v oc_total_rad_v_last_w(final n=n)
          annotation (extent=[105, 15; 140, 55], layer="icon");
        CUTS.oc_total_rad_v oc_total_rad_v_last_m_of_y(final n=n)
          annotation (extent=[105, -30; 140, 10], layer="icon");
        CUTS.oc_total_rad_v oc_total_rad_v_last_y(final n=n)
          annotation (extent=[105, -75; 140, -35], layer="icon");
        CUTS.InPort InPort1(n=4) annotation (extent=[-131, 3; -100.5, 33]);
      equation
        if cardinality(InPort1) == 0 then
          InPort1.signal[1] = 24;
          InPort1.signal[2] = 7*24;
          InPort1.signal[3] = max_d_of_last_m*24;
          InPort1.signal[4] = max_d_of_last_y*24;
        end if;
        for i in 1:n loop
          der(energy[i]) = ic_total_rad_v1.I[i];
          oc_total_rad_v_last_d_of_m.I[i] = (energy_acc_last_d_of_m[i] -
            energy_acc_last_but_1_d_of_m[i])/(InPort1.signal[1]*60*60);
          oc_total_rad_v_last_w.I[i] = (energy_acc_last_w[i] -
            energy_acc_last_but_1_w[i])/(InPort1.signal[2]*60*60);
          oc_total_rad_v_last_m_of_y.I[i] = (energy_acc_last_m_of_y[i] -
            energy_acc_last_but_1_m_of_y[i])/(InPort1.signal[3]*60*60);
          oc_total_rad_v_last_y.I[i] = (energy_acc_last_y[i] -
            energy_acc_last_but_1_y[i])/(InPort1.signal[4]*60*60);
        end for;
      algorithm
        when ic_t_point1.d_of_y <> pre(ic_t_point1.d_of_y) then
          (d_of_w,d_of_m,m_of_y) := TIME.f_of_date.inc_sdate(d_of_w, d_of_m,
            m_of_y, ic_t_point1.y);
        end when;
        for i in 1:n loop
          when d_of_w == 1 then
            energy_acc_last_but_1_w[i] := energy_acc_last_w[i];
            energy_acc_last_w[i] := energy[i];
          end when;
          when d_of_m <> pre(d_of_m) then
            energy_acc_last_but_1_d_of_m[i] := energy_acc_last_d_of_m[i];
            energy_acc_last_d_of_m[i] := energy[i];
          end when;
          when m_of_y <> pre(m_of_y) then
            energy_acc_last_but_1_m_of_y[i] := energy_acc_last_m_of_y[i];
            energy_acc_last_m_of_y[i] := energy[i];
            max_d_of_last_m := TIME.f_of_date.max_d_of_m(pre(m_of_y), pre(
              ic_t_point1.y));
          end when;
          when ic_t_point1.y <> pre(ic_t_point1.y) then
            energy_acc_last_but_1_y[i] := energy_acc_last_y[i];
            energy_acc_last_y[i] := energy[i];
            max_d_of_last_y := TIME.f_of_date.max_d_of_y(ic_t_point1.y - 1);
          end when;
        end for;
        if initial() then
          //initialization
          d_of_w := TIME.f_of_date.d_of_w_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          d_of_m := TIME.f_of_date.d_of_m_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
          m_of_y := TIME.f_of_date.m_of_y_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
        end if;
      end aver_rad_integ_cal_mux;
    end rad_integ;

    package rad_interpol
      extends icons.universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 320, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1));

      class total_rad_interpol
        "Radiation data interpolator by means of the averaged extraterrestrial radiation curve"

        extends icons.specifics.icon_rad_interpol_integ_extraterr_rad;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.17,
            y=0.22,
            width=0.6,
            height=0.73));
        CUTS.ic_beam_rad ic_extraterr_rad_aver_integ
          annotation (extent=[-130, 38; -100, 64], layer="icon");
        CUTS.ic_beam_rad ic_extraterr_rad
          annotation (extent=[-130, 2; -100, 28], layer="icon");
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-130, -62; -100, -32], layer="icon");
        CUTS.oc_total_rad oc_total_rad1
          annotation (extent=[100, -58; 130, -28], layer="icon");
      equation
        oc_total_rad1.I = if ic_extraterr_rad_aver_integ.I > 0 then
          ic_total_rad1.I*ic_extraterr_rad.I/ic_extraterr_rad_aver_integ.I else
                0;
      end total_rad_interpol;

      class beam_and_diff_rad_interpol
        "Beam and diffuse radiation data interpolator by means of the averaged extraterrestrial radiation curve"

        extends icons.specifics.icon_rad_interpol_integ_extraterr_rad;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        CUTS.ic_beam_rad ic_extraterr_rad_aver_integ
          annotation (extent=[-130, 0.8; -100, 26.8]);
        CUTS.ic_beam_rad ic_extraterr_rad
          annotation (extent=[-130.2, 36.4; -100.2, 62.4]);
        CUTS.ic_beam_rad ic_beam_rad1
          annotation (extent=[-126.6, -35.2; -100.6, -11.2]);
        CUTS.ic_diff_rad ic_diff_rad1
          annotation (extent=[-124.2, -65; -100, -43.6]);
        CUTS.oc_beam_rad oc_beam_rad1
          annotation (extent=[100.8, -39.2; 126.2, -15.4]);
        CUTS.oc_diff_rad oc_diff_rad1
          annotation (extent=[100.2, -63.6; 123, -43.6]);
      equation

        if ic_extraterr_rad_aver_integ.I > 0 then
          oc_beam_rad1.I = ic_beam_rad1.I*ic_extraterr_rad.I/
            ic_extraterr_rad_aver_integ.I;
          oc_diff_rad1.I = ic_diff_rad1.I*ic_extraterr_rad.I/
            ic_extraterr_rad_aver_integ.I;
        else
          oc_beam_rad1.I = 0;
          oc_diff_rad1.I = 0;
        end if;
      end beam_and_diff_rad_interpol;

      class total_rad_interpol_extraterr_rad_sampler
        "Radiation data interpolator by means of the continuous and sampled extraterrestrial radiation curves"

        extends icons.specifics.icon_rad_interpol_extraterr_rad_sampler;

        discrete Real I_extraterr_rad_sampled;
        Boolean b;
        Real Hilf1;
        parameter Real epsilon=1 "to compare reals for equality";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.02,
            y=0.02,
            width=0.6,
            height=0.73),
          Diagram);

        CUTS.ic_beam_rad ic_extraterr_rad1
          annotation (extent=[-132, 40; -102, 66], layer="icon");
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-130, -62; -100, -32], layer="icon");
        CUTS.oc_total_rad oc_total_rad1
          annotation (extent=[100, -58; 130, -28], layer="icon");
      equation

          //  b = {ic_total_rad1.I > pre(ic_total_rad1.I) + epsilon,ic_total_rad1.I < pre(
        //  ic_total_rad1.I) - epsilon};

      algorithm
        b := false;
        when {ic_total_rad1.I > Hilf1 + epsilon,ic_total_rad1.I < Hilf1 -
            epsilon} then
          Hilf1 := ic_total_rad1.I;
          b := true;

        end when;

        when b then
          I_extraterr_rad_sampled := ic_extraterr_rad1.I;
        end when;
        oc_total_rad1.I := if I_extraterr_rad_sampled > 0 then ic_total_rad1.I*
          ic_extraterr_rad1.I/I_extraterr_rad_sampled else 0;
      end total_rad_interpol_extraterr_rad_sampler;

      model lin_total_rad_interpol
        "Lineal radiation data interpolator under consideration of sunrise and sunset times"

        extends icons.specifics.icon_lin_rad_interpol;
        parameter Integer data_t_step=3600 "Weather data time step (s)";

        Real I1;
        Real I2;
        Real t_point_last_blip;
        Real t_point_detection_in_advance_of_sunset;
        Real d_t;
        Boolean b;
        Boolean c;
        Real Hilf1;
        Real Hilf2;
        Boolean next_interval_contains_sunset;
        parameter Real epsilon=1 "to compare reals for equality";

        CUTS.ic_position_of_sun ic_position_of_sun1
          annotation (extent=[-131, 71; -100.5, 100], layer="icon");
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-132, -15; -101, 18], layer="icon");
        CUTS.oc_total_rad oc_total_rad1
          annotation (extent=[99.5, -53.5; 129.5, -23], layer="icon");
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]), Window(
            x=0.13,
            y=0.07,
            width=0.6,
            height=0.6));
        CUTS.ic_total_rad ic_total_rad_a1
          annotation (extent=[-131.5, -55; -100.5, -22], layer="icon");
        CUTS.ic_position_of_sun ic_position_of_sun_a1
          annotation (extent=[-130.5, 37; -100, 66]);
      equation

          // b = {ic_position_of_sun1.cos_zenith >= 0,ic_position_of_sun1.cos_zenith < 0,

          // ic_total_rad_a1.I > pre(ic_total_rad_a1.I) + epsilon,ic_total_rad_a1.I <

          //  pre(ic_total_rad_a1.I) - epsilon,ic_total_rad1.I > pre(ic_total_rad1.I) +
        // epsilon,ic_total_rad1.I < pre(ic_total_rad1.I) - epsilon};

      algorithm
        b := false;
        c := ic_position_of_sun1.cos_zenith >= 0;

        when {ic_position_of_sun1.cos_zenith >= 0,ic_position_of_sun1.
            cos_zenith < 0,ic_total_rad_a1.I > Hilf1 + epsilon,ic_total_rad_a1.
            I < Hilf1 - epsilon,ic_total_rad1.I > Hilf2 + epsilon,ic_total_rad1.
             I < Hilf2 - epsilon} then

          Hilf1 := ic_total_rad_a1.I;
          Hilf2 := ic_total_rad1.I;
          b := true;

        end when;

        when b then
          if edge(c) then
            d_t := data_t_step - (time - t_point_last_blip);
            I1 := 0;
            I2 := ic_total_rad_a1.I;
            t_point_last_blip := time;
            next_interval_contains_sunset := false;
          else
            if next_interval_contains_sunset then
              next_interval_contains_sunset := false;
              d_t := data_t_step - (time -
                t_point_detection_in_advance_of_sunset);
              I1 := ic_total_rad1.I;
              I2 := 0;
              t_point_last_blip := time;
            else
              d_t := data_t_step;
              I1 := ic_total_rad1.I;
              I2 := ic_total_rad_a1.I;
              t_point_last_blip := time;
            end if;
          end if;
        end when;
        when ic_position_of_sun_a1.cos_zenith <= 0 then
          next_interval_contains_sunset := true;
          t_point_detection_in_advance_of_sunset := time;
        end when;

        oc_total_rad1.I := if ic_position_of_sun1.cos_zenith <= 0 then 0 else
          I1 + ((I2 - I1)/d_t)*(time - t_point_last_blip);

      end lin_total_rad_interpol;
    end rad_interpol;

    package table_reader
      //initialization
      extends icons.universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 319, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1));
      model daily_values_reader
        "Advanced data table reader for daily patterns (e.g. building user behaviour)"

        extends icons.specifics.icon_daily_values_reader;
        extends TIME.t_and_date.ini_and_fin_h_of_d;
        parameter Boolean repeat_cycle=true "Repeat cycle?";
        parameter Integer repetitions_n=0
          "How many times should be repeated? (0=endless)";
        parameter Integer v_d_of_w[:]={1,2,3,4,5,6,7}
          "Applying days of the week";
        parameter Boolean or_holid=true
          "Apply on holidays too (regardless of the day of the week)";
        parameter Boolean and_holid=false
          "Apply only on holidays (falling on the applying days of the week)";
        parameter Boolean ini_hold_zero_value=true
          "Hold 0 value whilst table initial time point not reached yet?";
        parameter Boolean ini_hold_first_value=false
          "Hold 1st interpolation value whilst table initial time point not reached yet?";
        parameter Boolean ini_hold_last_value=false
          "Hold last interpolation value whilst table initial time point not reached yet?";
        parameter Boolean int_hold_zero_value=true
          "Hold 0 value in the intermediate gaps between repetitions?";
        parameter Boolean int_hold_first_value=false
          "Hold 1st interpolation value in the intermediate gaps between repetitions?";
        parameter Boolean int_hold_last_value=false
          "Hold last interpolation value in the intermediate gaps between repetitions?";
        parameter Boolean fin_hold_zero_value=true
          "Hold 0 value when reaching table final time point?";
        parameter Boolean fin_hold_first_value=false
          "Hold 1st interpolation value when reaching table final time point?";
        parameter Boolean fin_hold_last_value=false
          "Hold last interpolation value when reaching table final time point?";
        parameter String tableName="NoName" "Daily values table name on file";
        parameter String fileName="NoName"
          "File where daily values table is stored";
        parameter Real icol[:]={2} "Columns of table to be interpolated";
        parameter Real uf_scaling_factor[:]={1}
          "Scaling factors vector for outputs (enter scalar to apply the same factor to all outputs)";
        parameter Real table[:, :]=[0, 0; 1, 1]
          "Daily values table if no file given";

        parameter Real scaling_factor[size(icol, 1)]=(if size(uf_scaling_factor,
             1) == 1 then ones(size(icol, 1))*uf_scaling_factor[1] else
            uf_scaling_factor);
        Real tableID(start=0);
        Real u(start=0);
        parameter Integer n=size(icol, 1);
        Boolean first_trigger_on(start=false);
        Boolean first_trigger_off(start=false);
        Boolean within_first_period;
        Boolean within_daily_period;
        discrete Real first_period_length;
        Integer cycle_n(start=0);
        Integer applying_cycle_n(start=0);
        Boolean new_cycle(start=false);
        Boolean reached_last_applying_cycle(start=false);
        Real first_trigger_on_t;
        Real acc_t_since_first_trigger_on(start=0);
        Boolean listed_d_of_w;
        Boolean applying_cycle;
        Integer d_of_w;
        annotation (Coordsys(
            extent=[-168, -92; -12, 120],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.1,
            y=0.18,
            width=0.77,
            height=0.73));

        CUTS.OutPort OutPort1(final n=size(icol, 1))
          annotation (extent=[-10, 24; 10, 44]);
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-208, 6; -170, 50], layer="icon");
        CUTS.BooleanInPort ic_holid1 annotation (extent=[-198, 88; -168, 118]);
      equation
        if cardinality(ic_holid1) == 0 then
          ic_holid1.signal = {false};
        end if;

        for i in 1:n loop
          OutPort1.signal[i] = scaling_factor[i]*(if (ini_hold_zero_value and
            not first_trigger_on) or (int_hold_zero_value and first_trigger_off
             and (not reached_last_applying_cycle or (
            reached_last_applying_cycle and applying_cycle and not
            within_daily_period)) and (not within_daily_period or not
            applying_cycle)) or (fin_hold_zero_value and first_trigger_off and
            (reached_last_applying_cycle and not applying_cycle)) then 0 else
            dymTableIpo1(tableID, icol[i], u));
        end for;
        when initial() then
          tableID = dymTableInit(1.0, 0.0, tableName, fileName, table, 0.0);
        end when;
      algorithm
        when ic_t_point1.d_of_y <> pre(ic_t_point1.d_of_y) then
          d_of_w := TIME.f_of_date.inc_d_of_w(d_of_w);
          listed_d_of_w := TIME.f_of_date.d_of_w_in_v(d_of_w, v_d_of_w);
        end when;
        within_daily_period := (ini_h_of_d < fin_h_of_d and ic_t_point1.h_of_d
           >= ini_h_of_d and ic_t_point1.h_of_d < fin_h_of_d) or (ini_h_of_d >
          fin_h_of_d and (ic_t_point1.h_of_d >= ini_h_of_d or ic_t_point1.
          h_of_d < fin_h_of_d)) or ini_h_of_d == fin_h_of_d;
        first_trigger_on := within_daily_period and ((or_holid and ic_holid1.
          signal[1]) or (listed_d_of_w and not and_holid) or (listed_d_of_w
           and (and_holid and ic_holid1.signal[1]))) or pre(first_trigger_on);
        when edge(first_trigger_on) then
          first_trigger_on_t := time;
          first_period_length := if fin_h_of_d > ic_t_point1.h_of_d then (
            fin_h_of_d - ic_t_point1.h_of_d)*60*60 else (fin_h_of_d -
            ic_t_point1.h_of_d + 24)*60*60;
        end when;
        acc_t_since_first_trigger_on := if first_trigger_on then time -
          first_trigger_on_t else 0;
        first_trigger_off := acc_t_since_first_trigger_on >=
          first_period_length and first_trigger_on;
        within_first_period := first_trigger_on and not first_trigger_off;
        new_cycle := acc_t_since_first_trigger_on - ((24*3600) - (period_length
           - first_period_length)) - (cycle_n - 1)*24*60*60 >= 24*60*60 and
          acc_t_since_first_trigger_on > 0;
        if edge(new_cycle) then
          cycle_n := 1 + pre(cycle_n);
          if listed_d_of_w then
            applying_cycle_n := 1 + pre(applying_cycle_n);
          end if;
          reached_last_applying_cycle := (applying_cycle_n >= repetitions_n - 1
             and repetitions_n <> 0) or not repeat_cycle;
          applying_cycle := not ((applying_cycle_n >= repetitions_n and
            repetitions_n <> 0) or not repeat_cycle) and ((or_holid and
            ic_holid1.signal[1]) or (listed_d_of_w and not and_holid) or (
            listed_d_of_w and (and_holid and ic_holid1.signal[1])));
        end if;
        u := if within_first_period or (within_daily_period and applying_cycle) then
                (ic_t_point1.h_of_d - ini_h_of_d)*60*60 else if (
          ini_hold_first_value and not first_trigger_on) or (
          int_hold_first_value and first_trigger_off and (not
          reached_last_applying_cycle or (reached_last_applying_cycle and
          applying_cycle and not within_daily_period)) and (not
          within_daily_period or not applying_cycle)) or (fin_hold_first_value
           and first_trigger_off and (reached_last_applying_cycle and not
          applying_cycle)) then 0 else period_length;
        if u < 0 then
          u := u + 24*60*60;
        end if;
        if initial() then
          //initialization
          d_of_w := TIME.f_of_date.d_of_w_from_jdate(ic_t_point1.d_of_y,
            ic_t_point1.y);
        end if;

        if initial() then
          assert(not ((ini_hold_zero_value and (ini_hold_first_value or
            ini_hold_last_value)) or (ini_hold_first_value and
            ini_hold_last_value)),
            "Error in class 'daily_values_reader': contradictory parameter settings for initial values.");

          assert(ini_hold_zero_value or ini_hold_first_value or
            ini_hold_last_value,
            "Error in class 'daily_values_reader': proving initial condition parameters failed.");

          assert(not (int_hold_zero_value and (int_hold_last_value or
            int_hold_first_value) or (int_hold_last_value and
            int_hold_first_value)),
            "Error in class 'daily_values_reader': contradictory parameter settings for intermediate values.");
          assert((int_hold_zero_value or int_hold_first_value or
            int_hold_last_value) or not repeat_cycle,
            "Error in class 'daily_values_reader': proving intermediate condition parameters failed.");
          assert(not ((fin_hold_zero_value and (fin_hold_last_value or
            fin_hold_first_value)) or (fin_hold_last_value and
            fin_hold_first_value)) or (repeat_cycle and repetitions_n == 0),
            "Error in class 'daily_values_reader': contradictory parameter settings for final values.");
          assert((fin_hold_zero_value or fin_hold_first_value or
            fin_hold_last_value) or (repeat_cycle and repetitions_n == 0),
            "Error in class 'daily_values_reader': proving final condition parameters failed.");
          assert(not (or_holid and and_holid),
            "Error in class 'daily_values_reader': contradictory parameter settings for holiday conditions.");
        end if;
      end daily_values_reader;

      model weather_table_reader "Advanced data table reader for yearly patterns (e.g. typical reference year or real weather data tables)
ATTENTION: Time step of weather data has to be constant; please take daylight-savings into account"

        extends icons.specifics.icon_weather_table_reader;
        extends TIME.t_and_date.ini_and_fin_h_of_d_and_date;
        parameter Boolean high_accuracy=true
          "Read table values at exactely every time step beginn?";
        parameter Real t_step=3600
          "Table time step for step-by-step-reading (s)";
        parameter Boolean read_before_ini_t_and_date=false
          "Repeat cycle before reaching table initial time point?";
        parameter Boolean repeat_cycle=true
          "Repeat cycle when reaching table final time point?";
        parameter Integer repetitions_n=0
          "How many times should be repeated? (0=endless)";
        parameter Boolean ini_hold_zero_value=false
          "Hold 0 value whilst table initial time point not reached yet?";
        parameter Boolean ini_hold_first_value=false
          "Hold 1st interpolation value whilst table initial time point not reached yet?";
        parameter Boolean ini_hold_last_value=false
          "Hold last interpolation value whilst table initial time point not reached yet?";
        parameter Boolean fin_hold_zero_value=false
          "Hold 0 value when reaching table final time point?";
        parameter Boolean fin_hold_first_value=false
          "Hold 1st interpolation value when reaching table final time point?";
        parameter Boolean fin_hold_last_value=false
          "Hold last interpolation value when reaching table final time point?";
        parameter String table_name="NoName" "Weather table name on file";
        parameter String file_name="NoName"
          "File where weather table is stored";
        parameter Real t_unit=1
          "Conversion factor of time units in first column to seconds (e.g. 1, 60, 3600...)";
        parameter Real t_offset=0 "Every 1st value of the table (col 1 row 1)";
        parameter Real uf_scaling_factor[:]={1}
          "Scaling factors vector for outputs (enter scalar to apply the same factor to all outputs)";
        parameter Integer interpol_col[:]={0}
          "Columns of table to be interpolated";
        parameter Integer step_col[:]={0}
          "Columns of table to be read step by step";
        parameter Integer a_step_col[:]={0}
          "Columns of table to be read step by step in advance";

        parameter Integer n_outputs=size(interpol_col, 1) + size(step_col, 1)
             + size(a_step_col, 1) - (if interpol_col[1] == 0 then size(
            interpol_col, 1) else 0) - (if step_col[1] == 0 then size(step_col,
             1) else 0) - (if a_step_col[1] == 0 then size(a_step_col, 1) else
            0);
        parameter Real scaling_factor[n_outputs]=(if size(uf_scaling_factor, 1)
             == 1 then ones(n_outputs)*uf_scaling_factor[1] else
            uf_scaling_factor);
        Real table_id(start=0);
        Real u(start=0);
        Boolean trigger_on(start=false);
        Boolean trigger_off(start=false);
        Boolean within_first_period;
        Boolean new_cycle;
        Boolean reached_last_cycle(start=false);
        Integer cycle_n(start=0);
        Integer ini_cycle_n(start=0);
        Integer current_date_m_ini_date;
        constant Real table[:, :]=[0, 0; 1, 1]
          "Not used here but required by function dymTableInit";
        Boolean read_now(start=false);
        Real next_u;
        function AT_read_next
          input Real tableID;
          input Integer icolIn;
          input Real u;
          output Real out1;
        external "C" out1 = AT_read_next(tableID, icolIn, u);
        end AT_read_next;

        function AT_read_previous
          input Real tableID;
          input Integer icolIn;
          input Real u;
          output Real out1;
        external "C" out1 = AT_read_previous(tableID, icolIn, u);
        end AT_read_previous;

        CUTS.OutPort OutPort1(final n=n_outputs)
          annotation (extent=[58, -6; 78, 14]);
        CUTS.ic_t_point ic_t_point1
          annotation (extent=[-138, -16; -100, 28], layer="icon");
        annotation (
          Coordsys(
            extent=[-98, -112; 56, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6),
          Diagram);
      equation
        when initial() then
          table_id = dymTableInit(1.0, 0.0, table_name, file_name, table, 0.0);
        end when;
        // columns of table to be interpolated
        for i in 1:size(interpol_col, 1) - (if interpol_col[1] == 0 then size(
            interpol_col, 1) else 0) loop
          OutPort1.signal[i] = scaling_factor[i]*(if (not trigger_on and
            ini_hold_zero_value) or (trigger_off and (fin_hold_zero_value and (
            not repeat_cycle or reached_last_cycle))) then 0 else dymTableIpo1(
            table_id, interpol_col[i], u/t_unit + t_offset));
        end for;

        if high_accuracy then
          when read_now or initial() then
            // columns of table to be read step by step (with high accuracy)
            for i in 1 + size(interpol_col, 1) - (if interpol_col[1] == 0 then
                size(interpol_col, 1) else 0):size(interpol_col, 1) + size(
                step_col, 1) - (if interpol_col[1] == 0 then size(interpol_col,
                 1) else 0) - (if step_col[1] == 0 then size(step_col, 1) else
                0) loop
              OutPort1.signal[i] = scaling_factor[i]*(if (not trigger_on and
                ini_hold_zero_value) or (trigger_off and (fin_hold_zero_value
                 and (not repeat_cycle or reached_last_cycle))) then 0 else
                AT_read_previous(table_id, step_col[i - (size(interpol_col, 1)
                 - (if interpol_col[1] == 0 then size(interpol_col, 1) else 0))],
                 (u + t_step/2)/t_unit + t_offset));
            end for;

              // columns of table to be read step by step in advance (with high accuracy)
            for i in 1 + size(interpol_col, 1) + size(step_col, 1) - (if
                interpol_col[1] == 0 then size(interpol_col, 1) else 0) - (if
                step_col[1] == 0 then size(step_col, 1) else 0):size(
                interpol_col, 1) + size(step_col, 1) + size(a_step_col, 1) - (
                if interpol_col[1] == 0 then size(interpol_col, 1) else 0) - (
                if step_col[1] == 0 then size(step_col, 1) else 0) - (if
                a_step_col[1] == 0 then size(a_step_col, 1) else 0) loop
              OutPort1.signal[i] = scaling_factor[i]*(if (not trigger_on and
                ini_hold_zero_value) or (trigger_off and (fin_hold_zero_value
                 and (not repeat_cycle or reached_last_cycle))) then 0 else
                AT_read_next(table_id, a_step_col[i - (size(interpol_col, 1) +
                size(step_col, 1) - (if interpol_col[1] == 0 then size(
                interpol_col, 1) else 0) - (if step_col[1] == 0 then size(
                step_col, 1) else 0))], (u + t_step/2)/t_unit + t_offset));
            end for;
          end when;
        else

          // columns of table to be read step by step (without high accuracy)
          for i in 1 + size(interpol_col, 1) - (if interpol_col[1] == 0 then
              size(interpol_col, 1) else 0):size(interpol_col, 1) + size(
              step_col, 1) - (if interpol_col[1] == 0 then size(interpol_col, 1) else
                    0) - (if step_col[1] == 0 then size(step_col, 1) else 0) loop
            OutPort1.signal[i] = scaling_factor[i]*(if (not trigger_on and
              ini_hold_zero_value) or (trigger_off and (fin_hold_zero_value
               and (not repeat_cycle or reached_last_cycle))) then 0 else
              AT_read_previous(table_id, step_col[i - (size(interpol_col, 1) -
              (if interpol_col[1] == 0 then size(interpol_col, 1) else 0))], u/
              t_unit + t_offset));
          end for;

            // columns of table to be read step by step in advance (without high accuracy)
          for i in 1 + size(interpol_col, 1) + size(step_col, 1) - (if
              interpol_col[1] == 0 then size(interpol_col, 1) else 0) - (if
              step_col[1] == 0 then size(step_col, 1) else 0):size(interpol_col,
               1) + size(step_col, 1) + size(a_step_col, 1) - (if interpol_col[
              1] == 0 then size(interpol_col, 1) else 0) - (if step_col[1] == 0 then
                    size(step_col, 1) else 0) - (if a_step_col[1] == 0 then
              size(a_step_col, 1) else 0) loop
            OutPort1.signal[i] = scaling_factor[i]*(if (not trigger_on and
              ini_hold_zero_value) or (trigger_off and (fin_hold_zero_value
               and (not repeat_cycle or reached_last_cycle))) then 0 else
              AT_read_next(table_id, a_step_col[i - (size(interpol_col, 1) +
              size(step_col, 1) - (if interpol_col[1] == 0 then size(
              interpol_col, 1) else 0) - (if step_col[1] == 0 then size(
              step_col, 1) else 0))], u/t_unit + t_offset));
          end for;
        end if;
      algorithm
        trigger_on := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, ini_d_of_y, ini_y) and ic_t_point1.h_of_d >=
          ini_h_of_d) or (TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
           ic_t_point1.y, ini_d_of_y, ini_y));
        trigger_off := (TIME.f_of_date.jdate_1_e_jdate_2(ic_t_point1.d_of_y,
          ic_t_point1.y, fin_d_of_y, fin_y) and ic_t_point1.h_of_d >=
          fin_h_of_d) or (TIME.f_of_date.jdate_1_g_t_jdate_2(ic_t_point1.d_of_y,
           ic_t_point1.y, fin_d_of_y, fin_y));
        within_first_period := trigger_on and not trigger_off;
        if initial() or ic_t_point1.d_of_y <> pre(ic_t_point1.d_of_y) then
          current_date_m_ini_date := TIME.f_of_date.jdate_1_m_jdate_2(
            ic_t_point1.d_of_y, ic_t_point1.y, ini_d_of_y, ini_y);
        end if;
        if initial() then
          while current_date_m_ini_date*24*60*60 + (ic_t_point1.h_of_d -
              ini_h_of_d)*60*60 - cycle_n*period_length >= period_length or
              current_date_m_ini_date*24*60*60 + (ic_t_point1.h_of_d -
              ini_h_of_d)*60*60 - cycle_n*period_length < 0 loop
            cycle_n := cycle_n + (if trigger_on then 1 else -1);
          end while;
          ini_cycle_n := cycle_n*(if trigger_on then 1 else 0);
        end if;
        u := if within_first_period or (read_before_ini_t_and_date and not
          trigger_on) or (trigger_on and (repeat_cycle and not
          reached_last_cycle)) then current_date_m_ini_date*24*60*60 + (
          ic_t_point1.h_of_d - ini_h_of_d)*60*60 - cycle_n*period_length else
          if (not trigger_on and ini_hold_first_value) or (trigger_off and
          fin_hold_first_value) then 0 else period_length;
        new_cycle := u > period_length;
        if edge(new_cycle) then
          cycle_n := cycle_n + 1;
          reached_last_cycle := (cycle_n - ini_cycle_n) > repetitions_n and
            repetitions_n <> 0;
          u := u - period_length;
        end if;
        when edge(trigger_on) or (initial() and read_before_ini_t_and_date) then
          next_u := rem(u + t_step, period_length);
        end when;
        //don't forget what happens if out of range//
        read_now := u >= next_u and (trigger_on or read_before_ini_t_and_date);
        if edge(read_now) then
          next_u := next_u + t_step;
          if next_u >= period_length then
            next_u := next_u - period_length;
            read_now := false;
          end if;
        end if;
        assert(not (not trigger_on and not (ini_hold_zero_value or
          ini_hold_first_value or ini_hold_last_value or
          read_before_ini_t_and_date)),
          "Error in class 'weather_table_reader': attempting to look up table with time point table entry preceeding table initial time point.");
        assert(not (not within_first_period and (not repeat_cycle or (
          repeat_cycle and reached_last_cycle)) and not (fin_hold_zero_value
           or fin_hold_last_value or fin_hold_first_value)),
          "Error in class 'weather_table_reader': attempting to look up table with time point table entry out of range.");
        if initial() then

          assert(not ((read_before_ini_t_and_date and (ini_hold_zero_value or
            ini_hold_first_value or ini_hold_last_value)) or (
            ini_hold_zero_value and (ini_hold_first_value or
            ini_hold_last_value) or (ini_hold_first_value and
            ini_hold_first_value))),
            "Error in class 'weather_table_reader': contradictory parameter settings for initial values.");
          assert(not (((repeat_cycle and repetitions_n == 0) and (
            fin_hold_zero_value or fin_hold_last_value or fin_hold_first_value))
             or (fin_hold_zero_value and (fin_hold_last_value or
            fin_hold_first_value)) or (fin_hold_last_value and
            fin_hold_first_value)),
            "Error in class 'weather_table_reader': contradictory parameter settings for final values.");
          assert(t_step > 0,
            "Error in class 'weather_table_reader': table time step not greater than zero.");
        end if;
      end weather_table_reader;
    end table_reader;

    package miscel
      extends icons.universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 574, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.43,
          y=0.56,
          width=0.57,
          height=0.44,
          library=1,
          autolayout=1));
      model const_disp "Constants displayer"
        Real pi=Constants.PI;
        Real half_pi=pi/2;
        Real minus_pi=-pi;
        Real minus_half_pi=-pi/2;
        Real zero=0;
        Real ninety=90;
        Real minus_ninety=-90;
        Real hundred_eighty=180;
        Real minus_hundred_eighty=-180;
        annotation (
          Coordsys(
            extent=[0, 0; 658, 516],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.32,
            y=0.04,
            width=0.65,
            height=0.81,
            library=1,
            autolayout=1),
          Invisible=true,
          Icon(
            Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50],
                style(fillColor=30, fillPattern=1)),
            Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30,
                  fillPattern=1)),
            Line(points=[-48, -2; 28, 0], style(color=0, thickness=2)),
            Line(points=[-20, -2; -28, -18; -36, -32; -50, -48], style(color=0,
                   thickness=2)),
            Line(points=[-2, -2; 8, -18; 16, -30; 28, -44], style(color=0,
                  thickness=2)),
            Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70],
                style(fillColor=30, fillPattern=1)),
            Text(
              extent=[99, 99; -99, 69],
              string="%name",
              style(color=73))));
      end const_disp;

      block add_sl_rad "Output the sum of the two inputs"
        extends icons.specifics.icon_add_2;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.23,
            y=0.22,
            width=0.54,
            height=0.66));
        CUTS.ic_beam_rad ic_beam_rad1 annotation (extent=[-144, 40; -100, 78]);
        CUTS.ic_diff_rad ic_diff_rad1 annotation (extent=[-138, -76; -100, -42]);
        CUTS.oc_total_rad oc_total_rad1 annotation (extent=[100, -18; 142, 20]);
      equation
        oc_total_rad1.I = ic_beam_rad1.I + ic_diff_rad1.I;
      end add_sl_rad;

      block sl_rad_to_norm_conn_adaptor
        "Radiation to standard connector adaptor"
        extends icons.specifics.icon_demux_1x1;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-160, -30; -100, 34], layer="icon");
        CUTS.OutPort OutPort1(final n=1)
          annotation (extent=[100, -24; 152, 26], layer="icon");
      equation
        ic_total_rad1.I = OutPort1.signal[1];
      end sl_rad_to_norm_conn_adaptor;

      block norm_to_sl_rad_conn_adaptor
        "Standard to radiation connector adaptor"
        extends icons.specifics.icon_demux_1x1;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        CUTS.InPort InPort1(final n=1) annotation (extent=[-152, -30; -100, 30]);
        CUTS.oc_total_rad oc_total_rad1 annotation (extent=[100, -30; 156, 26]);
      equation
        oc_total_rad1.I = InPort1.signal[1];
      end norm_to_sl_rad_conn_adaptor;

      block demux_total_sl_rad "Demuxer block for two output cuts"
        extends icons.specifics.icon_demux_1x2;
        parameter Integer n=1 "Dimension of input signal connector";
        parameter Integer p_total_rad=1
          "Position of total radiation in input signal connector";
        CUTS.InPort inPort(final n=n) "Connector of Real input signals"
          annotation (extent=[-140, -20; -100, 20]);
        CUTS.OutPort OutPort1(final n=n - 1)
          annotation (extent=[100, -78; 130, -46]);
        CUTS.oc_total_rad oc_total_rad1 annotation (extent=[100, 36; 142, 80]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      equation
        for i in 1:p_total_rad - 1 loop
          inPort.signal[i] = OutPort1.signal[i];
        end for;
        inPort.signal[p_total_rad] = oc_total_rad1.I;
        for i in p_total_rad + 1:n loop
          inPort.signal[i] = OutPort1.signal[i - 1];
        end for;
      end demux_total_sl_rad;

      block demux_sl_rad "Demuxer block for three output cuts"
        extends icons.specifics.icon_demux_1x3;
        parameter Integer n=1 "Dimension of input signal connector";
        parameter Integer p_beam_rad=1
          "Position of beam radiation in input signal connector";
        parameter Integer p_diff_rad=1
          "Position of diffuse radiation in input signal connector";

        parameter Integer p_min=min(p_beam_rad, p_diff_rad) - 1;

        CUTS.InPort inPort(final n=n) "Connector of Real input signals"
          annotation (extent=[-140, -20; -100, 20]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.2,
            y=0.17,
            width=0.6,
            height=0.83));
        CUTS.OutPort OutPort1(final n=n - 2)
          annotation (extent=[100, -74; 130, -40]);
        CUTS.oc_beam_rad oc_beam_rad1 annotation (extent=[100, 40; 136, 78]);
        CUTS.oc_diff_rad oc_diff_rad1 annotation (extent=[100, -16; 136, 18]);
      equation

        for i in 1:p_min loop
          inPort.signal[i] = OutPort1.signal[i];
        end for;
        for i in min(p_beam_rad, p_diff_rad) + 1:max(p_beam_rad, p_diff_rad) -
            1 loop
          inPort.signal[i] = OutPort1.signal[i - 1];
        end for;
        for i in max(p_beam_rad, p_diff_rad) + 1:n loop
          inPort.signal[i] = OutPort1.signal[i - 2];
        end for;

        oc_beam_rad1.I = inPort.signal[p_beam_rad];
        oc_diff_rad1.I = inPort.signal[p_diff_rad];
      end demux_sl_rad;

      block demux_2_total_sl_rad "Demuxer block for three output CUTS"
        extends icons.specifics.icon_demux_1x3;
        parameter Integer n=1 "Dimension of input signal connector";
        parameter Integer p_total_rad1=1
          "Position of 1st total radiation in input signal connector";
        parameter Integer p_total_rad2=1
          "Position of 2nd total radiation in input signal connector";

        parameter Integer p_min=min(p_total_rad1, p_total_rad2) - 1;

        CUTS.InPort inPort(final n=n) "Connector of Real input signals"
          annotation (extent=[-140, -20; -100, 20]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.2,
            y=0.17,
            width=0.6,
            height=0.83));
        CUTS.OutPort OutPort1(final n=n - 2)
          annotation (extent=[100, -74; 130, -40]);
        CUTS.oc_total_rad oc_total_rad1 annotation (extent=[100, 40; 136, 78]);
        CUTS.oc_total_rad oc_total_rad2 annotation (extent=[100, -16; 136, 18]);
      equation

        for i in 1:p_min loop
          inPort.signal[i] = OutPort1.signal[i];
        end for;
        for i in min(p_total_rad1, p_total_rad2) + 1:max(p_total_rad1,
            p_total_rad2) - 1 loop
          inPort.signal[i] = OutPort1.signal[i - 1];
        end for;
        for i in max(p_total_rad1, p_total_rad2) + 1:n loop
          inPort.signal[i] = OutPort1.signal[i - 2];
        end for;

        oc_total_rad1.I = inPort.signal[p_total_rad1];
        oc_total_rad2.I = inPort.signal[p_total_rad2];
      end demux_2_total_sl_rad;

      block mux_sl_rad_2x1
        extends icons.specifics.icon_mux_2x1;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-136, 44; -100, 76], layer="icon");
        CUTS.ic_total_rad ic_total_rad2
          annotation (extent=[-136, -78; -100, -46], layer="icon");
        CUTS.oc_total_rad_v oc_total_rad_v1(final n=2)
          annotation (extent=[100, -18; 138, 14], layer="icon");
      equation
        [oc_total_rad_v1.I] = [ic_total_rad1.I; ic_total_rad2.I];
      end mux_sl_rad_2x1;

      block mux_sl_rad_2x1_mux
        extends icons.specifics.icon_mux_2x1;
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector 1";
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-136, -78; -100, -46], layer="icon");
        CUTS.oc_total_rad_v oc_total_rad_v1(final n=n + 1)
          annotation (extent=[100, -18; 138, 14], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-136, 44; -100, 76]);
      equation
        [oc_total_rad_v1.I] = [ic_total_rad_v1.I; ic_total_rad1.I];
      end mux_sl_rad_2x1_mux;

      block mux_sl_rad_2x1_mux_mux
        extends icons.specifics.icon_mux_2x1;
        parameter Integer n1=n_of_surf_orient_def
          "Dimension of input solar radiation connector 1";
        parameter Integer n2=n_of_surf_orient_def
          "Dimension of input solar radiation connector 2";
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        CUTS.oc_total_rad_v oc_total_rad_v1(final n=n1 + n2)
          annotation (extent=[100, -18; 138, 14], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n1)
          annotation (extent=[-136, 44; -100, 76]);
        CUTS.ic_total_rad_v ic_total_rad_v2(final n=n2)
          annotation (extent=[-136, -78; -100, -46]);
      equation
        [oc_total_rad_v1.I] = [ic_total_rad_v1.I; ic_total_rad_v2.I];
      end mux_sl_rad_2x1_mux_mux;

      block mux_sl_rad_3x1_mux
        extends icons.specifics.icon_mux_3x1;
        parameter Integer n=n_of_surf_orient_def
          "Dimension of input solar radiation connector 1";
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
        CUTS.ic_total_rad ic_total_rad1
          annotation (extent=[-136, -16; -100, 16], layer="icon");
        CUTS.oc_total_rad_v oc_total_rad_v1(final n=n + 2)
          annotation (extent=[100, -18; 138, 14], layer="icon");
        CUTS.ic_total_rad_v ic_total_rad_v1(final n=n)
          annotation (extent=[-136, 44; -100, 76]);
        CUTS.ic_total_rad ic_total_rad2
          annotation (extent=[-136, -78; -100, -46], layer="icon");
      equation
        [oc_total_rad_v1.I] = [ic_total_rad_v1.I; ic_total_rad1.I;
          ic_total_rad2.I];
      end mux_sl_rad_3x1_mux;

    end miscel;
  end TOOLS;

  package CUTS
    extends icons.universals.icon_folder;
    annotation (Coordsys(
        extent=[0, 0; 320, 384],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.68,
        y=0,
        width=0.32,
        height=0.56,
        library=1,
        autolayout=1));
    connector ic_t_point
      extends icons.specifics.cuts.icon_ic_t_point;

      input Real h_of_d;
      input Integer d_of_y;
      input Integer y;
    end ic_t_point;

    connector oc_t_point
      extends icons.specifics.cuts.icon_oc_t_point;

      output Real h_of_d;
      output Integer d_of_y;
      output Integer y;
    end oc_t_point;

    connector ic_position_of_sun "input of sun's position"
      extends icons.specifics.cuts.icon_ic_position_of_sun;
      input SIunits.Angle sin_zenith;
      input SIunits.Angle cos_zenith;
      input SIunits.Angle sin_azimuth;
      input SIunits.Angle cos_azimuth;
      input Boolean shadow;
    end ic_position_of_sun;

    connector oc_position_of_sun "output of sun's position"
      extends icons.specifics.cuts.icon_oc_position_of_sun;
      output SIunits.Angle sin_zenith;
      output SIunits.Angle cos_zenith;
      output SIunits.Angle sin_azimuth;
      output SIunits.Angle cos_azimuth;
      output Boolean shadow;
    end oc_position_of_sun;

    connector ic_beam_rad
      extends icons.specifics.cuts.icon_ic_beam_rad;
      input SIunits.RadiantEnergyFluenceRate I;
    end ic_beam_rad;

    connector oc_beam_rad
      extends icons.specifics.cuts.icon_oc_beam_rad;
      output SIunits.RadiantEnergyFluenceRate I;
    end oc_beam_rad;

    connector ic_diff_rad
      extends icons.specifics.cuts.icon_ic_diff_rad;
      input SIunits.RadiantEnergyFluenceRate I;
    end ic_diff_rad;

    connector oc_diff_rad
      extends icons.specifics.cuts.icon_oc_diff_rad;
      output SIunits.RadiantEnergyFluenceRate I;
    end oc_diff_rad;

    connector ic_total_rad
      extends icons.specifics.cuts.icon_ic_total_rad;
      input SIunits.RadiantEnergyFluenceRate I;
    end ic_total_rad;

    connector oc_total_rad
      extends icons.specifics.cuts.icon_oc_total_rad;
      output SIunits.RadiantEnergyFluenceRate I;
    end oc_total_rad;

    connector ic_total_rad_v
      extends icons.specifics.cuts.icon_ic_total_rad_v;

      parameter Integer n=1 "Dimension of signal vector";
      input SIunits.RadiantEnergyFluenceRate I[n];
    end ic_total_rad_v;

    connector oc_total_rad_v
      extends icons.specifics.cuts.icon_oc_total_rad_v;
      parameter Integer n=1 "Dimension of signal vector";

      output SIunits.RadiantEnergyFluenceRate I[n];
    end oc_total_rad_v;

    connector InPort "Connector with input signals of type Real"
      parameter Integer n=1 "Dimension of signal vector";
      replaceable type SignalType = Real "type of signal";
      input SignalType signal[n] "Real input signals";

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
                color=3, fillColor=3))),
        Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=3, fillColor=3))),
        Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=3, fillColor=3))));
    end InPort;

    connector OutPort "Connector with output signals of type Real"
      parameter Integer n=1 "Dimension of signal vector";
      replaceable type SignalType = Real "type of signal";
      output SignalType signal[n] "Real output signals";

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
                color=3, fillColor=7))),
        Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=3, fillColor=7))),
        Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=3, fillColor=7))));
    end OutPort;

    connector BooleanInPort "Connector with input signals of type Boolean"
      parameter Integer n=1 "Dimension of signal vector";
      input Boolean signal[n] "Boolean input signals";

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
                color=5, fillColor=5))),
        Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=5, fillColor=5))),
        Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=5, fillColor=5))));
    end BooleanInPort;

    connector BooleanOutPort "Connector with output signals of type Boolean"
      parameter Integer n=1 "Dimension of signal vector";
      output Boolean signal[n] "Boolean output signals";

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
                color=5, fillColor=7))),
        Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=5, fillColor=7))),
        Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
              style(color=5, fillColor=7))));
    end BooleanOutPort;
  end CUTS;

  package global

    extends icons.universals.icon_folder;
    annotation (Coordsys(
        extent=[0, 0; 442, 394],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.68,
        y=0,
        width=0.32,
        height=0.56,
        library=1,
        autolayout=1));
    class global_t_and_date
      "Ready-to-instantiate encapsulation of some time-classes"
      extends icons.specifics.icon_global_t_and_date;
      parameter Integer uf_sim_ini_clt_date=01082003
        "Simulation initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_sim_ini_clt_h_of_d=000000
        "Simulation initial clock time (hhmmss)";
      parameter Boolean apply=false
        "Apply daylight savings time rules ? {true,false}";
      parameter String given_t_dir_name="europe"
        "Daylight savings time directive name from database";
      parameter String given_city_name="kaiserslautern"
        "City name from database (\"NoName\"=not registered location)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if no city name entered (-180°...180°)";
      annotation (
        Coordsys(
          extent=[-59.6, -56.2; 73.2, 60.4],
          grid=[0.1, 0.1],
          component=[20, 20]),
        Window(
          x=0.2,
          y=0.33,
          width=0.6,
          height=0.6),
        Diagram);
      TOOLS.location.location_sel location_sel1(given_city_name=given_city_name,
           uf_given_ref_meridian=uf_given_ref_meridian)
        annotation (extent=[-44.2, 28; -16.1, 51.7]);
      CUTS.oc_t_point oc_t_point1 annotation (extent=[54.8, -6; 79.2, 17.6]);
      TIME.t_and_date_processor t_and_date_processor1
        annotation (extent=[-36, -28.3; 13.2, 13.1]);
    equation
      connect(location_sel1.oc_meridians, t_and_date_processor1.ic_meridians)
        annotation (points=[-17.8563, 34.0477; -17.8563, 20.95; -17.8, 20.95; -17.8,
             10.1], style(color=3));
      connect(t_and_date_processor1.oc_clt_point, oc_t_point1)
        annotation (points=[7.6, 10.3; 37.4, 10.3; 37.4, 9.6; 67.2, 9.6]);
    end global_t_and_date;

    class global_extraterr
      extends icons.specifics.icon_global_extraterr;
      parameter Integer uf_sim_ini_clt_date=01012001
        "Simulation initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_sim_ini_clt_h_of_d=000000
        "Simulation initial clock time (hhmmss)";
      parameter Boolean apply=false
        "Apply daylight savings time rules ? {true,false}";
      parameter String given_t_dir_name="europe"
        "Daylight savings time directive name from database";
      parameter Real uf_given_latitude=49.45
        "Latitude angle if not entered via connector (-90°...90°)";
      parameter Real uf_given_longitude=7.75
        "Longitude angle if not entered via connector (-180°...180°)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if not entered via connector (-180°...180°)";

      SOLAR.position_of_sun position_of_sun1
        annotation (extent=[-2.2, -4.1; 12.8, 11.9]);
      SOLAR.extraterr_rad_on_horiz extraterr_rad_on_horiz1
        annotation (extent=[19.8, -4.6; 33.8, 9]);
      TIME.t_and_date_processor t_and_date_processor1(uf_sim_ini_clt_date=
            uf_sim_ini_clt_date, uf_sim_ini_clt_h_of_d=uf_sim_ini_clt_h_of_d)
        annotation (extent=[-23.4, -2.9; -12.4, 7.1]);
      SOLAR.declination declination1 annotation (extent=[-1, -20.8; 12, -7.8]);
      CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
        annotation (extent=[62.9, 17.3; 82.9, 37.3]);
      CUTS.oc_t_point oc_t_point1 annotation (extent=[63.2, 40.4; 80.6, 58.8]);
      CUTS.oc_beam_rad oc_beam_rad_horiz
        annotation (extent=[62.6, -5.5; 82.6, 14.5]);
      annotation (
        Coordsys(
          extent=[-61.2, -56.2; 72, 60.4],
          grid=[0.1, 0.1],
          component=[20, 20]),
        Window(
          x=0.1,
          y=0.13,
          width=0.74,
          height=0.69),
        Diagram,
        Icon);
      CUTS.InPort ic_latitude1 annotation (extent=[73.8, -28.6; 62.6, -18.7]);
      CUTS.InPort ic_meridians1(n=2)
        annotation (extent=[73.4, -47.5; 62.2, -37.6]);
      SOLAR.rad_on_surf.tilted.extraterr_rad_on_tilted_surf_mux
        extraterr_rad_on_tilted_surf_mux1
        annotation (extent=[22.3, 15.6; 42.3, 35.6]);
    equation
      connect(declination1.oc_declination1, position_of_sun1.ic_declination)
        annotation (points=[11.4, -12.6848; 14.6, -12.6848; 14.6, -5.9; -6, -5.9;
             -6, 8.1; -1.8, 8.1]);
      connect(t_and_date_processor1.oc_slt_point, declination1.ic_slt_point1)
        annotation (points=[-16.7316, 6.5; -16.7316, 10.7; -8.2, 10.7; -8.2, -8.66667;
             0, -8.66667], style(color=57));
      connect(t_and_date_processor1.oc_slt_point, position_of_sun1.
        ic_slt_point1) annotation (points=[-16.7316, 6.5; -16.7316, 10.7; -8.2,
             10.7; -8.2, 1.3; -1.2, 1.3], style(color=57));
      connect(t_and_date_processor1.ic_meridians_a, t_and_date_processor1.
        ic_meridians) annotation (points=[-21, 6.5; -21, 13.1; -19.6, 13.1; -19.6,
             6.5], style(color=73));
      connect(t_and_date_processor1.oc_clt_point, oc_t_point1) annotation (
          points=[-13.3821, 6.325; -13.3821, 2.8; -9.4, 2.8; -9.4, -19.1; -29.1,
             -19.1; -29.1, 48.6; 79.6, 48.6], style(color=57, thickness=2));
      connect(position_of_sun1.oc_position_of_sun1, extraterr_rad_on_horiz1.
        ic_position_of_sun1)
        annotation (points=[12.3, 7.9; 20.8481, 7.9], style(color=41));
      connect(position_of_sun1.ic_slt_point1, extraterr_rad_on_horiz1.
        ic_slt_point1) annotation (points=[-1.7, 1.3; -3.7, 1.3; -3.7, -4.1;
            14.3, -4.1; 14.3, 1.7; 20.6, 1.7], style(color=57));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        oc_beam_rad_horiz) annotation (points=[33.6, 4.4; 64.1, 4.4], style(
            color=45, thickness=2));
      connect(ic_latitude1, position_of_sun1.ic_latitude) annotation (points=[
            69.3, -23.4; -32, -23.4; -32, 17.8; -4.2, 17.8; -4.2, 5.2; -1.7,
            5.2], style(thickness=2));
      connect(ic_meridians1, t_and_date_processor1.ic_meridians) annotation (
          points=[65.2, -42.5; -34.7, -42.5; -34.7, 13.1; -19.5, 13.1; -19.5,
            6.5], style(thickness=2));
      connect(extraterr_rad_on_tilted_surf_mux1.
        oc_extraterr_rad_on_tilted_surf_v1, oc_total_rad_v1) annotation (points=
           [44.4, 27.6; 63.7, 27.6], style(color=45, thickness=2));
      connect(position_of_sun1.oc_position_of_sun1,
        extraterr_rad_on_tilted_surf_mux1.ic_position_of_sun1) annotation (
          points=[12.3, 7.9; 15.4, 7.9; 15.4, 32.6; 19.1, 32.6], style(color=41));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        extraterr_rad_on_tilted_surf_mux1.ic_extraterr_rad_on_horiz)
        annotation (points=[33.6, 4.6; 37.3, 4.6; 37.3, 14.1; 16.4, 14.1; 16.4,
             26.8; 19.5, 26.8], style(color=45));
      if cardinality(ic_meridians1) == 1 then
        ic_meridians1.signal = {uf_given_longitude*conv_deg_to_rad,
          uf_given_ref_meridian*conv_deg_to_rad};
      end if;
      if cardinality(ic_latitude1) == 1 then
        ic_latitude1.signal = {uf_given_latitude*conv_deg_to_rad};
      end if;
    end global_extraterr;

    class global_1
      extends icons.specifics.icon_global;
      parameter Integer uf_sim_ini_clt_date=01082003
        "Simulation initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_sim_ini_clt_h_of_d=000000
        "Simulation initial clock time (hhmmss)";
      parameter Boolean apply=false
        "Apply daylight savings time rules ? {true,false}";
      parameter String given_t_dir_name="europe"
        "Daylight savings time directive name from database";
      parameter String given_city_name=none
        "City name from database (\"NoName\"=not registered location)";
      parameter Real uf_given_latitude=49.45
        "Latitude angle if no city name entered (-90°...90°)";
      parameter Real uf_given_longitude=7.75
        "Longitude angle if no city name entered (-180°...180°)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if no city name entered (-180°...180°)";
      parameter Integer mode=1
        "Tilted surface radiation mode (see user manual) (1,2 or 3)";
      parameter Real rho_ground=0.2 "Ground reflectance around the area";
      parameter Real kT=0.76
        "Clearness index if not entered via connector (0...1)";

      SOLAR.position_of_sun position_of_sun1
        annotation (extent=[-35.4, 8.1; -20.4, 24.1]);
      SOLAR.extraterr_rad_on_horiz extraterr_rad_on_horiz1
        annotation (extent=[-13.4, 7.6; 0.6, 21.2]);
      TIME.t_and_date_processor t_and_date_processor1(uf_sim_ini_clt_date=
            uf_sim_ini_clt_date, uf_sim_ini_clt_h_of_d=uf_sim_ini_clt_h_of_d)
        annotation (extent=[-57.6, -29.2; -46.6, -19.2]);
      TOOLS.location.location_sel location_sel1(
        given_city_name=given_city_name,
        uf_given_latitude=uf_given_latitude,
        uf_given_longitude=uf_given_longitude,
        uf_given_ref_meridian=uf_given_ref_meridian)
        annotation (extent=[-59.6, 29.9; -49, 39.1]);
      SOLAR.declination declination1
        annotation (extent=[-34.2, -8.6; -21.2, 4.4]);
      SOLAR.rad_on_surf.tilted.rad_on_tilted_surf_mux rad_on_tilted_surf_mux1(
          mode=mode, rho_ground=rho_ground)
        annotation (extent=[44.2, 7.5; 57.2, 21.1]);
      CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
        annotation (extent=[62.9, 17.3; 82.9, 37.3]);
      CUTS.oc_t_point oc_t_point1 annotation (extent=[63.2, 40.4; 80.6, 58.8]);
      CUTS.oc_beam_rad oc_beam_rad_horiz
        annotation (extent=[62.6, -5.5; 82.6, 14.5]);
      CUTS.oc_diff_rad oc_diff_rad_horiz
        annotation (extent=[62.6, -28.5; 82.6, -8.5]);
      annotation (
        Coordsys(
          extent=[-62.7, -56.2; 73.7, 60.4],
          grid=[0.1, 0.1],
          component=[20, 20]),
        Window(
          x=0.1,
          y=0.13,
          width=0.74,
          height=0.69),
        Diagram,
        Icon(Text(
            extent=[28.1, 59.5; 59.2, 19.9],
            string="1",
            style(color=41))));
      SOLAR.rad_on_surf.horiz.rad_on_horiz_1 rad_on_horiz_1_1
        annotation (extent=[28.6, 6.4; 38.9, 18.9]);
      CUTS.InPort ic_kT1(n=1) annotation (extent=[81.5, -38.2; 65.1, -51.4]);
      SOLAR.atm_att atm_att1 annotation (extent=[9.8, 7.5; 20.4, 18.4]);
      TIME.dlight_svngs.dlight_svngs_t_sw dlight_svngs_t_sw1
        annotation (extent=[-57.4, -50.5; -46.58, -38.47]);
      TIME.daylight_svngs_adder daylight_svngs_adder
        annotation (extent=[-44.2, -30.24; -33.9, -20.64]);
    equation
      connect(location_sel1.oc_latitude, position_of_sun1.ic_latitude)
        annotation (points=[-49.125, 38.2081; -41, 38.2081; -41, 16.9; -34.3562,
             16.9], style(color=0));
      connect(declination1.oc_declination1, position_of_sun1.ic_declination)
        annotation (points=[-21.8, -0.484848; -18.6, -0.484848; -18.6, 6.3; -39.2,
             6.3; -39.2, 20.3; -35, 20.3]);
      connect(location_sel1.oc_meridians, t_and_date_processor1.ic_meridians_a)
         annotation (points=[-50, 32; -47, 32; -47, 25.2; -55.4062, 25.2; -55.4062,
             -19.975], style(color=0));
      connect(t_and_date_processor1.ic_meridians_a, t_and_date_processor1.
        ic_meridians) annotation (points=[-55.3062, -19.675; -55.3, -19.9; -53.9,
             -19.9; -53.8813, -19.675], style(color=0));
      connect(rad_on_horiz_1_1.oc_diff_rad_on_horiz1, oc_diff_rad_horiz)
        annotation (points=[38.1, 10.2; 40.2, 10.2; 40.2, -18.4; 65.6, -18.4],
          style(color=45, thickness=2));
      connect(rad_on_horiz_1_1.oc_beam_rad_on_horiz1, oc_beam_rad_horiz)
        annotation (points=[38.3, 12.6; 42, 12.6; 42, 4.5; 64.4, 4.5], style(
            color=45, thickness=2));
      connect(rad_on_horiz_1_1.oc_beam_rad_on_horiz1, rad_on_tilted_surf_mux1.
        ic_beam_rad_on_horiz)
        annotation (points=[38.3, 12.6; 45.4, 12.6], style(color=45));
      connect(rad_on_horiz_1_1.oc_diff_rad_on_horiz1, rad_on_tilted_surf_mux1.
        ic_diff_rad_on_horiz)
        annotation (points=[38.1, 10.2; 45.3, 10.2], style(color=45));
      connect(rad_on_tilted_surf_mux1.oc_total_rad_v1, oc_total_rad_v1)
        annotation (points=[56.7, 12.7; 58.3, 12.7; 58.3, 28; 63.9, 28], style(
            color=45, thickness=2));
      connect(position_of_sun1.oc_position_of_sun1, extraterr_rad_on_horiz1.
        ic_position_of_sun1)
        annotation (points=[-20.9, 20.1; -12.3519, 20.1], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_tilted_surf_mux1.
        ic_position_of_sun1) annotation (points=[-21, 20.1; -16.6, 20.1; -16.6,
             25.1; 41.7, 25.1; 41.7, 18.7; 45, 18.7], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_horiz_1_1.
        ic_position_of_sun1) annotation (points=[-21, 20.1; -16.6, 20.1; -16.6,
             25.1; 25.1, 25.1; 25.1, 17.9; 28.2, 17.9], style(color=41));
      connect(position_of_sun1.ic_slt_point1, extraterr_rad_on_horiz1.
        ic_slt_point1) annotation (points=[-34.9, 13.5; -36.9, 13.5; -36.9, 8.1;
             -18.9, 8.1; -18.9, 13.9; -12.6, 13.9], style(color=57));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        rad_on_tilted_surf_mux1.ic_extraterr_rad_on_horiz) annotation (points=[
            0.6, 17; 3.1, 17; 3.1, 23.3; 40.2, 23.3; 40.2, 16.8; 45.4, 16.8],
          style(color=45));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1, atm_att1.
        ic_extraterr_rad_on_horiz1) annotation (points=[0.6, 17; 3.1, 17; 3.1,
            18.3; 9.5, 18.3], style(color=45));
      connect(atm_att1.oc_total_rad_on_horiz1, rad_on_horiz_1_1.
        ic_total_rad_on_horiz1)
        annotation (points=[20.3, 10.8; 28.6, 10.8], style(color=45));
      connect(ic_kT1, atm_att1.ic_kT1) annotation (points=[73.7, -44.4; 23.5, -44.4;
             23.5, 13.7; 20.5, 13.7], style(thickness=2));
      if cardinality(ic_kT1) == 1 then
        ic_kT1.signal = {kT};
      end if;
      connect(daylight_svngs_adder.oc_slt_point, declination1.ic_slt_point1)
        annotation (points=[-37.399, -21.408; -37.4, 2.9; -33.5396, 3.53333],
          style(color=53));
      connect(daylight_svngs_adder.oc_slt_point, position_of_sun1.ic_slt_point1)
         annotation (points=[-37.299, -21.208; -37.4, 13.5; -33.9094, 13.4],
          style(color=53));
      connect(daylight_svngs_adder.oc_clt_point, oc_t_point1) annotation (
          points=[-34.8, -21.5; -34.8, -13.1; 4.8, -13.1; 4.8, 50.1; 63.5, 50.1],
           style(color=53));
      connect(dlight_svngs_t_sw1.oc_dlight_svngs_t_shift, daylight_svngs_adder.
        ic_dlight_svngs_t_shift) annotation (points=[-46.2837, -38.6081; -42.6,
             -38.6081; -42.6, -34.6; -45.5, -34.6; -45.5, -24.3; -43.7, -24.3],
           style(color=3));
      connect(t_and_date_processor1.oc_clt_point, daylight_svngs_adder.
        ic_clt_point) annotation (points=[-47.8, -20.3; -47.8, -18.3; -39.9, -18.3;
             -39.9, -21.5], style(color=53));
      connect(t_and_date_processor1.oc_lsmt_point, daylight_svngs_adder.
        ic_lsmt_point) annotation (points=[-49.5, -20.2; -49.5, -18.3; -41.2, -18.3;
             -41.2, -21.4], style(color=53));
      connect(t_and_date_processor1.oc_slt_point, daylight_svngs_adder.
        ic_slt_point) annotation (points=[-51, -20.3; -51, -18.3; -42.4, -18.3;
             -42.4, -21.1], style(color=53));
      connect(t_and_date_processor1.oc_aslt_point, daylight_svngs_adder.
        ic_aslt_point) annotation (points=[-52.4, -20; -52.4, -18.3; -43.6, -18.3;
             -43.6, -21.5], style(color=53));
      connect(t_and_date_processor1.oc_clt_point, dlight_svngs_t_sw1.
        ic_clt_point1) annotation (points=[-47.7, -19.975; -44.1, -19.975; -44.1,
             -41.8076; -46.0691, -41.8076], style(color=53));
      connect(rad_on_horiz_1_1.ic_kT1, atm_att1.ic_kT1) annotation (points=[
            28.1, 13.8; 24.1, 13.8; 24.1, 13.6; 20.1, 13.6], style(color=3));
    end global_1;

    class global_2 "Clear-day radiation source"
      extends icons.specifics.icon_global;
      parameter Integer uf_sim_ini_clt_date=01082003
        "Simulation initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_sim_ini_clt_h_of_d=000000
        "Simulation initial clock time (hhmmss)";
      parameter Boolean apply=false
        "Apply daylight savings time rules ? {true,false}";
      parameter String given_t_dir_name="europe"
        "Daylight savings time directive name from database";
      parameter String given_city_name=none
        "City name from database (\"NoName\"=not registered location)";
      parameter Real uf_given_latitude=49.45
        "Latitude angle if no city name entered (-90°...90°)";
      parameter Real uf_given_longitude=7.75
        "Longitude angle if no city name entered (-180°...180°)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if no city name entered (-180°...180°)";
      parameter Integer mode=1
        "Tilted surface radiation mode (see user manual) (1,2 or 3)";
      parameter Real rho_ground=0.2 "Ground reflectance around the area";
      parameter Real c_n=0.9 "Clearness number (0...1)";
      parameter Real atm_extinction_coef=0.142
        "Atmospheric extinction coefficient";

      SOLAR.position_of_sun position_of_sun1
        annotation (extent=[-35.4, 8.1; -20.4, 24.1]);
      SOLAR.extraterr_rad_on_horiz extraterr_rad_on_horiz1
        annotation (extent=[-13.4, 7.6; 0.6, 21.2]);
      TIME.t_and_date_processor t_and_date_processor1(uf_sim_ini_clt_date=
            uf_sim_ini_clt_date, uf_sim_ini_clt_h_of_d=uf_sim_ini_clt_h_of_d)
        annotation (extent=[-56.9, -21.9; -45.9, -11.9]);
      TOOLS.location.location_sel location_sel1(
        given_city_name=given_city_name,
        uf_given_latitude=uf_given_latitude,
        uf_given_longitude=uf_given_longitude,
        uf_given_ref_meridian=uf_given_ref_meridian)
        annotation (extent=[-59.7, 29.6; -49.1, 38.8]);
      SOLAR.declination declination1
        annotation (extent=[-34.2, -8.6; -21.2, 4.4]);
      SOLAR.rad_on_surf.tilted.rad_on_tilted_surf_mux rad_on_tilted_surf_mux1(
          mode=mode, rho_ground=rho_ground)
        annotation (extent=[44.2, 7.5; 57.2, 21.1]);
      CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
        annotation (extent=[62.9, 17.3; 82.9, 37.3]);
      CUTS.oc_t_point oc_t_point1 annotation (extent=[63.2, 40.4; 80.6, 58.8]);
      CUTS.oc_beam_rad oc_beam_rad_horiz
        annotation (extent=[62.6, -5.5; 82.6, 14.5]);
      CUTS.oc_diff_rad oc_diff_rad_horiz
        annotation (extent=[62.6, -28.5; 82.6, -8.5]);
      annotation (
        Coordsys(
          extent=[-62.7, -56.2; 72.9, 60.4],
          grid=[0.1, 0.1],
          component=[20, 20]),
        Window(
          x=0.1,
          y=0.13,
          width=0.74,
          height=0.69),
        Diagram,
        Icon(Text(
            extent=[28.1, 59.5; 59.2, 19.9],
            string="2",
            style(color=41))));
      SOLAR.rad_on_surf.horiz.rad_on_horiz_on_clear_d rad_on_horiz_on_clear_d1(
          c_n=c_n, atm_extinction_coef=atm_extinction_coef)
        annotation (extent=[14.7, 5.6; 30.9, 18.8]);
      TIME.dlight_svngs.dlight_svngs_t_sw dlight_svngs_t_sw1
        annotation (extent=[-61.8, -38.3; -51.5, -28.7]);
      TIME.daylight_svngs_adder daylight_svngs_adder
        annotation (extent=[-43.52, -22.07; -33.22, -12.47]);
    equation
      connect(location_sel1.oc_latitude, position_of_sun1.ic_latitude)
        annotation (points=[-49.7625, 38.2081; -41, 38.2081; -41, 16.9; -34.3562,
             16.9], style(color=0));
      connect(declination1.oc_declination1, position_of_sun1.ic_declination)
        annotation (points=[-21.8, -0.484848; -18.6, -0.484848; -18.6, 6.3; -39.2,
             6.3; -39.2, 20.3; -35, 20.3]);
      connect(location_sel1.oc_meridians, t_and_date_processor1.ic_meridians_a)
         annotation (points=[-49.8, 32.1; -46.8, 32.1; -46.8, 25.3; -54.5062,
            25.3; -54.5062, -12.675], style(color=0));
      connect(t_and_date_processor1.ic_meridians_a, t_and_date_processor1.
        ic_meridians) annotation (points=[-54.5062, -12.675; -53.0813, -12.675],
           style(color=0));
      connect(rad_on_tilted_surf_mux1.oc_total_rad_v1, oc_total_rad_v1)
        annotation (points=[56.7, 12.7; 58.3, 12.7; 58.3, 28; 63.9, 28], style(
            color=45, thickness=2));
      connect(position_of_sun1.oc_position_of_sun1, extraterr_rad_on_horiz1.
        ic_position_of_sun1)
        annotation (points=[-20.9, 20.1; -12.3519, 20.1], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_tilted_surf_mux1.
        ic_position_of_sun1) annotation (points=[-21, 20.1; -16.6, 20.1; -16.6,
             25.1; 41.7, 25.1; 41.7, 18.7; 45, 18.7], style(color=41));
      connect(position_of_sun1.ic_slt_point1, extraterr_rad_on_horiz1.
        ic_slt_point1) annotation (points=[-34.9, 13.5; -36.9, 13.5; -36.9, 8.1;
             -18.9, 8.1; -18.9, 13.9; -12.6, 13.9], style(color=57));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        rad_on_tilted_surf_mux1.ic_extraterr_rad_on_horiz) annotation (points=[
            0.6, 17; 3.1, 17; 3.1, 23.3; 40.2, 23.3; 40.2, 16.8; 45.4, 16.8],
          style(color=45));
      connect(rad_on_horiz_on_clear_d1.oc_diff_rad1, rad_on_tilted_surf_mux1.
        ic_diff_rad_on_horiz)
        annotation (points=[30.9, 10; 45.6, 10], style(color=45));
      connect(rad_on_tilted_surf_mux1.ic_beam_rad_on_horiz,
        rad_on_horiz_on_clear_d1.oc_beam_rad_on_horiz1)
        annotation (points=[45.2, 12.5; 31.1, 12.5], style(color=45));
      connect(rad_on_horiz_on_clear_d1.oc_diff_rad1, oc_diff_rad_horiz)
        annotation (points=[30.9, 10; 40.1, 10; 40.1, -18.4; 64.9, -18.4],
          style(color=45, thickness=2));
      connect(rad_on_horiz_on_clear_d1.oc_beam_rad_on_horiz1, oc_beam_rad_horiz)
         annotation (points=[31.5, 12.5; 42.1, 12.5; 42.1, 4.4; 63.7, 4.4],
          style(color=45, thickness=2));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        rad_on_horiz_on_clear_d1.ic_extraterr_rad_on_horiz1) annotation (points=
           [0.4, 17; 3.1, 17; 3.1, 14.6; 14.3, 14.6], style(color=45));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_horiz_on_clear_d1.
        ic_position_of_sun1) annotation (points=[-21.2, 20.1; -16.6, 20.1; -16.6,
             25.1; 10.4, 25.1; 10.4, 19.5; 13.9, 19.5], style(color=41));
      connect(daylight_svngs_adder.oc_slt_point, position_of_sun1.ic_slt_point1)
         annotation (points=[-36.6, -13.7; -36.6, 13.6; -34, 13.6], style(color=
             53));
      connect(daylight_svngs_adder.oc_slt_point, declination1.ic_slt_point1)
        annotation (points=[-36.5, -13.6; -36.5, 3.3; -33, 3.3], style(color=53));
      connect(dlight_svngs_t_sw1.oc_dlight_svngs_t_shift, daylight_svngs_adder.
        ic_dlight_svngs_t_shift) annotation (points=[-51.0994, -28.8779; -39.5,
             -28.8779; -39.5, -23.6; -44.5, -23.6; -44.5, -16.1; -42.799, -16.1],
           style(color=3, fillPattern=1));
      connect(t_and_date_processor1.oc_clt_point, daylight_svngs_adder.
        ic_clt_point) annotation (points=[-47.4, -12.7; -47.4, -10.4; -39.4, -10.4;
             -39.5, -13.3], style(color=53, fillPattern=1));
      connect(t_and_date_processor1.oc_lsmt_point, daylight_svngs_adder.
        ic_lsmt_point) annotation (points=[-48.8, -12.7; -48.8, -10.4; -40.6, -10.4;
             -40.6, -13.4], style(color=53, fillPattern=1));
      connect(t_and_date_processor1.oc_slt_point, daylight_svngs_adder.
        ic_slt_point) annotation (points=[-50.2, -12.9; -50.2, -10.4; -41.7, -10.4;
             -41.7, -13.6], style(color=53, fillPattern=1));
      connect(t_and_date_processor1.oc_aslt_point, daylight_svngs_adder.
        ic_aslt_point) annotation (points=[-51.6, -13.1; -51.6, -10.4; -43.1, -10.4;
             -43.1, -13.5], style(color=53, fillPattern=1));
      connect(daylight_svngs_adder.oc_clt_point, oc_t_point1) annotation (
          points=[-34.4, -13.4; -34.4, -9.1; 8.7, -9.1; 8.7, 50.4; 65.4, 50.4],
           style(color=53, fillPattern=1));
      connect(t_and_date_processor1.oc_clt_point, dlight_svngs_t_sw1.
        ic_clt_point1) annotation (points=[-47.4, -12.5; -47.4, -10.9; -44.4, -10.9;
             -44.4, -31.3789; -50.7136, -31.3789]);
    end global_2;

    class global_4 "Radiation source coupled to averaged radiation data table (interpolation by means of the averaged extraterrestrial radiation curve)
ATTENTION: Time step of weather table has to be constant; apply has to be true when daylight-savings are taken into account."

      extends icons.specifics.icon_global;
      parameter Integer uf_sim_ini_clt_date=01082003
        "Simulation initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_sim_ini_clt_h_of_d=000000
        "Simulation initial clock time (hhmmss)";
      parameter Integer uf_ini_date=01012001
        "Weather data initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_ini_h_of_d=000000
        "Weather data initial clock time (hhmmss)";
      parameter Integer uf_fin_date=01012003
        "Weather data final clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_fin_h_of_d=000000
        "Weather data final clock time (hhmmss)";
      parameter Boolean apply=false
        "Apply daylight savings time rules ? {true,false}";
      parameter String given_t_dir_name="europe"
        "Daylight savings time directive name from database";
      parameter String given_city_name="kaiserslautern"
        "City name from database (\"NoName\"=not registered location)";
      parameter Real uf_given_latitude=49.45
        "Latitude angle if no city name entered (-90°...90°)";
      parameter Real uf_given_longitude=7.75
        "Longitude angle if no city name entered (-180°...180°)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if no city name entered (-180°...180°)";
      parameter String table_name="NoName" "Weather data table name on file";
      parameter String file_name="NoName"
        "File where the weather data table is stored";
      parameter Integer weather_data_t_step=3600 "Weather data time step (s)";
      parameter Integer beam_rad_col=2
        "Column number in table containing integrated beam radiation data (1st column= time)";
      parameter Integer diff_rad_col=2
        "Column number in table containing integrated diffuse radiation data (1st column= time)";
      parameter Integer more_outputs_col[:]={2}
        "Additional columns in weather data table to output (minimum 1 column)";
      parameter Integer mode=1
        "Tilted surface radiation mode (see user manual) (1,2 or 3)";
      parameter Real rho_ground=0.2 "Ground reflectance around the area";

      parameter Integer n_more_outputs=size(more_outputs_col, 1) - (if
          more_outputs_col[1] == 0 then size(more_outputs_col, 1) else 0);

      SOLAR.position_of_sun position_of_sun1
        annotation (extent=[-35.8, -15; -20.8, 1]);
      SOLAR.extraterr_rad_on_horiz extraterr_rad_on_horiz1
        annotation (extent=[-13.4, -14.4; 0.6, -0.8]);
      TIME.t_and_date_processor t_and_date_processor1(
        uf_sim_ini_clt_date=uf_sim_ini_clt_date,
        uf_sim_ini_clt_h_of_d=uf_sim_ini_clt_h_of_d,
        forwarded_clock_t_gap=weather_data_t_step)
        annotation (extent=[-57, -54.3; -46, -44.3], rotation=0);
      SOLAR.declination declination_a
        annotation (extent=[-32.6, 35.4; -19.6, 46.6]);
      TOOLS.location.location_sel location_sel1(
        given_city_name=given_city_name,
        uf_given_latitude=uf_given_latitude,
        uf_given_longitude=uf_given_longitude,
        uf_given_ref_meridian=uf_given_ref_meridian)
        annotation (extent=[-59.6, 6.9; -49, 16.1]);
      TOOLS.rad_integ.aver_rad_integ_ini_and_length
        aver_rad_integ_ini_and_length_a(
        uf_ini_h_of_d=000000,
        integ_before_ini_t_and_date=true,
        p=weather_data_t_step,
        uf_ini_date=uf_ini_date) annotation (extent=[14.2, 17.3; 29.8, 30.2]);
      SOLAR.position_of_sun position_of_sun_a
        annotation (extent=[-35.2, 15.2; -20.2, 32.2]);
      SOLAR.extraterr_rad_on_horiz extraterr_rad_on_horiz_a
        annotation (extent=[-13.6, 16.4; 0.4, 29.4]);
      SOLAR.declination declination1
        annotation (extent=[-34.4, -39.8; -21.4, -26.8]);
      TOOLS.miscel.demux_sl_rad demux_sl_rad1(
        n=2 + n_more_outputs,
        p_beam_rad=n_more_outputs + 1,
        p_diff_rad=n_more_outputs + 2)
        annotation (extent=[9.1, -42.6; 15.7, -35.4]);
      TOOLS.rad_interpol.beam_and_diff_rad_interpol beam_and_diff_rad_interpol1
        annotation (extent=[25.2, -6.6; 39, 8.8]);
      SOLAR.rad_on_surf.tilted.rad_on_tilted_surf_mux rad_on_tilted_surf_mux1(
          mode=mode, rho_ground=rho_ground)
        annotation (extent=[43.4, -5.8; 56, 7.4]);
      TOOLS.table_reader.weather_table_reader weather_table_reader(
        uf_ini_h_of_d=000000,
        uf_fin_h_of_d=000000,
        high_accuracy=true,
        t_step=weather_data_t_step,
        repeat_cycle=true,
        repetitions_n=0,
        ini_hold_zero_value=true,
        ini_hold_first_value=false,
        ini_hold_last_value=false,
        fin_hold_zero_value=false,
        fin_hold_first_value=false,
        fin_hold_last_value=false,
        interpol_col=more_outputs_col,
        step_col={0},
        a_step_col={beam_rad_col,diff_rad_col},
        table_name=table_name,
        file_name=file_name,
        uf_ini_date=uf_ini_date,
        uf_fin_date=uf_fin_date) annotation (extent=[-11.6, -46.2; -0.7, -35.8]);
      CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
        annotation (extent=[62.9, 17.3; 82.9, 37.3]);
      CUTS.oc_t_point oc_t_point1 annotation (extent=[63.2, 40.4; 80.6, 58.8]);
      CUTS.oc_beam_rad oc_beam_rad_horiz1
        annotation (extent=[62.6, -5.5; 82.6, 14.5]);
      CUTS.oc_diff_rad oc_diff_rad_horiz1
        annotation (extent=[62.6, -28.5; 82.6, -8.5]);
      annotation (
        Coordsys(
          extent=[-61.2, -56.2; 72, 60.4],
          grid=[0.1, 0.1],
          component=[20, 20]),
        Window(
          x=0.04,
          y=0.34,
          width=0.74,
          height=0.69),
        Icon(Text(
            extent=[28.1, 59.5; 59.2, 19.9],
            string="4",
            style(color=41))),
        Diagram);
      CUTS.OutPort oc_weather_data_table1(final n=n_more_outputs)
        annotation (extent=[62.4, -52.7; 72.7, -42.8], layer="icon");
      TIME.daylight_svngs_adder daylight_svngs_adder
        annotation (extent=[-42.4, -52.1; -33.7, -44.5]);
      TIME.dlight_svngs.dlight_svngs_t_sw dlight_svngs_t_sw1
        annotation (extent=[-63.7, -35.4; -56.5, -26.3]);
    equation
      connect(location_sel1.oc_latitude, position_of_sun_a.ic_latitude)
        annotation (points=[-49.6625, 15.4345; -41.4, 15.4345; -41.4, 24.5596;
            -34.3563, 24.5596], style(color=57));
      connect(location_sel1.oc_latitude, position_of_sun1.ic_latitude)
        annotation (points=[-49.6625, 15.4345; -41.6, 15.4345; -41.6, -6.19101;
             -34.9562, -6.19101], style(color=0));
      connect(declination_a.oc_declination1, position_of_sun_a.ic_declination)
        annotation (points=[-20.3242, 42.3915; -16.6, 42.3915; -16.6, 36.1;
            -39.2, 36.1; -39.2, 28.0933; -34.3563, 28.0933]);
      connect(declination1.oc_declination1, position_of_sun1.ic_declination)
        annotation (points=[-22.1242, -31.6848; -18.6, -31.6848; -18.6, -21.4;
            -39.8, -21.4; -39.8, -2.86517; -34.9562, -2.86517]);
      connect(position_of_sun_a.oc_position_of_sun1, extraterr_rad_on_horiz_a.
        ic_position_of_sun1) annotation (points=[-20.6687, 28.0933; -18.4775,
            28.0933; -18.4775, 27.5494; -16.2863, 27.5494; -16.2863, 28.2;
            -13.2, 28.2], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, extraterr_rad_on_horiz1.
        ic_position_of_sun1) annotation (points=[-21.2688, -2.86517; -18.9775,
            -2.86517; -18.9775, -2.68956; -16.6863, -2.68956; -16.6863, -2.8;
            -12.6, -2.8], style(color=41));
      connect(aver_rad_integ_ini_and_length_a.oc_total_rad1,
        beam_and_diff_rad_interpol1.ic_extraterr_rad_aver_integ) annotation (
          points=[31.2625, 24.8949; 39.5, 24.8949; 39.5, 15; 15.4, 15; 15.4,
            2.1626; 24.165, 2.1626], style(color=45));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        beam_and_diff_rad_interpol1.ic_extraterr_rad) annotation (points=[
            0.450267, -5.27805; 12.8, -5.27805; 12.8, 4.9038; 24.1512, 4.9038],
           style(color=45));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        rad_on_tilted_surf_mux1.ic_extraterr_rad_on_horiz) annotation (points=[
            0.450267, -5.27805; 12.8, -5.27805; 12.8, 12.2; 37.6, 12.2; 37.6,
            3.15304; 44.6293, 3.15304], style(color=45));
      connect(beam_and_diff_rad_interpol1.oc_beam_rad1, oc_beam_rad_horiz1)
        annotation (points=[39.9315, -1.0021; 43, -1.0021; 43, -13.3; 59.7,
            -13.3; 59.7, 4.5; 72.6, 4.5], style(color=45, thickness=2));
      connect(beam_and_diff_rad_interpol1.oc_diff_rad1, oc_diff_rad_horiz1)
        annotation (points=[39.8004, -3.0272; 41.6, -3.0272; 41.6, -18.5; 72.6,
             -18.5], style(color=45, thickness=2));
      connect(rad_on_tilted_surf_mux1.oc_total_rad_v1, oc_total_rad_v1)
        annotation (points=[55.1805, -0.749565; 57.4, -0.749565; 57.4, 27.3;
            72.9, 27.3], style(color=45, thickness=2));
      connect(location_sel1.oc_meridians, t_and_date_processor1.ic_meridians_a)
         annotation (points=[-49.6625, 9.09234; -47.2, 9; -47.2, 2.2; -54.6062,
             2.2; -54.6062, -45.075], style(color=0));
      connect(t_and_date_processor1.ic_meridians_a, t_and_date_processor1.
        ic_meridians) annotation (points=[-54.6062, -45.075; -54.6, 2.1;
            -53.1813, 2.1; -53.1813, -45.075], style(pattern=0));
      connect(demux_sl_rad1.oc_beam_rad1, beam_and_diff_rad_interpol1.
        ic_beam_rad1) annotation (points=[16.294, -36.876; 16.2, -30.2; 16.2,
            -0.6864; 24.2616, -0.6864], style(color=45));
      connect(demux_sl_rad1.oc_diff_rad1, beam_and_diff_rad_interpol1.
        ic_diff_rad1) annotation (points=[16.294, -38.964; 16.294, -3.0811;
            24.3651, -3.0811], style(color=45));
      connect(extraterr_rad_on_horiz_a.oc_extraterr_rad_on_horiz1,
        aver_rad_integ_ini_and_length_a.ic_total_rad1) annotation (points=[
            0.250267, 25.1195; 3.40895, 25.1195; 3.40895, 24.9144; 6.56763,
            24.9144; 6.56763, 25.1; 12.2, 25.1], style(color=45));
      connect(weather_table_reader.OutPort1, demux_sl_rad1.inPort) annotation (
          points=[0.149351, -40.5094; 4.09468, -40.5094; 4.09468, -39; 8.44,
            -39]);
      connect(beam_and_diff_rad_interpol1.oc_diff_rad1, rad_on_tilted_surf_mux1.
         ic_diff_rad_on_horiz) annotation (points=[39.8004, -3.0272; 41.0149,
            -3.0272; 41.0149, -3.24459; 42.2295, -3.24459; 42.2295, -3; 44.6,
            -3], style(color=45));
      connect(beam_and_diff_rad_interpol1.oc_beam_rad1, rad_on_tilted_surf_mux1.
         ic_beam_rad_on_horiz) annotation (points=[39.9315, -1.0021; 41.1882,
            -1.0021; 41.1882, -0.923839; 42.445, -0.923839; 42.445, -1; 44.3,
            -1], style(color=45));
      connect(position_of_sun1.ic_slt_point1, extraterr_rad_on_horiz1.
        ic_slt_point1) annotation (points=[-34.9094, -9.47191; -37.6, -9.47191;
             -37.6, -16.4; -19.3, -16.4; -19.3, -7.98699; -12.4642, -7.98699],
          style(color=57));
      connect(position_of_sun_a.ic_slt_point1, extraterr_rad_on_horiz_a.
        ic_slt_point1) annotation (points=[-34.3094, 21.0736; -37.8, 21.0736;
            -37.8, 14.1; -18.7, 14.1; -18.7, 22.5301; -12.6642, 22.5301], style(
            color=57));
      connect(demux_sl_rad1.OutPort1, oc_weather_data_table1) annotation (
          points=[16.195, -41.052; 55.4, -41.052; 55.4, -47.75; 67.55, -47.75],
           style(thickness=2));
      connect(rad_on_tilted_surf_mux1.ic_position_of_sun1, position_of_sun1.
        oc_position_of_sun1) annotation (points=[44.6293, 5.04696; 39.4,
            5.04696; 39.4, 9.4; -17.4, 9.4; -17.4, -2.86517; -21.2688, -2.86517],
           style(color=41));
      connect(daylight_svngs_adder.oc_lsmt_point, weather_table_reader.
        ic_t_point1) annotation (points=[-35.527, -45.108; -35.527, -40.4113;
            -13.0864, -40.4113], style(color=59));
      connect(daylight_svngs_adder.oc_slt_point, position_of_sun1.ic_slt_point1)
         annotation (points=[-36.571, -45.108; -36.571, -27.75; -34.9094,
            -27.75; -34.9094, -9.47191], style(color=59));
      connect(daylight_svngs_adder.oc_lsmt_point,
        aver_rad_integ_ini_and_length_a.ic_t_point1) annotation (points=[
            -35.527, -45.108; -35.527, -12.3; 12.5425, -12.3; 12.5425, 21.0894],
           style(color=59));
      connect(t_and_date_processor1.oc_clt_point, oc_t_point1) annotation (
          points=[-47.3821, -45.075; -47.3821, 49.6; 71.9, 49.6], style(color=2));
      connect(declination_a.ic_slt_point1, daylight_svngs_adder.oc_aslt_point)
        annotation (points=[-31.8396, 45.8533; -37.615, 45.8533; -37.615,
            -45.108], style(color=2));
      connect(daylight_svngs_adder.oc_slt_point, declination1.ic_slt_point1)
        annotation (points=[-36.571, -45.108; -36.571, -36.249; -33.6396,
            -36.249; -33.6396, -27.6667], style(color=2));
      connect(t_and_date_processor1.oc_clt_point, daylight_svngs_adder.
        ic_clt_point) annotation (points=[-47.3821, -45.075; -47.3821, -42.5;
            -38.833, -42.5; -38.833, -45.032]);
      connect(t_and_date_processor1.oc_lsmt_point, daylight_svngs_adder.
        ic_lsmt_point) annotation (points=[-48.9067, -45.075; -48.9067, -42.5;
            -39.8335, -42.5; -39.8335, -45.032]);
      connect(t_and_date_processor1.oc_slt_point, daylight_svngs_adder.
        ic_slt_point) annotation (points=[-50.3316, -45.075; -50.3316, -42.2;
            -40.834, -42.2; -40.834, -45.032]);
      connect(t_and_date_processor1.oc_aslt_point, daylight_svngs_adder.
        ic_aslt_point) annotation (points=[-51.7707, -45.075; -51.7707, -42.5;
            -41.791, -42.5; -41.791, -45.032]);
      connect(t_and_date_processor1.oc_clt_point, dlight_svngs_t_sw1.
        ic_clt_point1) annotation (points=[-47.3821, -45.075; -47.3821,
            -28.9342; -56.16, -28.9342]);
      connect(dlight_svngs_t_sw1.oc_dlight_svngs_t_shift, daylight_svngs_adder.
        ic_dlight_svngs_t_shift) annotation (points=[-56.22, -26.5634; -45.2,
            -26.5634; -45.2, -47.388; -41.791, -47.388], style(color=3));
      connect(daylight_svngs_adder.oc_aslt_point, position_of_sun_a.
        ic_slt_point1) annotation (points=[-37.615, -45.108; -37.8, 21.4;
            -34.3094, 21.0736], style(color=53, fillColor=53));
    end global_4;

    class global_3a
      "Radiation source coupled to instantaneous radiation data table (lineal interpolation under consideration of sunrise and sunset times)"

      extends icons.specifics.icon_global;
      parameter Integer uf_sim_ini_clt_date=01012003
        "Simulation initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_sim_ini_clt_h_of_d=000000
        "Simulation initial clock time (hhmmss)";
      parameter Integer uf_ini_date=01012003
        "Weather data initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_ini_h_of_d=000000
        "Weather data initial clock time (hhmmss)";
      parameter Integer uf_fin_date=01012003
        "Weather data final clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_fin_h_of_d=000000
        "Weather data final clock time (hhmmss)";
      parameter Boolean apply=false
        "Apply daylight savings time rules ? {true,false}";
      parameter String given_t_dir_name="europe"
        "Daylight savings time directive name from database";
      parameter String given_city_name="kaiserslautern"
        "City name from database (\"NoName\"=not registered location)";
      parameter Real uf_given_latitude=49.45
        "Latitude angle if no city name entered (-90°...90°)";
      parameter Real uf_given_longitude=7.75
        "Longitude angle if no city name entered (-180°...180°)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if no city name entered (-180°...180°)";
      parameter String table_name="NoName" "Weather data table name on file";
      parameter String file_name="NoName"
        "File where the weather data table is stored";
      parameter Integer weather_data_t_step=300 "Weather data time step (s)";
      parameter Integer rad_col=2
        "Column number in table containing instantaneous total radiation data (1st column= time)";
      parameter Integer more_outputs_col[:]={2}
        "Additional columns in weather data table to output (minimum 1 column)";
      parameter Integer mode=1
        "Tilted surface radiation mode (see user manual) (1,2 or 3)";
      parameter Real rho_ground=0.2 "Ground reflectance around the area";

      parameter Integer n_more_outputs=size(more_outputs_col, 1) - (if
          more_outputs_col[1] == 0 then size(more_outputs_col, 1) else 0);

      SOLAR.position_of_sun position_of_sun1
        annotation (extent=[-35.4, 7.9; -20.4, 23.9]);
      SOLAR.extraterr_rad_on_horiz extraterr_rad_on_horiz1
        annotation (extent=[-13.4, 7.6; 0.6, 21.2]);
      TIME.t_and_date_processor t_and_date_processor1(
        uf_sim_ini_clt_date=uf_sim_ini_clt_date,
        uf_sim_ini_clt_h_of_d=uf_sim_ini_clt_h_of_d,
        forwarded_clock_t_gap=weather_data_t_step)
        annotation (extent=[-56.6, 9.3; -45.6, 19.3]);
      SOLAR.declination declination_a
        annotation (extent=[-33.7, 46.9; -20.7, 58.1]);
      TOOLS.location.location_sel location_sel1(
        given_city_name=given_city_name,
        uf_given_latitude=uf_given_latitude,
        uf_given_longitude=uf_given_longitude,
        uf_given_ref_meridian=uf_given_ref_meridian)
        annotation (extent=[-59.6, 29.9; -49, 39.1]);
      SOLAR.position_of_sun position_of_sun_a
        annotation (extent=[-35, 28.4; -20, 45.4]);
      SOLAR.declination declination1
        annotation (extent=[-34.2, -8.6; -21.2, 4.4]);
      SOLAR.rad_on_surf.tilted.rad_on_tilted_surf_mux rad_on_tilted_surf_mux1(
          mode=mode, rho_ground=rho_ground)
        annotation (extent=[44.2, 7.5; 57.2, 21.1]);
      TOOLS.table_reader.weather_table_reader weather_table_reader(
        uf_ini_date=uf_ini_date,
        uf_ini_h_of_d=000000,
        uf_fin_date=uf_fin_date,
        uf_fin_h_of_d=000000,
        high_accuracy=true,
        t_step=weather_data_t_step,
        read_before_ini_t_and_date=false,
        repeat_cycle=false,
        repetitions_n=0,
        ini_hold_zero_value=true,
        ini_hold_first_value=false,
        ini_hold_last_value=false,
        fin_hold_zero_value=true,
        fin_hold_first_value=false,
        fin_hold_last_value=false,
        table_name=table_name,
        file_name=file_name,
        interpol_col=more_outputs_col,
        step_col={rad_col},
        a_step_col={rad_col}) annotation (extent=[-13.2, -16.4; -2.3, -6]);
      CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
        annotation (extent=[62.9, 17.3; 82.9, 37.3]);
      CUTS.oc_t_point oc_t_point1 annotation (extent=[63.2, 40.4; 80.6, 58.8]);
      CUTS.oc_beam_rad oc_beam_rad_horiz
        annotation (extent=[62.6, -5.5; 82.6, 14.5]);
      CUTS.oc_diff_rad oc_diff_rad_horiz
        annotation (extent=[62.6, -28.5; 82.6, -8.5]);
      annotation (
        Coordsys(
          extent=[-62.7, -56.2; 72.9, 60.4],
          grid=[0.1, 0.1],
          component=[20, 20]),
        Window(
          x=0.1,
          y=0.13,
          width=0.74,
          height=0.69),
        Icon(Text(
            extent=[23.5, 58.9; 61.2, 30],
            string="3a",
            style(color=41))),
        Diagram);
      TIME.dlight_svngs.dlight_svngs_t_sw dlight_svngs_t_sw1(apply=apply,
          given_t_dir_name=given_t_dir_name)
        annotation (extent=[-61.3, -36.7; -52.7, -26.5]);
      CUTS.OutPort oc_weather_data_table1(final n=n_more_outputs)
        annotation (extent=[62.4, -52.7; 72.7, -42.8], layer="icon");
      SOLAR.rad_on_surf.horiz.rad_on_horiz_1 rad_on_horiz_1_1
        annotation (extent=[28.8, 6.4; 39.1, 18.9]);
      TOOLS.rad_interpol.lin_total_rad_interpol lin_total_rad_interpol1(
          data_t_step=weather_data_t_step)
        annotation (extent=[11.1, 6.3; 22.3, 20.1]);
      TOOLS.miscel.demux_2_total_sl_rad demux_2_total_sl_rad1(
        n=2 + n_more_outputs,
        p_total_rad1=n_more_outputs + 1,
        p_total_rad2=n_more_outputs + 2)
        annotation (extent=[3.3, -7.4; 9.8, -0.7], rotation=90);
      TIME.daylight_svngs_adder daylight_svngs_adder1
        annotation (extent=[-47.7, -35.6; -35.8, -22.1]);
    equation
      connect(location_sel1.oc_latitude, position_of_sun1.ic_latitude)
        annotation (points=[-49.6625, 38.4345; -41, 38.4345; -41, 16.709;
            -34.5562, 16.709], style(color=0));
      connect(declination_a.oc_declination1, position_of_sun_a.ic_declination)
        annotation (points=[-21.4242, 53.8915; -17, 53.8915; -17, 46.2; -38.8,
            46.2; -38.8, 41.2933; -34.1563, 41.2933], style(color=73));
      connect(declination1.oc_declination1, position_of_sun1.ic_declination)
        annotation (points=[-21.9242, -0.484848; -18.6, -0.484848; -18.6, 6.3;
            -39.2, 6.3; -39.2, 20.0348; -34.5562, 20.0348]);
      connect(location_sel1.oc_meridians, t_and_date_processor1.ic_meridians_a)
         annotation (points=[-49.6625, 32.0923; -46.8, 32.0923; -46.8, 25.3;
            -54.2062, 25.3; -54.2062, 18.525], style(color=0));
      connect(t_and_date_processor1.ic_meridians_a, t_and_date_processor1.
        ic_meridians) annotation (points=[-54.2062, 18.525; -54.2062, 25.3;
            -52.7813, 25.3; -52.7813, 18.525], style(color=0));
      connect(rad_on_horiz_1_1.oc_diff_rad_on_horiz1, oc_diff_rad_horiz)
        annotation (points=[38.2626, 10.1616; 40.2, 10.1616; 40.2, -18.5; 72.6,
             -18.5], style(color=45, thickness=2));
      connect(rad_on_horiz_1_1.oc_beam_rad_on_horiz1, oc_beam_rad_horiz)
        annotation (points=[38.3045, 12.4185; 42, 12.4185; 42, 4.5; 72.6, 4.5],
           style(color=45, thickness=2));
      connect(rad_on_horiz_1_1.oc_beam_rad_on_horiz1, rad_on_tilted_surf_mux1.
        ic_beam_rad_on_horiz) annotation (points=[38.3045, 12.4185; 40.1125,
            12.4185; 40.1125, 12.3446; 41.9205, 12.3446; 41.9205, 12.5261;
            45.4683, 12.5261], style(color=45));
      connect(rad_on_horiz_1_1.oc_diff_rad_on_horiz1, rad_on_tilted_surf_mux1.
        ic_diff_rad_on_horiz) annotation (points=[38.2626, 10.1616; 40.1061,
            10.1616; 40.1061, 10.1225; 41.9496, 10.1225; 41.9496, 10.1609;
            45.4683, 10.1609], style(color=45));
      connect(rad_on_tilted_surf_mux1.oc_total_rad_v1, oc_total_rad_v1)
        annotation (points=[56.3545, 12.7035; 58.3, 12.7035; 58.3, 27.3; 72.9,
            27.3], style(color=45, thickness=2));
      connect(position_of_sun_a.oc_position_of_sun1, lin_total_rad_interpol1.
        ic_position_of_sun_a1) annotation (points=[-20.4688, 41.2933; 6,
            41.2933; 6, 16.7535; 10.246, 16.7535], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, extraterr_rad_on_horiz1.
        ic_position_of_sun1) annotation (points=[-20.8687, 20.0348; -18.7395,
            20.0348; -18.7395, 19.3104; -16.6103, 19.3104; -16.6103, 20.1;
            -12.3519, 20.1], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_tilted_surf_mux1.
        ic_position_of_sun1) annotation (points=[-20.8687, 20.0348; -16.6,
            20.0348; -16.6, 25.1; 41.7, 25.1; 41.7, 18.6757; 45.4683, 18.6757],
           style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_horiz_1_1.
        ic_position_of_sun1) annotation (points=[-20.8687, 20.0348; -16.6,
            20.0348; -16.6, 25.1; 25.1, 25.1; 25.1, 17.7426; 28.8, 17.7426],
          style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, lin_total_rad_interpol1.
        ic_position_of_sun1) annotation (points=[-20.8687, 20.0348; -16.6,
            20.0348; -16.6, 25.1; 7.1, 25.1; 7.1, 19.0995; 10.218, 19.0995],
          style(color=41));
      connect(position_of_sun1.ic_slt_point1, extraterr_rad_on_horiz1.
        ic_slt_point1) annotation (points=[-34.5094, 13.4281; -36.8, 13.4281;
            -36.8, 8.1; -18.8, 8.1; -18.8, 14.013; -12.4642, 14.013], style(
            color=57));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        rad_on_tilted_surf_mux1.ic_extraterr_rad_on_horiz) annotation (points=[
            0.450267, 16.722; 3.1, 16.722; 3.1, 23.3; 40.2, 23.3; 40.2, 16.7243;
             45.4683, 16.7243], style(color=45));
      connect(lin_total_rad_interpol1.oc_total_rad1, rad_on_horiz_1_1.
        ic_total_rad_on_horiz1) annotation (points=[23.112, 10.5607; 24.6503,
            10.5607; 24.6503, 10.3274; 26.1885, 10.3274; 26.1885, 10.5667;
            28.6325, 10.5667], style(color=45));
      connect(demux_2_total_sl_rad1.oc_total_rad1, lin_total_rad_interpol1.
        ic_total_rad1) annotation (points=[4.6325, -0.097; 4.6325, 13.3035;
            10.176, 13.3035], style(color=45));
      connect(demux_2_total_sl_rad1.oc_total_rad2, lin_total_rad_interpol1.
        ic_total_rad_a1) annotation (points=[6.5175, -0.097; 6.5175, 10.5435;
            10.204, 10.5435], style(color=45));
      connect(weather_table_reader.OutPort1, demux_2_total_sl_rad1.inPort)
        annotation (points=[-1.45065, -10.7094; 6.55, -10.7094; 6.55, -8.07]);
      connect(location_sel1.oc_latitude, position_of_sun_a.ic_latitude)
        annotation (points=[-49.6625, 38.4345; -45.6, 38.4345; -45.6, 37.9941;
            -41.5375, 37.9941; -41.5375, 38.2; -34.9, 38.2], style(color=0));
      connect(demux_2_total_sl_rad1.OutPort1, oc_weather_data_table1)
        annotation (points=[8.4025, -0.1975; 8.4025, 2.4; 30.9, 2.4; 30.9,
            -47.75; 67.55, -47.75], style(thickness=2));
      connect(daylight_svngs_adder1.oc_clt_point, weather_table_reader.
        ic_t_point1) annotation (points=[-36.871, -23.18; -36.871, -10.6113;
            -14.6864, -10.6113], style(color=2));
      connect(dlight_svngs_t_sw1.oc_dlight_svngs_t_shift, daylight_svngs_adder1.
         ic_dlight_svngs_t_shift) annotation (points=[-52.3656, -26.7953; -47.4,
             -26.83; -46.867, -27.23], style(color=3));
      connect(t_and_date_processor1.oc_clt_point, dlight_svngs_t_sw1.
        ic_clt_point1) annotation (points=[-46.9821, 18.525; -46.9821, 21.4;
            -43.2, 21.4; -43.2, -13.7; -50.8, -13.7; -50.8, -29.4526; -52.2939,
             -29.4526], style(color=2));
      connect(t_and_date_processor1.oc_aslt_point, daylight_svngs_adder1.
        ic_aslt_point) annotation (points=[-51.3707, 18.525; -51.3707, 21.3;
            -46.867, 21.3; -46.867, -23.045], style(color=2));
      connect(t_and_date_processor1.oc_slt_point, daylight_svngs_adder1.
        ic_slt_point) annotation (points=[-49.9316, 18.525; -49.9316, 21.1;
            -45.558, 21.1; -45.558, -23.045], style(color=2));
      connect(daylight_svngs_adder1.ic_lsmt_point, t_and_date_processor1.
        oc_lsmt_point) annotation (points=[-44.1895, -23.045; -44.1895, 21.3;
            -48.5067, 21.3; -48.5067, 18.525], style(color=2));
      connect(t_and_date_processor1.oc_clt_point, daylight_svngs_adder1.
        ic_clt_point) annotation (points=[-46.9821, 18.525; -46.9821, 21.2;
            -42.821, 21.2; -42.821, -23.045], style(color=2));
      connect(daylight_svngs_adder1.oc_slt_point, declination1.ic_slt_point1)
        annotation (points=[-39.727, -23.18; -39.727, -8.5; -33.4396, -8.5;
            -33.4396, 3.53333], style(color=2));
      connect(daylight_svngs_adder1.oc_slt_point, position_of_sun1.
        ic_slt_point1) annotation (points=[-39.727, -23.18; -39.727, -4.74;
            -34.5094, -4.74; -34.5094, 13.4281], style(color=2));
      connect(daylight_svngs_adder1.oc_aslt_point, position_of_sun_a.
        ic_slt_point1) annotation (points=[-41.155, -23.18; -41.7, 33.8;
            -34.1094, 34.2736], style(color=2));
      connect(position_of_sun_a.ic_slt_point1, declination_a.ic_slt_point1)
        annotation (points=[-34.1094, 34.2736; -42, 34.2736; -42, 57.3533;
            -32.9396, 57.3533], style(color=2));
      connect(daylight_svngs_adder1.oc_clt_point, oc_t_point1) annotation (
          points=[-36.871, -23.18; -36.871, -11.1; -62.4, -11.1; -62.4, 59.5;
            17, 59.5; 17, 49.6; 71.9, 49.6], style(color=2));
    end global_3a;

    class global_3b
      "Radiation source coupled to instantaneous radiation data table (interpolation by means of the continuous and sampled extraterrestrial radiation curves)"

      extends icons.specifics.icon_global;
      parameter Integer uf_sim_ini_clt_date=01012003
        "Simulation initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_sim_ini_clt_h_of_d=000000
        "Simulation initial clock time (hhmmss)";
      parameter Integer uf_ini_date=01012003
        "Weather data initial clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_ini_h_of_d=000000
        "Weather data initial clock time (hhmmss)";
      parameter Integer uf_fin_date=01012003
        "Weather data final clock date (ddmmyyyy or jjjyy)";
      parameter Integer uf_fin_h_of_d=000000
        "Weather data final clock time (hhmmss)";
      parameter Boolean apply=false
        "Apply daylight savings time rules ? {true,false}";
      parameter String given_t_dir_name="europe"
        "Daylight savings time directive name from database";
      parameter String given_city_name="kaiserslautern"
        "City name from database (\"NoName\"=not registered location)";
      parameter Real uf_given_latitude=49.45
        "Latitude angle if no city name entered (-90°...90°)";
      parameter Real uf_given_longitude=7.75
        "Longitude angle if no city name entered (-180°...180°)";
      parameter Real uf_given_ref_meridian=15
        "Local standard time meridian if no city name entered (-180°...180°)";
      parameter String table_name="NoName" "Weather data table name on file";
      parameter String file_name="NoName"
        "File where the weather data table is stored";
      parameter Integer weather_data_t_step=300 "Weather data time step (s)";
      parameter Integer rad_col=2
        "Column number in table containing instantaneous total radiation data (1st column= time)";
      parameter Integer more_outputs_col[:]={2}
        "Additional columns in weather data table to output (minimum 1 column)";
      parameter Integer mode=1
        "Tilted surface radiation mode (see user manual) (1,2 or 3)";
      parameter Real rho_ground=0.2 "Ground reflectance around the area";

      parameter Integer n_more_outputs=size(more_outputs_col, 1) - (if
          more_outputs_col[1] == 0 then size(more_outputs_col, 1) else 0);

      SOLAR.position_of_sun position_of_sun1
        annotation (extent=[-35.4, 8.1; -20.4, 24.1]);
      SOLAR.extraterr_rad_on_horiz extraterr_rad_on_horiz1
        annotation (extent=[-13.4, 7.6; 0.6, 21.2]);
      TIME.t_and_date_processor t_and_date_processor1(
        uf_sim_ini_clt_date=uf_sim_ini_clt_date,
        uf_sim_ini_clt_h_of_d=uf_sim_ini_clt_h_of_d,
        forwarded_clock_t_gap=weather_data_t_step)
        annotation (extent=[-56.6, 9.3; -45.6, 19.3]);
      TOOLS.location.location_sel location_sel1(
        given_city_name=given_city_name,
        uf_given_latitude=uf_given_latitude,
        uf_given_longitude=uf_given_longitude,
        uf_given_ref_meridian=uf_given_ref_meridian)
        annotation (extent=[-59.6, 29.9; -49, 39.1]);
      SOLAR.declination declination1
        annotation (extent=[-34.2, -8.6; -21.2, 4.4]);
      SOLAR.rad_on_surf.tilted.rad_on_tilted_surf_mux rad_on_tilted_surf_mux1(
          mode=mode, rho_ground=rho_ground)
        annotation (extent=[44.2, 7.5; 57.2, 21.1]);
      TOOLS.table_reader.weather_table_reader weather_table_reader(
        uf_ini_date=uf_ini_date,
        uf_ini_h_of_d=000000,
        uf_fin_date=uf_fin_date,
        uf_fin_h_of_d=000000,
        high_accuracy=true,
        t_step=weather_data_t_step,
        read_before_ini_t_and_date=false,
        repeat_cycle=false,
        repetitions_n=0,
        ini_hold_zero_value=true,
        ini_hold_first_value=false,
        ini_hold_last_value=false,
        fin_hold_zero_value=true,
        fin_hold_first_value=false,
        fin_hold_last_value=false,
        table_name=table_name,
        file_name=file_name,
        interpol_col=more_outputs_col,
        step_col={rad_col}) annotation (extent=[-13.2, -16.4; -2.3, -6]);
      CUTS.oc_total_rad_v oc_total_rad_v1(final n=n_of_surf_orient_def)
        annotation (extent=[62.9, 17.3; 82.9, 37.3]);
      CUTS.oc_t_point oc_t_point1 annotation (extent=[63.2, 40.4; 80.6, 58.8]);
      CUTS.oc_beam_rad oc_beam_rad_horiz
        annotation (extent=[62.6, -5.5; 82.6, 14.5]);
      CUTS.oc_diff_rad oc_diff_rad_horiz
        annotation (extent=[62.6, -28.5; 82.6, -8.5]);
      annotation (
        Coordsys(
          extent=[-62.7, -56.2; 72.9, 60.4],
          grid=[0.1, 0.1],
          component=[20, 20]),
        Window(
          x=0.1,
          y=0.13,
          width=0.74,
          height=0.69),
        Icon(Text(
            extent=[23.5, 58.9; 61.2, 30],
            string="3b",
            style(color=41))),
        Diagram);
      CUTS.OutPort oc_weather_data_table1(final n=n_more_outputs)
        annotation (extent=[62.4, -52.7; 72.7, -42.8], layer="icon");
      SOLAR.rad_on_surf.horiz.rad_on_horiz_1 rad_on_horiz_1_1
        annotation (extent=[28.6, 6.4; 38.9, 18.9]);
      TOOLS.rad_interpol.total_rad_interpol_extraterr_rad_sampler
        total_rad_interpol_extraterr_rad_sampler1
        annotation (extent=[9.8, 6.8; 23.7, 20.7]);
      TOOLS.miscel.demux_total_sl_rad demux_total_sl_rad1(n=1 + n_more_outputs,
           p_total_rad=n_more_outputs + 1)
        annotation (extent=[3.6, -7.6; 9.9, -1.6], rotation=90);
      TIME.daylight_svngs_adder daylight_svngs_adder1
        annotation (extent=[-36.9, -35.7; -16.9, -15.7]);
      TIME.dlight_svngs.dlight_svngs_t_sw dlight_svngs_t_sw1
        annotation (extent=[-61.8, -39; -42, -16.3]);
    equation
      connect(location_sel1.oc_latitude, position_of_sun1.ic_latitude)
        annotation (points=[-49.125, 38.2081; -41, 38.2081; -41, 16.9; -34.3562,
             16.9], style(color=0));
      connect(declination1.oc_declination1, position_of_sun1.ic_declination)
        annotation (points=[-21.8, -0.484848; -18.6, -0.484848; -18.6, 6.3; -39.2,
             6.3; -39.2, 20.3; -35, 20.3]);
      connect(location_sel1.oc_meridians, t_and_date_processor1.ic_meridians_a)
         annotation (points=[-49.8, 32.1; -46.8, 32.1; -46.8, 25.3; -54.2, 25.3;
             -54.2, 18.7], style(color=0));
      connect(t_and_date_processor1.ic_meridians_a, t_and_date_processor1.
        ic_meridians) annotation (points=[-54.2, 18.7; -54.2, 25.3; -52.8, 25.3;
             -52.8, 18.7], style(color=0));
      connect(rad_on_horiz_1_1.oc_diff_rad_on_horiz1, oc_diff_rad_horiz)
        annotation (points=[38.1, 10.2; 40.2, 10.2; 40.2, -18.4; 65.6, -18.4],
          style(color=45, thickness=2));
      connect(rad_on_horiz_1_1.oc_beam_rad_on_horiz1, oc_beam_rad_horiz)
        annotation (points=[38.3, 12.6; 42, 12.6; 42, 4.5; 64.4, 4.5], style(
            color=45, thickness=2));
      connect(rad_on_horiz_1_1.oc_beam_rad_on_horiz1, rad_on_tilted_surf_mux1.
        ic_beam_rad_on_horiz)
        annotation (points=[38.3, 12.6; 45.4, 12.6], style(color=45));
      connect(rad_on_horiz_1_1.oc_diff_rad_on_horiz1, rad_on_tilted_surf_mux1.
        ic_diff_rad_on_horiz)
        annotation (points=[38.1, 10.2; 45.3, 10.2], style(color=45));
      connect(rad_on_tilted_surf_mux1.oc_total_rad_v1, oc_total_rad_v1)
        annotation (points=[56.7, 12.7; 58.3, 12.7; 58.3, 28; 63.9, 28], style(
            color=45, thickness=2));
      connect(position_of_sun1.oc_position_of_sun1, extraterr_rad_on_horiz1.
        ic_position_of_sun1)
        annotation (points=[-20.9, 20.1; -12.3519, 20.1], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_tilted_surf_mux1.
        ic_position_of_sun1) annotation (points=[-21, 20.1; -16.6, 20.1; -16.6,
             25.1; 41.7, 25.1; 41.7, 18.7; 45, 18.7], style(color=41));
      connect(position_of_sun1.oc_position_of_sun1, rad_on_horiz_1_1.
        ic_position_of_sun1) annotation (points=[-21, 20.1; -16.6, 20.1; -16.6,
             25.1; 25.1, 25.1; 25.1, 17.9; 28.2, 17.9], style(color=41));
      connect(position_of_sun1.ic_slt_point1, extraterr_rad_on_horiz1.
        ic_slt_point1) annotation (points=[-34.9, 13.5; -36.9, 13.5; -36.9, 8.1;
             -18.9, 8.1; -18.9, 13.9; -12.6, 13.9], style(color=57));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        rad_on_tilted_surf_mux1.ic_extraterr_rad_on_horiz) annotation (points=[
            0.6, 17.1; 3.1, 17.1; 3.1, 23.4; 40.2, 23.4; 40.2, 16.9; 45.4, 16.9],
           style(color=45));
      connect(total_rad_interpol_extraterr_rad_sampler1.oc_total_rad1,
        rad_on_horiz_1_1.ic_total_rad_on_horiz1)
        annotation (points=[24.7425, 10.8; 28, 10.8], style(color=45));
      connect(extraterr_rad_on_horiz1.oc_extraterr_rad_on_horiz1,
        total_rad_interpol_extraterr_rad_sampler1.ic_extraterr_rad1)
        annotation (points=[0.6, 17.1; 8, 17.1], style(color=45));
      connect(weather_table_reader.OutPort1, demux_total_sl_rad1.inPort)
        annotation (points=[-1.4, -10.8; 6.6, -10.8; 6.6, -8.07]);
      connect(demux_total_sl_rad1.OutPort1, oc_weather_data_table1) annotation (
         points=[8.8, -1.15; 8.8, 2.4; 30.9, 2.4; 30.9, -48.7; 65.4, -48.7],
          style(thickness=2));
      connect(demux_total_sl_rad1.oc_total_rad1,
        total_rad_interpol_extraterr_rad_sampler1.ic_total_rad1) annotation (
          points=[4.6, -0.97; 4.6, 10.8; 8.3, 10.8], style(color=45));
      connect(daylight_svngs_adder1.oc_slt_point, declination1.ic_slt_point1)
        annotation (points=[-23.5, -17.7; -23.5, -10.3; -38.7, -10.3; -38.7,
            3.7; -33.3, 3.7], style(color=2));
      connect(declination1.ic_slt_point1, position_of_sun1.ic_slt_point1)
        annotation (points=[-33.5, 3.6; -38.7, 3.6; -38.7, 13.8; -34.4094, 13.8],
           style(color=2));
      connect(daylight_svngs_adder1.oc_clt_point, weather_table_reader.
        ic_t_point1) annotation (points=[-18.7, -17.8; -18.7, -10.1; -13.7, -10.1],
           style(color=2));
      connect(daylight_svngs_adder1.oc_clt_point, oc_t_point1) annotation (
          points=[-18.6, -17.8; -18.6, -10.3; -61.4, -10.3; -61.4, 50.7; 71.8,
            50.7], style(color=2));
      connect(dlight_svngs_t_sw1.oc_dlight_svngs_t_shift, daylight_svngs_adder1.
         ic_dlight_svngs_t_shift) annotation (points=[-41.23, -16.9; -37.7, -16.9;
             -37.7, -23.3; -36.2, -23.3], style(color=3));
      connect(t_and_date_processor1.oc_clt_point, daylight_svngs_adder1.
        ic_clt_point) annotation (points=[-46.8821, 18.425; -46.8821, 23.4; -44.7,
             23.4; -44.7, -10.3; -29.3, -10.3; -29.3, -17.3], style(color=2));
      connect(daylight_svngs_adder1.ic_slt_point, t_and_date_processor1.
        oc_slt_point) annotation (points=[-32.6, -17.2; -32.6, -10.3; -44.7, -10.3;
             -44.7, 18.625; -50.0316, 18.625], style(color=2));
      connect(daylight_svngs_adder1.ic_lsmt_point, t_and_date_processor1.
        oc_lsmt_point) annotation (points=[-31, -17.5; -31, -10.3; -44.8, -10.3;
             -44.8, 20.9; -48.3, 20.9; -48.3, 18.125], style(color=2));
      connect(t_and_date_processor1.oc_aslt_point, daylight_svngs_adder1.
        ic_aslt_point) annotation (points=[-51.4707, 18.725; -51.4707, 25.1; -44.8,
             25.1; -44.8, -10.3; -35.1, -10.3; -35.1, -16.4], style(color=2));
      connect(dlight_svngs_t_sw1.ic_clt_point1, t_and_date_processor1.
        oc_clt_point) annotation (points=[-41.065, -23.4; -44.7, -23.4; -44.7,
            18.425; -46.9821, 18.425], style(color=2));
    end global_3b;
  end global;

  package icons
    extends universals.icon_folder;
    package universals
      package base_icons
        extends icon_folder;
        annotation (Coordsys(
            extent=[0, 0; 248, 292],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0.43,
            y=0.56,
            width=0.25,
            height=0.44,
            library=1,
            autolayout=1));
        model base_icon_folder
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-70, 48; 72, -90], style(color=10, fillColor=10)),
              Rectangle(extent=[-54, 44; 78, -84], style(color=10, fillColor=10)),
              Polygon(points=[-74, -84; -74, 56; -60, 66; -24, 66; -16, 58; -16,
                     52; 54, 52; 72, 42; 72, -84; -74, -84], style(
                  color=45,
                  thickness=4,
                  fillColor=52)),
              Polygon(points=[-58, 13; 10, 81; 100, -10; 34, -77; -58, 13],
                  style(color=9, fillColor=8)),
              Polygon(points=[-65, 14; 3, 82; 93, -9; 27, -76; -65, 14], style(
                  color=8,
                  fillColor=7,
                  fillPattern=10)),
              Line(points=[-12, 44; -15, 57; -3, 53], style(color=0)),
              Line(points=[-13, 50; -8, 55], style(color=0)),
              Line(points=[0, 56; -7, 64], style(color=0)),
              Line(points=[-11, 60; -4, 67], style(color=0)),
              Line(points=[1, 65; 7, 71], style(color=0)),
              Line(points=[1, 71; 7, 65], style(color=0)),
              Line(points=[-48, 13; -24, 37], style(thickness=2)),
              Line(points=[-37, 3; 11, 51], style(thickness=2)),
              Line(points=[-27, -8; 16, 35], style(thickness=2)),
              Line(points=[-13, -20; 37, 30], style(thickness=2)),
              Polygon(points=[72, -84; -78, -84; -90, -32; -96, 22; 52, 22; 66,
                     -26; 72, -84], style(
                  color=45,
                  thickness=4,
                  fillColor=51))),
            Window(
              x=0.39,
              y=0.17,
              width=0.44,
              height=0.65));

        end base_icon_folder;
      end base_icons;

      model icon_folder
        extends base_icons.base_icon_folder;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Icon(Text(extent=[-79, -11; 61, -69], string="%name")),
          Window(
            x=0.39,
            y=0.17,
            width=0.44,
            height=0.65));
      end icon_folder;

      model icon_usr_folder
        extends base_icons.base_icon_folder;
        annotation (
          Coordsys(
            extent=[-78.5, -84; -28, -15],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Polygon(points=[-67, -63.5; -62, -48.5; -49, -54; -45, -66.5; -40.5,
                   -74.5; -36, -78.5; -37.5, -81.5; -65.5, -81; -67, -63.5],
                style(
                color=10,
                pattern=3,
                gradient=1,
                fillColor=46)),
            Polygon(points=[-76.5, -84; -74.5, -74; -66.5, -63; -58.5, -63.5; -52,
                   -71; -47, -83.5; -76.5, -84], style(
                color=0,
                thickness=2,
                fillColor=73)),
            Polygon(points=[-47, -84; -45, -75.5; -43.5, -69; -34, -75.5; -28,
                  -84; -47, -84], style(
                color=0,
                thickness=2,
                fillColor=73)),
            Line(points=[-43, -50.5; -47, -50.5; -49.5, -48.5], style(color=0)),
            Ellipse(extent=[-43, -35.5; -49, -37], style(color=9, fillColor=8)),
            Polygon(points=[-39.5, -25.5; -39, -31.5; -39.5, -34.5; -41, -36.5;
                   -37, -44; -42, -44.5; -41, -48.5; -42.5, -50; -41, -52; -41,
                   -55; -41.5, -59; -47, -60; -56, -58.5; -65.5, -56; -69.5, -32;
                   -58.5, -17.5; -45, -19.5; -39.5, -25.5], style(color=10,
                  fillColor=47)),
            Polygon(points=[-67.5, -60.5; -76, -53.5; -78.5, -38.5; -77, -25; -70.5,
                   -17; -60.5, -15; -46.5, -15.5; -42, -20; -39.5, -26.5; -53,
                  -29; -59.5, -33; -64, -44; -62.5, -61.5; -67.5, -60.5], style(
                  color=0, fillColor=0)),
            Polygon(points=[-39.5, -25.5; -39, -31.5; -39.5, -34.5; -41, -36.5;
                   -37, -44; -42, -44.5; -41, -48.5; -42.5, -50; -41, -52; -41,
                   -55; -41.5, -59; -47, -60; -56, -58.5; -65.5, -56; -69.5, -32;
                   -58.5, -17.5; -45, -19.5; -39.5, -25.5], style(color=10,
                  fillColor=47)),
            Ellipse(extent=[-43, -35.5; -49, -37], style(color=9, fillColor=8)),
            Line(points=[-43, -50.5; -47, -50.5; -49.5, -48.5], style(color=0)),
            Polygon(points=[-68, -58.5; -76.5, -51.5; -79, -36.5; -77.5, -23; -71,
                   -15; -61, -13; -47, -13.5; -42.5, -18; -40, -24.5; -53.5, -27;
                   -60, -31; -64.5, -42; -63, -59.5; -68, -58.5], style(color=0,
                   fillColor=0))),
          Window(
            x=0.39,
            y=0.17,
            width=0.44,
            height=0.65));

      end icon_usr_folder;

      model icon_function "Icon for function"
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.17,
            y=0.2,
            width=0.61,
            height=0.61),
          Icon(
            Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30,
                  fillPattern=1)),
            Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50],
                style(fillColor=30, fillPattern=1)),
            Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70],
                style(fillColor=30, fillPattern=1)),
            Text(
              extent=[99, 99; -99, 69],
              string="%name",
              style(color=1)),
            Line(points=[82, 22; 91, 26; 95, 35; 94, 47; 91, 49; 89, 46; 88, 38;
                   89, 29; 92, 20; 95, 13; 95, 9; 94, 5; 89, 2; 88, 6; 88, 12;
                  89, 16; 93, 21; 99, 24])));
      equation

      end icon_function;

      model icon_ex
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-100, 100; 102, -68], style(gradient=3, fillColor=
                   72)),
            Text(extent=[-100, -70; 102, -102], string="%name"),
            Line(points=[36.4, 24.8; 37.8, 26.2; 40.8, 26.4; 74.6, 14; 74.8,
                  11.6; 73.6, 10; 68.2, 7.2; 66.2, 3.6; 65.6, -1.6; 66.8, -5;
                  71.2, -7.6; 76.8, -7.2; 81.2, -5; 82.8, -0.6; 83.8, 4.4; 83.4,
                   8; 85, 9.6; 102, 4.6], style(color=0, thickness=2)),
            Line(points=[21.8, -43.4; 22.2, -45.4; 52.4, -54.6; 55, -54.4; 55.2,
                   -52; 54.4, -45.4; 54.6, -39.8; 57.6, -35; 61.2, -33.8; 69.8,
                   -34.2; 74.8, -36.4; 76.4, -39.4; 76.2, -43.8; 70.8, -49.4;
                  64.6, -54.4; 64.2, -57; 65.8, -58.6; 87.8, -65.8; 89, -65.8;
                  91, -65.2; 99, -37.4; 99.4, -36.8], style(color=0, thickness=
                    2)),
            Line(points=[20.2, -43.8; 21.8, -45; 14.6, -67.8], style(color=0,
                  thickness=2)),
            Line(points=[37.8, 29.2; 38.8, 26.4], style(color=0)),
            Line(points=[-20.2, 50; -21.2, 51.6; -10.2, 75.4; -11, 79.4; -14,
                  80.4; -20.2, 78.8; -27.8, 78.4; -32.2, 81.8; -33.8, 86.8; -32.8,
                   91.8; -29.2, 97.4; -23, 98; -15.6, 97.4; -10.2, 96.4; -7.6,
                  92.8; -5, 91.4; -3, 92.8; -0.8, 97], style(color=0, thickness=
                   2)),
            Line(points=[-23.8, 52.4; -20.8, 52.6], style(color=0)),
            Line(points=[-55.2, -16.2; -53.4, -19.6], style(color=0)),
            Line(points=[-86.4, 84.4; -87, 86.8; -80.2, 97.6], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Line(points=[-89, 84.2; -89.8, 86.8; -96.6, 92], style(color=0,
                  thickness=2)),
            Line(points=[-89.8, 86.8; -87, 87], style(color=0, thickness=2)),
            Line(points=[-22.6, 49; -23.8, 52; -50.4, 65; -52, 64; -51.4, 62; -49.4,
                   57.2; -48.2, 51.2; -51.6, 45.4; -57.2, 44.2; -64, 46; -67,
                  51.4; -67, 57.4; -64.4, 62.8; -60.2, 65.6; -59.2, 67.8; -60.6,
                   69.8; -86.4, 84.4; -89, 84.2; -90.4, 82.4; -98, 68.8], style(
                  color=0, thickness=2)),
            Line(points=[35.8, 28.2; 37.8, 28.8; 48.6, 56.2; 50.6, 57.2; 54,
                  56.6; 55.6, 53; 60, 46.6; 63, 45.4; 67.2, 45; 72.2, 47.4;
                  74.8, 50.4; 76.4, 56.2; 76.2, 61; 73.8, 64; 70.8, 65; 57.6,
                  65.2; 56, 66.6; 55.2, 68.8; 65.6, 93.4; 68.2, 95.4; 73.2, 96;
                   95.4, 87; 98.4, 87.8; 97.6, 93.4; 98.2, 97], style(color=0,
                  thickness=2)),
            Line(points=[-51, -18.6; -53, -18.8; -60.6, -39.4; -62.2, -39.8; -64,
                   -38.8; -65.8, -30.8; -68.2, -26.2; -72.6, -24.8; -77.4, -25.2;
                   -81.2, -27.2; -82.8, -31.8; -82.8, -37; -81.2, -42; -78.2, -45;
                   -72.6, -46.6; -66.8, -49; -66.2, -51.6; -74.2, -67.8], style(
                  color=0, thickness=2)),
            Line(points=[-51.6, -15.2; -55, -16.6; -84.4, -0.4; -84.8, 2.4; -83.4,
                   5; -78.8, 6; -72.2, 7.2; -67.6, 10.6; -66.6, 15.4; -67.2,
                  19.2; -69.2, 22.8; -71.2, 25.8; -75.8, 28.2; -81.8, 27.8; -87,
                   24.4; -93, 15.8], style(color=0, thickness=2)),
            Polygon(points=[-25, -29.5; -51, -18.5; -51.5, -16; -43.5, 6.5; -41,
                   7.5; -38.5, 7.5; -36, 6; -34.5, 3.5; -32.5, -2; -29.5, -3.5;
                   -25.5, -2.5; -22, 0.5; -20, 5; -20, 9.5; -22, 14.5; -24.5,
                  16.5; -28, 17.5; -31, 18.5; -32, 22.5; -31.5, 28; -22.5, 49;
                  -20.5, 50; 2, 40; 5.5, 40; 7, 42; 7, 45; 4, 52; 3.5, 57.5;
                  4.5, 61.5; 8, 65; 13.5, 66.5; 20.5, 66.5; 27, 63.5; 30.5,
                  59.5; 31.5, 57; 32, 54.5; 31, 50.5; 28, 47.5; 19.5, 40; 18.5,
                   38; 20, 35; 36, 27.5; 36.5, 25; 32.5, 2; 31.5, 0.5; 28.5,
                  0.5; 26.5, 2; 21.5, 9.5; 19.5, 11.5; 15, 12.5; 10.5, 12; 7.5,
                   8.5; 6, 4.5; 7, -0.5; 11.5, -5.5; 21, -7.5; 25.5, -9.5; 27.5,
                   -11; 28, -14.5; 23, -41.5; 21.5, -44; -10.5, -34; -11, -31.5;
                   -10.5, -28.5; -6, -26; -3, -20.5; -4, -15.5; -8, -11; -14, -9.5;
                   -19.5, -13; -21.5, -16.5; -22.5, -22; -22.5, -26.5; -25, -29.5],
                 style(
                color=0,
                thickness=2,
                fillColor=48))),
          Window(
            x=0.08,
            y=0.4,
            width=0.63,
            height=0.47));
      equation

      end icon_ex;

      model icon_tonne
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-66, 62; 70, -86], style(gradient=1, fillColor=8)),
            Ellipse(extent=[-66, 78; 70, 44], style(
                color=0,
                thickness=4,
                fillColor=10)),
            Polygon(points=[-66, -69; -65, -72; -62, -75; -56, -78; -40, -83; -26,
                   -85; -11, -86; 0, -86; 13, -86; 29, -85; 41, -83; 55, -79;
                  64, -76; 69, -73; 71, -69; 73, -69; 74, -91; -69, -90; -70, -72;
                   -66, -69], style(
                color=0,
                thickness=2,
                fillColor=7)),
            Polygon(points=[-25, 67; -20, 81; -3, 83; 19, 51; -19, 52; -25, 67],
                 style(
                color=10,
                fillColor=9,
                fillPattern=10)),
            Polygon(points=[-48, 51; -27, 74; 10, 45; -11, 45; -27, 47; -41, 49;
                   -48, 51], style(
                color=10,
                fillColor=8,
                fillPattern=8)),
            Polygon(points=[-19, 47; 17, 70; 55, 52; 45, 49; 33, 47; 22, 46; 12,
                   45; -7, 45; -19, 47], style(
                color=9,
                fillColor=8,
                fillPattern=7)),
            Polygon(points=[27, 47; 49, 84; 65, 56; 59, 53; 52, 50; 42, 48; 27,
                   47], style(
                color=9,
                fillColor=8,
                fillPattern=10)),
            Polygon(points=[-20, 81; -4, 83; -14, 56; -20, 81], style(
                color=9,
                fillColor=8,
                fillPattern=10)),
            Ellipse(extent=[-35, 25; 39, -68], style(color=57)),
            Polygon(points=[-30, -45; -37, -24; -37, -5; -42, -2; -24, 12; -23,
                   -8; -30, -7; -33, -24; -30, -45], style(color=0, fillColor=
                    58)),
            Polygon(points=[-8, 24; 14, 26; 29, 17; 34, 19; 38, -7; 19, 8; 23,
                  13; 12, 22; -8, 24], style(color=0, fillColor=58)),
            Polygon(points=[38, -33; 30, -49; 15, -62; 13, -57; -9, -65; 14, -77;
                   14, -70; 33, -50; 38, -33], style(color=0, fillColor=58)),
            Polygon(points=[-66, -66; -65, -87; 69, -88; 70, -65; 79, -67; 79,
                  -95; -76, -93; -76, -66; -66, -66], style(color=7, fillColor=
                    7))),
          Window(
            x=0.16,
            y=0.55,
            width=0.31,
            height=0.36));

      end icon_tonne;
      annotation (Coordsys(
          extent=[0, 0; 320, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1));

      model icon_docu
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[5, 5],
            component=[20, 20]), Icon(
            Rectangle(extent=[-54, 82; 65, -95], style(color=10, fillColor=9)),
            Rectangle(extent=[-58, 90; 60, -90], style(color=9, fillColor=7)),
            Line(points=[-58, 70; 60, 70], style(color=8)),
            Line(points=[-58, 50; 60, 50], style(color=8)),
            Line(points=[-58, 30; 60, 30], style(color=8)),
            Line(points=[-58, 10; 60, 10], style(color=8)),
            Line(points=[-58, -10; 60, -10], style(color=8)),
            Line(points=[-58, -30; 60, -30], style(color=8)),
            Line(points=[-58, -50; 60, -50], style(color=8)),
            Line(points=[-58, -70; 60, -70], style(color=8)),
            Line(points=[-40, 90; -40, -90], style(color=8)),
            Line(points=[-20, 90; -20, -90], style(color=8)),
            Line(points=[20, 90; 20, -90], style(color=8)),
            Line(points=[-20, 90; -20, -90], style(color=8)),
            Line(points=[0, 90; 0, -90], style(color=8)),
            Line(points=[40, 90; 40, -90], style(color=8)),
            Text(extent=[-10, 85; 55, 50], string="AT+"),
            Line(points=[-45, 35; 10, 35], style(color=0, thickness=4)),
            Line(points=[-45, 15; 40, 15], style(color=0, thickness=2)),
            Line(points=[-45, -5; 40, -5], style(color=0, thickness=2)),
            Line(points=[-45, -25; 40, -25], style(color=0, thickness=2)),
            Line(points=[-45, -45; 40, -45], style(color=0, thickness=2)),
            Line(points=[-45, -65; -15, -65], style(color=0, thickness=2)),
            Text(extent=[-95, -95; 100, -120], string="%name")));

      end icon_docu;
      extends icon_folder;
    end universals;

    package specifics

      extends universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 854, 291],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.16,
          y=0.56,
          width=0.84,
          height=0.44,
          library=1,
          autolayout=1));
      package base_icons
        extends universals.icon_folder;
        annotation (Coordsys(
            extent=[0, 0; 156, 720],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0,
            y=0,
            width=0.16,
            height=1,
            library=1,
            autolayout=1));
        model base_icon_location_little_thick
          annotation (
            Coordsys(
              extent=[-61.2, -55; 72, 60],
              grid=[0.2, 0.2],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-58.8, 10; 56, -8.6], style(thickness=4)),
              Ellipse(extent=[-50.8, 39.6; 47.6, 23.6], style(thickness=4)),
              Ellipse(extent=[-48.4, -24; 45, -39], style(thickness=4)),
              Ellipse(extent=[27.8, 60.4; -28.4, -56], style(thickness=4)),
              Ellipse(extent=[-10.6, 60; 10.4, -56], style(thickness=4)),
              Ellipse(extent=[-59, 60.2; 55.6, -55.8], style(thickness=4))),
            Window(
              x=0.32,
              y=0.27,
              width=0.6,
              height=0.6));
        equation

        end base_icon_location_little_thick;

        model base_icon_location_little
          annotation (
            Coordsys(
              extent=[-61.2, -55; 72, 60],
              grid=[0.1, 0.1],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-59.1, 10.2; 55.5, -8.8]),
              Ellipse(extent=[-50.8, 39.6; 47.6, 23.6]),
              Ellipse(extent=[-48, -24.2; 44.6, -38.9]),
              Ellipse(extent=[27.8, 60.4; -28.4, -56]),
              Ellipse(extent=[-10.6, 60.2; 10.4, -55.8]),
              Ellipse(extent=[-59, 60.2; 55.6, -55.8])),
            Window(
              x=0.32,
              y=0.27,
              width=0.6,
              height=0.6));
        equation

        end base_icon_location_little;

        model base_icon_location
          annotation (
            Coordsys(
              extent=[-99, -60; 99, 138],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-99, 138; 99, -60], style(
                  color=0,
                  thickness=2,
                  gradient=1,
                  fillColor=0)),
              Ellipse(extent=[-99, 48; 99, 30], style(fillColor=0)),
              Ellipse(extent=[-85, 98; 85, 80], style(fillColor=0)),
              Ellipse(extent=[-85, -1; 85, -19], style(fillColor=0)),
              Ellipse(extent=[-9, 138; 9, -60], style(fillColor=0)),
              Ellipse(extent=[-45, 138; 45, -60], style(fillColor=0)),
              Ellipse(extent=[-79, 138; 79, -60], style(fillColor=0)),
              Ellipse(extent=[-99, 138; 99, -60], style(
                  color=0,
                  thickness=2,
                  gradient=1,
                  fillColor=69)),
              Ellipse(extent=[-99, 48; 99, 30]),
              Ellipse(extent=[-85, 98; 85, 80]),
              Ellipse(extent=[-85, -1; 85, -19]),
              Ellipse(extent=[-9, 138; 9, -60]),
              Ellipse(extent=[-45, 138; 45, -60]),
              Ellipse(extent=[-79, 138; 79, -60])),
            Window(
              x=0.32,
              y=0.27,
              width=0.6,
              height=0.6));
        equation

        end base_icon_location;

        model base_icon_city_coords_database
          extends base_icon_location;
          annotation (
            Coordsys(
              extent=[-99, -60; 99, 138],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Line(points=[33, 74; 45, 88], style(color=41)),
              Line(points=[34, 87; 48, 75], style(color=41)),
              Line(points=[5, 22; 17, 36], style(color=41)),
              Line(points=[6, 35; 20, 23], style(color=41)),
              Line(points=[-55, 70; -43, 84], style(color=41)),
              Line(points=[-54, 83; -40, 71], style(color=41)),
              Line(points=[-47, -5; -35, 9], style(color=41)),
              Line(points=[-46, 8; -32, -4], style(color=41)),
              Line(points=[65, 7; 77, 21], style(color=41)),
              Line(points=[66, 20; 80, 8], style(color=41)),
              Line(points=[-13, 54; 1, 42], style(color=41)),
              Line(points=[-14, 41; -2, 55], style(color=41)),
              Line(points=[-23, 91; -9, 79], style(color=41)),
              Line(points=[-24, 78; -12, 92], style(color=41)),
              Line(points=[12, 108; 26, 96], style(color=41)),
              Line(points=[11, 95; 23, 109], style(color=41)),
              Line(points=[20, -2; 34, -14], style(color=41)),
              Line(points=[19, -15; 31, -1], style(color=41))),
            Window(
              x=0.24,
              y=0.29,
              width=0.6,
              height=0.6));
        end base_icon_city_coords_database;

        model base_icon_sun
          annotation (
            Coordsys(
              extent=[14.4, 10.6; 76.4, 70.4],
              grid=[0.2, 0.2],
              component=[20, 20]),
            Icon(Ellipse(extent=[14.4, 70.4; 76.4, 10.6], style(
                  color=41,
                  thickness=4,
                  fillColor=45))),
            Window(
              x=0.32,
              y=0.27,
              width=0.6,
              height=0.6));
        equation

        end base_icon_sun;

        model base_icon_clock
          annotation (
            Coordsys(
              extent=[-95, 32; -16, 98],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-95, 98; -16, 32], style(
                  color=0,
                  thickness=4,
                  fillColor=8)),
              Line(points=[-56, 98; -56, 32], style(color=49, thickness=2)),
              Line(points=[-95, 66; -17, 66], style(color=49, thickness=2)),
              Line(points=[-74, 94; -37, 36], style(
                  color=49,
                  thickness=2,
                  fillColor=49)),
              Line(points=[-89, 82; -22, 49], style(
                  color=49,
                  thickness=2,
                  fillColor=49)),
              Line(points=[-38, 94; -74, 37], style(
                  color=49,
                  thickness=2,
                  fillColor=49)),
              Line(points=[-23, 82; -90, 49], style(color=49, thickness=2)),
              Ellipse(extent=[-90, 94; -22, 37], style(
                  color=8,
                  gradient=3,
                  fillColor=8)),
              Ellipse(extent=[-59, 67; -55, 64], style(color=49, fillColor=0)),
              Line(points=[-57, 66; -44, 74], style(color=0, thickness=2)),
              Line(points=[-57, 66; -83, 79], style(color=0, thickness=2))),
            Window(
              x=0.13,
              y=0.22,
              width=0.79,
              height=0.6));

        end base_icon_clock;

        model base_icon_t_and_date
          extends base_icon_calendar;
          annotation (
            Coordsys(
              extent=[-98, -36; 110, 99],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-95, 98; -16, 32], style(
                  color=0,
                  thickness=4,
                  fillColor=8)),
              Line(points=[-56, 98; -56, 32], style(color=49, thickness=2)),
              Line(points=[-95, 66; -17, 66], style(color=49, thickness=2)),
              Line(points=[-74, 94; -37, 36], style(
                  color=49,
                  thickness=2,
                  fillColor=49)),
              Line(points=[-89, 82; -22, 49], style(
                  color=49,
                  thickness=2,
                  fillColor=49)),
              Line(points=[-38, 94; -74, 37], style(
                  color=49,
                  thickness=2,
                  fillColor=49)),
              Line(points=[-23, 82; -90, 49], style(color=49, thickness=2)),
              Ellipse(extent=[-90, 94; -22, 37], style(
                  color=8,
                  gradient=3,
                  fillColor=8)),
              Ellipse(extent=[-59, 67; -55, 64], style(color=49, fillColor=0)),
              Line(points=[-57, 66; -44, 74], style(color=0, thickness=2)),
              Line(points=[-57, 66; -83, 79], style(color=0, thickness=2))),
            Window(
              x=0.13,
              y=0.22,
              width=0.79,
              height=0.6));

        end base_icon_t_and_date;

        model base_icon_calendar
          annotation (
            Coordsys(
              extent=[-98, -36; 110, 99],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-58, 88; 110, 74], style(color=8, fillColor=8)),
              Rectangle(extent=[-58, 88; -34, -36]),
              Rectangle(extent=[-34, 88; -10, -36]),
              Rectangle(extent=[-10, 88; 14, -36]),
              Rectangle(extent=[14, 88; 38, -36]),
              Rectangle(extent=[38, 88; 62, -36]),
              Rectangle(extent=[62, 88; 86, -36]),
              Rectangle(extent=[86, 88; 110, -36], style(fillColor=48)),
              Rectangle(extent=[-58, 74; 110, 52]),
              Rectangle(extent=[-58, 52; 110, 30]),
              Rectangle(extent=[-58, 30; 110, 8]),
              Rectangle(extent=[-58, 8; 110, -14]),
              Rectangle(extent=[-58, -14; 110, -36]),
              Text(extent=[-57, 87; -35, 75], string="mo"),
              Text(extent=[-33, 87; -11, 75], string="tu"),
              Text(extent=[-9, 87; 13, 75], string="we"),
              Text(extent=[15, 87; 37, 75], string="th"),
              Text(extent=[39, 87; 61, 75], string="fr"),
              Text(extent=[63, 87; 85, 75], string="sa"),
              Text(extent=[87, 87; 109, 75], string="su")),
            Window(
              x=0.13,
              y=0.22,
              width=0.79,
              height=0.6));

        end base_icon_calendar;

        model base_icon_calendar_grey
          annotation (
            Coordsys(
              extent=[-98, -36; 110, 99],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-58, 88; 110, 74], style(color=9, fillColor=8)),
              Rectangle(extent=[-58, 88; -34, -36], style(color=8)),
              Rectangle(extent=[-34, 88; -10, -36], style(color=8)),
              Rectangle(extent=[-10, 88; 14, -36], style(color=8)),
              Rectangle(extent=[14, 88; 38, -36], style(color=8)),
              Rectangle(extent=[38, 88; 62, -36], style(color=8)),
              Rectangle(extent=[62, 88; 86, -36], style(color=8)),
              Rectangle(extent=[86, 88; 110, -36], style(color=8, fillColor=48)),
              Rectangle(extent=[-58, 74; 110, 52], style(color=8)),
              Rectangle(extent=[-58, 52; 110, 30], style(color=8)),
              Rectangle(extent=[-58, 30; 110, 8], style(color=8)),
              Rectangle(extent=[-58, 8; 110, -14], style(color=8)),
              Rectangle(extent=[-58, -14; 110, -36], style(color=8)),
              Text(
                extent=[-9, 87; 13, 75],
                string="we",
                style(color=9)),
              Text(
                extent=[15, 87; 37, 75],
                string="th",
                style(color=9)),
              Text(
                extent=[39, 87; 61, 75],
                string="fr",
                style(color=9)),
              Text(
                extent=[63, 87; 85, 75],
                string="sa",
                style(color=9)),
              Text(
                extent=[87, 87; 109, 75],
                string="su",
                style(color=9)),
              Text(
                extent=[-33, 87; -11, 75],
                string="tu",
                style(color=9)),
              Text(
                extent=[-57, 87; -35, 75],
                string="mo",
                style(color=9))),
            Window(
              x=0.13,
              y=0.36,
              width=0.79,
              height=0.6));

        end base_icon_calendar_grey;

        model base_icon_holid
          extends base_icon_calendar_grey;
          annotation (
            Coordsys(
              extent=[-173, -150; 110, 130],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-124, 7; 12, -141], style(gradient=1, fillColor=
                     59)),
              Ellipse(extent=[-124, 23; 12, -11], style(
                  color=0,
                  thickness=2,
                  fillColor=57)),
              Polygon(points=[-124, -124; -123, -127; -120, -130; -114, -133; -98,
                     -138; -84, -140; -69, -141; -58, -141; -45, -141; -29, -140;
                     -17, -138; -3, -134; 6, -131; 11, -128; 13, -124; 15, -124;
                     16, -146; -127, -145; -128, -127; -124, -124], style(
                  color=0,
                  thickness=2,
                  fillColor=7)),
              Polygon(points=[-124, -121; -123, -142; 11, -143; 12, -120; 21, -122;
                     21, -150; -134, -148; -134, -121; -124, -121], style(color=
                     7, fillColor=7)),
              Line(points=[-173, 130; -101, -4], style(color=81, thickness=2)),
              Polygon(points=[-32, -9; -31, 8; -24, 22; -11, 39; 5, 47; 29, 53;
                     53, 51; 58, 47; 15, -3; 11, 10; 9, 3; 5, 0; -2, -3; -12, -6;
                     -23, -8; -32, -9], style(
                  color=45,
                  thickness=2,
                  fillColor=51)),
              Line(points=[19, 50; 13, 14; 14, 9; 19, 7; 26, 11], style(color=
                      45)),
              Line(points=[-16, 31; 3, 9; 8, 9; 13, 14], style(color=45)),
              Line(points=[2, 9; 4, 5; 3, 1; -1, -2], style(color=45))),
            Window(
              x=0.38,
              y=0.18,
              width=0.45,
              height=0.71));

        end base_icon_holid;

        model base_icon_atm_att
          annotation (
            Coordsys(
              extent=[-119, -122; 117, 48],
              grid=[2, 2],
              component=[20, 20]),
            Window(
              x=0.15,
              y=0.19,
              width=0.77,
              height=0.63),
            Icon(
              Rectangle(extent=[-100, -86; 100, -100], style(color=57,
                    fillColor=58)),
              Polygon(points=[-100, 8; -84, 10; -58, 12; 6, 14; 74, 12; 100, 10;
                     100, -86; -100, -86; -100, 8], style(color=7, fillColor=68)),
              Ellipse(extent=[-48, -12; -46, -14]),
              Ellipse(extent=[-48, -12; -46, -14]),
              Ellipse(extent=[78, -40; 80, -42]),
              Ellipse(extent=[-34, -30; -32, -32]),
              Ellipse(extent=[8, -32; 10, -34]),
              Ellipse(extent=[-20, -4; -18, -6]),
              Ellipse(extent=[-32, -44; -30, -46]),
              Ellipse(extent=[-10, -12; -8, -14]),
              Ellipse(extent=[-48, -34; -46, -36]),
              Ellipse(extent=[-52, -62; -50, -64]),
              Ellipse(extent=[-70, -26; -68, -28]),
              Ellipse(extent=[32, -52; 34, -54]),
              Ellipse(extent=[56, -18; 58, -20]),
              Ellipse(extent=[-16, -54; -14, -56]),
              Ellipse(extent=[80, -4; 82, -6]),
              Ellipse(extent=[-10, -34; -8, -36]),
              Ellipse(extent=[60, -60; 62, -62]),
              Ellipse(extent=[48, -34; 50, -36]),
              Ellipse(extent=[42, -2; 44, -4]),
              Ellipse(extent=[12, -64; 14, -66]),
              Ellipse(extent=[-18, -72; -16, -74]),
              Ellipse(extent=[-86, -6; -84, -8]),
              Ellipse(extent=[-80, -52; -78, -54]),
              Ellipse(extent=[16, -6; 18, -8]),
              Line(points=[-94, 46; -60, 12], style(color=41, thickness=4)),
              Line(points=[-60, 12; -14, -34], style(color=41, thickness=2)),
              Line(points=[-14, -34; 14, -62], style(color=41)),
              Line(points=[10, -58; 40, -86], style(color=41, pattern=3)),
              Line(points=[-8, -30; 10, -18], style(color=45)),
              Line(points=[-36, -38; -56, -28], style(color=45)),
              Line(points=[52, -54; 78, -26], style(color=45)),
              Line(points=[2, -78; -28, -64], style(color=45)),
              Line(points=[24, -32; 38, -52], style(color=45)),
              Line(points=[-68, -66; -50, -50], style(color=45))));

        end base_icon_atm_att;

        model base_icon_extraterr_rad_on_tilted_surf
          annotation (
            Icon(
              Ellipse(extent=[-114, 66; -186, -6], style(
                  color=41,
                  thickness=2,
                  fillColor=45)),
              Line(points=[-108, 20; 90, -32], style(color=41, thickness=2)),
              Polygon(points=[158, -41; 135, -48; 119, -56; 104, -68; 93, -80;
                    85, -92; 78, -106; 73, -124; 72, -142; 159, -142; 159, -41;
                     158, -41], style(
                  color=7,
                  gradient=3,
                  fillColor=68)),
              Polygon(points=[159, -75; 150, -78; 142, -82; 133, -88; 126, -94;
                     120, -100; 115, -107; 110, -116; 106, -127; 105, -134; 104,
                     -142; 159, -142; 159, -75], style(color=69, fillColor=58)),
              Text(extent=[-186, -142; 130.5, -178], string=
                    "EXTRAT.RAD.ON TILTED SURF."),
              Line(points=[-108, 20; -148, 30], style(color=0, pattern=3)),
              Line(points=[119.8, -53.3; 139.5, -82.9], style(color=0)),
              Polygon(points=[61.3, -68.5; 86.7, -83; 105.5, -52.9; 98.7, -48.1;
                     61.3, -68.5], style(
                  color=0,
                  fillColor=7,
                  fillPattern=10)),
              Polygon(points=[122.7, -32.9; 129.9, -41.7; 158.5, -27.3; 150.7,
                    -6.8; 122.7, -32.9], style(
                  color=0,
                  fillColor=7,
                  fillPattern=10)),
              Ellipse(extent=[104.7, -37.3; 122.7, -49.3], style(color=0)),
              Ellipse(extent=[108.7, -39.3; 116.7, -47.3], style(color=0)),
              Line(points=[125.6, -36.9; 112, -43.7; 100.9, -52.2], style(color=
                     0))),
            Coordsys(
              extent=[-186, -178; 159, 68],
              grid=[0.1, 0.1],
              component=[20, 20]),
            Window(
              x=0.08,
              y=0.32,
              width=0.6,
              height=0.6));

        end base_icon_extraterr_rad_on_tilted_surf;

        model base_icon_rad_on_horiz
          annotation (
            Coordsys(
              extent=[-40, -56; 62, 52],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Text(extent=[-40, -44; 62, -56], string="RAD.ON HORIZ."),
              Line(points=[-28, 42; -22, 31], style(color=0, pattern=3)),
              Line(points=[61, 32; 55, 35; 50, 37; 44, 39; 37, 41; 29, 42; 23,
                    42; 18, 42; 11, 41; 5, 40; -1, 38; -6, 36; -10, 34; -14, 31;
                     -18, 28; -24, 23; -29, 18; -32, 14; -36, 8; -38, 5; -40, 2]),
              Line(points=[47, 31; 38, 20], style(color=45)),
              Line(points=[29, 37; 26, 26], style(color=45)),
              Line(points=[56, 20; 46, 10], style(color=45)),
              Polygon(points=[60, -40; 20, 0; -40, 0; 0, -40; 60, -40], style(
                    color=0, fillColor=58)),
              Polygon(points=[35, -30; 15, -10; -13, -10; 5, -30; 35, -30],
                  style(color=0, fillColor=69)),
              Ellipse(extent=[-18, 52; -40, 30], style(
                  color=41,
                  thickness=2,
                  fillColor=45)),
              Line(points=[-24, 32; 7, -19], style(
                  color=41,
                  thickness=2,
                  fillColor=41)),
              Line(points=[-24, 32; -29, 41], style(color=0, pattern=3)),
              Line(points=[7, -19; 7, 27], style(color=0))),
            Window(
              x=0.22,
              y=0.04,
              width=0.77,
              height=0.88));

        end base_icon_rad_on_horiz;

        model base_icon_rad_on_tilted_surf
          annotation (
            Coordsys(
              extent=[-43, -55; 72, 60],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Text(extent=[-43, -44; 72, -55], string="RAD.ON TILTED SURF."),
              Line(points=[62, 35; 56, 38; 51, 40; 45, 42; 38, 44; 30, 45; 24,
                    45; 19, 45; 12, 44; 6, 43; 0, 41; -5, 39; -9, 37; -13, 34;
                    -17, 31; -23, 26; -28, 21; -31, 17; -35, 11; -37, 8; -39, 5]),
              Line(points=[36, 44; 30, 34], style(color=45)),
              Line(points=[21, 44; 17, 35], style(color=45)),
              Line(points=[12, 43; 10, 35], style(color=45)),
              Polygon(points=[60, -40; 20, 0; -40, 0; 0, -40; 60, -40], style(
                    color=0, fillColor=58)),
              Ellipse(extent=[-8, 53; -17, 44], style(
                  color=41,
                  thickness=2,
                  fillColor=45)),
              Line(points=[-11, 45; -12, 49], style(color=0, pattern=3)),
              Polygon(points=[20, -30; 33, -24; 22, -16; 20, -30], style(color=
                      0, fillColor=0)),
              Polygon(points=[36, -12; 10, 4; -4, -10; 20, -30; 36, -12], style(
                    color=0, fillColor=69)),
              Line(points=[-10, 44; 14, -12], style(
                  color=41,
                  thickness=2,
                  fillColor=41)),
              Line(points=[14, -12; -13, 13], style(color=0, pattern=2)),
              Line(points=[-10, 27; -3, -32; 5, -24], style(color=45, fillColor=
                     49)),
              Line(points=[-16, 25; -18, -15; -8, -13], style(color=45,
                    fillColor=49)),
              Line(points=[14, -12; 14, 26], style(color=0, pattern=2)),
              Line(points=[-8, 9; -6, 13; -3, 16; 3, 20; 8, 22; 14, 23], style(
                    color=0)),
              Line(points=[11, 25; 14, 23; 12, 20], style(color=0)),
              Line(points=[6, -18; -34, -30], style(color=0, pattern=2)),
              Ellipse(extent=[-24, 60; -35, 50], style(color=41)),
              Text(
                extent=[-25, 59; -34, 52],
                string="noon",
                style(color=41)),
              Line(points=[-30, 51; -30, -16], style(color=0, pattern=2)),
              Line(points=[-29, -16; 5, -18], style(color=0, pattern=2)),
              Line(points=[-28, -16; -29, -18; -30, -20; -31, -24; -31, -27; -31,
                     -29], style(color=0)),
              Line(points=[-27, -18; -28, -16; -30, -17], style(color=0))),
            Window(
              x=0.08,
              y=0.13,
              width=0.78,
              height=0.67));

        end base_icon_rad_on_tilted_surf;

        model base_icon_rad_on_normal_surf
          annotation (
            Coordsys(
              extent=[-43, -55; 72, 60],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Line(points=[62, 35; 56, 38; 51, 40; 45, 42; 38, 44; 30, 45; 24,
                    45; 19, 45; 12, 44; 6, 43; 0, 41; -5, 39; -9, 37; -13, 34;
                    -17, 31; -23, 26; -28, 21; -31, 17; -35, 11; -37, 8; -39, 5]),
              Line(points=[36, 44; 30, 34], style(color=45)),
              Line(points=[21, 44; 17, 35], style(color=45)),
              Line(points=[12, 43; 10, 35], style(color=45)),
              Polygon(points=[60, -40; 20, 0; -40, 0; 0, -40; 60, -40], style(
                    color=0, fillColor=58)),
              Ellipse(extent=[-8, 53; -17, 44], style(
                  color=41,
                  thickness=2,
                  fillColor=45)),
              Line(points=[-11, 45; -12, 49], style(color=0, pattern=3)),
              Line(points=[-10, 44; 14, -13], style(
                  color=41,
                  thickness=2,
                  fillColor=41)),
              Line(points=[-10, 27; -3, -32; 5, -24], style(color=45, fillColor=
                     49)),
              Line(points=[-16, 25; -18, -15; -8, -13], style(color=45,
                    fillColor=49)),
              Text(extent=[-43, -44; 72, -55], string="RAD.ON NORMAL SURF."),
              Line(points=[7, 2; 18, 12; 25, -3], style(color=0, thickness=2)),
              Line(points=[3, -22; 34, 4], style(thickness=2)),
              Polygon(points=[3, -23; 16, -12; 29, -10; 17, -22; 3, -23], style(
                    pattern=0, fillColor=0))),
            Window(
              x=0.14,
              y=0.21,
              width=0.78,
              height=0.67));

        end base_icon_rad_on_normal_surf;

        model base_icon_rad_on_tracking_surf
          annotation (
            Coordsys(
              extent=[-43, -55; 72, 60],
              grid=[0.2, 0.2],
              component=[20, 20]),
            Icon(
              Text(extent=[-43, -44; 72, -55], string="RAD.ON TRACKING SURF."),
              Line(points=[62, 35; 56, 38; 51, 40; 45, 42; 38, 44; 30, 45; 24,
                    45; 19, 45; 12, 44; 6, 43; 0, 41; -5, 39; -9, 37; -13, 34;
                    -17, 31; -23, 26; -28, 21; -31, 17; -35, 11; -37, 8; -39, 5]),
              Line(points=[36, 44; 30, 34], style(color=45)),
              Line(points=[21, 44; 17, 35], style(color=45)),
              Line(points=[12, 43; 10, 35], style(color=45)),
              Polygon(points=[60, -40; 20, 0; -40, 0; 0, -40; 60, -40], style(
                    color=0, fillColor=58)),
              Ellipse(extent=[-8, 53; -17, 44], style(
                  color=41,
                  thickness=2,
                  fillColor=45)),
              Line(points=[-11, 45; -12, 49], style(color=0, pattern=3)),
              Polygon(points=[20, -30; 33, -24; 22, -16; 20, -30], style(color=
                      0, fillColor=0)),
              Polygon(points=[36, -12; 10, 4; -4, -10; 20, -30; 36, -12], style(
                    color=0, fillColor=69)),
              Line(points=[-10, 44; 14, -12], style(
                  color=41,
                  thickness=2,
                  fillColor=41)),
              Line(points=[-16, 25; -18, -15; -8, -13], style(color=45,
                    fillColor=49)),
              Line(points=[-10, 27; -3, -32; 5, -24], style(color=45, fillColor=
                     49)),
              Line(points=[-16, 25; -18, -15; -8, -13], style(color=45,
                    fillColor=49)),
              Line(points=[-10, 27; -3, -32; 5, -24], style(color=45, fillColor=
                     49))),
            Window(
              x=0.02,
              y=0.03,
              width=0.78,
              height=0.67));

        end base_icon_rad_on_tracking_surf;

        model base_icon_rad_on_tracking_surf_vert_axis
          extends base_icon_rad_on_tracking_surf;
          annotation (
            Coordsys(
              extent=[-43, -55; 72, 60],
              grid=[0.2, 0.2],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-9, 31; 38, 19], style(color=0, thickness=2)),
              Line(points=[18, 22; 23.2, 19.2; 18.6, 16.2], style(color=0)),
              Line(points=[11.6, 21.6; 7, 19; 11.4, 16], style(color=0)),
              Line(points=[14, -12; 14, 26], style(color=0, pattern=4))),
            Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));
        end base_icon_rad_on_tracking_surf_vert_axis;

        model base_icon_rad_on_tracking_surf_horiz_axis
          extends base_icon_rad_on_tracking_surf;
          annotation (
            Coordsys(
              extent=[-43, -55; 72, 60],
              grid=[0.2, 0.2],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-17.8, 18; 4, -8.2], style(color=0, thickness=2)),
              Line(points=[26.8, -22.8; -19.4, 15.8], style(color=0, pattern=4)),
              Line(points=[-13.2, 19; -13.6, 15.2; -10, 15.2], style(color=0)),
              Line(points=[-2.6, 19.2; -0.6, 15.4; -4.4, 15.4], style(color=0))),
            Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));

        end base_icon_rad_on_tracking_surf_horiz_axis;

        model base_icon_rad_on_tracking_surf_tilted_axis
          extends base_icon_rad_on_tracking_surf;
          annotation (
            Coordsys(
              extent=[-43, -55; 72, 60],
              grid=[0.2, 0.2],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[31.6, 25.6; 53.4, -0.6], style(color=0, thickness=
                     2)),
              Line(points=[6.8, -18.4; 42.4, 13.6], style(color=0, pattern=4)),
              Line(points=[36.2, 26.6; 35.8, 22.8; 39.4, 22.8], style(color=0)),
              Line(points=[46.8, 26.8; 48.8, 23; 45, 23], style(color=0)),
              Polygon(points=[30.6, -18.2; 17.2, -33.6; 39.2, -25.2; 30.6, -18.2],
                   style(pattern=0, fillColor=58)),
              Polygon(points=[1.8, -14.6; -0.6, -16; 20.2, -36.2; 42, -26.8;
                    29.8, -19; 19.8, -29.8; 1.8, -14.6], style(pattern=0,
                    fillColor=0))),
            Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));

        end base_icon_rad_on_tracking_surf_tilted_axis;

        model base_icon_weather_table_reader
          annotation (
            Coordsys(
              extent=[-98, -70; 56, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-98, 100; 56, -70], style(color=0, fillColor=67)),
              Ellipse(extent=[-38, 66; 26, 28], style(color=7, fillColor=7)),
              Ellipse(extent=[-48, 94; 16, 56], style(color=7, fillColor=7)),
              Ellipse(extent=[-14, 84; 50, 46], style(color=7, fillColor=7)),
              Ellipse(extent=[-12, 42; 52, 4], style(color=7, fillColor=7)),
              Ellipse(extent=[-54, 52; 10, 14], style(color=7, fillColor=7)),
              Ellipse(extent=[-16, 58; 48, 20], style(color=7, fillColor=7)),
              Rectangle(extent=[-92, 58; -62, 38], style(
                  color=0,
                  fillColor=47,
                  fillPattern=1)),
              Rectangle(extent=[-92, 38; -62, 18], style(
                  color=0,
                  fillColor=47,
                  fillPattern=1)),
              Rectangle(extent=[-92, 18; -62, -2], style(
                  color=0,
                  fillColor=47,
                  fillPattern=1)),
              Rectangle(extent=[-92, -2; -62, -22], style(
                  color=0,
                  fillColor=47,
                  fillPattern=1)),
              Line(points=[-92, 58; -92, -22; 28, -22; 28, 58; -2, 58; -2, -22;
                     -62, -22; -62, 58; -92, 58; -92, 38; 28, 38; 28, 18; -92,
                    18; -92, -2; 28, -2; 28, -22; -92, -22; -92, 58; 28, 58; 28,
                     -22], style(color=0)),
              Line(points=[-32, 58; -32, -22], style(color=0)),
              Polygon(points=[-8, 26; -46, -10; -28, -6; -60, -44; -62, -34; -74,
                     -62; -44, -52; -54, -50; -4, 2; -20, 2; 10, 22; -8, 26],
                  style(color=0, fillColor=49))),
            Diagram,
            Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));

        end base_icon_weather_table_reader;

        model base_icon_axis
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[0.5, 0.5],
              component=[20, 20]),
            Icon(
              Polygon(points=[-79.5, 99; -87.5, 77; -71.5, 77; -79.5, 99],
                  style(
                  color=8,
                  fillColor=0,
                  fillPattern=1)),
              Line(points=[-92, -44; 80, -44], style(color=0, fillColor=0)),
              Polygon(points=[88, -45; 66, -37; 66, -53; 88, -45], style(
                  color=8,
                  fillColor=0,
                  fillPattern=1)),
              Line(points=[-79.5, 82.5; -79.5, -68.5], style(color=0))),
            Window(
              x=0.34,
              y=0.21,
              width=0.6,
              height=0.6));
        equation

        end base_icon_axis;

        model base_icon_axis_integ
          extends base_icon_axis;
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[0.5, 0.5],
              component=[20, 20]),
            Icon(Line(points=[83, 89; 82, 93.5; 76, 98; 67.5, 98; 59.5, 93; 57,
                     79.5; 61.5, 57.5; 72.5, 37; 83, 21.5; 86, 12.5; 85, 3;
                    76.5, -1.5; 66.5, -1; 60, 7], style(color=0, thickness=2))),
            Window(
              x=0.34,
              y=0.21,
              width=0.6,
              height=0.6));

        end base_icon_axis_integ;

        model base_icon_axis_integ_aver
          extends base_icon_axis;
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[0.5, 0.5],
              component=[20, 20]),
            Icon(
              Text(
                extent=[71.7, 15.4; 95.3, -4.6],
                string="P",
                style(color=0, pattern=0)),
              Line(points=[99.5, -6.5; 50.2, -24.4], style(color=0, thickness=2)),
              Line(points=[66.5, 86; 65.5, 90.5; 59.5, 95; 51, 95; 43, 90; 40.5,
                     76.5; 45, 54.5; 56, 34; 66.5, 18.5; 69.5, 9.5; 68.5, 0; 60,
                     -4.5; 50, -4; 43.5, 4], style(color=0, thickness=2)),
              Text(
                extent=[54.5, -14; 121.5, -46.5],
                string="P",
                style(color=0))),
            Window(
              x=0,
              y=0.01,
              width=0.85,
              height=0.72));

        end base_icon_axis_integ_aver;

        model base_icon_axis_calendar
          extends base_icon_calendar_grey;
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[0.5, 0.5],
              component=[20, 20]),
            Icon(
              Polygon(points=[-79.5, 99; -87.5, 77; -71.5, 77; -79.5, 99],
                  style(
                  color=8,
                  fillColor=0,
                  fillPattern=1)),
              Line(points=[-92, -44; 80, -44], style(color=0, fillColor=0)),
              Polygon(points=[88, -45; 66, -37; 66, -53; 88, -45], style(
                  color=8,
                  fillColor=0,
                  fillPattern=1)),
              Line(points=[-79.5, 82.5; -79.5, -68.5], style(color=0))),
            Window(
              x=0.34,
              y=0.21,
              width=0.6,
              height=0.6));
        end base_icon_axis_calendar;

        model base_icon_axis_calender_integ
          extends base_icon_axis_calendar;
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[0.5, 0.5],
              component=[20, 20]),
            Icon(Line(points=[83, 89; 82, 93.5; 76, 98; 67.5, 98; 59.5, 93; 57,
                     79.5; 61.5, 57.5; 72.5, 37; 83, 21.5; 86, 12.5; 85, 3;
                    76.5, -1.5; 66.5, -1; 60, 7], style(color=0, thickness=2))),
            Window(
              x=0.34,
              y=0.21,
              width=0.6,
              height=0.6));

        end base_icon_axis_calender_integ;

        model base_icon_axis_calendar_integ_aver
          extends base_icon_axis_calendar;
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[0.5, 0.5],
              component=[20, 20]),
            Icon(
              Text(
                extent=[71.7, 15.4; 95.3, -4.6],
                string="P",
                style(color=0, pattern=0)),
              Line(points=[99.5, -6.5; 50.2, -24.4], style(color=0, thickness=2)),
              Line(points=[66.5, 86; 65.5, 90.5; 59.5, 95; 51, 95; 43, 90; 40.5,
                     76.5; 45, 54.5; 56, 34; 66.5, 18.5; 69.5, 9.5; 68.5, 0; 60,
                     -4.5; 50, -4; 43.5, 4], style(color=0, thickness=2)),
              Text(
                extent=[54.5, -14; 121.5, -46.5],
                string="P",
                style(color=0))),
            Window(
              x=0,
              y=0.01,
              width=0.85,
              height=0.72));

        end base_icon_axis_calendar_integ_aver;
      end base_icons;

      package cuts
        extends universals.icon_folder;
        annotation (Coordsys(
            extent=[0, 0; 156, 294],
            grid=[1, 1],
            component=[20, 20]), Window(
            x=0,
            y=0.56,
            width=0.16,
            height=0.44,
            library=1,
            autolayout=1));
        connector icon_ic_t_point
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[60, 100; 100, -100], style(color=0, fillColor=
                      68)),
              Ellipse(extent=[-100, 72; 60, -70], style(
                  color=0,
                  pattern=2,
                  fillColor=47)),
              Line(points=[4, 40; -18, 2; 60, 2], style(color=0)),
              Line(points=[50, -12; 60, 2; 50, 12], style(color=0))),
            Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));
        end icon_ic_t_point;

        connector icon_oc_t_point
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-60, 100; -100, -100], style(color=0, fillColor=
                     68)),
              Ellipse(extent=[100, 72; -60, -70], style(
                  color=0,
                  pattern=2,
                  fillColor=47)),
              Line(points=[44, 40; 22, 2; 100, 2], style(color=0)),
              Line(points=[90, -12; 100, 2; 90, 12], style(color=0))),
            Window(
              x=0.34,
              y=0.23,
              width=0.6,
              height=0.6));
        end icon_oc_t_point;

        connector icon_ic_position_of_sun
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[-36, -84; -20, -98], style(fillColor=73)),
              Polygon(points=[-100, 100; -100, -60; 60, -60; -100, 100], style(
                    color=0, fillColor=47)),
              Ellipse(extent=[-80, 80; 40, -42], style(color=73)),
              Line(points=[-28, 18; -28, -90]),
              Polygon(points=[-100, 100; 60, -60; 60, 100; -100, 100; -100, 100],
                   style(color=7, fillColor=7)),
              Rectangle(extent=[60, 100; 100, -100], style(color=0, fillColor=
                      68)),
              Line(points=[-100, 100; 60, -60], style(color=0))),
            Window(
              x=0.15,
              y=0.21,
              width=0.6,
              height=0.6));
        end icon_ic_position_of_sun;

        connector icon_oc_position_of_sun
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(
              Ellipse(extent=[4, -84; 20, -98], style(fillColor=73)),
              Polygon(points=[-60, 100; -60, -60; 100, -60; -60, 100], style(
                    color=0, fillColor=47)),
              Line(points=[12, 18; 12, -90]),
              Ellipse(extent=[-40, 80; 80, -42]),
              Polygon(points=[-60, 100; 100, -60; 100, 100; -60, 100; -60, 100],
                   style(color=7, fillColor=7)),
              Rectangle(extent=[-100, 100; -60, -100], style(color=0, fillColor=
                     68)),
              Line(points=[-60, 100; 100, -60], style(color=0))),
            Window(
              x=0.36,
              y=0.36,
              width=0.6,
              height=0.6));
        end icon_oc_position_of_sun;

        connector icon_ic_beam_rad
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[1, 1],
              component=[20, 20]),
            Icon(Polygon(points=[-100, 19; -40, 19; -40, 59; 60, -3; -40, -61;
                    -40, -21; -100, -21; -100, 19], style(color=0, fillColor=47)),
                 Rectangle(extent=[60, 100; 100, -100], style(color=0,
                    fillColor=68))),
            Window(
              x=0.24,
              y=0.31,
              width=0.6,
              height=0.6));
        end icon_ic_beam_rad;

        connector icon_oc_beam_rad
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(Rectangle(extent=[-100, 100; -60, -100], style(color=0,
                    fillColor=68)), Polygon(points=[-60, 18; 0, 18; 0, 58; 100,
                     -4; 0, -62; 0, -22; -60, -22; -60, 18], style(color=0,
                    fillColor=47))),
            Window(
              x=0.29,
              y=0.27,
              width=0.6,
              height=0.6));
        end icon_oc_beam_rad;

        connector icon_ic_diff_rad
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[60, 100; 100, -100], style(color=0, fillColor=
                      68)),
              Line(points=[21, 97; 59, 0], style(color=45)),
              Line(points=[-28, 82; 60, 0], style(color=45)),
              Line(points=[-62, 65; 60, 0], style(color=45)),
              Line(points=[-91, 33; 60, 0], style(color=45)),
              Line(points=[22, -96; 60, 0], style(color=45)),
              Line(points=[-28, -82; 60, 0], style(color=45)),
              Line(points=[-62, -65; 60, 0], style(color=45)),
              Line(points=[-91, -33; 60, 0], style(color=45)),
              Line(points=[60, 100; 38, 99; 13, 95; -12, 89; -29, 82; -42, 76;
                    -55, 69; -67, 61; -77, 51; -84, 43; -89, 36; -93, 29; -96,
                    22; -98, 15; -100, 7; -100, 0], style(color=0)),
              Line(points=[60, -100; 38, -99; 13, -95; -12, -89; -29, -82; -42,
                     -76; -55, -69; -67, -61; -77, -51; -84, -43; -89, -36; -93,
                     -29; -96, -22; -98, -15; -100, -7; -100, 0], style(color=0)),
              Line(points=[-66, 73; -63, 66; -70, 67], style(color=45)),
              Line(points=[-31, 90; -29, 83; -36, 86], style(color=45)),
              Line(points=[-95, 38; -91, 33; -97, 32], style(color=45)),
              Line(points=[-65, -72; -62, -65; -69, -66], style(color=45)),
              Line(points=[-30, -89; -28, -82; -35, -85], style(color=45)),
              Line(points=[-95, -38; -91, -33; -97, -32], style(color=45))),
            Window(
              x=0.39,
              y=0.23,
              width=0.45,
              height=0.68));

        end icon_ic_diff_rad;

        connector icon_oc_diff_rad
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-60, 100; -100, -100], style(color=0, fillColor=
                     68)),
              Line(points=[-21, 97; -60, 0], style(color=45)),
              Line(points=[28, 82; -60, 0], style(color=45)),
              Line(points=[61, 65; -60, 0], style(color=45)),
              Line(points=[91, 33; -60, 0], style(color=45)),
              Line(points=[-21, -97; -60, 0], style(color=45)),
              Line(points=[28, -82; -60, 0], style(color=45)),
              Line(points=[61, -65; -60, 0], style(color=45)),
              Line(points=[91, -33; -60, 0], style(color=45)),
              Line(points=[-60, 100; -38, 99; -13, 95; 12, 89; 29, 82; 42, 76;
                    55, 69; 67, 61; 77, 51; 84, 43; 89, 36; 93, 29; 96, 22; 98,
                     15; 100, 7; 100, 0], style(color=0)),
              Line(points=[-60, -100; -38, -99; -13, -95; 12, -89; 29, -82; 42,
                     -76; 55, -69; 67, -61; 77, -51; 84, -43; 89, -36; 93, -29;
                     96, -22; 98, -15; 100, -7; 100, 0], style(color=0)),
              Line(points=[20, 80; 28, 82; 27, 75], style(color=45)),
              Line(points=[53, 65; 61, 65; 58, 58], style(color=45)),
              Line(points=[84, 36; 91, 33; 86, 28], style(color=45)),
              Line(points=[20, -80; 28, -82; 27, -75], style(color=45)),
              Line(points=[53, -65; 61, -65; 58, -58], style(color=45)),
              Line(points=[84, -36; 91, -33; 86, -28], style(color=45))),
            Window(
              x=0.39,
              y=0.23,
              width=0.45,
              height=0.68));
        end icon_oc_diff_rad;

        connector icon_ic_total_rad
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[60, 100; 100, -100], style(color=0, fillColor=
                      68)),
              Line(points=[21, 100; 60, 0], style(color=45)),
              Line(points=[-48, 100; 60, 0], style(color=45)),
              Line(points=[-100, 81; 60, 0], style(color=45)),
              Line(points=[-100, 39; 60, 0], style(color=45)),
              Line(points=[21, -100; 60, 0], style(color=45)),
              Line(points=[-48, -100; 60, 0], style(color=45)),
              Line(points=[-100, -81; 60, 0], style(color=45)),
              Line(points=[-100, -39; 60, 0], style(color=45)),
              Polygon(points=[-100, 22; -40, 22; -40, 62; 60, 0; -40, -58; -40,
                     -18; -100, -18; -100, 22], style(color=0, fillColor=47))),
            Window(
              x=0.07,
              y=0.28,
              width=0.44,
              height=0.61));

        end icon_ic_total_rad;

        connector icon_oc_total_rad
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[1, 1],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-60, 100; -100, -100], style(color=0, fillColor=
                     68)),
              Line(points=[-60, 0; -21, 100], style(color=45)),
              Line(points=[-60, 0; 48, 100], style(color=45)),
              Line(points=[-60, 0; 100, 81], style(color=45)),
              Line(points=[-60, 0; 100, 39], style(color=45)),
              Line(points=[-60, 0; -21, -100], style(color=45)),
              Line(points=[-60, 0; 48, -100], style(color=45)),
              Line(points=[-60, 0; 100, -81], style(color=45)),
              Line(points=[-60, 0; 100, -39], style(color=45)),
              Polygon(points=[-60, 18; 0, 18; 0, 58; 100, -4; 0, -62; 0, -22; -60,
                     -22; -60, 18], style(color=0, fillColor=47))),
            Window(
              x=0.17,
              y=0.25,
              width=0.45,
              height=0.68));
        end icon_oc_total_rad;

        connector icon_ic_total_rad_v
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[60, 100; 100, -100], style(color=0, fillColor=
                      68)),
              Line(points=[21, 100; 60, 0], style(color=45)),
              Line(points=[-48, 100; 60, 0], style(color=45)),
              Line(points=[-100, 81; 60, 0], style(color=45)),
              Line(points=[-100, 39; 60, 0], style(color=45)),
              Line(points=[-100, -81; 60, 0], style(color=45)),
              Line(points=[-100, -39; 60, 0], style(color=45)),
              Polygon(points=[-100, 22; -40, 22; -40, 62; 60, 0; -40, -58; -40,
                     -18; -100, -18; -100, 22], style(color=0, fillColor=45)),
              Line(points=[-30, -36; -8, -70], style(color=0)),
              Text(
                extent=[-2, -42; 54, -96],
                string="%n",
                style(color=0, pattern=0))),
            Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));
        end icon_ic_total_rad_v;

        connector icon_oc_total_rad_v
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(
              Rectangle(extent=[-60, 100; -100, -100], style(color=0, fillColor=
                     68)),
              Line(points=[-60, 0; -21, 100], style(color=45)),
              Line(points=[-60, 0; 48, 100], style(color=45)),
              Line(points=[-60, 0; 100, 81], style(color=45)),
              Line(points=[-60, 0; 100, 39], style(color=45)),
              Text(
                extent=[42, -46; 98, -100],
                string="%n",
                style(color=0, pattern=0)),
              Line(points=[-60, 0; -18, -100], style(color=45)),
              Line(points=[-60, 0; 100, -40], style(color=45)),
              Polygon(points=[-60, 18; 0, 18; 0, 58; 100, -4; 0, -62; 0, -22; -60,
                     -22; -60, 18], style(color=0, fillColor=45)),
              Line(points=[14, -40; 36, -74], style(color=0))),
            Window(
              x=0.17,
              y=0.18,
              width=0.6,
              height=0.6));
        end icon_oc_total_rad_v;

        connector icon_InPort
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
                  style(color=3, fillColor=3))),
            Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
                  style(color=3, fillColor=3)), Text(
                extent=[-100, -120; 100, -220],
                string="%name",
                style(color=3))),
            Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
                   style(color=3, fillColor=3))),
            Window(
              x=0.15,
              y=0.04,
              width=0.6,
              height=0.6));
        end icon_InPort;

        connector icon_OutPort
          annotation (
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
                  style(color=3, fillColor=7))),
            Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
                  style(color=3, fillColor=7)), Text(
                extent=[-100, -120; 100, -220],
                string="%name",
                style(color=3))),
            Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
                   style(color=3, fillColor=7))),
            Window(
              x=0.06,
              y=0.28,
              width=0.6,
              height=0.6));
        end icon_OutPort;
      end cuts;

      model icon_t_and_date_processor
        annotation (
          Coordsys(
            extent=[-156, -148; 230, 252],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.16,
            y=0.08,
            width=0.79,
            height=0.89),
          Icon(
            Rectangle(extent=[-129, 198; -114, 180], style(color=9, fillColor=8)),
            Rectangle(extent=[-79, 198; -64, 180], style(color=9, fillColor=8)),
            Rectangle(extent=[-29, 198; -14, 180], style(color=9, fillColor=8)),
            Rectangle(extent=[21, 198; 36, 180], style(color=9, fillColor=8)),
            Rectangle(extent=[71, 198; 86, 180], style(color=9, fillColor=8)),
            Rectangle(extent=[121, 198; 136, 180], style(color=9, fillColor=8)),
            Rectangle(extent=[171, 198; 186, 180], style(color=9, fillColor=8)),
            Rectangle(extent=[-153, 179; 219, -53], style(
                color=10,
                thickness=2,
                fillColor=10)),
            Rectangle(extent=[-145, 189; 227, -43], style(
                color=10,
                thickness=2,
                fillColor=10)),
            Polygon(points=[-153, 179; -145, 188; -49, 112; -153, 179], style(
                color=10,
                thickness=2,
                fillColor=10)),
            Polygon(points=[219, -52; 120, 59; 227, -43; 219, -52], style(color=
                   10, fillColor=10)),
            Line(points=[-153, -52; -134, -31], style(color=0, thickness=2)),
            Rectangle(extent=[-145, 189; 227, -43], style(
                color=10,
                thickness=2,
                fillColor=10)),
            Rectangle(extent=[-145, 189; 227, -43], style(
                color=8,
                gradient=2,
                fillColor=8)),
            Rectangle(extent=[-5, 85; 19, -39]),
            Rectangle(extent=[19, 85; 43, -39]),
            Rectangle(extent=[43, 85; 67, -39]),
            Rectangle(extent=[67, 85; 91, -39]),
            Rectangle(extent=[91, 85; 115, -39]),
            Rectangle(extent=[115, 85; 139, -39]),
            Rectangle(extent=[139, 85; 163, -39], style(fillColor=48)),
            Rectangle(extent=[-5, 49; 163, 27]),
            Rectangle(extent=[-5, 27; 163, 5]),
            Rectangle(extent=[-5, 5; 163, -17]),
            Rectangle(extent=[-5, -17; 163, -39]),
            Text(extent=[44, 84; 66, 72], string="we"),
            Text(extent=[68, 84; 90, 72], string="th"),
            Text(extent=[92, 84; 114, 72], string="fr"),
            Text(extent=[116, 84; 138, 72], string="sa"),
            Text(extent=[140, 84; 162, 72], string="su"),
            Text(extent=[20, 84; 42, 72], string="tu"),
            Text(extent=[-4, 84; 18, 72], string="mo"),
            Text(extent=[140, 84; 162, 72], string="su"),
            Rectangle(extent=[-5, 71; 163, 49]),
            Line(points=[-102, 140; -101, 138; -97, 137; -89, 135; -76, 133; -62,
                   132; -44, 131; -27, 131; -17, 131; -8, 131; 8, 131; 27, 132;
                   40, 133; 52, 134; 57, 135; 64, 137; 68, 140], style(color=49,
                   thickness=2)),
            Ellipse(extent=[-116, 189; 82, -9], style(
                color=0,
                thickness=2,
                gradient=1,
                fillColor=0)),
            Ellipse(extent=[-116, 99; 82, 81], style(fillColor=0)),
            Ellipse(extent=[-102, 149; 68, 131], style(fillColor=0)),
            Ellipse(extent=[-102, 50; 68, 32], style(fillColor=0)),
            Ellipse(extent=[-26, 189; -8, -9], style(fillColor=0)),
            Ellipse(extent=[-62, 189; 28, -9], style(fillColor=0)),
            Ellipse(extent=[-96, 189; 62, -9], style(fillColor=0)),
            Ellipse(extent=[-116, 189; 82, -9], style(
                color=0,
                thickness=2,
                gradient=1,
                fillColor=69)),
            Ellipse(extent=[-116, 99; 82, 81]),
            Ellipse(extent=[-102, 149; 68, 131]),
            Ellipse(extent=[-102, 50; 68, 32]),
            Ellipse(extent=[-26, 189; -8, -9]),
            Ellipse(extent=[-62, 189; 28, -9]),
            Ellipse(extent=[-96, 189; 62, -9]),
            Line(points=[-102, 140; -101, 138; -97, 137; -89, 135; -76, 133; -62,
                   132; -44, 131; -27, 131; -17, 131; -8, 131; 8, 131; 27, 132;
                   40, 133; 52, 134; 57, 135; 64, 137; 68, 140], style(color=49,
                   thickness=2)),
            Line(points=[-18, 189; -13, 189; -8, 187; -2, 184; 4, 178; 9, 171;
                  14, 162; 18, 152; 22, 141; 25, 126; 26, 117; 27, 106; 28, 94;
                   28, 83; 28, 75; 26, 61; 24, 48; 22, 38; 19, 30; 16, 22; 12,
                  13; 5, 3; -3, -4; -9, -7; -13, -8; -17, -9], style(color=49,
                  thickness=2)),
            Ellipse(extent=[13, 141; 33, 122], style(color=41, thickness=2)),
            Line(points=[16, 125; 28, 139], style(color=41, thickness=2)),
            Line(points=[17, 138; 31, 126], style(color=41, thickness=2)),
            Ellipse(extent=[21, 96; 100, 30], style(
                color=0,
                thickness=4,
                fillColor=0)),
            Line(points=[60, 96; 60, 30], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[21, 64; 99, 64], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[42, 92; 79, 34], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[27, 80; 94, 47], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[78, 92; 42, 35], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[93, 80; 26, 47], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[26, 92; 94, 35], style(color=8, fillColor=0)),
            Ellipse(extent=[57, 65; 61, 62], style(color=49, fillColor=0)),
            Line(points=[59, 64; 72, 72], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Line(points=[59, 64; 33, 77], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[21, 96; 100, 30], style(
                color=0,
                thickness=4,
                fillColor=8)),
            Line(points=[60, 96; 60, 30], style(color=49, thickness=2)),
            Line(points=[21, 64; 99, 64], style(color=49, thickness=2)),
            Line(points=[42, 92; 79, 34], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[27, 80; 94, 47], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[78, 92; 42, 35], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[93, 80; 26, 47], style(color=49, thickness=2)),
            Ellipse(extent=[26, 92; 94, 35], style(color=8, fillColor=8)),
            Ellipse(extent=[57, 65; 61, 62], style(color=49, fillColor=0)),
            Line(points=[59, 64; 72, 72], style(color=0, thickness=2)),
            Line(points=[59, 64; 33, 77], style(color=0, thickness=2)),
            Ellipse(extent=[177, 99; 211, 67], style(color=10, fillColor=10)),
            Rectangle(extent=[193, 99; 226, 67], style(color=10, fillColor=10)),
            Ellipse(extent=[177, 99; 211, 67], style(
                color=10,
                gradient=2,
                fillColor=10)),
            Rectangle(extent=[193, 99; 226, 67], style(color=10, fillColor=10)),
            Rectangle(extent=[193, 99; 226, 67], style(color=10, fillColor=10)),
            Rectangle(extent=[193, 99; 226, 67], style(
                color=10,
                gradient=2,
                fillColor=10)),
            Rectangle(extent=[-153, 179; 219, -53], style(
                color=10,
                thickness=2,
                fillColor=10)),
            Rectangle(extent=[-145, 189; 227, -43], style(
                color=10,
                thickness=2,
                fillColor=10)),
            Rectangle(extent=[-145, 189; 227, -43], style(
                color=0,
                gradient=2,
                fillColor=10)),
            Rectangle(extent=[-5, 85; 19, -39]),
            Rectangle(extent=[19, 85; 43, -39]),
            Rectangle(extent=[43, 85; 67, -39]),
            Rectangle(extent=[67, 85; 91, -39]),
            Rectangle(extent=[91, 85; 115, -39]),
            Rectangle(extent=[115, 85; 139, -39]),
            Rectangle(extent=[139, 85; 163, -39], style(fillColor=48)),
            Rectangle(extent=[-5, 49; 163, 27]),
            Rectangle(extent=[-5, 27; 163, 5]),
            Rectangle(extent=[-5, 5; 163, -17]),
            Rectangle(extent=[-5, -17; 163, -39]),
            Text(extent=[44, 84; 66, 72], string="we"),
            Text(extent=[68, 84; 90, 72], string="th"),
            Text(extent=[92, 84; 114, 72], string="fr"),
            Text(extent=[116, 84; 138, 72], string="sa"),
            Text(extent=[140, 84; 162, 72], string="su"),
            Text(extent=[20, 84; 42, 72], string="tu"),
            Text(extent=[-4, 84; 18, 72], string="mo"),
            Text(extent=[140, 84; 162, 72], string="su"),
            Rectangle(extent=[-5, 71; 163, 49]),
            Line(points=[-102, 140; -101, 138; -97, 137; -89, 135; -76, 133; -62,
                   132; -44, 131; -27, 131; -17, 131; -8, 131; 8, 131; 27, 132;
                   40, 133; 52, 134; 57, 135; 64, 137; 68, 140], style(color=49,
                   thickness=2)),
            Ellipse(extent=[-116, 189; 82, -9], style(
                color=0,
                thickness=2,
                gradient=1,
                fillColor=0)),
            Ellipse(extent=[-116, 99; 82, 81], style(fillColor=0)),
            Ellipse(extent=[-102, 149; 68, 131], style(fillColor=0)),
            Ellipse(extent=[-102, 50; 68, 32], style(fillColor=0)),
            Ellipse(extent=[-26, 189; -8, -9], style(fillColor=0)),
            Ellipse(extent=[-62, 189; 28, -9], style(fillColor=0)),
            Ellipse(extent=[-96, 189; 62, -9], style(fillColor=0)),
            Ellipse(extent=[-116, 189; 82, -9], style(
                color=0,
                thickness=2,
                gradient=1,
                fillColor=69)),
            Ellipse(extent=[-116, 99; 82, 81]),
            Ellipse(extent=[-102, 149; 68, 131]),
            Ellipse(extent=[-102, 50; 68, 32]),
            Ellipse(extent=[-26, 189; -8, -9]),
            Ellipse(extent=[-62, 189; 28, -9]),
            Ellipse(extent=[-96, 189; 62, -9]),
            Line(points=[-102, 140; -101, 138; -97, 137; -89, 135; -76, 133; -62,
                   132; -44, 131; -27, 131; -17, 131; -8, 131; 8, 131; 27, 132;
                   40, 133; 52, 134; 57, 135; 64, 137; 68, 140], style(color=49,
                   thickness=2)),
            Line(points=[-18, 189; -13, 189; -8, 187; -2, 184; 4, 178; 9, 171;
                  14, 162; 18, 152; 22, 141; 25, 126; 26, 117; 27, 106; 28, 94;
                   28, 83; 28, 75; 26, 61; 24, 48; 22, 38; 19, 30; 16, 22; 12,
                  13; 5, 3; -3, -4; -9, -7; -13, -8; -17, -9], style(color=49,
                  thickness=2)),
            Ellipse(extent=[13, 141; 33, 122], style(color=41, thickness=2)),
            Line(points=[16, 125; 28, 139], style(color=41, thickness=2)),
            Line(points=[17, 138; 31, 126], style(color=41, thickness=2)),
            Ellipse(extent=[21, 96; 100, 30], style(
                color=0,
                thickness=4,
                fillColor=0)),
            Line(points=[60, 96; 60, 30], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[21, 64; 99, 64], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[42, 92; 79, 34], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[27, 80; 94, 47], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[78, 92; 42, 35], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[93, 80; 26, 47], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[26, 92; 94, 35], style(color=8, fillColor=0)),
            Ellipse(extent=[57, 65; 61, 62], style(color=49, fillColor=0)),
            Line(points=[59, 64; 72, 72], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Line(points=[59, 64; 33, 77], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[21, 96; 100, 30], style(
                color=0,
                thickness=4,
                fillColor=8)),
            Line(points=[60, 96; 60, 30], style(color=49, thickness=2)),
            Line(points=[21, 64; 99, 64], style(color=49, thickness=2)),
            Line(points=[42, 92; 79, 34], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[27, 80; 94, 47], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[78, 92; 42, 35], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[93, 80; 26, 47], style(color=49, thickness=2)),
            Ellipse(extent=[26, 92; 94, 35], style(
                color=8,
                gradient=3,
                fillColor=8)),
            Ellipse(extent=[57, 65; 61, 62], style(color=49, fillColor=0)),
            Line(points=[59, 64; 72, 72], style(color=0, thickness=2)),
            Line(points=[59, 64; 33, 77], style(color=0, thickness=2)),
            Ellipse(extent=[175, 101; 209, 69], style(
                color=0,
                thickness=2,
                fillColor=9)),
            Rectangle(extent=[193, 101; 226, 69], style(color=9, fillColor=9)),
            Line(points=[-153, -52; -143, -41], style(color=0, thickness=2)),
            Line(points=[-153, 180; -145, 189], style(color=0, thickness=2)),
            Line(points=[220, -53; 227, -44], style(color=0, thickness=2)),
            Ellipse(extent=[175, 99; 209, 67], style(
                color=9,
                gradient=2,
                fillColor=10)),
            Rectangle(extent=[193, 99; 227, 67], style(
                color=0,
                gradient=2,
                fillColor=10)),
            Polygon(points=[-123, -45; -129, -53; -129, -71; -114, -71; -114, -53;
                   -106, -45; -123, -45], style(color=10, fillColor=8)),
            Polygon(points=[-74, -45; -80, -53; -80, -71; -65, -71; -65, -53; -57,
                   -45; -74, -45], style(color=10, fillColor=8)),
            Polygon(points=[-24, -45; -30, -53; -30, -71; -15, -71; -15, -53; -7,
                   -45; -24, -45], style(color=10, fillColor=8)),
            Polygon(points=[26, -45; 20, -53; 20, -71; 35, -71; 35, -53; 43, -45;
                   26, -45], style(color=10, fillColor=8)),
            Polygon(points=[75, -45; 69, -53; 69, -71; 84, -71; 84, -53; 92, -45;
                   75, -45], style(color=10, fillColor=8)),
            Polygon(points=[125, -45; 119, -53; 119, -71; 134, -71; 134, -53;
                  142, -45; 125, -45], style(color=10, fillColor=8)),
            Polygon(points=[176, -45; 170, -53; 170, -71; 185, -71; 185, -53;
                  193, -45; 176, -45], style(color=10, fillColor=8)),
            Line(points=[-128, -52; 187, -52], style(color=9)),
            Line(points=[192, 101; 227, 101], style(color=0, thickness=2)),
            Text(extent=[-156, -91; 228, -145], string="T. & DATE PROCESSOR")));

      end icon_t_and_date_processor;

      model icon_location
        extends base_icons.base_icon_location;
        annotation (
          Icon(
            Line(points=[-85, 89; -84, 87; -80, 86; -72, 84; -59, 82; -45, 81;
                  -27, 80; -10, 80; 0, 80; 9, 80; 25, 80; 44, 81; 57, 82; 69,
                  83; 74, 84; 81, 86; 85, 89], style(color=49, thickness=2)),
            Line(points=[-1, 138; 4, 138; 9, 136; 15, 133; 21, 127; 26, 120; 31,
                   111; 35, 101; 39, 90; 42, 75; 43, 66; 44, 55; 45, 43; 45, 32;
                   45, 24; 43, 10; 41, -3; 39, -13; 36, -21; 33, -29; 29, -38;
                  22, -48; 14, -55; 8, -58; 4, -59; 0, -60], style(color=49,
                  thickness=2)),
            Line(points=[33, 74; 45, 88], style(color=41, thickness=2)),
            Line(points=[34, 87; 48, 75], style(color=41, thickness=2)),
            Ellipse(extent=[30, 90; 50, 71], style(color=41, thickness=2)),
            Text(extent=[-99, -59; 149, -97], string="LOCATION")),
          Coordsys(
            extent=[-99, -98; 150, 138],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_location;

      model icon_city_coords_database_reader
        extends base_icons.base_icon_location;
        annotation (
          Coordsys(
            extent=[-99, -98; 99, 138],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Line(points=[33, 74; 45, 88], style(color=41)),
            Line(points=[34, 87; 48, 75], style(color=41)),
            Line(points=[5, 22; 17, 36], style(color=41)),
            Line(points=[6, 35; 20, 23], style(color=41)),
            Line(points=[-55, 70; -43, 84], style(color=41)),
            Line(points=[-54, 83; -40, 71], style(color=41)),
            Line(points=[-47, -5; -35, 9], style(color=41)),
            Line(points=[-46, 8; -32, -4], style(color=41)),
            Line(points=[65, 7; 77, 21], style(color=41)),
            Line(points=[66, 20; 80, 8], style(color=41)),
            Line(points=[-13, 54; 1, 42], style(color=41)),
            Line(points=[-14, 41; -2, 55], style(color=41)),
            Line(points=[-23, 91; -9, 79], style(color=41)),
            Line(points=[-24, 78; -12, 92], style(color=41)),
            Line(points=[12, 108; 26, 96], style(color=41)),
            Line(points=[11, 95; 23, 109], style(color=41)),
            Line(points=[20, -2; 34, -14], style(color=41)),
            Line(points=[19, -15; 31, -1], style(color=41)),
            Line(points=[-85, 89; -84, 87; -80, 86; -72, 84; -59, 82; -45, 81;
                  -27, 80; -10, 80; 0, 80; 9, 80; 25, 80; 44, 81; 57, 82; 69,
                  83; 74, 84; 81, 86; 85, 89], style(color=49, thickness=2)),
            Line(points=[-1, 138; 4, 138; 9, 136; 15, 133; 21, 127; 26, 120; 31,
                   111; 35, 101; 39, 90; 42, 75; 43, 66; 44, 55; 45, 43; 45, 32;
                   45, 24; 43, 10; 41, -3; 39, -13; 36, -21; 33, -29; 29, -38;
                  22, -48; 14, -55; 8, -58; 4, -59; 0, -60], style(color=49,
                  thickness=2)),
            Line(points=[33, 74; 45, 88], style(color=41, thickness=2)),
            Line(points=[34, 87; 48, 75], style(color=41, thickness=2)),
            Ellipse(extent=[30, 90; 50, 71], style(color=41, thickness=2)),
            Text(extent=[-99, -63; 99, -98], string="DATABASE READER")),
          Window(
            x=0.34,
            y=0.21,
            width=0.6,
            height=0.6));
      end icon_city_coords_database_reader;

      model icon_city_coords_database_usr
        extends base_icons.base_icon_city_coords_database;
        annotation (Coordsys(
            extent=[-99, -98; 99, 138],
            grid=[1, 1],
            component=[20, 20]), Icon(Text(
              extent=[-99, -63; 99, -98],
              string="%name",
              style(color=73)), Text(
              extent=[-97, -49; -25, -69],
              string="database:",
              style(color=0))));
      end icon_city_coords_database_usr;

      model icon_city_coords_database_sel
        extends base_icons.base_icon_city_coords_database;
        annotation (Coordsys(
            extent=[-99, -98; 99, 138],
            grid=[1, 1],
            component=[20, 20]), Icon(Text(
              extent=[-99, -63; 99, -98],
              string="%name",
              style(color=41))));
      end icon_city_coords_database_sel;

      model icon_declination
        annotation (
          Coordsys(
            extent=[-100, 32; 258, 316],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Ellipse(extent=[-99, 284; 99, 86], style(
                color=0,
                thickness=2,
                gradient=1,
                fillColor=0)),
            Ellipse(extent=[-99, 194; 99, 176], style(fillColor=0)),
            Ellipse(extent=[-85, 244; 85, 226], style(fillColor=0)),
            Ellipse(extent=[-85, 145; 85, 127], style(fillColor=0)),
            Ellipse(extent=[-9, 284; 9, 86], style(fillColor=0)),
            Ellipse(extent=[-45, 284; 45, 86], style(fillColor=0)),
            Ellipse(extent=[-79, 284; 79, 86], style(fillColor=0)),
            Ellipse(extent=[-99, 284; 99, 86], style(
                color=0,
                thickness=2,
                gradient=1,
                fillColor=69)),
            Ellipse(extent=[-45, 284; 45, 86]),
            Ellipse(extent=[-79, 284; 79, 86]),
            Ellipse(extent=[200, 316; 258, 260], style(color=41, fillColor=45)),
            Line(points=[-98, 184; 98, 184], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-84, 236; 84, 236]),
            Line(points=[-84, 134; 84, 134]),
            Line(points=[202, 276; 90, 226], style(
                color=41,
                thickness=2,
                fillColor=45)),
            Line(points=[98, 184; 196, 184], style(color=0, pattern=2)),
            Line(points=[152, 184; 152, 196; 150, 216; 144, 236; 138, 246],
                style(
                color=0,
                thickness=2,
                fillColor=0)),
            Line(points=[136, 239; 138, 246; 145, 245], style(color=0,
                  thickness=2)),
            Line(points=[90, 226; -3, 184], style(color=0, thickness=2)),
            Text(extent=[-100, 72; 144, 32], string="DECLINATION"),
            Line(points=[0, 310; 0, 68], style(pattern=4)),
            Line(points=[202, 276; 230, 288], style(color=0, thickness=2))),
          Window(
            x=0.29,
            y=0.12,
            width=0.6,
            height=0.73));

      end icon_declination;

      model icon_dlight_svngs_t_sw
        annotation (
          Coordsys(
            extent=[-101, 55; -21, 135],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Ellipse(extent=[-101, 135; -22, 69], style(
                color=0,
                thickness=4,
                fillColor=0)),
            Line(points=[-62, 135; -62, 69], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-101, 103; -23, 103], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-80, 131; -43, 73], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-95, 119; -28, 86], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-44, 131; -80, 74], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-29, 119; -96, 86], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[-96, 131; -28, 74], style(color=8, fillColor=0)),
            Ellipse(extent=[-65, 104; -61, 101], style(color=49, fillColor=0)),
            Line(points=[-63, 103; -50, 111], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Line(points=[-63, 103; -89, 116], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[-101, 135; -22, 69], style(
                color=0,
                thickness=4,
                fillColor=8)),
            Line(points=[-62, 135; -62, 69], style(color=49, thickness=2)),
            Line(points=[-101, 103; -22, 103], style(color=49, thickness=2)),
            Line(points=[-80, 131; -43, 73], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-95, 119; -27, 86], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-44, 131; -80, 74], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-29, 119; -96, 86], style(color=49, thickness=2)),
            Ellipse(extent=[-96, 131; -28, 74], style(
                color=8,
                gradient=3,
                fillColor=8)),
            Ellipse(extent=[-64, 104; -60, 101], style(color=49, fillColor=0)),
            Line(points=[-62, 103; -39, 116], style(color=0, thickness=4)),
            Line(points=[-62, 103; -62, 130], style(color=0)),
            Line(points=[-60, 103; -34, 103], style(
                color=41,
                thickness=4,
                fillColor=49)),
            Line(points=[-40, 114; -38, 112; -37, 110; -36, 107; -36, 105],
                style(color=49, thickness=2)),
            Line(points=[-39, 106; -36, 104; -33, 106], style(color=49,
                  thickness=2)),
            Text(extent=[-101, 71; -21, 55], string="DAYLIGHT SAV.T."),
            Text(
              extent=[-91, 123; -58, 84],
              string="§",
              style(color=41))),
          Window(
            x=0.09,
            y=0.15,
            width=0.55,
            height=0.67),
          Documentation(info="N.B.
If user enters an initial standard date and time for the simulation at that point in time, where
there is an ambiguity due to the switch from summer to winter clock time, it is supposed
to be meant the time before the daylight savings time applies.
Does the user enter a not-existing time, due to the reversal switching, the following error message
will be displayed:\"error, simulation initial clock time does not exist. Please review parameters
     for daylight savings time governmental rules!\""));

      end icon_dlight_svngs_t_sw;

      model icon_t_dir_reader
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Ellipse(extent=[-97.5, 98.5; -18.5, 32.5], style(
                color=0,
                thickness=4,
                fillColor=0)),
            Line(points=[-58.5, 98.5; -58.5, 32.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-97.5, 66.5; -19.5, 66.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-76.5, 94.5; -39.5, 36.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-91.5, 82.5; -24.5, 49.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-40.5, 94.5; -76.5, 37.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-25.5, 82.5; -92.5, 49.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[-92.5, 94.5; -24.5, 37.5], style(color=8, fillColor=
                   0)),
            Ellipse(extent=[-61.5, 67.5; -57.5, 64.5], style(color=49,
                  fillColor=0)),
            Line(points=[-59.5, 66.5; -46.5, 74.5], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Line(points=[-59.5, 66.5; -85.5, 79.5], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[-97.5, 98.5; -18.5, 32.5], style(
                color=0,
                thickness=4,
                fillColor=8)),
            Line(points=[-58.5, 98.5; -58.5, 32.5], style(color=49, thickness=2)),
            Line(points=[-97.5, 66.5; -18.5, 66.5], style(color=49, thickness=2)),
            Line(points=[-76.5, 94.5; -39.5, 36.5], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-91.5, 82.5; -23.5, 49.5], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-40.5, 94.5; -76.5, 37.5], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-25.5, 82.5; -92.5, 49.5], style(color=49, thickness=2)),
            Ellipse(extent=[-92.5, 94.5; -24.5, 37.5], style(
                color=8,
                gradient=3,
                fillColor=8)),
            Ellipse(extent=[-60.5, 67.5; -56.5, 64.5], style(color=49,
                  fillColor=0)),
            Line(points=[-58.5, 66.5; -35.5, 79.5], style(color=0, thickness=4)),
            Line(points=[-58.5, 66.5; -58.5, 93.5], style(color=0)),
            Line(points=[-56.5, 66.5; -30.5, 66.5], style(
                color=41,
                thickness=4,
                fillColor=49)),
            Line(points=[-36.5, 77.5; -34.5, 75.5; -33.5, 73.5; -32.5, 70.5; -32.5,
                   68.5], style(color=49, thickness=2)),
            Line(points=[-35.5, 69.5; -32.5, 67.5; -29.5, 69.5], style(color=49,
                   thickness=2)),
            Text(
              extent=[-98.5, 18; -47, -47.5],
              string="§",
              style(color=69)),
            Text(extent=[-99.5, -64.5; 98.5, -99.5], string="T.DIR.READER"),
            Text(
              extent=[-2, 15.5; 49.5, -50],
              string="§",
              style(color=69)),
            Text(
              extent=[47, 13.5; 98.5, -52],
              string="§",
              style(color=69))),
          Window(
            x=0.35,
            y=0.28,
            width=0.6,
            height=0.6));

      end icon_t_dir_reader;

      model icon_t_dir
        annotation (
          Coordsys(
            extent=[-98.5, -98.5; 42, 98.5],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Ellipse(extent=[-97.5, 98.5; -18.5, 32.5], style(
                color=0,
                thickness=4,
                fillColor=0)),
            Line(points=[-58.5, 98.5; -58.5, 32.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-97.5, 66.5; -19.5, 66.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-76.5, 94.5; -39.5, 36.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-91.5, 82.5; -24.5, 49.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-40.5, 94.5; -76.5, 37.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Line(points=[-25.5, 82.5; -92.5, 49.5], style(
                color=49,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[-92.5, 94.5; -24.5, 37.5], style(color=8, fillColor=
                   0)),
            Ellipse(extent=[-61.5, 67.5; -57.5, 64.5], style(color=49,
                  fillColor=0)),
            Line(points=[-59.5, 66.5; -46.5, 74.5], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Line(points=[-59.5, 66.5; -85.5, 79.5], style(
                color=0,
                thickness=2,
                fillColor=0)),
            Ellipse(extent=[-97.5, 98.5; -18.5, 32.5], style(
                color=0,
                thickness=4,
                fillColor=8)),
            Line(points=[-58.5, 98.5; -58.5, 32.5], style(color=49, thickness=2)),
            Line(points=[-97.5, 66.5; -18.5, 66.5], style(color=49, thickness=2)),
            Line(points=[-76.5, 94.5; -39.5, 36.5], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-91.5, 82.5; -23.5, 49.5], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-40.5, 94.5; -76.5, 37.5], style(
                color=49,
                thickness=2,
                fillColor=49)),
            Line(points=[-25.5, 82.5; -92.5, 49.5], style(color=49, thickness=2)),
            Ellipse(extent=[-92.5, 94.5; -24.5, 37.5], style(
                color=8,
                gradient=3,
                fillColor=8)),
            Ellipse(extent=[-60.5, 67.5; -56.5, 64.5], style(color=49,
                  fillColor=0)),
            Line(points=[-58.5, 66.5; -35.5, 79.5], style(color=0, thickness=4)),
            Line(points=[-58.5, 66.5; -58.5, 93.5], style(color=0)),
            Line(points=[-56.5, 66.5; -30.5, 66.5], style(
                color=41,
                thickness=4,
                fillColor=49)),
            Line(points=[-36.5, 77.5; -34.5, 75.5; -33.5, 73.5; -32.5, 70.5; -32.5,
                   68.5], style(color=49, thickness=2)),
            Line(points=[-35.5, 69.5; -32.5, 67.5; -29.5, 69.5], style(color=49,
                   thickness=2)),
            Text(extent=[40.5, -67.5; -98, 99.5], string="§"),
            Text(extent=[-99.5, -64.5; 40.5, -97.5], string="T.DIR.")),
          Window(
            x=0.35,
            y=0.28,
            width=0.6,
            height=0.6));

      end icon_t_dir;

      model icon_sim_ini_clt_h_of_d
        extends base_icons.base_icon_clock;
        annotation (
          Coordsys(
            extent=[-95, 20.6; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(
            Line(points=[-31.4, 68.8; -25.4, 75.8], style(color=41, thickness=2)),
            Line(points=[-32.4, 74.8; -24.4, 69.8], style(color=41, thickness=2)),
            Line(points=[-27.2, 68.2; -27, 64.6; -27.2, 60.8; -28.6, 56.4; -30.4,
                   52.8; -33.6, 49; -37, 46.4; -42.4, 43.4; -46, 42.4; -50.4,
                  41.6; -56.8, 41.6; -61.8, 42], style(color=41)),
            Line(points=[-58.2, 45; -62.2, 42; -58.6, 38.6], style(color=41)),
            Text(extent=[-94.4, 31.2; -16.6, 20.6], string="SIM.INI.ST.T.")),
          Window(
            x=0.16,
            y=0.11,
            width=0.6,
            height=0.6));

      end icon_sim_ini_clt_h_of_d;

      model icon_ini_h_of_d
        extends base_icons.base_icon_clock;
        annotation (
          Coordsys(
            extent=[-95, 20.6; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(
            Line(points=[-31.4, 68.8; -25.4, 75.8], style(color=41, thickness=2)),
            Line(points=[-32.4, 74.8; -24.4, 69.8], style(color=41, thickness=2)),
            Line(points=[-27.2, 68.2; -27, 64.6; -27.2, 60.8; -28.6, 56.4; -30.4,
                   52.8; -33.6, 49; -37, 46.4; -42.4, 43.4; -46, 42.4; -50.4,
                  41.6; -56.8, 41.6; -61.8, 42], style(color=41)),
            Line(points=[-58.2, 45; -62.2, 42; -58.6, 38.6], style(color=41)),
            Text(extent=[-94.4, 31.2; -16.6, 20.6], string="INI.T.")),
          Window(
            x=0.16,
            y=0.11,
            width=0.6,
            height=0.6));

      end icon_ini_h_of_d;

      model icon_fin_h_of_d
        extends base_icons.base_icon_clock;
        annotation (
          Coordsys(
            extent=[-95, 20.6; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(
            Line(points=[-69.6, 81; -69.4, 88.6], style(color=41, thickness=2)),
            Line(points=[-73.8, 85; -64.8, 84], style(color=41, thickness=2)),
            Line(points=[-74.6, 81.2; -76.6, 79; -79, 76; -80.8, 72.6; -82.2,
                  68.2; -82.4, 63.6; -81.2, 59; -79.2, 54.6; -76, 50.6; -71.8,
                  47.2], style(color=41)),
            Line(points=[-78.8, 80; -74.4, 81.4; -74.2, 77.4], style(color=41)),
            Text(extent=[-94.4, 31.2; -16.6, 20.6], string="FIN.T.")),
          Window(
            x=0.19,
            y=0.25,
            width=0.6,
            height=0.6));

      end icon_fin_h_of_d;

      model icon_ini_and_fin_h_of_d
        extends base_icons.base_icon_clock;
        annotation (
          Coordsys(
            extent=[-95, 20.6; -16, 98],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(
            Line(points=[-31.4, 68.8; -25.4, 75.8], style(color=41, thickness=2)),
            Line(points=[-32.4, 74.8; -24.4, 69.8], style(color=41, thickness=2)),
            Line(points=[-27.2, 68.2; -27, 64.6; -27.2, 60.8; -28.6, 56.4; -30.4,
                   52.8; -33.6, 49; -37, 46.4; -42.4, 43.4; -46, 42.4; -50.4,
                  41.6; -56.8, 41.6; -61.8, 42], style(color=41)),
            Line(points=[-58.2, 45; -62.2, 42; -58.6, 38.6], style(color=41)),
            Text(extent=[-94.4, 31.2; -16.6, 20.6], string="INI.AND FIN.T"),
            Line(points=[-73.8, 85; -64.8, 84], style(color=41, thickness=2)),
            Line(points=[-69.6, 81; -69.4, 88.6], style(color=41, thickness=2)),
            Line(points=[-74.6, 81.2; -76.6, 79; -79, 76; -80.8, 72.6; -82.2,
                  68.2; -82.4, 63.6; -81.2, 59; -79.2, 54.6; -76, 50.6; -71.8,
                  47.2], style(color=41)),
            Line(points=[-78.8, 80; -74.4, 81.4; -74.2, 77.4], style(color=41))),
          Window(
            x=0.16,
            y=0.11,
            width=0.6,
            height=0.6));

      end icon_ini_and_fin_h_of_d;

      model icon_sim_ini_clt_h_of_d_and_date
        extends base_icons.base_icon_t_and_date;
        annotation (
          Coordsys(
            extent=[-98, -88; 116, 99],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Text(extent=[-96, -44; 116, -88], string="SIM.INI.ST.T.AND DATE"),
            Line(points=[-30, 13; -16, 26], style(color=41, thickness=2)),
            Line(points=[-31, 27; -16, 10], style(color=41, thickness=2)),
            Line(points=[-13, 19; 75, 19], style(color=41)),
            Line(points=[65, 25; 75, 19; 67, 12], style(color=41)),
            Line(points=[-31.4, 68.8; -25.4, 75.8], style(color=41, thickness=2)),
            Line(points=[-32.4, 74.8; -24.4, 69.8], style(color=41, thickness=2)),
            Line(points=[-27.2, 68.2; -27, 64.6; -27.2, 60.8; -28.6, 56.4; -30.4,
                   52.8; -33.6, 49; -37, 46.4; -42.4, 43.4; -46, 42.4; -50.4,
                  41.6; -56.8, 41.6; -61.8, 42], style(color=41)),
            Line(points=[-58.2, 45; -62.2, 42; -58.6, 38.6], style(color=41))),
          Window(
            x=0.06,
            y=0.22,
            width=0.79,
            height=0.6));

      end icon_sim_ini_clt_h_of_d_and_date;

      model icon_ini_h_of_d_and_date
        extends base_icons.base_icon_t_and_date;
        annotation (
          Coordsys(
            extent=[-98, -88; 116, 99],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Text(extent=[-96, -44; 116, -88], string="INI.T.AND DATE"),
            Line(points=[-30, 13; -16, 26], style(color=41, thickness=2)),
            Line(points=[-31, 27; -16, 10], style(color=41, thickness=2)),
            Line(points=[-13, 19; 75, 19], style(color=41)),
            Line(points=[65, 25; 75, 19; 67, 12], style(color=41)),
            Line(points=[-31.4, 68.8; -25.4, 75.8], style(color=41, thickness=2)),
            Line(points=[-32.4, 74.8; -24.4, 69.8], style(color=41, thickness=2)),
            Line(points=[-27.2, 68.2; -27, 64.6; -27.2, 60.8; -28.6, 56.4; -30.4,
                   52.8; -33.6, 49; -37, 46.4; -42.4, 43.4; -46, 42.4; -50.4,
                  41.6; -56.8, 41.6; -61.8, 42], style(color=41)),
            Line(points=[-58.2, 45; -62.2, 42; -58.6, 38.6], style(color=41))),
          Window(
            x=0.06,
            y=0.22,
            width=0.79,
            height=0.6));

      end icon_ini_h_of_d_and_date;

      model icon_fin_h_of_d_and_date
        extends base_icons.base_icon_t_and_date;
        annotation (
          Coordsys(
            extent=[-98, -88; 116, 99],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6),
          Icon(
            Text(extent=[-96, -44; 116, -88], string="FIN.T.AND DATE"),
            Line(points=[66, 5; 81, -12], style(color=41, thickness=2)),
            Line(points=[67, -9; 81, 4], style(color=41, thickness=2)),
            Line(points=[-24, -4; 54, -4], style(color=41)),
            Line(points=[46, 2; 54, -4; 46, -10], style(color=41)),
            Line(points=[-74.6, 81.2; -76.6, 79; -79, 76; -80.8, 72.6; -82.2,
                  68.2; -82.4, 63.6; -81.2, 59; -79.2, 54.6; -76, 50.6; -71.8,
                  47.2], style(color=41)),
            Line(points=[-78.8, 80; -74.4, 81.4; -74.2, 77.4], style(color=41)),
            Line(points=[-69.6, 81; -69.4, 88.6], style(color=41, thickness=2)),
            Line(points=[-73.8, 85; -64.8, 84], style(color=41, thickness=2))));

      end icon_fin_h_of_d_and_date;

      model icon_ini_and_fin_h_of_d_and_date
        extends base_icons.base_icon_t_and_date;
        annotation (
          Coordsys(
            extent=[-98, -88; 116, 99],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6),
          Icon(
            Text(extent=[-96, -44; 116, -88], string="INI.AND FIN.T.AND DATE"),
            Line(points=[-30, 13; -16, 26], style(color=41, thickness=2)),
            Line(points=[-31, 27; -16, 10], style(color=41, thickness=2)),
            Line(points=[-15, 19; 32, 19], style(color=41)),
            Line(points=[22, 25; 32, 19; 24, 12], style(color=41)),
            Line(points=[-24, -4; 54, -4], style(color=41)),
            Line(points=[46, 2; 54, -4; 46, -10], style(color=41)),
            Line(points=[66, 5; 81, -12], style(color=41, thickness=2)),
            Line(points=[67, -9; 81, 4], style(color=41, thickness=2)),
            Line(points=[-73.8, 85; -64.8, 84], style(color=41, thickness=2)),
            Line(points=[-69.6, 81; -69.4, 88.6], style(color=41, thickness=2)),
            Line(points=[-32.4, 74.8; -24.4, 69.8], style(color=41, thickness=2)),
            Line(points=[-31.4, 68.8; -25.4, 75.8], style(color=41, thickness=2))));

      end icon_ini_and_fin_h_of_d_and_date;

      model icon_f_of_date
        extends universals.icon_function;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-94, 37; -70, -87]),
            Rectangle(extent=[-70, 37; -46, -87]),
            Rectangle(extent=[-46, 37; -22, -87]),
            Rectangle(extent=[-22, 37; 2, -87]),
            Rectangle(extent=[2, 37; 26, -87]),
            Rectangle(extent=[26, 37; 50, -87]),
            Rectangle(extent=[50, 37; 74, -87], style(fillColor=48)),
            Rectangle(extent=[-94, 23; 74, 1]),
            Rectangle(extent=[-94, 1; 74, -21]),
            Rectangle(extent=[-94, -21; 74, -43]),
            Rectangle(extent=[-94, -43; 74, -65]),
            Rectangle(extent=[-94, -65; 74, -87]),
            Text(extent=[-45, 36; -23, 24], string="we"),
            Text(extent=[-21, 36; 1, 24], string="th"),
            Text(extent=[3, 36; 25, 24], string="fr"),
            Text(extent=[27, 36; 49, 24], string="sa"),
            Text(extent=[51, 36; 73, 24], string="su"),
            Text(extent=[-69, 36; -47, 24], string="tu"),
            Text(extent=[-93, 36; -71, 24], string="mo"),
            Text(extent=[51, 36; 73, 24], string="su")),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_f_of_date;

      model icon_holid_calc
        extends base_icons.base_icon_holid;
        annotation (
          Icon(Text(extent=[-170, -149; 119, -194], string="HOLID.CALC."), Text(
              extent=[3, 35; 111, -151],
              string="§",
              style(color=41))),
          Coordsys(
            extent=[-173, -194; 119, 130],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.31,
            y=0.27,
            width=0.6,
            height=0.6));
      end icon_holid_calc;

      model icon_holid_dir_reader
        extends base_icons.base_icon_holid;
        annotation (
          Icon(
            Text(extent=[-170, -149; 119, -194], string="HOLID.DIR.READER"),
            Text(
              extent=[-44, -56; 17, -132.5],
              string="§",
              style(color=73)),
            Text(
              extent=[86, -66.5; 137.5, -132],
              string="§",
              style(color=73)),
            Text(
              extent=[-91, -56; -30, -132.5],
              string="§",
              style(color=73)),
            Text(
              extent=[-1, 35; 107, -151],
              string="§",
              style(color=41))),
          Coordsys(
            extent=[-173, -194; 119, 130],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.4,
            y=0.24,
            width=0.6,
            height=0.6));
      end icon_holid_dir_reader;

      model icon_holid_dir
        extends base_icons.base_icon_holid;
        annotation (
          Icon(Text(extent=[-246, -298; 149, -355], string="HOLID.DIR."), Text(
              extent=[-29, 46; 140, -300],
              string="§",
              style(color=73))),
          Coordsys(
            extent=[-250, -357; 160, 130],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.34,
            y=0.22,
            width=0.6,
            height=0.6));
      end icon_holid_dir;

      model icon_position_of_sun
        annotation (
          Coordsys(
            extent=[-85, -90; 75, 88],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Text(extent=[-85, -74; 75, -90], string="POSITION OF SUN"),
            Ellipse(extent=[-67, -36; 51, -74], style(color=0, fillColor=54)),
            Ellipse(extent=[-63, 88; -33, 62], style(
                color=41,
                pattern=4,
                fillPattern=0)),
            Text(
              extent=[-57, 81; -39, 71],
              string="NOON",
              style(color=41, fillColor=85)),
            Line(points=[42, 31; 42, -45], style(color=0, thickness=2)),
            Line(points=[-49, 62; -49, 74], style(color=0, pattern=3)),
            Line(points=[-49, 62; -49, -41], style(color=0, pattern=3)),
            Line(points=[40, 42; -8, -58], style(color=41, thickness=2)),
            Line(points=[-49, -41; -8, -58], style(color=0, pattern=3)),
            Line(points=[42, -45; -8, -58], style(color=0, thickness=2)),
            Line(points=[-8, 7; -6, 9; -2, 12; 2, 14; 7, 16; 12, 17; 16, 17; 20,
                   16; 25, 14], style(color=0, thickness=2)),
            Line(points=[22, 18; 26, 14; 21, 13], style(color=0, thickness=2)),
            Line(points=[-38, -45; -30, -43; -22, -42; -15, -41; -3, -41; 6, -42;
                   14, -43; 19, -44; 23, -45; 27, -46; 32, -47], style(color=0,
                   thickness=2)),
            Line(points=[25, -44; 32, -47; 22, -48], style(color=0, thickness=2)),
            Ellipse(extent=[-63, 88; -33, 62], style(
                color=41,
                pattern=4,
                fillPattern=0)),
            Ellipse(extent=[27, 57; 57, 31], style(
                color=41,
                pattern=4,
                thickness=2,
                fillColor=45)),
            Line(points=[41, 44; 36, 33], style(color=0, pattern=3)),
            Line(points=[42, 31; 42, 44], style(color=0, pattern=3)),
            Line(points=[-8, -58; -8, 25], style(color=0))),
          Window(
            x=0.12,
            y=0.03,
            width=0.84,
            height=0.91));

      end icon_position_of_sun;

      model icon_sunrise_and_sunset
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Ellipse(extent=[-36, 45.5; 36, -26.5], style(
                color=41,
                thickness=2,
                fillColor=45)),
            Polygon(points=[-100, 4.5; -85.5, 6; -56.5, 7.5; 0, 8; 56.5, 7.5;
                  85.6, 6; 100, 4.5; 95, -75; -95, -75; -100, 4.5], style(color=
                   7, fillColor=54)),
            Line(points=[0, 8; -97.5, 22.5], style(color=45)),
            Line(points=[0, 8; -85, 65.5], style(color=45)),
            Line(points=[0, 8; -31, 83.5], style(color=45)),
            Line(points=[0, 8; 97.5, 22.5], style(color=45)),
            Line(points=[0, 8; 85, 65.5], style(color=45)),
            Line(points=[0, 8; 31, 83.5], style(color=45)),
            Text(extent=[-99.5, -74; 101, -101.5], string=
                  "SUNSET & SUNRISE T.REG.")),
          Window(
            x=0.2,
            y=0.09,
            width=0.6,
            height=0.59));
      equation

      end icon_sunrise_and_sunset;

      model icon_extraterr_rad_on_horiz
        annotation (
          Icon(
            Ellipse(extent=[-26, 68; -98, -4], style(
                color=41,
                thickness=2,
                fillColor=45)),
            Line(points=[-30, 18; 128, -50], style(color=41, thickness=2)),
            Polygon(points=[158, -41; 135, -48; 119, -56; 104, -68; 93, -80; 85,
                   -92; 78, -106; 73, -124; 72, -142; 159, -142; 159, -41; 158,
                   -41], style(
                color=7,
                gradient=3,
                fillColor=68)),
            Polygon(points=[159, -75; 150, -78; 142, -82; 133, -88; 126, -94;
                  120, -100; 115, -107; 110, -116; 106, -127; 105, -134; 104, -142;
                   159, -142; 159, -75], style(color=69, fillColor=58)),
            Text(extent=[-186, -142; 128, -178], string="EXTRAT.RAD.ON HORIZ."),
            Line(points=[-30, 20; -62, 34], style(color=0, pattern=3)),
            Line(points=[124, -54; 136, -48], style(thickness=2)),
            Line(points=[138, -84; 150, -78], style(thickness=2)),
            Line(points=[130, -52; 144, -80], style(color=0))),
          Coordsys(
            extent=[-186, -178; 159, 68],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.08,
            y=0.32,
            width=0.6,
            height=0.6));

      end icon_extraterr_rad_on_horiz;

      model icon_extraterr_rad_on_tilted_surf
        extends base_icons.base_icon_extraterr_rad_on_tilted_surf;
        annotation (
          Icon(Text(extent=[14.2, 62.1; 137.8, 30.1], string=
                  "ss= %uf_surf_slope°"), Text(extent=[17.7, 31.2; 129.3, -3.7],
                 string="sa=%uf_surf_azimuth°")),
          Coordsys(
            extent=[-186, -178; 159, 68],
            grid=[0.1, 0.1],
            component=[20, 20]),
          Window(
            x=0.2,
            y=0.24,
            width=0.6,
            height=0.6));
      end icon_extraterr_rad_on_tilted_surf;

      model icon_extraterr_rad_on_tilted_surf_mux
        extends base_icons.base_icon_extraterr_rad_on_tilted_surf;
        annotation (Coordsys(
            extent=[-186, -178; 159, 68],
            grid=[.1,.1],
            component=[20, 20]), Window(
            x=0.2,
            y=0.24,
            width=0.6,
            height=0.6));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[82, 0; 156, 64], layer="icon");
      end icon_extraterr_rad_on_tilted_surf_mux;

      model icon_atm_att
        extends base_icons.base_icon_atm_att;
        annotation (
          Coordsys(
            extent=[-118, -130; 118, 46],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.15,
            y=0.19,
            width=0.77,
            height=0.63),
          Icon(Text(extent=[-118, -100; 118, -130], string="ATM.ATT.")));
      end icon_atm_att;

      model icon_rad_on_horiz_on_clear_d
        annotation (
          Coordsys(
            extent=[-124, -106; 112, 32],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[-100, -52; 100, -76], style(color=57, fillColor=
                    58)),
            Polygon(points=[-100, 8; -84, 10; -58, 12; 6, 14; 74, 12; 100, 10;
                  100, -52; -100, -52; -100, 8], style(pattern=0, fillColor=68)),
            Ellipse(extent=[-48, -12; -46, -14]),
            Ellipse(extent=[-48, -12; -46, -14]),
            Ellipse(extent=[78, -40; 80, -42]),
            Ellipse(extent=[-34, -30; -32, -32]),
            Ellipse(extent=[8, -32; 10, -34]),
            Ellipse(extent=[-20, -4; -18, -6]),
            Ellipse(extent=[-32, -44; -30, -46]),
            Ellipse(extent=[-10, -12; -8, -14]),
            Ellipse(extent=[-48, -34; -46, -36]),
            Ellipse(extent=[-70, -26; -68, -28]),
            Ellipse(extent=[20, -22; 22, -24]),
            Ellipse(extent=[56, -18; 58, -20]),
            Ellipse(extent=[-26, -16; -24, -18]),
            Ellipse(extent=[80, -4; 82, -6]),
            Ellipse(extent=[-10, -34; -8, -36]),
            Ellipse(extent=[24, -42; 26, -44]),
            Ellipse(extent=[48, -34; 50, -36]),
            Ellipse(extent=[42, -2; 44, -4]),
            Ellipse(extent=[-86, -6; -84, -8]),
            Ellipse(extent=[-82, -40; -80, -42]),
            Ellipse(extent=[16, -6; 18, -8]),
            Line(points=[58, -46; 84, -18], style(color=45)),
            Line(points=[-78, -50; -60, -34], style(color=45)),
            Line(points=[41, -21; 46, -30], style(color=45)),
            Text(extent=[-124, -74; 112, -106], string="CLR D.RAD.ON HORIZ."),
            Line(points=[6, -12; -4, -22], style(color=45)),
            Polygon(points=[41, -74; 21, -54; -7, -54; 11, -74; 41, -74], style(
                  color=0, fillColor=69)),
            Line(points=[13, -61; 13, -15], style(color=0)),
            Line(points=[-82, 32; -70, 20], style(color=41, thickness=4)),
            Line(points=[-70, 20; -24, -26], style(color=41, thickness=2)),
            Line(points=[-40, -10; -12, -38], style(color=41)),
            Line(points=[-12, -38; 14, -62], style(color=41, pattern=3)),
            Line(points=[-30, 4; -44, 2], style(color=45))),
          Window(
            x=0.26,
            y=0.23,
            width=0.6,
            height=0.6));

      end icon_rad_on_horiz_on_clear_d;

      model icon_rad_on_horiz_1
        extends base_icons.base_icon_rad_on_horiz;
        annotation (
          Coordsys(
            extent=[-40, -56; 62, 52],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.22,
            y=0.04,
            width=0.77,
            height=0.88),
          Icon(Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=
                   49)), Text(
              extent=[-16, -26; -35, -44],
              string="1",
              style(color=41))));
      end icon_rad_on_horiz_1;

      model icon_rad_on_horiz_2
        extends base_icons.base_icon_rad_on_horiz;
        annotation (
          Coordsys(
            extent=[-40, -56; 62, 52],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.22,
            y=0.04,
            width=0.77,
            height=0.88),
          Icon(Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=
                   49)), Text(
              extent=[-16, -26; -35, -44],
              string="2",
              style(color=41))));
      end icon_rad_on_horiz_2;

      model icon_rad_on_tilted_surf
        extends base_icons.base_icon_rad_on_tilted_surf;
        annotation (
          Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Text(extent=[16, 34; 62, 20], string="ss= %uf_surf_slope°"),
            Text(extent=[16, 20; 62, 4], string="sa=%uf_surf_azimuth°"),
            Text(
              extent=[-16, -26; -35, -44],
              string="%mode",
              style(color=41))),
          Window(
            x=0.08,
            y=0.13,
            width=0.78,
            height=0.67));
      end icon_rad_on_tilted_surf;

      model icon_rad_on_tilted_surf_mode_4
        extends base_icons.base_icon_rad_on_tilted_surf;
        annotation (
          Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[1, 1],
            component=[20, 20]),
          Icon(
            Text(extent=[62, 34; 16, 20], string="ss= %uf_surf_slope°"),
            Text(extent=[16, 20; 62, 4], string="sa=%uf_surf_azimuth°"),
            Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=49)),
            Text(
              extent=[-17, -26; -36, -44],
              string="4",
              style(color=41))),
          Window(
            x=0.07,
            y=0.05,
            width=0.89,
            height=0.95));

      end icon_rad_on_tilted_surf_mode_4;

      model icon_rad_on_tilted_surf_mux
        extends base_icons.base_icon_rad_on_tilted_surf;
        annotation (
          Coordsys(
            extent=[-61, -55; 62, 60],
            grid=[1, 1],
            component=[20, 20]),
          Icon(Text(
              extent=[-16, -26; -35, -44],
              string="%mode",
              style(color=41))),
          Window(
            x=0.15,
            y=0.21,
            width=0.78,
            height=0.67));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[24, 5; 56, 36], layer="icon");
      end icon_rad_on_tilted_surf_mux;

      model icon_rad_on_tilted_surf_mode_4_mux
        extends base_icons.base_icon_rad_on_tilted_surf;
        annotation (
          Coordsys(
            extent=[-61, -55; 62, 60],
            grid=[1, 1],
            component=[20, 20]),
          Icon(Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=
                   49)), Text(
              extent=[-16, -26; -35, -44],
              string="4",
              style(color=41))),
          Window(
            x=0.15,
            y=0.21,
            width=0.78,
            height=0.67));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[24, 5; 56, 36], layer="icon");
      end icon_rad_on_tilted_surf_mode_4_mux;

      model icon_rad_on_normal_surf
        extends base_icons.base_icon_rad_on_normal_surf;
        annotation (
          Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[1, 1],
            component=[20, 20]),
          Icon(Text(
              extent=[-16, -26; -35, -44],
              string="%mode",
              style(color=41))),
          Window(
            x=0.08,
            y=0.13,
            width=0.78,
            height=0.67));
      end icon_rad_on_normal_surf;

      model icon_rad_on_normal_surf_mode_4
        extends base_icons.base_icon_rad_on_normal_surf;
        annotation (
          Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[1, 1],
            component=[20, 20]),
          Icon(Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=
                   49)), Text(
              extent=[-17, -26; -36, -44],
              string="4",
              style(color=41))),
          Window(
            x=0.07,
            y=0.05,
            width=0.89,
            height=0.95));
      end icon_rad_on_normal_surf_mode_4;

      model icon_rad_on_tracking_surf_vert_axis
        extends base_icons.base_icon_rad_on_tracking_surf_vert_axis;
        annotation (Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_rad_on_tracking_surf_vert_axis;

      model icon_rad_on_tracking_surf_vert_axis_mode_4
        extends base_icons.base_icon_rad_on_tracking_surf_vert_axis;
        annotation (
          Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=
                   49)), Text(
              extent=[-17, -26; -36, -44],
              string="4",
              style(color=41))),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_rad_on_tracking_surf_vert_axis_mode_4;

      model icon_rad_on_tracking_surf_horiz_axis
        extends base_icons.base_icon_rad_on_tracking_surf_horiz_axis;
        annotation (Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_rad_on_tracking_surf_horiz_axis;

      model icon_rad_on_tracking_surf_horiz_axis_mode_4
        extends base_icons.base_icon_rad_on_tracking_surf_horiz_axis;
        annotation (
          Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=
                   49)), Text(
              extent=[-17, -26; -36, -44],
              string="4",
              style(color=41))),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_rad_on_tracking_surf_horiz_axis_mode_4;

      model icon_rad_on_tracking_surf_tilted_axis
        extends base_icons.base_icon_rad_on_tracking_surf_tilted_axis;
        annotation (Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[0.2, 0.2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_rad_on_tracking_surf_tilted_axis;

      model icon_rad_on_tracking_surf_tilted_axis_mode_4
        extends base_icons.base_icon_rad_on_tracking_surf_tilted_axis;
        annotation (
          Coordsys(
            extent=[-43, -55; 72, 60],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(Rectangle(extent=[-19, -29; -31, -41], style(color=49, fillColor=
                   49)), Text(
              extent=[-17, -26; -36, -44],
              string="4",
              style(color=41))),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_rad_on_tracking_surf_tilted_axis_mode_4;

      model icon_global_old
        extends base_icons.base_icon_location_little;
        annotation (
          Coordsys(
            extent=[-61.2, -56.2; 72, 60.4],
            grid=[0.1, 0.1],
            component=[20, 20]),
          Window(
            x=0.1,
            y=0.13,
            width=0.74,
            height=0.69),
          Icon(
            Rectangle(extent=[-59.6, 60.4; 62.2, -56.2], style(thickness=4)),
            Polygon(points=[52.4, -38.2; 12.4, 1.8; -47.6, 1.8; -7.6, -38.2;
                  52.4, -38.2], style(color=0, fillColor=58)),
            Ellipse(extent=[-15.6, 54.8; -24.6, 45.8], style(
                color=41,
                thickness=2,
                fillColor=45)),
            Polygon(points=[12.4, -28.2; 25.4, -22.2; 14.4, -14.2; 12.4, -28.2],
                 style(color=0, fillColor=0)),
            Polygon(points=[28.4, -10.2; 2.4, 5.8; -11.6, -8.2; 12.4, -28.2;
                  28.4, -10.2], style(color=0, fillColor=69)),
            Line(points=[-17.6, 45.8; 6.4, -10.2], style(
                color=41,
                thickness=2,
                fillColor=41)),
            Rectangle(extent=[-58.4, -38.8; 60.7, -55.1], style(color=7,
                  fillColor=7)),
            Text(
              extent=[-59.3, -38; 61.5, -55.4],
              string="T. & SOLAR RADIATION",
              style(color=41))));
      end icon_global_old;

      model icon_global
        logos.logo_icon_4 logo_icon_4_1
          annotation (extent=[-58.3, -54.2; 59.7, 58.3], layer="icon");
        annotation (
          Coordsys(
            extent=[-61.2, -56.2; 72, 60.4],
            grid=[0.1, 0.1],
            component=[20, 20]),
          Window(
            x=0.04,
            y=0.5,
            width=0.74,
            height=0.53),
          Icon(
            Rectangle(extent=[-59.6, 60.4; 62.2, -56.2], style(thickness=4)),
            Rectangle(extent=[-58.4, -38.8; 60.7, -55.1], style(color=7,
                  fillColor=7)),
            Polygon(points=[52.4, -38.2; 12.4, 1.8; -47.6, 1.8; -7.6, -38.2;
                  52.4, -38.2], style(color=0, fillColor=58)),
            Polygon(points=[10.6, -29.6; -15.6, -28.1; -15.8, -8.9; 7.5, -7.7;
                  10.6, -29.6], style(pattern=0, fillColor=0)),
            Text(
              extent=[-54.7, -39; 56, -54.7],
              string="T.& SL.RAD.",
              style(color=41)),
            Polygon(points=[7.4, -7; 10.6, -29.5; -12.8, -18.4; -16.4, 7.3; 7.4,
                   -7], style(color=0, fillColor=69)),
            Line(points=[33.1, 31.1; -3.1, -11.3], style(color=41, thickness=2))));
      end icon_global;

      model icon_global_extraterr
        annotation (
          Coordsys(
            extent=[-61.2, -56.2; 72, 60.4],
            grid=[0.1, 0.1],
            component=[20, 20]),
          Window(
            x=0.1,
            y=0.13,
            width=0.74,
            height=0.69),
          Icon(
            Rectangle(extent=[-59.6, 60.4; 62.2, -56.2], style(thickness=4)),
            Rectangle(extent=[-58.4, -38.8; 60.7, -55.1], style(color=7,
                  fillColor=7)),
            Text(
              extent=[-59.3, -38; 61.5, -55.4],
              string="T.& SL.RAD.",
              style(color=41)),
            Polygon(points=[-57.9, -24.5; -32.5, -39; -13.7, -8.9; -20.5, -4.1;
                   -57.9, -24.5], style(
                color=0,
                fillColor=7,
                fillPattern=10)),
            Polygon(points=[3.5, 11.1; 10.7, 2.3; 42.6, 17; 31.5, 37.2; 3.5,
                  11.1], style(
                color=0,
                fillColor=7,
                fillPattern=10)),
            Ellipse(extent=[-10.5, 4.7; -2.5, -3.3], style(color=0)),
            Line(points=[6.4, 7.1; -7.2, 0.3; -18.3, -8.2], style(color=0)),
            Ellipse(extent=[-14.5, 6.7; 3.5, -5.3], style(
                color=57,
                gradient=3,
                fillColor=7))));
        logos.logo_icon_4 logo_icon_4_1
          annotation (extent=[-58.3, -54.2; 59.7, 58.3], layer="icon");
      end icon_global_extraterr;

      model icon_global_usr_behaviour
        annotation (
          Coordsys(
            extent=[-61.2, -56.2; 72, 60.4],
            grid=[0.1, 0.1],
            component=[20, 20]),
          Window(
            x=0.1,
            y=0.13,
            width=0.74,
            height=0.69),
          Icon(
            Rectangle(extent=[-59.6, 60.4; 62.2, -56.2], style(thickness=4)),
            Rectangle(extent=[-58.4, -38.8; 60.7, -55.1], style(color=7,
                  fillColor=7)),
            Text(
              extent=[-59.3, -38; 61.5, -55.4],
              string="USER BEHAVIOUR",
              style(color=41))));
        logos.logo_icon_4 logo_icon_4_1
          annotation (extent=[-58.3, -54.2; 59.7, 58.3], layer="icon");

      end icon_global_usr_behaviour;

      model icon_global_t_and_date
        annotation (
          Coordsys(
            extent=[-61.2, -56.2; 72, 60.4],
            grid=[0.1, 0.1],
            component=[20, 20]),
          Window(
            x=0.1,
            y=0.13,
            width=0.74,
            height=0.69),
          Icon(
            Rectangle(extent=[-59.6, 60.4; 62.2, -56.2], style(thickness=4)),
            Rectangle(extent=[-58.4, -38.8; 60.7, -55.1], style(color=7,
                  fillColor=7)),
            Text(
              extent=[-59.3, -38; 61.5, -55.4],
              string="T.& DATE",
              style(color=41))));
        logos.logo_icon_4 logo_icon_4_1
          annotation (extent=[-58.3, -54.2; 59.7, 58.3], layer="icon");
        base_icons.base_icon_clock base_icon_clock1
          annotation (extent=[-40.5, -33.4; 24.8, 30.6], layer="icon");
      end icon_global_t_and_date;

      model icon_surf_orient_alias_def
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.17,
            y=0.03,
            width=0.56,
            height=0.57),
          Icon(
            Ellipse(extent=[-45, 45; 45, -45], style(color=0)),
            Polygon(points=[0, 0; 15, 42; 55, 55; 0, 0], style(color=0,
                  fillColor=9)),
            Polygon(points=[0, 0; 42, 15; 55, 55; 0, 0], style(color=0,
                  fillColor=8)),
            Polygon(points=[0, 0; -15, -42; -55, -55; 0, 0], style(color=0,
                  fillColor=9)),
            Polygon(points=[0, 0; -42, -15; -55, -55; 0, 0], style(color=0,
                  fillColor=8)),
            Polygon(points=[0, 0; 15, -42; 55, -55; 0, 0], style(color=0,
                  fillColor=8)),
            Polygon(points=[0, 0; 42, -15; 55, -55; 0, 0], style(color=0,
                  fillColor=9)),
            Polygon(points=[0, 0; -15, 42; -55, 55; 0, 0], style(color=0,
                  fillColor=8)),
            Polygon(points=[0, 0; -42, 15; -55, 55; 0, 0], style(color=0,
                  fillColor=9)),
            Polygon(points=[20, -24; 100, 0; 0, 0; 20, -24], style(color=0,
                  fillColor=8)),
            Polygon(points=[20, -24; 0, -100; 0, 0; 20, -24], style(color=0,
                  fillColor=9)),
            Polygon(points=[-20, -24; -100, 0; 0, 0; -20, -24], style(color=0,
                  fillColor=9)),
            Polygon(points=[-20, -24; 0, -100; 0, 0; -20, -24], style(color=0,
                  fillColor=8)),
            Polygon(points=[-20, 24; 0, 100; 0, 0; -20, 24], style(color=0,
                  fillColor=9)),
            Polygon(points=[20, 24; 0, 100; 0, 0; 20, 24], style(color=0,
                  fillColor=8)),
            Polygon(points=[-20, 24; -100, 0; 0, 0; -20, 24], style(color=0,
                  fillColor=8)),
            Polygon(points=[20, 24; 100, 0; 0, 0; 20, 24], style(color=0,
                  fillColor=9))));
      equation

      end icon_surf_orient_alias_def;

      model icon_surf_orient_alias_usr_settings
        extends icon_surf_orient_alias_def;
        annotation (
          Coordsys(
            extent=[-100, -138; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Text(extent=[-98, -96; 98, -138], string="%name"), Text(
              extent=[-100, -66; -20, -98],
              string="alias set:",
              style(color=0))),
          Window(
            x=0.26,
            y=0.29,
            width=0.6,
            height=0.6));
      end icon_surf_orient_alias_usr_settings;

      model icon_surf_orient_alias_usr_settings_sel
        extends icon_surf_orient_alias_def;
        annotation (
          Coordsys(
            extent=[-100, -138; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Text(
              extent=[-98, -96; 98, -138],
              string="%name",
              style(color=41))),
          Window(
            x=0.26,
            y=0.29,
            width=0.6,
            height=0.6));
      end icon_surf_orient_alias_usr_settings_sel;

      model icon_equation_of_t
        annotation (Coordsys(
            extent=[-108, -114; 160, 100],
            grid=[2, 2],
            component=[20, 20]), Icon(
            Text(
              extent=[-80, -60; -60, -80],
              string="J",
              style(color=8)),
            Line(points=[160, -60; -80, -60; -80, 100], style(color=0,
                  thickness=4)),
            Text(
              extent=[-60, -60; -40, -80],
              string="F",
              style(color=8)),
            Text(
              extent=[-40, -60; -20, -80],
              string="M",
              style(color=8)),
            Text(
              extent=[-20, -60; 0, -80],
              string="A",
              style(color=8)),
            Text(
              extent=[0, -60; 20, -80],
              string="M",
              style(color=8)),
            Text(
              extent=[20, -60; 40, -80],
              string="J",
              style(color=8)),
            Text(
              extent=[40, -60; 60, -80],
              string="J",
              style(color=8)),
            Text(
              extent=[60, -60; 80, -80],
              string="A",
              style(color=8)),
            Text(
              extent=[80, -60; 100, -80],
              string="S",
              style(color=8)),
            Text(
              extent=[100, -60; 120, -80],
              string="O",
              style(color=8)),
            Text(
              extent=[120, -60; 140, -80],
              string="N",
              style(color=8)),
            Text(
              extent=[140, -60; 160, -80],
              string="D",
              style(color=8)),
            Text(extent=[-108, -80; 160, -114], string="EQUATION OF T."),
            Text(extent=[-108, -30; -82, -44], string="-0.25"),
            Line(points=[-80, 4; -66, -18; -60, -28; -48, -32; -38, -28; -30, -16;
                   -18, 4; -8, 24; 2, 34; 12, 38; 22, 34; 30, 24; 42, 8; 48, 4;
                   58, -2; 62, 0; 68, 4; 82, 24; 92, 44; 102, 66; 111, 82; 121,
                   89; 133, 82; 142, 66; 150, 44; 156, 24; 160, 4], style(
                  thickness=2)),
            Line(points=[-80, 20; 160, 20; 160, -60], style(color=9)),
            Line(points=[-80, 100; 160, 100; 160, 20], style(color=9)),
            Text(extent=[-108, 86; -80, 74], string="0.25"),
            Text(extent=[-106, 30; -82, 10], string="0"),
            Text(extent=[-70, 96; -34, 70], string="(h)")));
      equation

      end icon_equation_of_t;

      model icon_per_rad_integ_ini_and_length
        extends base_icons.base_icon_axis_integ;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Text(
              extent=[-35, 98.5; -2.5, 79],
              string="P",
              style(color=0)),
            Line(points=[-44.5, 76; 7.5, 76], style(color=10)),
            Line(points=[-39.5, -44; -39.5, 83.5], style(color=10, pattern=2)),
            Line(points=[0.5, 31; 0.5, 80.5], style(color=10, pattern=2)),
            Line(points=[-79.5, -44; -39.5, -44; -39.5, -44; 0.5, 56; 0.5, -44;
                   40.5, -2.5; 40.5, -44; 60.5, -24.5]),
            Text(extent=[-99.5, -75; 99.5, -99], string="PER.RAD.INTEG."),
            Text(extent=[-98.5, 72.5; -80.5, 48], string="E"),
            Text(
              extent=[-49, -47.5; -24.5, -66.5],
              string="to",
              style(color=0))),
          Window(
            x=0.18,
            y=0.16,
            width=0.6,
            height=0.6));

      end icon_per_rad_integ_ini_and_length;

      model icon_per_rad_integ_ini_and_length_demux
        extends icon_per_rad_integ_ini_and_length;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[20.5, 28; 63, 71.5], layer="icon");
      end icon_per_rad_integ_ini_and_length_demux;

      model icon_per_rad_integ_ini_and_length_mux
        extends icon_per_rad_integ_ini_and_length;
        annotation (
          Icon(Line(points=[-79.5, -44; -39.5, -44; -39.5, -44; 0.5, 14; 0.5, -44;
                   40.5, -24; 40.5, -44; 60.5, -32], style(color=57)), Line(
                points=[-79.5, -44; -39.5, -44; -39.5, -44; 0.5, 40.5; 0.5, -44;
                   40.5, 13; 40.5, -44; 60, -17], style(color=85))),
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Window(
            x=0.08,
            y=0.11,
            width=0.6,
            height=0.6));
      end icon_per_rad_integ_ini_and_length_mux;

      model icon_per_rad_integ_cal
        extends base_icons.base_icon_axis_calender_integ;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Line(points=[-79.5, -44; -39.5, 37; -39.5, -44; 0.5, 56; 0.5, -44;
                  40.5, -2.5; 40.5, -44; 60.5, -24.5]),
            Text(extent=[-98.5, 72.5; -80.5, 48], string="E"),
            Text(extent=[-99.5, -75; 99.5, -99], string="PER.RAD.INTEG.")),
          Window(
            x=0.27,
            y=0.04,
            width=0.6,
            height=0.6));
      end icon_per_rad_integ_cal;

      model icon_per_rad_integ_cal_demux
        extends icon_per_rad_integ_cal;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[20.5, 28; 63, 71.5], layer="icon");
      end icon_per_rad_integ_cal_demux;

      model icon_per_rad_integ_cal_mux
        extends icon_per_rad_integ_cal;
        annotation (
          Icon(Line(points=[-79.5, -44; -39.5, 1.5; -39.5, -44; 0.5, 30.5; 0.5,
                   -44; 40.5, -24; 40.5, -44; 60.5, -32], style(color=57)),
              Line(points=[-79.5, -44; -39.5, 54.5; -39.5, -44; 0.5, 40.5; 0.5,
                   -44; 40.5, 13; 40.5, -44; 60, -17], style(color=85))),
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Window(
            x=0.36,
            y=0.26,
            width=0.6,
            height=0.6));
      end icon_per_rad_integ_cal_mux;

      model icon_int_rad_integ_ini_and_length
        extends base_icons.base_icon_axis_integ;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Text(extent=[-98.5, 72.5; -80.5, 48], string="E"),
            Text(extent=[-99.5, -75; 99.5, -99], string="INT.RAD.INTEG."),
            Line(points=[-79.5, -44; -33, -44; 4.5, 20.5; 42, 20.5]),
            Line(points=[-33, -43; -33, 60], style(color=10, pattern=2)),
            Line(points=[4.5, -44; 4.5, 60.5], style(color=10, pattern=2)),
            Text(
              extent=[-45.5, -47.5; -21, -66.5],
              string="to",
              style(color=0)),
            Line(points=[-39, 55; 11, 55], style(color=10)),
            Text(
              extent=[-30.5, 78; 2, 58.5],
              string="it",
              style(color=0))),
          Window(
            x=0.34,
            y=0.21,
            width=0.6,
            height=0.6));
      end icon_int_rad_integ_ini_and_length;

      model icon_int_rad_integ_ini_and_length_demux
        extends icon_int_rad_integ_ini_and_length;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[20.5, 28; 63, 71.5], layer="icon");
      end icon_int_rad_integ_ini_and_length_demux;

      model icon_int_rad_integ_ini_and_length_mux
        extends icon_int_rad_integ_ini_and_length;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(Line(points=[-79.5, -44; -33, -44; 4.5, 0; 44, 0], style(color=
                    57)), Line(points=[-79.5, -44; -33, -44; 4.5, 44.5; 45.5,
                  44.5], style(color=85))),
          Window(
            x=0.34,
            y=0.21,
            width=0.6,
            height=0.6));
      end icon_int_rad_integ_ini_and_length_mux;

      model icon_int_rad_integ_ini_and_fin
        extends base_icons.base_icon_axis_integ;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Text(extent=[-98.5, 72.5; -80.5, 48], string="E"),
            Text(extent=[-99.5, -75; 99.5, -99], string="INT.RAD.INTEG."),
            Line(points=[-79.5, -44; -33, -44; 4.5, 27.5; 40.5, 27.5]),
            Line(points=[4.5, -43.5; 4.5, 60.5], style(color=10, pattern=2)),
            Text(
              extent=[-45.5, -47.5; -21, -66.5],
              string="to",
              style(color=0)),
            Text(
              extent=[-8, -47.5; 16.5, -66.5],
              string="tf",
              style(color=0))),
          Window(
            x=0.34,
            y=0.21,
            width=0.6,
            height=0.6));
      end icon_int_rad_integ_ini_and_fin;

      model icon_int_rad_integ_ini_and_fin_demux
        extends icon_int_rad_integ_ini_and_fin;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[20.5, 28; 63, 71.5], layer="icon");
      end icon_int_rad_integ_ini_and_fin_demux;

      model icon_int_rad_integ_ini_and_fin_mux
        extends icon_int_rad_integ_ini_and_fin;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(Line(points=[-79.5, -44; -33, -44; 4.5, 0; 44, 0], style(color=
                    57)), Line(points=[-79.5, -44; -33, -44; 5, 47.5; 42, 47.5],
                 style(color=85))),
          Window(
            x=0.34,
            y=0.21,
            width=0.6,
            height=0.6));
      end icon_int_rad_integ_ini_and_fin_mux;

      model icon_aver_rad_integ_ini_and_length
        extends base_icons.base_icon_axis_integ_aver;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Line(points=[-40, -32.5; 0, -32.5], style(color=10)),
            Line(points=[-35.5, -28.5; -40.5, -32.7; -35.5, -36.5], style(color=
                   10)),
            Line(points=[-5.5, -28.5; -0.5, -32.8; -5.5, -36.5], style(color=10)),
            Text(
              extent=[-30.8, -11.1; -7.2, -31.1],
              string="P",
              style(color=0, pattern=0)),
            Line(points=[0, -9; 0, -43.5], style(color=10, pattern=3)),
            Text(
              extent=[-51, -49.5; -26.5, -68.5],
              string="to",
              style(color=0)),
            Text(extent=[-98.5, 72.5; -80.5, 48], string="I"),
            Text(extent=[-99.5, -75; 99.5, -99], string="AVER.RAD.INTEG"),
            Line(points=[-80, -44; -40, -44; -40, 54; 0, 54; 0, -9; 39, -9; 39,
                   -35; 62.1, -35])),
          Window(
            x=0.11,
            y=0.1,
            width=0.85,
            height=0.72));

      end icon_aver_rad_integ_ini_and_length;

      model icon_aver_rad_integ_ini_and_length_demux
        extends icon_aver_rad_integ_ini_and_length;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[2, 26; 44.5, 69.5], layer="icon");
      end icon_aver_rad_integ_ini_and_length_demux;

      model icon_aver_rad_integ_ini_and_length_mux
        extends icon_aver_rad_integ_ini_and_length;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(Line(points=[-79.5, -44; -40, -44; -40, 39; 0, 39; 0, -21; 39, -21;
                   39, -42; 62.1, -42], style(color=57)), Line(points=[-79.5, -44;
                   -40, -44; -40, 90; 0, 90; 0, 21; 39, 21; 39, -14; 62.1, -14],
                 style(color=85))),
          Window(
            x=0.02,
            y=0.03,
            width=0.86,
            height=0.97));
      end icon_aver_rad_integ_ini_and_length_mux;

      model icon_aver_rad_integ_cal
        extends base_icons.base_icon_axis_calendar_integ_aver;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(
            Line(points=[-79.5, 13.4; -40, 13.4; -40, 54; 0, 54; 0, -9; 39, -9;
                   39, -35; 62.1, -35]),
            Text(extent=[-99.5, -75; 99.5, -99], string="AVER.RAD.INTEG"),
            Text(extent=[-98.5, 72.5; -80.5, 48], string="I")),
          Window(
            x=0,
            y=0.01,
            width=0.85,
            height=0.72));
      end icon_aver_rad_integ_cal;

      model icon_aver_rad_integ_cal_demux
        extends icon_aver_rad_integ_cal;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]));
        icon_surf_orient_alias_def icon_surf_orient_alias_def1
          annotation (extent=[2, 26; 44.5, 69.5], layer="icon");
      end icon_aver_rad_integ_cal_demux;

      model icon_aver_rad_integ_cal_mux
        extends icon_aver_rad_integ_cal;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.5, 0.5],
            component=[20, 20]),
          Icon(Line(points=[-79.5, 4.5; -40, 4.5; -40, 40.5; 0, 40.5; 0, -19.5;
                   39, -19.5; 39, -40.5; 62.1, -40.5], style(color=57)), Line(
                points=[-79.5, 28.5; -40, 28.5; -40, 76.5; 0, 76.5; 0, 7.5; 39,
                   7.5; 39, -27.5; 62.1, -27.5], style(color=85))),
          Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end icon_aver_rad_integ_cal_mux;

      model icon_rad_interpol_integ_extraterr_rad
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[8, 1],
            component=[20, 20]),
          Icon(
            Polygon(points=[-79.5, 99; -87.5, 77; -71.5, 77; -79.5, 99], style(
                color=8,
                fillColor=0,
                fillPattern=1)),
            Line(points=[-89.5, -71; 82.5, -71], style(color=0, fillColor=0)),
            Polygon(points=[90.5, -71; 68.5, -63; 68.5, -79; 90.5, -71], style(
                color=8,
                fillColor=0,
                fillPattern=1)),
            Text(extent=[-98.5, 72.5; -80.5, 48], string="I"),
            Line(points=[-79.5, 82.5; -79.5, -75], style(color=0)),
            Text(extent=[-99.5, -75; 99.5, -99], string="RAD.INTERPOL."),
            Line(points=[-69.2, -71.2; -61.6, -33.8; -56.6, -10.4; -50.8, 13.2;
                   -43.8, 34.2; -35.8, 47.2; -25, 57; -16, 60.2; -8, 60.2; 1,
                  57; 11.8, 47.2; 19.8, 34.2; 26.8, 13.2; 32.6, -10.4; 37.6, -33.8;
                   45.2, -71.2], style(color=41)),
            Line(points=[-72, -71; -64, -71; -64, -61; -56, -61; -56, -27; -48,
                   -27; -48, 5; -40, 5; -40, 28; -32, 28; -32, 45; -24, 45; -24,
                   54; -16, 54; -16, 59; -8, 59; -8, 60; 0, 60; 0, 59; 8, 59; 8,
                   55; 16, 55; 16, 47; 24, 47; 24, 34; 32, 34; 32, 13; 40, 13;
                  40, -21; 48, -21; 48, -64; 56, -64; 56, -71; 64, -71], style(
                  color=73))),
          Window(
            x=0.34,
            y=0.21,
            width=0.6,
            height=0.6));
      equation

      end icon_rad_interpol_integ_extraterr_rad;

      model icon_rad_interpol_extraterr_rad_sampler
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[0.1, 0.1],
            component=[20, 20]),
          Icon(
            Polygon(points=[-79.5, 99; -87.5, 77; -71.5, 77; -79.5, 99], style(
                color=8,
                fillColor=0,
                fillPattern=1)),
            Line(points=[-89.5, -71; 82.5, -71], style(color=0, fillColor=0)),
            Polygon(points=[90.5, -71; 68.5, -63; 68.5, -79; 90.5, -71], style(
                color=8,
                fillColor=0,
                fillPattern=1)),
            Text(extent=[-98.5, 72.5; -80.5, 48], string="I"),
            Line(points=[-79.5, 82.5; -79.5, -75], style(color=0)),
            Text(extent=[-99.5, -75; 99.5, -99], string="RAD.INTERPOL."),
            Line(points=[-69.2, -71.2; -61.6, -33.8; -56.6, -10.4; -50.8, 13.2;
                   -43.8, 34.2; -35.8, 47.2; -25, 57; -16, 60.2; -8, 60.2; 1,
                  57; 11.8, 47.2; 19.8, 34.2; 26.8, 13.2; 32.6, -10.4; 37.6, -33.8;
                   45.2, -71.2], style(color=41)),
            Line(points=[-48.8, 71.3; -0.8, 71.3], style(color=3)),
            Ellipse(extent=[5.8, 67.1; -6.5, 75.8], style(color=3, fillColor=7)),
            Line(points=[2.1, 71.9; 45.1, 94.9], style(color=3)),
            Ellipse(extent=[58.4, 64.3; 46.8, 75.8], style(color=73, fillColor=
                    7)),
            Line(points=[58.8, 68.8; 85.8, 68.8], style(color=73))),
          Window(
            x=0.34,
            y=0.21,
            width=0.6,
            height=0.6));

      end icon_rad_interpol_extraterr_rad_sampler;

      model icon_lin_rad_interpol
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[10, 1],
            component=[20, 20]),
          Icon(
            Polygon(points=[-79.5, 99; -87.5, 77; -71.5, 77; -79.5, 99], style(
                color=8,
                fillColor=0,
                fillPattern=1)),
            Line(points=[-92, -44; 80, -44], style(color=0, fillColor=0)),
            Polygon(points=[88, -45; 66, -37; 66, -53; 88, -45], style(
                color=8,
                fillColor=0,
                fillPattern=1)),
            Line(points=[-79.5, 82.5; -79.5, -68.5], style(color=0)),
            Line(points=[-60, 79; -30, 70; 0, 42; 30, 0; 40, -43.5]),
            Line(points=[-30, 69; -30, -43], style(color=9, pattern=3)),
            Line(points=[30, 0; 30, -44], style(color=9, pattern=3)),
            Line(points=[0, 41; 0, -44], style(color=9, pattern=3)),
            Text(extent=[-99.5, -75; 99.5, -99], string="RAD.INTERPOL."),
            Text(extent=[-98.5, 72.5; -80.5, 48], string="I"),
            Ellipse(extent=[31, -49; 51.5, -68.5], style(color=41, fillColor=45)),
            Rectangle(extent=[27.5, -57; 58.5, -69], style(color=7, fillColor=7)),
            Line(points=[-60, 78; -60, -44], style(color=9, pattern=3))),
          Window(
            x=0.28,
            y=0.1,
            width=0.6,
            height=0.6));

      end icon_lin_rad_interpol;

      model icon_weather_table_reader
        extends base_icons.base_icon_weather_table_reader;
        annotation (
          Coordsys(
            extent=[-98, -112; 56, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Text(extent=[-98, -70; 56, -112], string="WEATHER TAB.READ.")),
          Diagram,
          Window(
            x=0.27,
            y=0.28,
            width=0.6,
            height=0.6));
      end icon_weather_table_reader;

      model icon_TRY_reader
        extends base_icons.base_icon_weather_table_reader;
        annotation (
          Coordsys(
            extent=[-98, -112; 56, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Text(extent=[-98, -70; 56, -112], string="T.R.Y. READ.")),
          Diagram,
          Window(
            x=0.27,
            y=0.28,
            width=0.6,
            height=0.6));
      end icon_TRY_reader;

      model icon_daily_values_reader
        extends base_icons.base_icon_clock;
        annotation (
          Coordsys(
            extent=[-168, -92; -12, 120],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Text(extent=[-168, -50; -12, -92], string="DAILY TAB.READ."),
            Rectangle(extent=[-168, 120; -12, -50], style(color=0, fillPattern=
                    0)),
            Rectangle(extent=[-162, 78; -132, 58], style(
                color=0,
                fillColor=47,
                fillPattern=1)),
            Rectangle(extent=[-162, 58; -132, 38], style(
                color=0,
                fillColor=47,
                fillPattern=1)),
            Rectangle(extent=[-162, 38; -132, 18], style(
                color=0,
                fillColor=47,
                fillPattern=1)),
            Rectangle(extent=[-162, 18; -132, -2], style(
                color=0,
                fillColor=47,
                fillPattern=1)),
            Line(points=[-162, 78; -162, -2; -42, -2; -42, 78; -72, 78; -72, -2;
                   -132, -2; -132, 78; -162, 78; -162, 58; -42, 58; -42, 38; -162,
                   38; -162, 18; -42, 18; -42, -2; -162, -2; -162, 78; -42, 78;
                   -42, -2], style(color=0)),
            Line(points=[-102, 78; -102, -2], style(color=0))),
          Diagram,
          Window(
            x=0.34,
            y=0.29,
            width=0.6,
            height=0.6));
      end icon_daily_values_reader;

      model icon_weekly_progr
        extends base_icons.base_icon_clock;
        annotation (
          Coordsys(
            extent=[-95, 2; 108, 110],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Line(points=[-31.4, 68.8; -25.4, 75.8], style(color=41, thickness=2)),
            Line(points=[-32.4, 74.8; -24.4, 69.8], style(color=41, thickness=2)),
            Line(points=[-27.2, 68.2; -27, 64.6; -27.2, 60.8; -28.6, 56.4; -30.4,
                   52.8; -33.6, 49; -37, 46.4; -42.4, 43.4; -46, 42.4; -50.4,
                  41.6; -56.8, 41.6; -61.8, 42], style(color=41)),
            Line(points=[-58.2, 45; -62.2, 42; -58.6, 38.6], style(color=41)),
            Line(points=[-73.8, 85; -64.8, 84], style(color=41, thickness=2)),
            Line(points=[-69.6, 81; -69.4, 88.6], style(color=41, thickness=2)),
            Line(points=[-74.6, 81.2; -76.6, 79; -79, 76; -80.8, 72.6; -82.2,
                  68.2; -82.4, 63.6; -81.2, 59; -79.2, 54.6; -76, 50.6; -71.8,
                  47.2], style(color=41)),
            Line(points=[-78.8, 80; -74.4, 81.4; -74.2, 77.4], style(color=41)),
            Rectangle(extent=[-60, 110; -36, 80], style(fillColor=7)),
            Rectangle(extent=[-36, 110; -12, 80], style(fillColor=7)),
            Rectangle(extent=[-12, 110; 12, 80], style(fillColor=7)),
            Rectangle(extent=[12, 110; 36, 80], style(fillColor=7)),
            Rectangle(extent=[36, 110; 60, 80], style(fillColor=7)),
            Rectangle(extent=[60, 110; 84, 80], style(fillColor=7)),
            Rectangle(extent=[84, 110; 108, 80], style(fillColor=48)),
            Text(extent=[-11, 109; 11, 97], string="we"),
            Text(extent=[13, 109; 35, 97], string="th"),
            Text(extent=[37, 109; 59, 97], string="fr"),
            Text(extent=[61, 109; 83, 97], string="sa"),
            Text(extent=[-35, 109; -13, 97], string="tu"),
            Text(extent=[-59, 109; -37, 97], string="mo"),
            Text(extent=[85, 109; 107, 97], string="su"),
            Line(points=[18, 90; 24, 84; 30, 94], style(color=41, thickness=2)),
            Line(points=[90, 90; 96, 84; 102, 94], style(color=41, thickness=2)),
            Text(extent=[-72, 20; 92, 2], string="WEEKLY PROGR.")),
          Window(
            x=0.16,
            y=0.11,
            width=0.6,
            height=0.6));

      end icon_weekly_progr;

      model icon_demux_1x1
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Icon(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Line(points=[-100, 0; 0, 0]),
            Ellipse(extent=[-16, 16; 16, -16], style(fillColor=73)),
            Line(points=[0, 0; 100, 0])));

      end icon_demux_1x1;

      model icon_demux_1x2
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Icon(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Line(points=[-100, 0; 0, 0]),
            Line(points=[100, 60; 60, 60; 0, 0]),
            Line(points=[100, -60; 60, -60; 0, 0]),
            Ellipse(extent=[-16, 16; 16, -16], style(fillColor=73))));

      end icon_demux_1x2;

      model icon_mux_2x1
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Icon(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Line(points=[100, 0; 0, 0]),
            Line(points=[-100, 60; -60, 60; 0, 0]),
            Line(points=[-100, -60; -60, -60; 0, 0]),
            Ellipse(extent=[16, 16; -16, -16], style(fillColor=73))));

      end icon_mux_2x1;

      model icon_demux_1x3
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Icon(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Line(points=[-100, 0; 0, 0]),
            Line(points=[0, 0; 100, 0]),
            Line(points=[100, 60; 60, 60; 0, 0]),
            Line(points=[100, -60; 60, -60; 0, 0]),
            Ellipse(extent=[-16, 16; 16, -16], style(fillColor=73))));

      end icon_demux_1x3;

      model icon_mux_3x1
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Icon(
            Rectangle(extent=[100, -100; -100, 100], style(color=3, fillColor=7)),
            Line(points=[100, 0; 0, 0]),
            Line(points=[0, 0; -100, 0]),
            Line(points=[-100, 60; -60, 60; 0, 0]),
            Line(points=[-100, -60; -60, -60; 0, 0]),
            Ellipse(extent=[16, 16; -16, -16], style(fillColor=73))));

      end icon_mux_3x1;

      model icon_add_2 "Output the sum of the two inputs"
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.23,
            y=0.22,
            width=0.54,
            height=0.66),
          Icon(
            Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
            Line(points=[-100, 60; -74, 24; -44, 24]),
            Line(points=[-100, -60; -74, -28; -42, -28]),
            Ellipse(extent=[-50, 50; 50, -50]),
            Line(points=[50, 0; 100, 0]),
            Text(
              extent=[-38, 34; 38, -34],
              string="+",
              style(color=0))));

      end icon_add_2;
    end specifics;

    package logos
      extends universals.icon_folder;
      annotation (Coordsys(
          extent=[0, 0; 320, 292],
          grid=[1, 1],
          component=[20, 20]), Window(
          x=0.68,
          y=0.56,
          width=0.32,
          height=0.44,
          library=1,
          autolayout=1));
      model logo_icon_1
        annotation (
          Coordsys(
            extent=[-59.6, -56; 76.4, 70.4],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(
            Ellipse(extent=[14.4, 25.8; 52.6, -13], style(
                color=45,
                thickness=4,
                fillColor=51)),
            Ellipse(extent=[-58.8, -34.6; 18, -44.8], style(thickness=2)),
            Ellipse(extent=[-55.8, -3.4; 18, -17.2], style(thickness=2)),
            Ellipse(extent=[-59, -17; 21.2, -31.2], style(thickness=2)),
            Ellipse(extent=[6.6, 15.6; -45.6, -66.2], style(thickness=2)),
            Ellipse(extent=[-30.6, 15.4; -8, -66], style(thickness=2)),
            Ellipse(extent=[-59, 15.6; 21.2, -66], style(thickness=2))),
          Window(
            x=0.32,
            y=0.27,
            width=0.6,
            height=0.6));
      equation

      end logo_icon_1;

      model logo_icon_2
        extends logo_icon_1;
        annotation (Coordsys(
            extent=[-59.6, -56; 76.4, 70.4],
            grid=[0.2, 0.2],
            component=[20, 20]), Icon(Text(extent=[-73, -56.4; 84.4, -80.2],
                string="T. & SL.RAD.LIB.")));
      end logo_icon_2;

      model logo_icon_3
        extends logo_icon_1;
        annotation (
          Coordsys(
            extent=[-59.6, -56; 76.4, 70.4],
            grid=[0.2, 0.2],
            component=[20, 20]),
          Icon(Text(extent=[-73, -56.4; 84.4, -80.2], string=
                  "TIME & SOLAR RADIATION LIBRARY")),
          Window(
            x=0.31,
            y=0.05,
            width=0.6,
            height=0.6));
      end logo_icon_3;

      model logo_icon_4 "t_and_sl_rad logo"
        annotation (
          Coordsys(
            extent=[-59.6, -56; 76.4, 70.4],
            grid=[0.05, 0.05],
            component=[20, 20]),
          Icon(
            Ellipse(extent=[14.4, 70.4; 76.4, 10.6], style(color=45, fillColor=
                    51)),
            Ellipse(extent=[-59.05, 10.1; 55.7, -8.8]),
            Ellipse(extent=[-50.4, 40.9; 46.8, 24.3]),
            Ellipse(extent=[-47.8, -24.2; 44.6, -38.8]),
            Ellipse(extent=[27.8, 60.4; -28.4, -56]),
            Ellipse(extent=[-10.6, 60; 10.4, -56]),
            Ellipse(extent=[-59, 60.2; 55.6, -55.8])),
          Window(
            x=0.28,
            y=0.34,
            width=0.6,
            height=0.6),
          Documentation(info="MODELICA TOOLBOX
TIME AND SOLAR RADIATION
Lehrstuehl fr Automatisierungstechnik
Fachbereich Elektrotechnik
Universitaet Kaiserslautern
Postfach 3049
67653 Kaiserslautern
Germany
Phone:   +49 (0)631 205-0
Fax:     +49 (0)631 205-4462
http://www.eit.uni-kl.de/litz/
e-mail:  litz@eit.uni-kl.de
Head: Prof. Dr.-Ing. habil. L. Litz
Project Manager: Dr. rer. nat. R. Merz
Modeler and Designer: R. Cladera
Version 1.0 (02.02), alle Rechte vorbehalten
"));
      equation

      end logo_icon_4;
    end logos;
    annotation (Coordsys(
        extent=[0, 0; 319, 384],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.68,
        y=0,
        width=0.32,
        height=0.56,
        library=1,
        autolayout=1));
  end icons;

  class about
    icons.logos.logo_icon_4 logo_icon_4_1
      annotation (extent=[254, 337; 315, 380]);
    annotation (
      Coordsys(
        extent=[0, 0; 317, 382],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.68,
        y=0,
        width=0.32,
        height=0.56,
        library=1),
      Diagram(
        Rectangle(extent=[1, 277; 319, -1], style(color=73, fillPattern=0)),
        Rectangle(extent=[1, 307; 319, 261], style(fillColor=8)),
        Rectangle(extent=[2, 385; 319, 308], style(thickness=2, fillPattern=0)),
        Text(
          extent=[6, 262; 317, 220],
          string="Lehrstuhl für Automatisierungstechnik",
          style(color=0, pattern=0)),
        Text(
          extent=[49, 200; 272, 164],
          string="Universität Kaiserslautern",
          style(color=0, pattern=0)),
        Text(extent=[0, 62; 225, 30], string="Modeled and designed by:"),
        Text(
          extent=[3, 149; 321, 121],
          string="Prof. Dr.-Ing. habil. L. Litz",
          style(color=0)),
        Text(
          extent=[14, 230; 300, 195],
          string="(Institute of Process Automation)",
          style(color=0, pattern=0)),
        Text(
          extent=[12, 92; 310, 62],
          string="Dr. rer. nat. R. Merz",
          style(color=0)),
        Text(extent=[4, 177; 56, 147], string="Head:"),
        Text(extent=[1, 123; 141, 88], string="Project Manager:"),
        Text(
          extent=[7, 34; 317, 4],
          string="R. Cladera",
          style(color=0)),
        Text(
          extent=[11, 338; 312, 303],
          string="TIME & SOLAR RADIATION",
          style(color=45)),
        Text(
          extent=[41, 372; 215, 341],
          string="MODELICA TOOLBOX",
          style(color=45)),
        Text(
          extent=[9, 297; 83, 285],
          string="v. 1.0 (02-2002)",
          style(color=10)),
        Text(
          extent=[198, 301; 317, 282],
          string="alle Rechte vorbehalten",
          style(color=10)),
        Text(
          extent=[45, 282; 281, 268],
          string="Click 'Info' in contextual menu on library logo above",
          style(color=10)),
        Text(extent=[95, 298; 186, 283], string="internal v. 14 (10-02)")));

    icons.universals.icon_folder credits
      annotation (extent=[0, 0; 320, 384], layer="icon");
  end about;
end t_and_sl_rad;
