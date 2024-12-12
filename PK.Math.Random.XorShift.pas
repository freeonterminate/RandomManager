(*
 * XorShift
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

unit PK.Math.Random.XorShift;

interface

implementation

uses
  System.SysUtils
  , PK.Math.Random.Types
  , PK.Math.Random.RandomManager
  ;

type
  TXorShiftAlgo = class(TRandomAlgo)
  private const
    NAME = 'XorShift';
  private var
    FA: UInt32;
  private
    procedure Initialize; override;
    procedure SetSeed(const ASeed: UInt64); override;
    function Execute: UInt32; override;
    function GetName: String; override;
  end;

  TXorShiftAlgoBuilder = class(TInterfacedObject, IRandomAlgoBuilder)
  public
    function CreateAlgo: IRandomAlgo;
  end;

{ TXorShiftAlgoBuilder }

function TXorShiftAlgoBuilder.CreateAlgo: IRandomAlgo;
begin
  Result := TXorShiftAlgo.Create;
end;

{ TXorShiftAlgo }

function TXorShiftAlgo.Execute: UInt32;
begin
  FA := FA xor (FA shl 13);
  FA := FA xor (FA shr 17);
  FA := FA xor (FA shl 5);
  Result := FA;
end;

function TXorShiftAlgo.GetName: String;
begin
  Result := NAME;
end;

procedure TXorShiftAlgo.Initialize;
begin
  FA := Round(Frac(Now) * 24 * 60 * 60 * 1000) mod 1000;;
end;

procedure TXorShiftAlgo.SetSeed(const ASeed: UInt64);
begin
  DefaultRandomize(ASeed);
  FA := RandSeed;
end;

initialization
  TRandomManager.RegisterAlgo(TXorShiftAlgo.NAME, TXorShiftAlgoBuilder.Create);

end.

