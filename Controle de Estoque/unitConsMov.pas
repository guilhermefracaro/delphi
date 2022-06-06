unit unitConsMov;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TformConsMov = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    txtDataIni: TMaskEdit;
    txtDataFim: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    btConsultar: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label4: TLabel;
    lblTotal: TLabel;
    procedure btConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formConsMov: TformConsMov;

implementation

{$R *.dfm}

uses unitDM;

procedure TformConsMov.btConsultarClick(Sender: TObject);
begin
  DM.sqlMov.Close;
  DM.sqlMov.SQL.Clear;
  DM.sqlMov.SQL.Text := 'SELECT * FROM movimentacoes WHERE Date(dataHora) BETWEEN :pDataIni AND :pDataFim';
  DM.sqlMov.ParamByName('pDataIni').Value := FormatDateTime('yyyy-mm-dd',StrToDate(txtDataIni.Text));
  DM.sqlMov.ParamByName('pDataFim').Value := FormatDateTime('yyyy-mm-dd',StrToDate(txtDataFim.Text));
  DM.sqlMov.Open;

  lblTotal.Caption := IntToStr(DM.sqlMov.RecordCount);
end;

procedure TformConsMov.FormShow(Sender: TObject);
begin
  DM.sqlMov.Refresh;
  DM.sqlMovProdutos.Refresh;
  lblTotal.Caption := IntToStr(DM.sqlMov.RecordCount);
end;

end.
