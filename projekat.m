function E = projekat (ime,n,R,alfa)
% ime - naziv slike ; n- broj iteracija; R- precnik ; alfa - koeficijent
x=imread(ime); % ucitavanje slike

x=im2double(x);
So=zeros(size(x));
Sc=zeros(size(x));
% pravljenje strukturnog elementa
for i=1:n 
    se(i)=strel('disk',i*R,0);
end
 
% white tophat 

for i=1:n 
    op=imopen(x,se(i)); % otvaranje strukurnim elementom
    Do=x-op; % oduzimamo od originalne slike otvorenu sliku
    So=So+Do; % suma svih slika svetlih detalja 
end

% black tophat

for i=1:n
    cl=imclose(x,se(i)); %zatvaranje slike strukturnim elementom
    Dc=cl+x; % na originalnu sliku dodajemo zatvorenu sliku
    Sc=Sc+Dc; % suma svih slika tamnih detalja
   
end
    OS= So;
    OS=OS/max(max(max(OS))); % preskaliranje opsega
    
    CS= - Sc; % menjamo znak sumi tamnih
    CS= (CS-min(min(min(CS)))); % preskaliranje
    CS=CS/max(max(max(CS)));
    
    E= x+(1-alfa)*OS-alfa*CS; % forumula za krajnju sliku
    E=im2uint8(E);
    figure, imshow(im2uint8(x))
    figure, imshow(E)
    
    
    
end

