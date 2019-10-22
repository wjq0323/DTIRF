

m=E_N_Pssm;   

E_N_feature_PsePSSM = [];  
[H_all,L_all]=size(m); 

for nn=1:L_all  
    nn
    [iNum , jNum] = size(cell2mat(m(nn)));   
    m1=cell2mat(m(nn));                 
    E = [];                                      


    for i = 1:iNum         
        result2 = 0;  
        for u = 1:20

            inner = InnerPssm( m1(i,:) , u);
            result2 = result2 + inner^2;
        end
        result2 =sqrt( result2 / 20);

        for j = 1:20
            result1 = 0;  
            result1 = InnerPssm( m1(i,:) , j);

            E(i,j) = result1 / result2;    
        end
    end

    AVE_EG=[];  
    for j = 1:20    
        result3 = 0;
        for i=1:iNum
            result3 = result3 + E(i,j);
        end
        AVE_EG(j) = result3 / iNum;
    end

    Para=49;    
    
    for k=1:Para    
        for j = 1:20
            result4 = 0;
            for i = 1:iNum-k
                result4 = result4 + (E(i,j) -  E(i+k,j))^2;
            end
            AVE_EG(20+j+20*(k-1)) = result4 / (iNum-k);
        end
    end

if isnan(AVE_EG)        
    AVE_EG=0;
end
E_N_feature_PsePSSM(nn,:)=AVE_EG(:);
end

recordfile=strcat('./E/',num2str(Para),'_E_N_feature_PsePSSM');
save(recordfile,'E_N_feature_PsePSSM')  

