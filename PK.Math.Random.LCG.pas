﻿(*
 * Linear congruential generators
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

unit PK.Math.Random.LCG;

interface

implementation

uses
  System.SysUtils
  , PK.Math.Random.Types
  , PK.Math.Random.RandomManager
  ;

type
  TLCGAlgo = class(TRandomAlgo)
  private
    const NAME = 'LCG';
  private
    procedure Initialize; override;
    procedure SetSeed(const ASeed: UInt64); override;
    function Execute: UInt32; override;
    function GetName: String; override;
  end;

  TLCGAlgoBuilder = class(TInterfacedObject, IRandomAlgoBuilder)
  public
    function CreateAlgo: IRandomAlgo;
  end;

{ TLCGAlgoBuilder }

function TLCGAlgoBuilder.CreateAlgo: IRandomAlgo;
begin
  Result := TLCGAlgo.Create;
end;

{ TLCGAlgo }

function TLCGAlgo.Execute: UInt32;
begin
  Result := DefaultRandom32;
end;

function TLCGAlgo.GetName: String;
begin
  Result := NAME;
end;

procedure TLCGAlgo.Initialize;
begin
  // None
end;

procedure TLCGAlgo.SetSeed(const ASeed: UInt64);
begin
  DefaultRandomize(ASeed);
end;

initialization
  TRandomManager.RegisterAlgo(TLCGAlgo.NAME, TLCGAlgoBuilder.Create);

end.

