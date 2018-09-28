program prSpecificationPattern;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.TypInfo,
  Winapi.Windows,
  Winapi.Messages,
  Generics.Collections,
  Vcl.Graphics,
  SpecificationPattern.Types in 'Source\SpecificationPattern.Types.pas',
  SpecificationPattern.Interfaces in 'Source\SpecificationPattern.Interfaces.pas',
  SpecificationPattern.Sample.Types in 'Source\SpecificationPattern.Sample.Types.pas',
  SpecificationPattern.Sample.Specs in 'Source\SpecificationPattern.Sample.Specs.pas';

var
  CarRepo: TCarRepo;
  CarService: TCarService;
  Car: TCar;
  Cars: TCars;

  IterationIndex: Integer;

  sManufacturedInEurope: ISpecification<TCar>;
  sYellowConvertible: ISpecification<TCar>;
  sRedCar: ISpecification<TCar>;
  sVintage: ISpecification<TCar>;

  A: ISpecification<TCar>;
  B: ISpecification<TCar>;
  C: ISpecification<TCar>;
  D: ISpecification<TCar>;

  sComposed: ISpecification<TCar>;
  msBefore: Cardinal;
  msAfter: Cardinal;
begin
  ReportMemoryLeaksOnShutdown := True;
  try
    msBefore := GetTickCount;
    WriteLn('generating random data');
    CarRepo := TCarRepo.Create(1000);// 1000000);
    msAfter := GetTickCount - msBefore;
    WriteLn(Format('->finished [created %d in %dms]', [Pred(CarRepo.FindAllCarsInStock.Count), msAfter]));

    CarService := TCarService.Create(CarRepo);
    try
      WriteLn('defining specifications');
      // Let's apply some filters using our specifications.
      // We're searching for a car with the following specifications:
      // - yellow convertible or red nonconvertible which was manufactured
      // in europe and is not older than one year.

      // Part 1: Manufacturing location in europe?
      sManufacturedInEurope := TCarPersonRegionSpecification.Create([reEurope]);

      // Part 2: Date of construction is less than one year from now?
      sVintage := TCarAgeSpecification.Create(Now, 1);

      // Part 3: Yellow convertible?
      sYellowConvertible :=
        TCarColorSpecification.Create(clYellow)._And(
          TCarConvertibleSpecification.Create);

      // Part4: Red and not a convertible
      sRedCar := TCarColorSpecification.Create(clRed);




      // Final part: Compose our specification parts
      sComposed :=

        sVintage._And(
          sManufacturedInEurope._And(
            sYellowConvertible._Or(sRedCar)));











      msBefore := GetTickCount;
      // Do the magic!
      WriteLn('searching by specifications');
      Cars := CarService.FindCandidateCars(sComposed);
      msAfter := GetTickCount - msBefore;
      try
        // Output
        WriteLn(Format('->finished [%d matches found in %dms]', [Cars.Count, msAfter]));
        WriteLn('Press Enter...');
        ReadLn;
        for Car in Cars do
        begin
          WriteLn(
            Format('[Match #%d] Color=%s; Cabrio=%s; CY=%s; OwnerAddress=%s; OwnerCountry=%s',
              [ Cars.IndexOf(Car)+1,
                ColorToString(Car.Color),
                BoolToStr(Car.Convertible, True),
                DateToStr(Car.ManufacturingDate),
                Car.Person.Address,
                GetSetElementName(TypeInfo(TRegion), Ord(Car.Person.Region))
              ]));

          IterationIndex := Cars.IndexOf(Car);
          if (IterationIndex > 0) and (IterationIndex mod 24 = 0) then
          begin
            WriteLn('Press Enter...');
            Readln;
          end;
        end;
      except
        raise;
      end;
    finally
      (*
      CarService := nil;
      CarRepo := nil;
      *)
    end;
    WriteLn('end of program');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
