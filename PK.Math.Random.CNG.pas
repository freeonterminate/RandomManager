unit PK.Math.Random.CNG;

interface

implementation

uses
  Winapi.Windows
  , System.SysUtils
  , PK.Math.Random.Types
  , PK.Math.Random.RandomManager
  ;

type
  TCNGAlgo = class(TRandomAlgo)
  private const
    NAME = 'CNG';
  private
    procedure Initialize; override;
    procedure SetSeed(const ASeed: UInt64); override;
    function Execute: UInt32; override;
    function GetName: String; override;
  end;

  TCNGAlgoBuilder = class(TInterfacedObject, IRandomAlgoBuilder)
  public
    function CreateAlgo: IRandomAlgo;
  end;

// CNG Random の定義
const
  LIB_NAME = 'bcrypt.dll';
  BCRYPT_USE_SYSTEM_PREFERRED_RNG = 2;

function BCryptGenRandom(
  hAlgorithm: THandle;
  pbBuffer: PByte;
  cbBuffer: ULONG;
  dwFlags: ULONG): HRESULT; stdcall; external LIB_NAME;

{ TCNGAlgoBuilder }

function TCNGAlgoBuilder.CreateAlgo: IRandomAlgo;
begin
  Result := TCNGAlgo.Create;
end;

{ TCNGAlgo }

function TCNGAlgo.Execute: UInt32;
begin
  if
    BCryptGenRandom(
      0,
      @Result,
      SizeOf(Result),
      BCRYPT_USE_SYSTEM_PREFERRED_RNG
    ) <> ERROR_SUCCESS
  then
    Result := 0;
end;

function TCNGAlgo.GetName: String;
begin
  Result := NAME;
end;

procedure TCNGAlgo.Initialize;
begin
  // Nothing to do
end;

procedure TCNGAlgo.SetSeed(const ASeed: UInt64);
begin
  // Nothing to do
end;

initialization
  TRandomManager.RegisterAlgo(TCNGAlgo.NAME, TCNGAlgoBuilder.Create);

end.
