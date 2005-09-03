package Heating
extends ATplus.Icons.Package;


annotation (
  Coordsys(
    extent=[0, 0; 442, 394],
    grid=[0.5, 0.5],
    component=[20, 20]),
  Window(
    x=0.45,
    y=0.01,
    width=0.44,
    height=0.65,
    library=1,
    autolayout=1),
  Icon(
    Rectangle(extent=[-51, 18; 15, 10], style(gradient=2, fillColor=41)),
    Rectangle(extent=[-41, -26; 25, -34], style(gradient=2, fillColor=73)),
    Rectangle(extent=[-29, 28; -21, -40], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[7, 28; 15, -40], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[-5, 28; 3, -40], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[-17, 28; -9, -40], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[19, 2; 27, -34], style(gradient=1, fillColor=73)),
    Rectangle(extent=[-41, 10; -33, -34], style(gradient=1, fillColor=73)),
    Rectangle(extent=[19, -26; 27, -34], style(gradient=3)),
    Rectangle(extent=[-41, -26; -33, -34], style(gradient=3)),
    Ellipse(extent=[-43, 20; -31, 8], style(fillColor=53)),
    Line(points=[-40.5, 16; -34, 11], style(color=0)),
    Rectangle(extent=[-55.5, 18; -47.5, 10], style(gradient=3, fillColor=41)),
    Rectangle(extent=[-32.5, -2; -1, -10], style(color=65, fillColor=65)),
    Polygon(points=[0, 3; 0, -14; 15.5, -5.5; 0, 3], style(color=65, fillColor=
            65))),
  Diagram);
end Heating;
