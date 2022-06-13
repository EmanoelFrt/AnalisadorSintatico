unit uAnalisadorSintatico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  System.Generics.Collections, StrUtils, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Vcl.DBGrids, Vcl.NumberBox, Vcl.Buttons, MidasLib;

type
  TfAnalisadorSintatico = class(TForm)
    lbl_sentenca: TLabel;
    edt_sentenca: TEdit;
    stg_gramatica: TStringGrid;
    btn_total: TButton;
    btn_passo_a_passo: TButton;
    stg_principal: TStringGrid;
    lbl_gramatica: TLabel;
    Label1: TLabel;
    lbl_resposta: TLabel;
    tmr: TTimer;
    dbg_parsing: TDBGrid;
    cds_tabparsing: TClientDataSet;
    cds_tabparsinginfo_1: TStringField;
    cds_tabparsinginfo_2: TStringField;
    cds_tabparsinginfo_3: TStringField;
    cds_tabparsinginfo_4: TStringField;
    cds_tabparsinginfo_5: TStringField;
    cds_tabparsinginfo_6: TStringField;
    src_tabparsing: TDataSource;
    Label2: TLabel;
    nmb_velocidade: TNumberBox;
    btn_gerar: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure stg_gramaticaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure stg_firstDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure stg_tabelaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure stg_principalDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_passo_a_passoClick(Sender: TObject);
    procedure btn_totalClick(Sender: TObject);
    procedure edt_sentencaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edt_sentencaChange(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure btn_gerarClick(Sender: TObject);
    procedure dbg_parsingMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbg_parsingCellClick(Column: TColumn);
    procedure dbg_parsingExit(Sender: TObject);
  private
    { Private declarations }
    procedure Processar;
    procedure geraLinha;
    procedure Limpar;
  public
    { Public declarations }
    slPilha: TStringList;
    slEntrada: TStringList;
    slRegra: TStringList;
    iLinha: Integer;
    bFirst: Boolean;
    bLer: Boolean;
    bFim: Boolean;
    bTotal: Boolean;
    texto: string;
    sField: string;
    iRecNo: Integer;
  end;

var
  fAnalisadorSintatico: TfAnalisadorSintatico;

implementation

{$R *.dfm}

procedure TfAnalisadorSintatico.btn_gerarClick(Sender: TObject);
var
  slSentencas: TStringList;
begin
  slSentencas := TStringList.Create;
  try
    slSentencas.Add('cbaaababd');
    slSentencas.Add('badc');
    slSentencas.Add('cbaabadccdca');
    slSentencas.Add('babadccc');
    slSentencas.Add('cbaca');
    slSentencas.Add('babaabaccdccc');
    edt_sentenca.Text := slSentencas[random(6)];
  finally
    slSentencas.Free;
  end;
end;

procedure TfAnalisadorSintatico.btn_passo_a_passoClick(Sender: TObject);
begin
  if bFim then
    Limpar;
  btn_gerar.Enabled := false;
  btn_total.Enabled := false;
  btn_passo_a_passo.Enabled := true;
  bTotal := false;
  try
    Processar;
  finally
    btn_gerar.Enabled := bFim;
  end;
end;

procedure TfAnalisadorSintatico.btn_totalClick(Sender: TObject);
begin
  Limpar;
  edt_sentenca.Enabled      := false;
  nmb_velocidade.Enabled    := false;
  btn_gerar.Enabled         := false;
  btn_total.Enabled         := false;
  btn_passo_a_passo.Enabled := false;
  bTotal                    := true;
  tmr.Enabled               := true;
  dbg_parsing.SetFocus;
end;

procedure TfAnalisadorSintatico.dbg_parsingCellClick(Column: TColumn);
var
  I: Integer;
  sTexto: String;
begin
  if (iRecNo = -1) or (iRecNo = cds_tabparsing.RecNo) then
  begin
    if (sField = '') or (sField = 'info_1') or
      (cds_tabparsing.FieldByName(sField).AsString = '') then
      Exit;
    sTexto := Copy(cds_tabparsing.FieldByName(sField).AsString, 5,
      Length(cds_tabparsing.FieldByName(sField).AsString) - 4);
    if sTexto = 'E' then
    begin
      for I := Length(texto) downto 1 do
        if (texto[I] in ['A' .. 'Z']) then
          Delete(texto, I, 1);
      edt_sentenca.Text := texto;
      iRecNo := -1;
      texto := '';
    end
    else
    begin
      if texto <> '' then
      begin
        for I := Length(texto) downto 1 do
          if (texto[I] in ['A' .. 'Z']) then
            texto := StringReplace(texto, texto[I], sTexto, [rfReplaceAll]);
      end
      else
        texto := sTexto;
      for I := Length(sTexto) downto 1 do
        if (sTexto[I] in ['A' .. 'Z']) then
          if cds_tabparsing.Locate('info_1', VarArrayOf([sTexto[I]]), []) then
          begin
            iRecNo := cds_tabparsing.RecNo;
            Break;
          end;
    end;
  end
  else
    cds_tabparsing.RecNo := iRecNo;
end;

procedure TfAnalisadorSintatico.dbg_parsingExit(Sender: TObject);
begin
  texto := '';
end;

procedure TfAnalisadorSintatico.dbg_parsingMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (X >= 1) and (X < 58) then
    sField := 'info_1'
  else if (X >= 58) and (X < 115) then
    sField := 'info_2'
  else if (X >= 116) and (X < 173) then
    sField := 'info_3'
  else if (X >= 174) and (X < 231) then
    sField := 'info_4'
  else if (X >= 232) and (X < 289) then
    sField := 'info_5'
  else if (X >= 290) and (X < 374) then
    sField := 'info_6'
  else
    sField := '';
end;

procedure TfAnalisadorSintatico.edt_sentencaChange(Sender: TObject);
begin
  Limpar;
  btn_passo_a_passo.Enabled := Length(edt_sentenca.Text) > 0;
  btn_total.Enabled := Length(edt_sentenca.Text) > 0;
  bFirst := Length(edt_sentenca.Text) > 0;
end;

procedure TfAnalisadorSintatico.edt_sentencaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in ['a' .. 'd', Chr(8)]) then
    Key := #0;
