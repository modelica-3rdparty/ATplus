package Weather
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
    Ellipse(extent=[-36, 20; -16, 2], style(color=41, fillColor=49)),
    Ellipse(extent=[-46, 10; -18, -10], style(color=8, fillColor=8)),
    Ellipse(extent=[-48, 0; -20, -20], style(color=8, fillColor=8)),
    Ellipse(extent=[-26, 16; 6, -6], style(color=8, fillColor=8)),
    Ellipse(extent=[-26, 6; 6, -16], style(color=8, fillColor=8)),
    Ellipse(extent=[-8, 10; 22, -10], style(color=8, fillColor=8)),
    Line(points=[-20, 18; -10, 26], style(color=45)),
    Line(points=[-24, 20; -22, 32], style(color=45)),
    Line(points=[-30, 20; -34, 30], style(color=45)),
    Line(points=[-36, 16; -46, 20], style(color=45)),
    Line(points=[-36, 10; -48, 8], style(color=45)),
    Line(points=[-28, -18; -18, -48], style(color=0, pattern=3)),
    Line(points=[-20, -14; -10, -44], style(color=0, pattern=3)),
    Line(points=[-10, -16; 0, -46], style(color=0, pattern=3)),
    Line(points=[0, -14; 10, -44], style(color=0, pattern=3)),
    Line(points=[8, -8; 18, -38], style(color=0, pattern=3))));
end Weather;
