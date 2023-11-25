# Check_PartitaIVA_CodiceFiscale
Libreria Delphi per il controllo della partita iva e del codice fiscale italiani

Vuoi effettuare un controllo formale di validità nel tuo programma di una partita iva e/o di un codice fiscale.

Semplice inserisci nel tuo progetto i file .pas contenuti nella cartella core e utilizza le classi definite
per effettuare i controlli

Esempio di codice:

`procedure ControlloCodicefiscale(const aSrcValue: string);  
begin  
    var lValore := TCheckCodiceFiscale.New.ControlTaxIdCodice(aSrcValue);  
    EditCDControllo.Text := lValore;  
end;  `

procedure ControlloPIVA(const aSrcValue: string);  
begin  
    var lChecker := TCheckPartitaIVA.New.CalculateVatcontrolNumber(aSrcValue);  
    EditValoreControllo.Text := lChecker.GetControlNumber.ToString;  
    EditPartitaCompleta.Text := lChecker.GestDestVatNumber;  
end;  