end;

procedure TfAnalisadorSintatico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfAnalisadorSintatico.FormCreate(Sender: TObject);
begin
  slPilha := TStringList.Create;
  slEntrada := TStringList.Create;
  slRegra := TStringList.Create;
  iLinha := 0;
  bFirst := true;
  bLer := false;
  bFim := false;
  bTotal := false;
  lbl_resposta.Caption := EmptyStr;
end;

procedure TfAnalisadorSintatico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssAlt]) and (Key = 50) then // Alt+P
    btn_passo_a_passo.Click;
end;

procedure TfAnalisadorSintatico.FormShow(Sender: TObject);
var
  CanSel: Boolean;
begin
  iRecNo := -1;

  stg_gramatica.ColWidths[0] := 0;
  stg_gramatica.ColWidths[1] := 40;
  stg_gramatica.ColWidths[2] := 30;
  stg_gramatica.ColWidths[3] := 10;
  stg_gramatica.ColWidths[4] := 30;
  stg_gramatica.ColWidths[5] := 80;
  stg_gramatica.ColWidths[6] := 80;
  stg_gramatica.ColWidths[7] := 30;
  stg_gramatica.ColWidths[8] := 80;
  // Gramática
  stg_gramatica.Cells[1, 0] := 'GLC   ';
  stg_gramatica.Cells[1, 1] := 'S ::=';
  stg_gramatica.Cells[2, 1] := 'bBc';
  stg_gramatica.Cells[3, 1] := '|';
  stg_gramatica.Cells[4, 1] := 'cCa';
  stg_gramatica.Cells[1, 2] := 'A ::=';
  stg_gramatica.Cells[2, 2] := 'Cb';
  stg_gramatica.Cells[3, 2] := '|';
  stg_gramatica.Cells[4, 2] := 'aBd';
  stg_gramatica.Cells[1, 3] := 'B ::=';
  stg_gramatica.Cells[2, 3] := 'aCc';
  stg_gramatica.Cells[3, 3] := '|';
  stg_gramatica.Cells[4, 3] := 'ε';
  stg_gramatica.Cells[1, 4] := 'C ::=';
  stg_gramatica.Cells[2, 4] := 'bAc';
  stg_gramatica.Cells[3, 4] := '|';
  // First
  stg_gramatica.Cells[6, 0] := 'First       ';
  stg_gramatica.Cells[6, 1] := 'S ::= {b,c}';
  stg_gramatica.Cells[6, 2] := 'A ::= {a}   ';
  stg_gramatica.Cells[6, 3] := 'B ::= {a,ε}';
  stg_gramatica.Cells[6, 4] := 'C ::= {b}   ';
  // Follow
  stg_gramatica.Cells[8, 0] := 'Follow     ';
  stg_gramatica.Cells[8, 1] := 'S ::= {$}   ';
  stg_gramatica.Cells[8, 2] := 'A ::= {c}   ';
  stg_gramatica.Cells[8, 3] := 'B ::= {c,d}';
  stg_gramatica.Cells[8, 4] := 'C ::= {c,a}';

  // Tabela
  cds_tabparsing.CreateDataSet;
  cds_tabparsing.Open;

  cds_tabparsing.Append;
  cds_tabparsinginfo_1.AsString := 'S';
  cds_tabparsinginfo_3.AsString := 'S > bBc';
  cds_tabparsinginfo_4.AsString := 'S > cCa';
  cds_tabparsing.Post;

  cds_tabparsing.Append;
  cds_tabparsinginfo_1.AsString := 'A';
  cds_tabparsinginfo_2.AsString := 'A > aBd';
  cds_tabparsing.Post;

  cds_tabparsing.Append;
  cds_tabparsinginfo_1.AsString := 'B';
  cds_tabparsinginfo_2.AsString := 'B > aCc';
  cds_tabparsinginfo_4.AsString := 'B > E';
  cds_tabparsinginfo_5.AsString := 'B > E';
  cds_tabparsing.Post;

  cds_tabparsing.Append;
  cds_tabparsinginfo_1.AsString := 'C';
  cds_tabparsinginfo_3.AsString := 'C > bAc';
  cds_tabparsing.Post;

  // Principal
  stg_principal.Cells[0, 0] := '#';
  stg_principal.Cells[1, 0] := 'Pilha';
  stg_principal.Cells[2, 0] := 'Entrada';
  stg_principal.Cells[3, 0] := 'Ação';

  stg_principal.ColWidths[0] := 50;
  stg_principal.ColWidths[1] := 231;
  stg_principal.ColWidths[2] := 231;
  stg_principal.ColWidths[3] := 231;

