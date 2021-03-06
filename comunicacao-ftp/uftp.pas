unit uftp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  IdTrivialFTP, IdFTP, INIFiles, zlib, process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    edthostname: TEdit;
    edtusername: TEdit;
    edtpassword: TEdit;
    edtport: TEdit;
    edtcaminhoupload: TEdit;
    edtcaminhodownload: TEdit;
    idftp: TIdFTP;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

   sArquivo:String;
   sHostName:string;
   sPassWord:string;
   sUserName:string;
   sPort:string;

   scaminhoupload:string;

   procedure carregaDadosftp;
    procedure gravaDadosConexao;
     procedure recuperaDadosConexao;
     function DataDirectory: string;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}



{ TForm1 }


function tform1.dataDirectory: string;
      begin
           Result := ExtractFilePath(ParamStr(0));
           Result := ExpandFileName(Result );
      end;

procedure tform1.carregaDadosftp;
begin
  idftp.Host:=edthostname.Text;
  idftp.Username:=edtusername.Text;
  idftp.Password:=edtpassword.Text;
  idftp.Port:= strtoint( edtport.Text );


end;

procedure tform1.gravaDadosConexao;
var
  Ini:TIniFile;
begin
  sArquivo := dataDirectory+'conexoes.ini';
  Ini := TIniFile.Create(sArquivo);

  Ini.WriteString('conexaoftp','hostname',edthostname.Text);
  Ini.WriteString('conexaoftp','username',edtusername.Text);
  Ini.WriteString('conexaoftp','password',edtpassword.Text);
  Ini.WriteString('conexaoftp','port',edtport.Text);

  Ini.WriteString('conexaoftp','caminhoupload',edtcaminhoupload.Text);



end;

procedure tform1.recuperaDadosConexao;
var
  Ini:TIniFile;

begin
  sArquivo := dataDirectory+'conexoes.ini';
  Ini := TIniFile.Create(sArquivo);

  sHostName := Ini.ReadString('conexaoftp','hostname','');
  sUserName := Ini.ReadString('conexaoftp','username','');
  sPassWord := Ini.ReadString('conexaoftp','password','');
  sPort     := Ini.ReadString('conexaoftp','port','');
  scaminhoupload := Ini.ReadString('conexaoftp','caminhoupload','');



end;

procedure TForm1.Button1Click(Sender: TObject);
begin






  gravaDadosConexao;

  carregaDadosftp;

  idftp.Connect();

  idftp.ChangeDir('/');


  recuperaDadosConexao;



  if   (fileexists(  edtcaminhoupload.Text  )) and (idftp.Connected) then
     begin

       form1.Caption:= 'Enviando...';

       idftp.Put(edtcaminhoupload.Text, extractfilename(edtcaminhoupload.Text), true);



     end;



  if (idftp.Connected) then
     begin

       idftp.Disconnect;

       form1.Caption:= 'Desconectado';

     end;



end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  idftp.List(memo1.Lines);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
      begin

        edtcaminhoupload.Text:= OPenDialog1.FileName;


      end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  sArquivo := dataDirectory+'conexoes.ini';

  edthostname.Text:='';
  edtusername.Text:='';
  edtpassword.Text:='';
  edtport.Text:='';
  edtcaminhoupload.Text:='';

  if fileexists(sArquivo) then
     begin

       recuperaDadosconexao;
       edthostname.Text:=sHostName;
       edtusername.Text:=sUserName;
       edtpassword.Text:=sPassWord;
       edtport.Text:= sport;
       edtcaminhoupload.Text:=scaminhoupload;

     end;


end;

end.

