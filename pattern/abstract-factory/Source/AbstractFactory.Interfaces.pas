unit AbstractFactory.Interfaces;

interface

type
  IAnimal = interface(IUnknown)
    ['{5517FA1F-1167-41F3-AD5F-D0144ED7997A}']
  end;

  IPlant = interface(IUnknown)
    ['{7D9FF3CD-8B2F-4007-8945-4D97EB5F65D9}']
  end;

  IGround = interface(IUnknown)
    ['{8C1EDE30-9D71-4887-8BF4-189CF2CA578D}']
  end;

  IGenerator = interface(IUnknown)
    ['{2271CED4-2DE8-4A92-875D-66D3A90ADA92}']
    function GenerateAnimal: IAnimal;
    function GeneratePlant: IPlant;
    function GenerateGround: IGround;
  end;

implementation

end.
