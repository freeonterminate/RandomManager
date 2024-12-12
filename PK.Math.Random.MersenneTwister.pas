(*
 * Mersenne Twister
 *
 * PLATFORMS
 *   Windows / macOS / Android / iOS
 *
 * LICENSE
 *   Copyright (c) 2024 piksware (http://piksware.com/)
 *   Released under the MIT license
 *   http://opensource.org/licenses/mit-license.php
 *
 * 2024/12/12 Version 1.0.0
 * Programmed by HOSOKAWA Jun (twitter: @pik)
 *)

 unit PK.Math.Random.MersenneTwister;

{$OVERFLOWCHECKS OFF}

interface

implementation

uses
  System.SysUtils
  , PK.Math.Random.Types
  , PK.Math.Random.RandomManager
  ;

type
  TMtAlgo = class(TRandomAlgo)
  private const
    NAME = 'MT';
    N = 624;
    M = 397;
    MATRIX_A =   $9908B0df;
    UPPER_MASK = $80000000;
    LOWER_MASK = $7fffffff;
  private class var
    FMatrix: array[0.. N - 1] of UInt32;
    FIndex: Integer;
  private
    procedure Initialize; override;
    procedure SetSeed(const ASeed: UInt64); override;
    function Execute: UInt32; override;
    function GetName: String; override;
    procedure Twist;
  end;

  TMtAlgoBuilder = class(TInterfacedObject, IRandomAlgoBuilder)
  public
    function CreateAlgo: IRandomAlgo;
  end;

{ TMtAlgoBuilder }

function TMtAlgoBuilder.CreateAlgo: IRandomAlgo;
begin
  Result := TMtAlgo.Create;
end;

{ TMtAlgo }

function TMtAlgo.Execute: UInt32;
begin
  if FIndex >= N then
    Twist;

  var Y := FMatrix[FIndex];
  Inc(FIndex);

  // Tempering
  Y := Y xor (Y shr 11);
  Y := Y xor ((Y shl 7) and $9d2c5680);
  Y := Y xor ((Y shl 15) and $efc60000);
  Y := Y xor (Y shr 18);

  Result := Y;
end;

function TMtAlgo.GetName: String;
begin
  Result := NAME;
end;

procedure TMtAlgo.Initialize;
begin
  RandSeed := 5489; // Default Seed (mt19937)
  SetSeed(RandSeed);
end;

procedure TMtAlgo.SetSeed(const ASeed: UInt64);
begin
  FMatrix[0] := UInt32(ASeed and $ffff_ffff);

  for var i := 1 to N - 1 do
    FMatrix[i] := 1812433253 * (FMatrix[i - 1] xor (FMatrix[i - 1] shr 30)) + i;

  FIndex := N;
end;

procedure TMtAlgo.Twist;
begin
  for var i := 0 to N - M - 1 do
  begin
    var Y := (FMatrix[i] and UPPER_MASK) or (FMatrix[i + 1] and LOWER_MASK);
    FMatrix[i] := FMatrix[i + M] xor (Y shr 1) xor (MATRIX_A * (Y and 1));
  end;

  for var i := N - M to N - 2 do
  begin
    var Y := (FMatrix[i] and UPPER_MASK) or (FMatrix[i + 1] and LOWER_MASK);
    FMatrix[i] := FMatrix[i + (M - N)] xor (Y shr 1) xor (MATRIX_A * (Y and 1));
  end;

  var Y := (FMatrix[N - 1] and UPPER_MASK) or (FMatrix[0] and LOWER_MASK);
  FMatrix[N - 1] := FMatrix[M - 1] xor (Y shr 1) xor (MATRIX_A * (Y and 1));

  FIndex := 0;
end;

initialization
  TRandomManager.RegisterAlgo(TMtAlgo.NAME, TMtAlgoBuilder.Create);

end.

