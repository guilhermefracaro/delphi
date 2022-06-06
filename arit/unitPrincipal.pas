unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    txtN1: TEdit;
    txtN2: TEdit;
    txtTotSom: TEdit;
    txtN3: TEdit;
    txtN4: TEdit;
    txtTotSub: TEdit;
    txtN5: TEdit;
    txtN6: TEdit;
    txtTotMul: TEdit;
    txtN7: TEdit;
    txtN8: TEdit;
    txtTotDiv: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  num1, num2, resSoma : Real;

begin
  num1 := StrToFloat(txtN1.Text);
  num2 := StrToFloat(txtN2.Text);
  resSoma := num1 + num2;
  txtTotSom.Text := FloatToStr(resSoma);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  num1, num2, resSub : Real;
begin
  num1 := StrToFloat(txtN3.Text);
  num2 := StrToFloat(txtN4.Text);
  resSub := num1 - num2;
  txtTotSub.Text := FloattoStr(resSub);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  num1, num2, resMul : Real;
begin
  num1 := StrToFloat(txtN5.Text);
  num2 := StrToFloat(txtN6.Text);
  resMul := num1 * num2;
  txtTotMul.Text := FloatToStr(resMul);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  num1, num2, resDiv : Real;
begin
  num1 := StrToFloat(txtN7.Text);
  num2 := StrToFloat(txtN8.Text);
  resDiv := num1 / num2;
  txtTotDiv.Text := FloatToStr(resDiv);
end;

end.