end;

procedure TfAnalisadorSintatico.geraLinha;
begin
  iLinha := iLinha + 1;
  stg_principal.Cells[0, iLinha] := IntToStr(iLinha);
  if slPilha[slPilha.Count - 1] = '$' then
    stg_principal.Cells[1, iLinha] := slPilha[slPilha.Count - 1]
  else
    stg_principal.Cells[1, iLinha] := '$' + slPilha[slPilha.Count - 1];
  if slEntrada[slEntrada.Count - 1] = '$' then
    stg_principal.Cells[2, iLinha] := slEntrada[slEntrada.Count - 1]
  else
    stg_principal.Cells[2, iLinha] := slEntrada[slEntrada.Count - 1] + '$';
  stg_principal.Cells[3, iLinha] := slRegra[slRegra.Count - 1];
  if bLer then
  begin
    slPilha[slPilha.Count - 1] := Copy(slPilha[slPilha.Count - 1], 1,
      Length(slPilha[slPilha.Count - 1]) - 1);
    bLer := false;
  end;
end;

procedure TfAnalisadorSintatico.Limpar;
var
  I, j: Integer;
begin
  lbl_resposta.Caption := EmptyStr;
  for I := 0 to stg_principal.ColCount - 1 do
    for j := 1 to stg_principal.RowCount do
      stg_principal.Cells[I, j] := EmptyStr;
  stg_principal.RowCount := 1;
  iLinha := 0;
  bFirst := true;
  bLer := false;
  bFim := false;
  slPilha.clear;
  slEntrada.clear;
  slRegra.clear;
