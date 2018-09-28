unit AbstractFactory.Types;

interface

uses
  Winapi.Windows,
  AbstractFactory.Interfaces;

type
  // Rainforest
  TElephant = class(TInterfacedObject, IAnimal);
  TTree = class(TInterfacedObject, IPlant);
  TGrass = class(TInterfacedObject, IGround);
  TRainforestGenerator = class(TInterfacedObject, IGenerator)
  public
    // IGenerator
    function GenerateAnimal: IAnimal;
    function GeneratePlant: IPlant;
    function GenerateGround: IGround;
  end;

  // Desert
  TCamel = class(TInterfacedObject, IAnimal);
  TCactus = class(TInterfacedObject, IPlant);
  TSand = class(TInterfacedObject, IGround);
  TDesertGenerator = class(TInterfacedObject, IGenerator)
  public
    // IGenerator
    function GenerateAnimal: IAnimal;
    function GeneratePlant: IPlant;
    function GenerateGround: IGround;
  end;

  // Polar region
  TPolarBear = class(TInterfacedObject, IAnimal);
  TLichen = class(TInterfacedObject, IPlant);
  TSnow = class(TInterfacedObject, IGround);
  TPolarRegionGenerator = class(TInterfacedObject, IGenerator)
  public
    // IGenerator
    function GenerateAnimal: IAnimal;
    function GeneratePlant: IPlant;
    function GenerateGround: IGround;
  end;

implementation

{ TRainforestGenerator }

function TRainforestGenerator.GenerateAnimal: IAnimal;
begin
  OutputDebugString(PChar('Generating an elephant.'));
  Result := TElephant.Create;
end;

function TRainforestGenerator.GenerateGround: IGround;
begin
  OutputDebugString(PChar('Generating grass.'));
  Result := TGrass.Create;
end;

function TRainforestGenerator.GeneratePlant: IPlant;
begin
  OutputDebugString(PChar('Generating a tree.'));
  Result := TTree.Create;
end;

{ TDesertGenerator }

function TDesertGenerator.GenerateAnimal: IAnimal;
begin
  OutputDebugString(PChar('Generating a camel.'));
  Result := TCamel.Create;
end;

function TDesertGenerator.GenerateGround: IGround;
begin
  OutputDebugString(PChar('Generating sand.'));
  Result := TSand.Create;
end;

function TDesertGenerator.GeneratePlant: IPlant;
begin
  OutputDebugString(PChar('Generating a cactus.'));
  Result := TCactus.Create;
end;

{ TPolarRegionGenerator }

function TPolarRegionGenerator.GenerateAnimal: IAnimal;
begin
  OutputDebugString(PChar('Generating a polar bear.'));
  Result := TPolarBear.Create;
end;

function TPolarRegionGenerator.GenerateGround: IGround;
begin
  OutputDebugString(PChar('Generating snow.'));
  Result := TSnow.Create;
end;

function TPolarRegionGenerator.GeneratePlant: IPlant;
begin
  OutputDebugString(PChar('Generating a lichen.'));
  Result := TLichen.Create;
end;

end.
