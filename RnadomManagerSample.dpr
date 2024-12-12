program RnadomManagerSample;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  PK.Math.Random.RandomManager in 'PK.Math.Random.RandomManager.pas';

begin
  TRandomManager.Current.SetAlgo('XorShift');
  Randomize;

  var Rs: array [0.. 9] of Integer;
  FillChar(Rs, SizeOf(Rs), 0);

  for var i := 0 to 10000 do
  begin
    var R := Random(10); // 乱数の呼び出し
    Inc(Rs[R]);
  end;

  for var i := 0 to High(Rs) do
    Writeln(i, ' ', Rs[i]);

  Readln;
end.
