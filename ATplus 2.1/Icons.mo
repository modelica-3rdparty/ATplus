package Icons
  annotation (Coordsys(
      extent=[0, 0; 402, 261],
      grid=[2, 2],
      component=[20, 20]));
  model Package
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
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
        Text(extent=[-6, 116; -6, 64], string="%name")),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end Package;
end Icons;
