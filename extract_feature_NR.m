
protein_drug=bind_orfhsa_drug_nr;               

P_proteinfeature=[];
for i=1:size(protein_drug,1)
    i    
    PssmM = cell2mat(N_A_Pssm(i));    
    DCT=dct2(PssmM);                                                     
    DCT=DCT(1:20,1:20);
    P_proteinfeature(i,:)=DCT(:);
    
end
 P_proteinfeature=mapminmax(P_proteinfeature,-1,1);   
 
P_drugfeature=[];
for i=1:size(protein_drug,1)
    i
    name=protein_drug(i,2);
    name=name{1};
    [x,y] = find(strcmp(all_drug_fingerprints,name));
    F=all_drug_fingerprints(x,2:882);
    F=cell2mat(F);
    P_drugfeature(i,:)=F(:);
end

Positivefeature=[P_proteinfeature P_drugfeature];


protein_drug=NegativeList;
N_proteinfeature=[];
for i=1:size(protein_drug,1)
    i
    PssmM = cell2mat(N_B_Pssm(i));          
    DCT=dct2(PssmM);                                                    
    DCT=DCT(1:20,1:20);
    N_proteinfeature(i,:)=DCT(:);
end
 N_proteinfeature=mapminmax(N_proteinfeature,-1,1);   
 
N_drugfeature=[];
for i=1:size(protein_drug,1)
    i
    name=protein_drug(i,2);
    name=name{1};
    [x,y] = find(strcmp(all_drug_fingerprints,name));
    F=all_drug_fingerprints(x,2:882);
    F=cell2mat(F);
    N_drugfeature(i,:)=F(:);
end
Negativefeature=[N_proteinfeature N_drugfeature];

NUM=size(Positivefeature,1);
DATA=[ones(NUM,1) Positivefeature; -ones(NUM,1) Negativefeature];