end;

procedure TfAnalisadorSintatico.Processar;
  function BuscaRegra(sLinha, sColuna: string): string;
  var
    I, j: Integer;
  begin
    if (sLinha = EmptyStr) and (sColuna = EmptyStr) then
    begin
      btn_total.Enabled := false;
      slPilha.Add('$');
      slEntrada.Add('$');
      slRegra.Add('Aceito em ' + IntToStr(iLinha + 1) + ' Iterações');
      lbl_resposta.Font.Color := clLime;
      lbl_resposta.Caption := 'ACEITO';
      bFim := true;
      btn_total.Enabled := True;
      btn_passo_a_passo.Enabled := True;
      Exit;
    end
    else if (sLinha <> EmptyStr) and (sColuna = EmptyStr) then
    begin
      btn_total.Enabled := false;
      slEntrada.Add('$');
      slRegra.Add('Erro em ' + IntToStr(iLinha + 1) + ' Iterações');
      lbl_resposta.Font.Color := clRed;
      lbl_resposta.Caption := 'ERRO';
      bFim := true;
      btn_total.Enabled := True;
      btn_passo_a_passo.Enabled := True;
      Exit;
    end
    else if (sLinha = EmptyStr) and (sColuna <> EmptyStr) then
    begin
      btn_total.Enabled := false;
      slEntrada.Add('$');
      slRegra.Add('Erro em ' + IntToStr(iLinha + 1) + ' Iterações');
      lbl_resposta.Font.Color := clRed;
      lbl_resposta.Caption := 'ERRO';
      btn_total.Enabled := True;
      btn_passo_a_passo.Enabled := True;
      bFim := true;
      Exit;
    end;
    cds_tabparsing.First;
    while not cds_tabparsing.Eof do
    begin
      if cds_tabparsinginfo_1.AsString = sLinha then
      begin
        if dbg_parsing.Columns[1].Title.Caption = sColuna then
        begin
          j := 2;
          Break;
        end
        else if dbg_parsing.Columns[2].Title.Caption = sColuna then
        begin
          j := 3;
          Break;
        end
        else if dbg_parsing.Columns[3].Title.Caption = sColuna then
        begin
          j := 4;
          Break;
        end
        else if dbg_parsing.Columns[4].Title.Caption = sColuna then
        begin
          j := 5;
          Break;
        end
        else if dbg_parsing.Columns[5].Title.Caption = sColuna then
        begin
          j := 6;
          Break;
        end
        else
        begin
          j := -1;
          Break;
        end
      end;
      cds_tabparsing.Next;
    end;

    if j = -1 then
      Result := ''
    else
    begin
      if j = 2 then
        Result := cds_tabparsinginfo_2.AsString
      else if j = 3 then
        Result := cds_tabparsinginfo_3.AsString
      else if j = 4 then
        Result := cds_tabparsinginfo_4.AsString
      else if j = 5 then
        Result := cds_tabparsinginfo_5.AsString
      else if j = 6 then
        Result := cds_tabparsinginfo_6.AsString
    end;

  end;

  function BuscaLinha: String;
  begin
    Result := Copy(AnsiReverseString(slPilha[slPilha.Count - 1]), 1, 1);
  end;

  function BuscaColuna: String;
  begin
    Result := Copy(slEntrada[slEntrada.Count - 1], 1, 1);
  end;

  procedure MontaDerivacao;
  var
    sEps: string;
  begin
    if (Copy(slRegra[slRegra.Count - 1], 1, 2) <> 'Lê') then
    begin
      if Copy(slRegra[slRegra.Count - 1],5,3) = 'E' then
        sEps := EmptyStr
      else if Copy(slRegra[slRegra.Count - 1],5,3) = '' then
      begin
        btn_total.Enabled := false;
        slEntrada.Add('$');
        slRegra.Add('Erro em ' + IntToStr(iLinha + 1) + ' Iterações');
        lbl_resposta.Font.Color := clRed;
        lbl_resposta.Caption := 'ERRO';
        btn_total.Enabled := True;
        btn_passo_a_passo.Enabled := True;
        bFim := true;
        Exit;
      end
      else
        sEps := AnsiReverseString(Copy(slRegra[slRegra.Count - 1],5,3));
      slPilha[slPilha.Count - 1] := Copy(slPilha[slPilha.Count - 1], 1,
        Length(slPilha[slPilha.Count - 1]) - 1) + sEps;
    end
    else
    begin
      slEntrada[slEntrada.Count - 1] := Copy(slEntrada[slEntrada.Count - 1], 2,
        Length(slEntrada[slEntrada.Count - 1]));
      slRegra.Add(BuscaRegra(BuscaLinha, BuscaColuna));
      if bFim then
        slRegra.Delete(slRegra.Count - 1);
    end;
    if (not bFim) and (BuscaLinha = BuscaColuna) then
    begin
      slRegra.Add('Lê ' + BuscaLinha);
      bLer := true;
    end;
  end;

