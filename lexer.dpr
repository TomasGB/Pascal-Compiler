program lexer;

{$APPTYPE CONSOLE}

uses
  Classes, SysUtils,StdCtrls;


Const NUM_Token = 'NUM';
      STRING_Token = 'STRING';
      SEPARADOR_Token = 'SEPARADOR';
      OPERADOR_Token = 'OPERADOR';
      KEYWORD_Token = 'KEYWORD';

type
    rangos = set of Char;
    //Tkeys = ['begin','end','function','procedure','if','else','for','while','repeat','do','until','to','down','type','const','var','uses','program'];


var
 lista:TStringList;
 lineaArchivo,j,k,it:integer;
 linea,token,acum:string;
 digitos,letras:rangos;
 //keywords:keys;

begin
  { TODO -oUser -cConsole Main : Insert code here }
   Lista:= TStringList.Create;
   Lista.LoadFromFile('prueba.txt');

   digitos:=['0','1','2','3','4','5','6','7','8','9'];
   letras:=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];

   for lineaArchivo:=0 to Lista.count-1 do
      begin
            linea:=Lista.Strings[lineaArchivo];
            token:='';
            for j:=1 to 1 do
            begin
                writeln('linea: '+ inttostr(lineaArchivo));
                writeln('');
                k:=j;
                while linea[k] <> linea[length(linea)+1] do
                    begin
                        if linea[k] in digitos then
                            begin
                                it:=k;
                                acum:='';
                                while (linea[it] in digitos) or (linea[it]='.') do
                                    begin
                                        acum:=acum+linea[it];
                                        it:=it+1;
                                end;
                                writeln('['+NUM_Token+' , ',acum,' ]');
                                k:=it;
                            end
                        else
                            if linea[k] in ['=','+','-','*','/','<','>'] then
                                begin
                                    acum:='';
                                    if (linea[it] = '>') and (linea[it+1]='=') then
                                        begin
                                            acum:='>=';
                                            writeln('['+OPERADOR_Token+' , ',acum+' ]');
                                            k:=k+2;
                                        end
                                    else
                                        if (linea[it] = '<') and (linea[it+1]='=') then
                                            begin
                                                acum:='<=';
                                                writeln('['+OPERADOR_Token+' , ',acum+' ]');
                                                k:=k+2;
                                            end
                                        else
                                            begin
                                                writeln('['+OPERADOR_Token+' , ',linea[k]+' ]');
                                                k:=k+1;
                                            end;
                                end
                            else
                                if linea[k] in ['(',')','.',':',';','[',']'] then
                                    begin
                                        writeln('['+SEPARADOR_Token+' , ',linea[k]+' ]');
                                        k:=k+1;
                                    end
                                else
                                    if linea[k] in letras then
                                        begin
                                            it:=k;
                                            acum:='';
                                            while (linea[it] in letras)do
                                              begin
                                                acum:=acum+linea[it];
                                                it:=it+1;
                                              end;
                                              if (acum ='begin') or (acum = 'end') or (acum = 'function') or (acum = 'procedure' )or (acum = 'if' )or (acum = 'else' )or (acum = 'for') or (acum = 'while') or (acum = 'repeat') or (acum = 'do') or (acum = 'until')or (acum = 'to')or( acum = 'down')or (acum = 'type')or (acum = 'const')or (acum = 'var')or (acum = 'uses')or (acum = 'program' )then
                                                begin
                                                    writeln('['+KEYWORD_Token+' , ',acum,' ]');
                                                    k:=it;
                                                end
                                              else
                                                begin
                                                    writeln('['+STRING_Token+' , ',acum,' ]');
                                                    k:=it;
                                                end;
                                        end
                                    else k:=k+1;

                    end; //while linea[k] <> linea[length(linea)+1]
                    writeln('');

            end;//for j:=1 to 1 do

      end;//for lineaArchivo:=0 to Lista.count-1 do
      
readln;
end.
