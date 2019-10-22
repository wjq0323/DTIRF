function [Result_Pre] = rotationforest_LOCO(Te,Te_lab,Tr,Tr_lab,kk,LL)

R=[];
[kk_h_num,kk_num] = size(kk);
[LL_h_num,LL_num] = size(LL);


 for Ls=1:LL_num
    L=LL(Ls);                %% the ensemble size
    Ls;
    for ks=1:kk_num
        K=kk(ks);                
 
        for rs=1:1

        datafile = strcat('dataset_IC','_',dec2base(rs,10));


        train_sample=Tr';   
        train_label=Tr_lab';
        test_label=Te_lab';
        test_1=Te';
        R_matrix=cell(L,1);



            for i=1:L   
                [feature_num,data_num] = size(train_sample);
                fold_num=floor(feature_num/K);
                inx=randperm(feature_num);

                rotation_matrix=zeros(feature_num,feature_num);  
                rmatrix=zeros(ceil(feature_num/K),feature_num);
                for j=1:K
                    if j==K
                        newfeature=[ ceil((feature_num*(j-1)/K)+1):feature_num];
                    else
                        newfeature=[ floor((feature_num*(j-1)/K)+1):floor((feature_num*j)/K)];
                    end
                    val_x=train_sample(inx(newfeature),:);
                    % without eliminating the samples of classes
                    boot=randsample(1:data_num,ceil(data_num*3/4),true);
                    boot_x = val_x(:,boot);
                    newmatrix = pcacov(boot_x');
                    rmatrix(:,inx(newfeature))=newmatrix;
                end
                for j=1:K
                    if j==K
                        newfeature=[ ceil((feature_num*(j-1)/K)+1):feature_num];
                    else
                        newfeature=[ floor((feature_num*(j-1)/K)+1):floor((feature_num*j)/K)];
                    end
                    rotation_matrix(floor((feature_num*(j-1)/K)+1):floor((feature_num*(j-1)/K)+size(newmatrix,1)), ...
                        floor((feature_num*(j-1)/K)+1):floor((feature_num*(j-1)/K)+size(newmatrix,2)))=...
                        rmatrix(:,floor((feature_num*(j-1)/K)+1):floor((feature_num*(j-1)/K)+size(newmatrix,1)));
                end
                R_matrix{i,1}=rotation_matrix;
            end

            test_sample=Te';
            s0=j48;
            s0.confidence=0.25;
            s0.binary=1;

            prediction_result=zeros(L,size(test_label,2));
            error=zeros(L,1);
            for i=1:L
                d=data(train_sample'*R_matrix{i},train_label'); % training data (based on spider)
                s=data(test_sample'*R_matrix{i},test_label'); % test data
                [r,a]=train(s0,d);
                tst=test(a,s);
                prediction_result(i,:)=tst.X';
            end
            if s0.unpruned==1
                strprun='unpruned';
            else
                strprun='pruned';
            end


                temp=prediction_result(1,:);
                temp(find(temp>0))=1; %#ok<FNDSB>
                temp(find(temp<=0))=-1; %#ok<FNDSB>
                temp=temp';
                [precision(1),sensitivity(1),total(1),tp(1),fp(1),tn(1),fn(1)]=measure(temp,Te_lab); 
            for m=2:L
                temp=sum(prediction_result(1:m,:));
                temp(find(temp>0))=1; %#ok<FNDSB>
                temp(find(temp<=0))=-1; %#ok<FNDSB>
                temp=temp';
                [precision(m),sensitivity(m),total(m),tp(m),fp(m),tn(m),fn(m)]=measure(temp,Te_lab);  
            end      
             recordfile = strcat(num2str(K),'_',num2str(L),'_5f_1_',strprun,'_dataset_IC_result','_unprund',dec2base(rs,10)); %落地的文件  %%%%%%
             save(recordfile,'precision','sensitivity','total','tp','fn','tn','fp','prediction_result','Te_lab');     
        end

        pre_result = sum(prediction_result,1);
        pre_result(find(pre_result>0))=1; %#ok<FNDSB>
        pre_result(find(pre_result<=0))=-1;
        Result_Pre=pre_result';
        
    end
 end
end