Program tp3;

Type 
    str_ = string[30];
    T = ^TT;
    TT = Record
        nom : str_;
        D : T;
        F : T;
        S : T;
        P : T;
    End;

var 
data : array[1..5] of string;op:integer;X,temp:T;

procedure New_(var D,F:T;nom:str_);
begin
	if D = nil then
	begin
		new(D);
		D^.nom := nom; D^.D := nil; D^.F := nil; D^.P := nil; D^.S := nil; F := D
    end
    else
    begin
    	new(F^.S); 
    	F^.S^.nom := nom; F^.S^.D := nil; F^.S^.F := nil; F^.S^.P := nil; F^.S^.S := nil; F := F^.S;
    end;
end;

procedure supp(var D,F:T);
var X:T;
begin
	while D <> nil do
	begin
        X:=D;
		D:=D^.S;
		dispose(X);
	end;
	F:=nil;
end;

procedure trier(var D,F:T);
var A,X:T; stop :boolean;temp:str_;
begin
	if D <> nil then
	if D^.S <> nil then
	begin
        stop := false;
        repeat
            stop :=true;
            X:=D;
            while X^.S <> nil do 
            begin
            	if X^.nom > X^.S^.nom then
            	begin
            		temp := X^.nom;
            		X^.nom := X^.S^.nom;
            		X^.S^.nom := temp;
            		A := X^.D; X^.D:=X^.S^.D; X^.S^.D := A;
            		A := X^.F; X^.F:=X^.S^.F; X^.S^.F := A;
            		stop := false
                end;
                X:=X^.S;
            end;
        until stop;
    end;
end;

function Taille(D,F:T):integer;
var X:T ; cpt:integer;
begin
	X:=D;cpt:=0;
	while X <> nil do
	begin
		cpt := cpt + 1 ;
		X := X^.S
    end;
    Taille := cpt
end;

function contenue(D,F:T;N:integer):T;
var X:T; cpt:integer;
begin
	cpt:=1; X:=D;
	while cpt <> N do
	begin
		X := X^.S;
		cpt := cpt +1 
    end;
    contenue := X
end;

procedure show(D,F:T);
var X:T ; cpt:integer;
begin
	X:=D;cpt:=0;
	while X <> nil do
	begin
		cpt := cpt + 1 ;
		writeln(cpt,' - ',X^.nom);
		X := X^.S
    end
end;

procedure New__(var X:T;a,b:integer);
var nom:str_;c:integer;
begin
	if a=b then
	begin
            write('Enter the name of this ',data[a],' : ');
            readln(nom);
            New_(X^.D,X^.F,nom)
     end
	else if X^.D <> nil then 
        begin
        	writeln('Choose the ',data[a],' : ');
            show(X^.D,X^.F);
            repeat
                write('number (in the list) : ');
                readln(C)
            until (C <= Taille(X^.D,X^.F)) and (C >= 1);
            X := contenue(X^.D,X^.F,C);
           New__(X,a+1,b)
       end
    else if a=1 then writeln('no ',data[1],' found')
    else writeln('there is no ',data[a],' in this ',data[a-1])
end;

procedure tri_(var X:T;a,b:integer);
var c:integer;
begin
	if a=b then
	begin
            trier(X^.D,X^.F);
            writeln('done...')
     end
	else if X^.D <> nil then 
        begin
        	writeln('Choose the ',data[a],' : ');
            show(X^.D,X^.F);
            repeat
                write('number (in the list) : ');
                readln(C)
            until (C <= Taille(X^.D,X^.F)) and (C >= 1);
            X := contenue(X^.D,X^.F,C);
           tri_(X,a+1,b)
       end
    else if a=1 then writeln('no ',data[1],' found')
    else writeln('there is no ',data[a],' in this ',data[a-1])
end;

function recherche(D,F:T;nom:str_):boolean;
var X:T; tr:boolean;
begin
	X:=D; tr:=false;
	while (X<>nil ) and not(tr) do
	if X^.nom = nom then tr:= true
	else X := X^.S;
	recherche:=tr;
end;
    
function recherche_(var X:T;a,b:integer):boolean;
var nom:str_;c:integer;
begin
	if a=b then
	begin
            write('Enter the ',data[a],' name  that you are looking for : ');
            readln(nom);
            recherche_:=recherche(X^.D,X^.F,nom)
     end
	else if X^.D <> nil then 
        begin
        	writeln('Choose the ',data[a],' : ');
            show(X^.D,X^.F);
            repeat
                write('number (in the list) : ');
                readln(C)
            until (C <= Taille(X^.D,X^.F)) and (C >= 1);
            X := contenue(X^.D,X^.F,C);
           recherche_:=recherche_(X,a+1,b)
       end
    else if a=1 then writeln('no ',data[1],' found')
    else writeln('there is no ',data[a],' in this ',data[a-1])
end;

procedure affiche(X:T;a:integer);
var Y:T; cpt,i:integer;f:boolean;
begin
	Y:=X^.D;cpt:=0;f:=true;
	while Y <> nil do
	begin
		if f then
		begin
	for i:=1 to a do write('    ');
	writeln(data[a+1],'  : ');
	f:=false;
end;
		cpt := cpt + 1 ;
		for i:=1 to a do write('    ');
		write(cpt,' - ',Y^.nom);
		writeln;
		affiche(Y,a+1);
		Y:= Y^.S
    end