begin
  try
    if bFirst then
    begin
      Limpar;
      slPilha.Add('S');
      slEntrada.Add(edt_sentenca.Text);
      bFirst := false;
      slRegra.Add(BuscaRegra(BuscaLinha, BuscaColuna));
    end
    else
      MontaDerivacao;
    stg_principal.RowCount := stg_principal.RowCount + 1;
    stg_principal.Row := stg_principal.RowCount - 1;
    geraLinha;
  finally
    btn_gerar.Enabled := bFim;
    edt_sentenca.Enabled := bFim;
    nmb_velocidade.Enabled := bFim;
  end;
end;

procedure TfAnalisadorSintatico.stg_firstDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sTexto: String;
begin
  with TStringGrid(Sender) do
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect); // Limpa o conteúdo da célula.
    sTexto := Cells[ACol, ARow];
    if ARow = 0 then
      Canvas.Font.Style := [fsBold];
    Canvas.TextRect(Rect, sTexto, [tfWordBreak, tfVerticalCenter, tfCenter]);
  end;
end;

procedure TfAnalisadorSintatico.stg_gramaticaDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sTexto: String;
begin
  with TStringGrid(Sender) do
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect); // Limpa o conteúdo da célula.
    sTexto := Cells[ACol, ARow];
    Canvas.TextRect(Rect, sTexto, [tfWordBreak, tfVerticalCenter, tfCenter]);
  end;
end;

procedure TfAnalisadorSintatico.stg_principalDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sTexto: String;
begin
  if ARow = 0 then
  begin
    with TStringGrid(Sender) do
    begin
      Canvas.Brush.Color := clWhite;
      Canvas.FillRect(Rect); // Limpa o conteúdo da célula.
      sTexto := Cells[ACol, ARow];
      Canvas.Font.Style := [fsBold];
      Canvas.TextRect(Rect, sTexto, [tfWordBreak, tfVerticalCenter, tfCenter]);
    end;
  end;
end;

procedure TfAnalisadorSintatico.stg_tabelaDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sTexto: String;
begin
  if ARow = 0 then
  begin
    with TStringGrid(Sender) do
    begin
      Canvas.Brush.Color := clWhite;
      Canvas.FillRect(Rect); // Limpa o conteúdo da célula.
      sTexto := Cells[ACol, ARow];
      Canvas.TextRect(Rect, sTexto, [tfWordBreak, tfVerticalCenter, tfCenter]);
    end;
  end;
end;

procedure TfAnalisadorSintatico.tmrTimer(Sender: TObject);
begin
  tmr.Interval := Trunc(nmb_velocidade.Value * 1000);
  Processar;
  if bFim then
    tmr.Enabled := false;
end;

end.
