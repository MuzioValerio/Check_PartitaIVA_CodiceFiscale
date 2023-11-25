{-----------------------------------------------------------------------------
   Demo
   Copyright (C) 2023 Muzio Valerio

   Unit Name: uMain
   Author:    muzio_dell
   Date:      25-nov-2023

   Info:
   Purpose:
   History:

-----------------------------------------------------------------------------}

unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  VM.PartitaIVA.Classes, VM.CodiceFiscale.Classes;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    edtCodiceFiscale: TEdit;
    btnControlloCF: TButton;
    edtCFControllo: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtPartitaIVA: TEdit;
    bntControlloPI: TButton;
    edtPIVAControllo: TEdit;
    Label4: TLabel;
    edtPIVA: TEdit;
    procedure bntControlloPIClick(Sender: TObject);
    procedure btnControlloCFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.bntControlloPIClick(Sender: TObject);
begin
  var lChecker := TCheckPartitaIVA.New.CalculateVatControlNumber(edtPartitaIVA.Text);
  edtPIVAControllo.Text := lChecker.GetControlNumber.ToString;
  edtPIVA.Text := lChecker.GetDestVatNumber;
end;

procedure TfrmMain.btnControlloCFClick(Sender: TObject);
begin
  var lValoreControllo := TCheckCodiceFiscale.New.ControlTaxIDCode(edtCodiceFiscale.Text);
  edtCFControllo.Text := lValoreControllo;
end;

end.
