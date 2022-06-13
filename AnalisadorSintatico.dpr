program AnalisadorSintatico;

uses
  Vcl.Forms,
  uAnalisadorSintatico in 'uAnalisadorSintatico.pas' {fAnalisadorSintatico};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfAnalisadorSintatico, fAnalisadorSintatico);
  Application.Run;
end.