end;

procedure supp_(var X:T;a,b:integer);
var c:integer;y,temp:T;
begin
	if a=b then
	begin
		if X^.D <> nil then
		begin
            writeln('Enter the ',data[a],' name  that you are looking for (to supp): ');
            show(X^.D,X^.F);
            repeat
                write('number (in the list) : ');
                readln(C)
            until (C <= Taille(X^.D,X^.F)) and (C >= 1);
            writeln('done');
            case b of
            2: if c=1 then
            begin
            	temp:=X^.D;
            X^.D:=X^.D^.S;
            dispose(temp);
            	end
            else 
            begin
            begin
            X := contenue(X^.D,X^.F,C-1);
            temp:=X^.D;
            while temp <> nil do
            begin
            	y:=temp^.D;
            	while y <> nil do 
            	begin
            		supp(y^.D,y^.F);
            		y:=y^.S
                end;
            	temp:=temp^.S
            end;
            temp:=X^.D;
            while temp <> nil do 
            begin
            	supp(temp^.D,temp^.F);
            	temp:=temp^.S
            end;
            supp(X^.S^.D,X^.S^.F);
            temp:=X^.S;
            X^.S:=X^.S^.S;
            dispose(temp);
        end
        end;
            3:begin
             if c=1 then
            begin
            	temp:=X^.D;
            X^.D:=X^.D^.S;
            dispose(temp);
            	end
            else 
            begin
            X := contenue(X^.D,X^.F,C-1);
            temp:=X^.D;
            while temp <> nil do 
            begin
            	supp(temp^.D,temp^.F);
            	temp:=temp^.S;
            	end;
            supp(X^.S^.D,X^.S^.F);
            temp:=X^.S;
            X^.S:=X^.S^.S;
            dispose(temp);
            end;end;
            4:begin
             if c=1 then
            begin
            	temp:=X^.D;
            X^.D:=X^.D^.S;
            dispose(temp);
            	end
            else 
            begin
            X := contenue(X^.D,X^.F,C-1);
            supp(X^.S^.D,X^.S^.F);
            temp:=X^.S;
            X^.S:=X^.S^.S;
            dispose(temp);
            end;end;
            5:begin
            if c=1 then
            begin
            	temp:=X^.D;
            X^.D:=X^.D^.S;
            dispose(temp);
            	end
            else 
            begin
            X := contenue(X^.D,X^.F,C-1);
            temp:=X^.S;
            X^.S:=X^.S^.S;
            dispose(temp);
            end;
        end;
    end;
    
  end  else writeln('there is no ',data[a],' in this ',data[a-1])
     end
	else if X^.D <> nil then 
        begin
        	writeln('Choose the ',data[a],' : ');
            show(X^.D,X^.F);
            repeat
                write('number (in the list) : ');
                readln(C)
            until (C <= Taille(X^.D,X^.F)) and (C >= 1);
            X := contenue(X^.D,X^.F,C);
           supp_(X,a+1,b)
       end
    else if a=1 then writeln('no ',data[1],' found')
    else writeln('there is no ',data[a],' in this ',data[a-1])
end;
    
procedure remblier(var D,F:T;a:integer);
var i:integer; G:str_; temp :T;
begin
	randomize;
	if a=5 then
	for i:=1 to 1+random(8) do 
	begin
        G := chr(random(25)+65);
        for i:=1 to random(10) do G:=G+chr(random(25)+65);
		New_(D,F,G)
    end
	else if a <> 1 then
	for i:=1 to 1+random(3) do 
	begin
        G := chr(random(25)+65);
        for i:=1 to random(10) do G:=G+chr(random(25)+65);
		New_(D,F,G)
    end
    else begin
         G := chr(random(25)+65);
        for i:=1 to random(10) do G:=G+chr(random(25)+65);
		New_(D,F,G)
	end;
    if a <> 5 then
    begin
    	temp:= D;
    	while temp <> nil do
    	begin
    		remblier(temp^.D,temp^.F,a+1);
    		temp := temp^.S;
        end;
        end;
end;
    
begin
	data[1] := 'University' ; data[2] := 'Faculte' ; data[3] := 'Departement' ; data[4] := 'Specialite' ; data[5] := 'Student' ;
	new(X);
	X^.D:=nil;
	X^.F:=nil;
	while true do
	begin
		temp:=X;
		write('op = ');
		readln(op);
		case op of
		0:remblier(X^.D,X^.F,1);
		1:New__(X,1,1);
		2:New__(X,1,2);
		3:New__(X,1,3);
		4:New__(X,1,4);
		5:New__(X,1,5);
		6:writeln(recherche_(X,1,2));
		7:writeln(recherche_(X,1,3));
		8:writeln(recherche_(X,1,4));
		9:writeln(recherche_(X,1,5));
		10:supp_(X,1,2);
		11:supp_(X,1,3);
		12:supp_(X,1,4);
		13:supp_(X,1,5);
		14:tri_(X,1,2);
		15:tri_(X,1,3);
		16:tri_(X,1,4);
		17:tri_(X,1,5);
		18:affiche(X,0);
		else writeln('no function')
    end;
    X:=temp;
	writeln;writeln;
	end
end.