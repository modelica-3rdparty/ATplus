package Hvac
extends Icons.Package;


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
    Line(points=[57.5, 34.5; 57.5, -3.5]),
    Line(points=[57.5, 17; 72, 31.5]),
    Line(points=[57.5, 17; 45.5, 5]),
    Line(points=[44, 30.5; 70.5, 5]),
    Line(points=[62.5, 13.5; 70.5, 13.5]),
    Line(points=[62, 13.5; 62, 5.5]),
    Line(points=[63, 23; 63, 30]),
    Line(points=[63.5, 22.5; 72.5, 22.5]),
    Line(points=[53, 12.5; 44.5, 12.5]),
    Line(points=[53.5, 12; 53.5, 5]),
    Line(points=[53.5, 22.5; 53.5, 29.5]),
    Line(points=[52, 21.5; 44.5, 21.5]),
    Line(points=[63.5, 22.5; 72.5, 22.5]),
    Line(points=[53.5, 22.5; 53.5, 29.5]),
    Line(points=[52, 21.5; 44.5, 21.5]),
    Line(points=[-81, 3; -81, -23]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-77.5, -12.5; -77.5, -18.5]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-77.5, -12; -77.5, -18]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-81, 3; -81, -23]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-77.5, -12.5; -77.5, -18.5]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-77.5, -12; -77.5, -18]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-81, 3; -81, -23]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-77.5, -12.5; -77.5, -18.5]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-77.5, -12; -77.5, -18]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-84, -12; -84, -19]),
    Line(points=[-77.5, -12.5; -77.5, -18.5]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-89, -1; -73, -16]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-77.5, -12; -77.5, -18]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Line(points=[-88.5, -16.5; -71, 1.5]),
    Line(points=[-77.5, -5; -77.5, 1]),
    Line(points=[-77.5, -5.5; -70, -5.5]),
    Line(points=[-77, -11.5; -71.5, -11.5]),
    Line(points=[-85, -5; -91, -5]),
    Line(points=[-85, -11.5; -91, -11.5]),
    Line(points=[-84.5, -5; -84.5, 1.5]),
    Rectangle(extent=[-64.5, 27; -10.5, 21], style(gradient=2, fillColor=41)),
    Rectangle(extent=[-56.5, 5; -0.5, -1], style(gradient=2, fillColor=73)),
    Rectangle(extent=[-48.5, 37; -42.5, -9], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[-14.5, 37; -8.5, -9], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[-26.5, 37; -20.5, -9], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[-38.5, 37; -32.5, -9], style(
        gradient=1,
        fillColor=8,
        fillPattern=1)),
    Rectangle(extent=[-6.5, 19; -0.5, -1], style(gradient=1, fillColor=73)),
    Rectangle(extent=[-56.5, 29; -50.5, -1], style(gradient=1, fillColor=73)),
    Rectangle(extent=[-6.5, 1; -0.5, 7], style(gradient=3)),
    Rectangle(extent=[-56.5, 7; -51.5, -1], style(gradient=3)),
    Ellipse(extent=[-58.5, 31; -48.5, 21], style(fillColor=53)),
    Line(points=[-57, 27; -52.5, 25], style(color=0)),
    Rectangle(extent=[-66.5, 27; -58.5, 21], style(gradient=3, fillColor=41)),
    Rectangle(extent=[-40.5, 15; -21.5, 11], style(color=65, fillColor=65)),
    Polygon(points=[-20.5, 17; -20.5, 9; -11, 13.5; -20.5, 17], style(color=65,
           fillColor=65)),
    Ellipse(extent=[23.5, -19.5; 35, -30], style(gradient=3, fillColor=10)),
    Ellipse(extent=[33.5, -18; 66, -34], style(gradient=2, fillColor=8)),
    Ellipse(extent=[-8, -17.5; 24.5, -33.5], style(gradient=2, fillColor=8)),
    Ellipse(extent=[20.5, 10.5; 38.5, -19.5], style(gradient=2, fillColor=8)),
    Ellipse(extent=[19.5, -30; 37.5, -59], style(
        color=8,
        gradient=2,
        fillColor=8))),
  Diagram);
end Hvac;
