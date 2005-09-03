package MatrixInversion

  function inv "inverse Matrix"
    input Real A[:, size(A, 1)];
    constant Integer n=size(A, 1);
    output Real Ainv[size(A, 1), size(A, 1)];
  protected
    Real L[n, n]=zeros(n, n);
    Real U[n, n]=zeros(n, n);
    Real P[n, n]=zeros(n, n);
    Real Lt[n, n]=zeros(n, n);
    Real Uinv[n, n]=zeros(n, n);
    Real Ltinv[n, n]=zeros(n, n);
    Real Linv[n, n]=zeros(n, n);
  algorithm
    (L,U,P) := lu(A);
    Lt := transpose(L);
    for i in 1:n loop
      Uinv[i, i] := 1/U[i, i];
      Ltinv[i, i] := 1/Lt[i, i];
    end for;
    for i in 1:n loop
      for j in 1:n loop
        if i > j then
          Uinv[i, j] := 0;
          Ltinv[i, j] := 0;
        elseif i < j then
          Uinv[i, j] := -Uinv[j, j]*Uinv[i, i:j - 1]*U[i:j - 1, j];
          Ltinv[i, j] := -Ltinv[j, j]*Ltinv[i, i:j - 1]*Lt[i:j - 1, j];
        end if;
      end for;
    end for;
    Linv := transpose(Ltinv);
    Ainv := Uinv*Linv*P;
  end inv;

  function lu "LU decomposition"
    input Real A[:, size(A, 1)];
    constant Integer n=size(A, 1);
    output Real L[size(A, 1), size(A, 1)];
    output Real U[size(A, 1), size(A, 1)];
    output Real P[size(A, 1), size(A, 1)];
  protected
    Real At[n, n];
    Real Lt[n, n];
    Real Ut[n];
    Real temp[1, n];
    Real Pt[n, n];
    Real Y;
    Integer ind;
  algorithm
    (Y,ind) := maxi(abs(A[:, 1]));

    //create permutation matrix
    P := identity(n);
    temp[1, :] := P[1, :];
    P[1, :] := P[ind, :];
    P[ind, :] := temp[1, :];

    At := P*A;
    U := [At[1:1, :]; zeros(n - 1, n)];
    L := identity(n);
    for i in 2:n loop
      //searching maximal U(i,j)
      Lt := zeros(n, n);
      Ut := zeros(n);
      for k in i:n loop
        for j in 1:i loop
          if j < i then
            //calculate element of L
            if j == 1 then
              Lt[k, 1] := At[k, 1]/U[1, 1];
            else
              Lt[k, j] := (At[k, j] - Lt[k, 1:j - 1]*U[1:j - 1, j])/U[j, j];
            end if;
          else
            Ut[k] := At[k, j] - Lt[k, 1:i - 1]*U[1:i - 1, j];
          end if;
        end for;
      end for;
      (Y,ind) := maxi(abs(Ut));

      //create permutation matrix
      Pt := identity(n);
      temp[1, :] := Pt[i, :];
      Pt[i, :] := Pt[ind, :];
      Pt[ind, :] := temp[1, :];
      P := Pt*P;
      At := Pt*At;
      L[i, 1:i - 1] := Lt[ind, 1:i - 1];
      U[i, i] := Ut[ind];
      for j in i + 1:n loop
        U[i, j] := At[i, j] - L[i, 1:i - 1]*U[1:i - 1, j];
      end for;
    end for;
  end lu;

  function maxi "return the larges component of vector and its index"
    input Real A[:];
    output Real Y;
    output Integer index;
  protected
    Integer lengthA;
  algorithm
    lengthA := size(A, 1);
    Y := A[1];
    index := 1;
    for i in 2:lengthA loop
      if Y < A[i] then
        Y := A[i];
        index := i;
      end if;
    end for;
  end maxi;

  function mini "return the smallest component of vector and its index"
    input Real A[:];
    output Real Y;
    output Integer index;
  protected
    Integer lengthA;
  algorithm
    lengthA := size(A, 1);
    Y := A[1];
    index := 1;
    for i in 2:lengthA loop
      if Y > A[i] then
        Y := A[i];
        index := i;
      end if;
    end for;
  end mini;

  function fdm "Feasible Direction Method"
    input Real u0[size(u0, 1), 1];
    input Real H[size(u0, 1), size(u0, 1)];
    input Real b[size(u0, 1), 1];
    input Real A[size(A, 1), size(u0, 1)];
    input Real a[size(A, 1), 1];
    input Real Aeq[size(Aeq, 1), size(u0, 1)];
    input Real aeq[size(Aeq, 1), 1];
    constant Integer nu=size(u0, 1);
    constant Integer na=size(A, 1);
    constant Integer naeq=size(Aeq, 1);
    output Real u[size(u0, 1), 1];
  protected
    Boolean flag;
    //active set
    Real A1[na + naeq, nu];
    //non active set
    Real A2[na + naeq, nu];
    Real a1[na + naeq, 1];
    Real a2[na + naeq, 1];
    //projection
    Real P[nu, nu];
    //direction
    Real d[nu, 1];
    Real w[na + naeq, 1];
    Real min_w;
    Real lambda;
    Integer ind;
    Integer na1;
    Integer na2;
    Integer iter;
  algorithm
    u := u0;
    flag := true;
    iter := 0;
    A1 := [Aeq; zeros(na, nu)];
    A2 := zeros(na + naeq, nu);
    a1 := [aeq; zeros(na, 1)];
    a2 := zeros(na + naeq, 1);
    na1 := naeq;
    na2 := 0;
    for i in 1:na loop
      if abs(A[i, 1:nu]*u[1:nu, 1] - a[i, 1]) < 1e-10 then
        na1 := na1 + 1;
        A1[na1, 1:nu] := A[i, 1:nu];
        a1[na1, 1] := a[i, 1];
      else
        na2 := na2 + 1;
        A2[na2, 1:nu] := A[i, 1:nu];
        a2[na2, 1] := a[i, 1];
      end if;
    end for;
    while flag == true loop

      if na1 == 0 then
        P := identity(nu);
      else
        P := identity(nu) - transpose(A1[1:na1, :])*inv(A1[1:na1, :]*transpose(
          A1[1:na1, :]))*A1[1:na1, :];
      end if;
      d := -P*(H*u + b);
      if max(abs(d)) < 1e-10 then
        if na1 == 0 then
          flag := false;
        else
          w := zeros(na + naeq, 1);
          w[1:na1, :] := -inv(A1[1:na1, :]*transpose(A1[1:na1, :]))*A1[1:na1, :]
            *(H*u + b);
          (min_w,ind) := mini(w[1:na1, 1]);
          if min_w >= 0 then
            flag := false;
          else
            // choose the most negativ component of w and
            // remove the corresponding constraint from the active set
            na2 := na2 + 1;
            A2[na2, :] := A1[ind, :];
            a2[na2, 1] := a1[ind, 1];
            na1 := na1 - 1;
            A1[ind:na1, :] := A1[ind + 1:na1 + 1, :];
            A1[na1 + 1:na1 + 1, 1:nu] := zeros(1, nu);
            a1[ind:na1, 1] := a1[ind + 1:na1 + 1, 1];
            a1[na1 + 1, 1] := 0;
          end if;
        end if;
      else
        lambda := -scalar((transpose(d)*H*u + transpose(b)*d))/scalar(transpose(
          d)*H*d);
        for i in 1:na2 loop
          if scalar(A2[i, :]*d) > 0 then
            lambda := min(lambda, (a2[i, 1] - scalar(A2[i, :]*u))/scalar(A2[i,
              :]*d));
          end if;
        end for;
        u := u + lambda*d;
        A1 := [Aeq; zeros(na, nu)];
        A2 := zeros(na + naeq, nu);
        a1 := [aeq; zeros(na, 1)];
        a2 := zeros(na + naeq, 1);
        na1 := naeq;
        na2 := 0;
        for i in 1:na loop
          if abs(A[i, 1:nu]*u[1:nu, 1] - a[i, 1]) < 1e-10 then
            na1 := na1 + 1;
            A1[na1, 1:nu] := A[i, 1:nu];
            a1[na1, 1] := a[i, 1];
          else
            na2 := na2 + 1;
            A2[na2, 1:nu] := A[i, 1:nu];
            a2[na2, 1] := a[i, 1];
          end if;
        end for;
      end if;
      iter := iter + 1;
    end while;
  end fdm;

  model try
    parameter Integer n=2;
    parameter Real m[n, n];

    Real minv[n, n];
  equation

    minv = inv(m);
  end try;

  block OffGLS "Offline Generalized Least Square Identification"
    //number of input
    parameter Integer n_input=1;
    //number of output
    parameter Integer n_output=1;
    //number of data
    parameter Integer n_data=50;
    //numerator order
    parameter Integer nB=3;
    //denumerator order
    parameter Integer nA=3;
    //filter order
    parameter Integer nC=2;
    //sampling time
    parameter Real Ts=1;
  protected
    Real uin[n_input]=InPort1.signal;
    Real yin[n_output]=InPort2.signal;
    discrete Real uout[n_input];
    Boolean collect=BooleanOutPort1.signal[1];
    //model parameter
    Real modpar[nB*n_input + nA + nC, n_output]=OutPortMatrix2_1.signal;
    //this matrix is needed for initialization of online identification
    Real Theta[nB*n_input + nA + nC, nB*n_input + nA + nC, n_output]=
        OutPortMatrix3_1.signal;
    //this matrix is needed for initialization of online identification
    Real c[nC, n_output]=OutPortMatrix2_2.signal;
    Real u[n_data*n_input](start=zeros(n_data*n_input));
    Real y[n_data*n_output]=zeros(n_data*n_output);
    //index for u
    discrete Integer uind(start=1);
    //index for y
    discrete Integer yind;
  public
    Modelica.Blocks.Interfaces.InPort InPort1(final n=n_input)
      annotation (extent=[-120, 38; -100, 58]);
    Modelica.Blocks.Interfaces.InPort InPort2(final n=n_output)
      annotation (extent=[-120, -62; -100, -42]);
    Modelica.Blocks.Interfaces.BooleanOutPort BooleanOutPort1
      annotation (extent=[100, 30; 120, 50]);
    OutPortMatrix2 OutPortMatrix2_1(final s1=nB*n_input + nA + nC, final s2=
          n_output) annotation (extent=[100, -10; 120, 10]);
    OutPortMatrix3 OutPortMatrix3_1(
      final s1=nB*n_input + nA + nC,
      final s2=nB*n_input + nA + nC,
      final s3=n_output) annotation (extent=[100, -50; 120, -30]);
    OutPortMatrix2 OutPortMatrix2_2(final s1=nC, final s2=n_output)
      annotation (extent=[100, -90; 120, -70]);
    Modelica.Blocks.Interfaces.OutPort OutPort1(final n=n_input)
      annotation (extent=[100,66; 120,86]);
  algorithm
    when (sample(0, Ts)) then
      uout := uin;
      OutPort1.signal:=uout;
      //u[uind:uind + n_input - 1] := uin;
      u[uind] := uin[1];
      //    y[yind:yind + n_output - 1] := yin;
      uind := pre(uind) + n_input;
      yind := pre(yind) + n_output;
    end when;
    modpar := zeros(nB*n_input + nA + nC, n_output);
    Theta := zeros(nB*n_input + nA + nC, nB*n_input + nA + nC, n_output);
    c := zeros(nC, n_output);
    collect := true;
    annotation (Icon, Diagram);
  end OffGLS;

  model try2
    Modelica.Blocks.Sources.Sine Sine1(freqHz={0.1})
      annotation (extent=[-66, 28; -46, 48]);
    annotation (Diagram);
    OffGLS OffGLS1 annotation (extent=[-18, 10; 2, 30]);
    Modelica.Blocks.Sources.ExpSine ExpSine1(damping={0.1}, freqHz={0.3})
      annotation (extent=[-66, -10; -46, 10]);
  equation
    connect(Sine1.outPort, OffGLS1.InPort1)
      annotation (points=[-44, 38; -20, 24], style(color=3));
    connect(ExpSine1.outPort, OffGLS1.InPort2)
      annotation (points=[-44, 0; -20, 14], style(color=3));
  end try2;

  connector OutPortMatrix2 "Output Matrix with size 2"
    parameter Integer s1=1;
    parameter Integer s2=1;
    replaceable type SignalType = Real "type of signal";
    output SignalType signal[s1, s2] "Real input signals";
    annotation (Icon(Line(points=[-100, 100; -100, -100; 100, 0; -100, 100])));
  end OutPortMatrix2;

  connector OutPortMatrix3 "Output Matrix with size 3"
    parameter Integer s1=1;
    parameter Integer s2=1;
    parameter Integer s3=1;
    replaceable type SignalType = Real "type of signal";
    output SignalType signal[s1, s2, s3] "Real input signals";
    annotation (Icon(Line(points=[-100, 100; -100, -100; 100, 0; -100, 100])));
  end OutPortMatrix3;
  annotation (Icon(Text(extent=[2, 100; 144, 48], string="-1"), Text(extent=[-74,
             36; 48, -60], string="A")));
end MatrixInversion;
