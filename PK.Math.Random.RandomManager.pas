(*
 * Random Manager
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

unit PK.Math.Random.RandomManager;

interface

uses
  System.Classes
  , System.Generics.Collections
  , System.SysUtils
  , PK.Math.Random.Types
  ;

type
  TRandomManager = class
  private class var
    FCurrent: TRandomManager;
    FBuilders: TDictionary<String, IRandomAlgoBuilder>;
  private
    class procedure Initialize;
    class destructor DestroyClass;
    class function ExecuteProc: UInt32; static;
    class procedure SetSeedProc(ASeed: UInt64); static;
  public
    class procedure RegisterAlgo(
      const AName: String;
      const ABuilder: IRandomAlgoBuilder);
    class property Current: TRandomManager read FCurrent;
  private var
    FAlgo: IRandomAlgo;
  private
    constructor Create; reintroduce;
  public
    procedure SetAlgo(const AName: String);
    property Algo: IRandomAlgo read FAlgo;
  end;

implementation

uses
  PK.Math.Random.CNG
  , PK.Math.Random.XorShift
  , PK.Math.Random.MersenneTwister
  , PK.Math.Random.LCG
  ;

{ TRandomManager }

constructor TRandomManager.Create;
begin
  inherited;
end;

class destructor TRandomManager.DestroyClass;
begin
  FBuilders.Free;
  FCurrent.Free;
end;

class function TRandomManager.ExecuteProc: UInt32;
begin
  if FCurrent.FAlgo = nil then
    Result := 0
  else
    Result := FCurrent.FAlgo.Execute;
end;

class procedure TRandomManager.Initialize;
begin
  if TRandomManager.FCurrent  <> nil then
    Exit;

  TRandomManager.FCurrent := TRandomManager.Create;
  FBuilders := TDictionary<String, IRandomAlgoBuilder>.Create;

  Random32Proc := ExecuteProc;
  RandomizeProc := SetSeedProc;
end;

class procedure TRandomManager.RegisterAlgo(
  const AName: String;
  const ABuilder: IRandomAlgoBuilder);
begin
  TRandomManager.Initialize;
  FCurrent.FBuilders.AddOrSetValue(AName, ABuilder);
end;

procedure TRandomManager.SetAlgo(const AName: String);
begin
  if (FAlgo <> nil) and SameText(FAlgo.GetName, AName) then
    Exit;

  var Builder: IRandomAlgoBuilder;
  if FBuilders.TryGetValue(AName, Builder) then
  begin
    FAlgo := Builder.CreateAlgo;
    FAlgo.Initialize;
  end;
end;

class procedure TRandomManager.SetSeedProc(ASeed: UInt64);
begin
  if FCurrent.FAlgo <> nil then
    FCurrent.FAlgo.SetSeed(ASeed);
end;

initialization
  TRandomManager.Initialize;

end.
