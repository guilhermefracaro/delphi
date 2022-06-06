unit unitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    tbProdutos: TFDTable;
    dsProdutos: TDataSource;
    tbMov: TFDTable;
    dsMov: TDataSource;
    tbMovProdutos: TFDTable;
    dsMovProdutos: TDataSource;
    sqlAumentaEstoque: TFDCommand;
    sqlDiminuiEstoque: TFDCommand;
    sqlMov: TFDQuery;
    dsSqlMov: TDataSource;
    tbProdutosid: TFDAutoIncField;
    tbProdutosnome: TStringField;
    tbProdutosfabricante: TStringField;
    tbProdutosvalidade: TDateField;
    tbProdutosestoqueAtual: TIntegerField;
    tbMovProdutosid: TFDAutoIncField;
    tbMovProdutosidMovimentacao: TIntegerField;
    tbMovProdutosidProduto: TIntegerField;
    tbMovProdutosqtd: TIntegerField;
    tbMovProdutosnomeProduto: TStringField;
    sqlMovProdutos: TFDQuery;
    dsSqlMovProdutos: TDataSource;
    sqlMovProdutosid: TFDAutoIncField;
    sqlMovProdutosidMovimentacao: TIntegerField;
    sqlMovProdutosidProduto: TIntegerField;
    sqlMovProdutosqtd: TIntegerField;
    sqlMovProdutosnomeProduto: TStringField;
    procedure tbMovProdutosAfterPost(DataSet: TDataSet);
    procedure tbMovProdutosAfterDelete(DataSet: TDataSet);
    procedure calcularTotais;
    procedure tbMovAfterScroll(DataSet: TDataSet);
    procedure tbMovProdutosBeforeDelete(DataSet: TDataSet);
    procedure tbMovBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses unitCadMov;

{$R *.dfm}

procedure TDM.calcularTotais;
var
  totais : integer;
begin
  if tbMovProdutos.State in [dsBrowse] then
    begin
      tbMovProdutos.First;

      while not tbMovProdutos.Eof do
        begin
          totais := totais + tbMovProdutos.FieldByName('qtd').Value;

          tbMovProdutos.Next;
        end;

        formMov.txtTotalProdutos.Caption := IntToStr(totais);
    end;
end;

  procedure TDM.tbMovAfterScroll(DataSet: TDataSet);
  begin
    calcularTotais;
end;

procedure TDM.tbMovBeforeDelete(DataSet: TDataSet);
begin
  if tbProdutos.RecordCount > 0 then
    begin
      ShowMessage('Existem produtos cadastrados nessa movimentação. Exclua-os primeiro!');
      Abort;
    end;
end;

procedure TDM.tbMovProdutosAfterDelete(DataSet: TDataSet);
begin
  calcularTotais;
end;

procedure TDM.tbMovProdutosAfterPost(DataSet: TDataSet);
begin
  calcularTotais;

  if (tbMov.FieldByName('tipo').Value = 'Entrada no Estoque') then
    begin
      sqlAumentaEstoque.ParamByName('pID').Value := tbMovProdutos.FieldByName('idProduto').Value;
      sqlAumentaEstoque.ParamByName('pQTD').Value := tbMovProdutos.FieldByName('qtd').Value;
      sqlAumentaEstoque.Execute;
    end;

  if (tbMov.FieldByName('tipo').Value = 'Saída do Estoque') then
    begin
      sqlDiminuiEstoque.ParamByName('pID').Value := tbMovProdutos.FieldByName('idProduto').Value;
      sqlDiminuiEstoque.ParamByName('pQTD').Value := tbMovProdutos.FieldByName('qtd').Value;
      sqlDiminuiEstoque.Execute;
    end;

end;

procedure TDM.tbMovProdutosBeforeDelete(DataSet: TDataSet);
begin
  if (tbMov.FieldByName('tipo').Value = 'Entrada no Estoque') then
    begin
      sqlDiminuiEstoque.ParamByName('pID').Value := tbMovProdutos.FieldByName('idProduto').Value;
      sqlDiminuiEstoque.ParamByName('pQTD').Value := tbMovProdutos.FieldByName('qtd').Value;
      sqlDiminuiEstoque.Execute;
    end;

  if (tbMov.FieldByName('tipo').Value = 'Saída do Estoque') then
    begin
      sqlAumentaEstoque.ParamByName('pID').Value := tbMovProdutos.FieldByName('idProduto').Value;
      sqlAumentaEstoque.ParamByName('pQTD').Value := tbMovProdutos.FieldByName('qtd').Value;
      sqlAumentaEstoque.Execute;
    end;
end;

end.
