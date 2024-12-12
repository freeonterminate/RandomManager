unit PK.Math.Random.Types;

interface

uses
  System.Classes
  , System.Generics.Collections
  , System.SysUtils
  ;

type
  IRandomAlgo = interface
  ['{6508CC6E-67CD-4F63-B4FF-5F6461F2FE76}']
    procedure Initialize;
    procedure SetSeed(const ASeed: UInt64);
    function Execute: UInt32;
    function GetName: String;
    property Name: String read GetName;
  end;

  IRandomAlgoBuilder = interface
  ['{4461DD5C-6BCF-4F3E-A93D-24ED90E157BB}']
    function CreateAlgo: IRandomAlgo;
  end;

  TRandomAlgo = class(TInterfacedObject, IRandomAlgo)
  protected
    procedure Initialize; virtual; abstract;
    procedure SetSeed(const ASeed: UInt64); virtual; abstract;
    function Execute: UInt32; virtual; abstract;
    function GetName: String; virtual; abstract;
  public
    property Name: String read GetName;
  end;

  TRandomAlgoBuilder = class(TInterfacedObject, IRandomAlgoBuilder)
  protected
    function CreateAlgo: IRandomAlgo; virtual; abstract;
  end;

implementation

end.
