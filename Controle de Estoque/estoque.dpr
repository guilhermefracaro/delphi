program estoque;

uses
  Vcl.Forms,
  unitPrincipal in 'unitPrincipal.pas' {formPrincipal},
  unitCadProdutos in 'unitCadProdutos.pas' {formProdutos},
  unitCadMov in 'unitCadMov.pas' {formMov},
  unitConsMov in 'unitConsMov.pas' {formConsMov},
  unitDM in 'unitDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TformProdutos, formProdutos);
  Application.CreateForm(TformMov, formMov);
  Application.CreateForm(TformConsMov, formConsMov);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
