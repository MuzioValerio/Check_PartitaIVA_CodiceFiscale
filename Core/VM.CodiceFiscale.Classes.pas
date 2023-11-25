{-----------------------------------------------------------------------------
   Project: ControlloCodiceFiscale
   Copyright (C) 2023 Muzio Valerio

   Unit Name: VM.CodiceFiscale.Classes
   Author:    muzio_dell
   Date:      14-apr-2023

   Info:
   Purpose:
   History:

-----------------------------------------------------------------------------}

unit VM.CodiceFiscale.Classes;

interface

uses
  System.Classes, System.SysUtils, System.Math, System.Generics.Collections;

type
  ICheckCodiceFiscale = interface(IInterface)
  ['{777D6B9C-85D3-4327-81AD-F9F5FE741FB2}']
    function ControlTaxIDCode(const aTaxIDCode: string): string;
  end;

  TMatches = class
  strict private
    FEvenValue: Integer;
    FOddValue: Integer;
  public
    property EvenValue: Integer read FEvenValue write FEvenValue;
    property OddValue: Integer read FOddValue write FOddValue;
  end;

  TCheckCodiceFiscale = class(TInterfacedObject, ICheckCodiceFiscale)
  strict private
    const
      Alfabet: TArray<string> =
        ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
         '0','1','2','3','4','5','6','7','8','9'];
      EvenValues: TArray<integer> =  [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,0,1,2,3,4,5,6,7,8,9];
      OddValues: TArray<integer> = [1,0,5,7,9,13,15,17,19,21,2,4,18,20,11,3,6,8,12,14,16,10,22,25,24,23,1,0,5,7,9,13,15,17,19,21];
  strict private
      FControlNumber: Integer;

      FOddSummary: Integer;
      FEvenSummary: Integer;

      FDicCharacters: TObjectDictionary<String, TMatches>;
      FTaxIdCode: string;
    procedure LoadDictionary;
    procedure InternalCalculate;
  private
    constructor Create; reintroduce;
    destructor Destroy; override;

    function ControlTaxIDCode(const aTaxIDCode: string): string;
  public
    class function New: ICheckCodiceFiscale;
  end;

implementation

uses
  System.StrUtils;

{ TCheckCodiceFiscale }

constructor TCheckCodiceFiscale.Create;
begin
  inherited Create;
  FDicCharacters := TObjectDictionary<string, TMatches>.Create();
  LoadDictionary;
end;

destructor TCheckCodiceFiscale.Destroy;
begin
  if Assigned(FDicCharacters) then
    FreeAndNil(FDicCharacters);

  inherited Destroy;
end;

class function TCheckCodiceFiscale.New: ICheckCodiceFiscale;
begin
  Result := TCheckCodiceFiscale.Create;
end;

function TCheckCodiceFiscale.ControlTaxIDCode(const aTaxIDCode: string): string;
begin
  FOddSummary := 0;
  FEvenSummary := 0;

  if (aTaxIDCode.Trim.Length <> 16) or (aTaxIdCode.Trim.IsEmpty) then
    raise Exception.Create('Errore codice fiscale non valido');

  FTaxIdCode := aTaxIDCode.Trim.ToUpper.Substring(0,15);
  InternalCalculate;
  Result := Alfabet[FControlNumber];
end;

procedure TCheckCodiceFiscale.InternalCalculate;
var
  lNumbers: TMatches;
begin
  for var I := Low(FTaxIdCode) to High(FTaxIdCode) do
  begin
    if not FDicCharacters.TryGetValue(FTaxIdCode[I], lNumbers) then
      raise Exception.Create('Errore lettura carattere codice fiscale');

    if Odd(I) then
      FOddSummary := FOddSummary + lNumbers.OddValue
    else
      FEvenSummary := FEvenSummary + lNumbers.EvenValue;
  end;
  FControlNumber := (FOddSummary + FEvenSummary) mod 26;
end;

procedure TCheckCodiceFiscale.LoadDictionary;
begin
  for var I := Low(Alfabet) to High(Alfabet) do
  begin
    var lMatches := TMatches.Create;
    lMatches.EvenValue := EvenValues[I];
    lMatches.OddValue := OddValues[I];
    FDicCharacters.AddOrSetValue(Alfabet[I], lMatches);
  end;
end;

end.
