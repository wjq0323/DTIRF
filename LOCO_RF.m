
[row,col]=size(data_DCT);
[Class_Num,index]=max(T); 
Result_ALL=zeros(row,1);
R=[];
R_Temp=[];

for i=1:Class_Num
   Test=[];
   Train=[];
   for j=1:row 
       if T(j)==i
           Test=[Test;data_DCT(j,:)];
       else
           Train=[Train;data_DCT(j,:)];
       end
   end
   Te_lab=Test(:,1);
   Te=Test(:,2:col);
   Tr_lab=Train(:,1);
   Tr=Train(:,2:col);
   kk=16;   
   LL=21;    
   Result_Pre = rotationforest_LOCO(Te,Te_lab,Tr,Tr_lab,kk,LL);
   
    
   [ACC,SN,SP,PPV,NPV,F1,MCC] = roc1(Result_Pre,Te_lab);
    aa = [ACC,SN,SP,PPV,NPV,F1,MCC];
    R_Temp=[R_Temp;aa];
   i
   k=1;
   for j=1:row 
       if T(j)==i
           Result_ALL(j)=Result_Pre(k);
           k=k+1;
       end
   end
end

[ACC,SN,SP,PPV,NPV,F1,MCC] = roc1(Result_ALL,data_DCT(:,1) );
aa = [ACC,SN,SP,PPV,NPV,F1,MCC];

R=[R;aa];  

