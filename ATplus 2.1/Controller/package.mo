package Controller
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
    Ellipse(extent=[-60, 6; -48, -6], style(fillColor=7)),
    Rectangle(extent=[-30, 8; -8, -8], style(fillColor=41)),
    Rectangle(extent=[4, 8; 28, -8], style(fillColor=7)),
    Line(points=[-48, 0; -30, 0]),
    Line(points=[-8, 0; 4, 0]),
    Line(points=[28, 0; 56, 0]),
    Line(points=[42, 0; 42, -34; -54, -34; -54, -6]),
    Line(points=[-80, 0; -60, 0]),
    Line(points=[-64, 2; -60, 0; -64, -2]),
    Line(points=[-34, 2; -30, 0; -34, -2]),
    Line(points=[0, 2; 4, 0; 0, -2]),
    Line(points=[52, 2; 56, 0; 52, -2]),
    Line(points=[-56, -10; -54, -6; -52, -10])));
end Controller;
