{-----------------------------------------------------------------------------
 Project: ControlloPartitaIVA

 Copyrigth (C) 2023 Muzio Valerio

 Unit Name: VM.PartitaIVA.Classes
 Author:    muzio_dell
 Date:      14-apr-2023
 Purpose:
  Calcolo  cifra di controllo Partita I.V.A. con Formula di Luhn
  Verifica cifra di controllo Partita I.V.A. con Formula di Luhn
 History:
-----------------------------------------------------------------------------}

unit VM.PartitaIVA.Classes;

interface

uses
  System.Classes, System.SysUtils, System.Math;

type
  ICheckPartitaIVA = interface(IInterface)
  ['{3080F95D-602D-4E6C-89C0-5E38629AC661}']
    function CalculateVatControlNumber(const aSrcValue: string): ICheckPartitaIVA;
    function VerifyVatControlNumber(const aSrcValue: string): ICheckPartitaIVA;
    function GetDestVatNumber: string;
    function GetControlNumber: Integer;
  end;

  TCheckPartitaIVA = class(TInterfacedObject, ICheckPartitaIVA)
  private
    FControlNumber: Integer;

    FOddSummary: Integer;
    FEvenSummary: Integer;

    FSrcVatNumber: string;
    FDestVatNumber: string;
    procedure InternalCalculate;
    function IsOnlyNumbers: Boolean;
    function CalcEvenValue(const aValue: Integer): Integer;
    function CalcControlNumber(const aOddSum, aEvenSum: Integer; IsCheck: Boolean): Integer; overload;

    function CalculateVatControlNumber(const aSrcValue: string): ICheckPartitaIVA;
    function VerifyVatControlNumber(const aSrcValue: string): ICheckPartitaIVA;

    function GetDestVatNumber: string;
    function GetControlNumber: Integer;
  public
    class function New: ICheckPartitaIVA;
  end;


implementation

uses
  System.StrUtils;

{ TCheckPartitaIVA }

class function TCheckPartitaIVA.New: ICheckPartitaIVA;
begin
  Result := TCheckPartitaIVA.Create;
end;

function TCheckPartitaIVA.GetControlNumber: Integer;
begin
  Result := FControlNumber;
end;

function TCheckPartitaIVA.GetDestVatNumber: string;
begin
  Result := FDestVatNumber;
end;

function TCheckPartitaIVA.CalculateVatControlNumber(const aSrcValue: string): ICheckPartitaIVA;
begin
  FOddSummary := 0;
  FEvenSummary := 0;

  FSrcVatNumber := aSrcValue.Trim;
  if (FSrcVatNumber.IsEmpty) or (FSrcVatNumber.Length > 11) or (FSrcVatNumber.Length < 10) then
    raise Exception.Create('Partita IVA non valida');

  if FSrcVatNumber.Length > 10 then
    FSrcVatNumber := FSrcVatNumber.Substring(0, 10);

  if not IsOnlyNumbers then
    raise Exception.Create('Partita IVA non valida');

  InternalCalculate;
  FControlNumber := CalcControlNumber(FOddSummary, FEvenSummary, False);
  FDestVatNumber := FSrcVatNumber + FControlNumber.ToString;
  Result := Self;
end;

function TCheckPartitaIVA.VerifyVatControlNumber(const aSrcValue: string): ICheckPartitaIVA;
begin
  FOddSummary := 0;
  FEvenSummary := 0;

  FSrcVatNumber := aSrcValue.Trim;
  if (FSrcVatNumber.IsEmpty) or (FSrcVatNumber.Length <> 11) then
    raise Exception.Create('Partita IVA non valida inserire le undici cifre');

  if not IsOnlyNumbers then
    raise Exception.Create('La Partita IVA contiene caratteri non validi');

  InternalCalculate;

  FControlNumber := CalcControlNumber(FOddSummary, FEvenSummary, True);
  if FControlNumber = 0 then
    Exit(Self);

  CalculateVatControlNumber(FSrcVatNumber.Substring(0, 10));
  Result := Self;
end;

procedure TCheckPartitaIVA.InternalCalculate;
begin
  for var I := 1 to FSrcVatNumber.Length do
  begin
    if Odd(I) then
      FOddSummary := FOddSummary + StrToInt(FSrcVatNumber[I])
    else
      FEvenSummary := FEvenSummary + CalcEvenValue(StrToInt(FSrcVatNumber[I]));
  end;
end;

function TCheckPartitaIVA.IsOnlyNumbers: Boolean;
begin
  for var I := Low(FSrcVatNumber) to High(FSrcVatNumber) do
  begin
    if not Ord(FSrcVatNumber[I]) in [48..57] then
      Exit(False);
  end;

  Exit(True);
end;

function TCheckPartitaIVA.CalcControlNumber(const aOddSum, aEvenSum: Integer; IsCheck: Boolean): Integer;
begin
  var lSum := aOddSum + aEvenSum;
  Result := lSum mod 10;
  if not IsCheck then
  begin
    if Result <> 0 then
      Result := 10 - Result;
  end;
end;

function TCheckPartitaIVA.CalcEvenValue(const aValue: Integer): Integer;
begin
  Result := aValue * 2;
  if Result > 9 then
    Result := Result - 9;
end;

end.
