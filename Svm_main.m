
%fold-1
model1=svmtrain(double(IC_f1_train_label),double(IC_f1_train_feature),'-c 0.5 -g 0.4 -b 1');
[predictions_f1,accuracy1,dec_values1]=svmpredict(double(IC_f1_test_label),double(IC_f1_test_feature),model1,'-b 1');

%fold-2
model2=svmtrain(double(IC_f2_train_label),double(IC_f2_train_feature),'-c 0.5 -g 0.2 -b 1');
[predictions_f2,accuracy2,dec_values2]=svmpredict(double(IC_f2_test_label),double(IC_f2_test_feature),model2,'-b 1');

%fold-3
model3=svmtrain(double(IC_f3_train_label),double(IC_f3_train_feature),'-c 0.06 -g 0.05 -b 1');
[predictions_f3,accuracy3,dec_values3]=svmpredict(double(IC_f3_test_label),double(IC_f3_test_feature),model3,'-b 1');

%fold-4
model4=svmtrain(double(IC_f4_train_label),double(IC_f4_train_feature),'-c 0.5 -g 0.3 -b 1');
[predictions_f4,accuracy4,dec_values4]=svmpredict(double(IC_f4_test_label),double(IC_f4_test_feature),model4,'-b 1');

%fold-5
model5=svmtrain(double(IC_f5_train_label),double(IC_f5_train_feature),'-c 0.5 -g 0.09 -b 1');
[predictions_f5,accuracy5,dec_values5]=svmpredict(double(IC_f5_test_label),double(IC_f5_test_feature),model5,'-b 1');


[ACC,SN,SP,PPV,NPV,F1,MCC] = roc1(predictions_f1,IC_f1_test_label);
aa = [ACC,SN,SP,PPV,NPV,F1,MCC];
[ACC,SN,SP,PPV,NPV,F1,MCC] = roc1(predictions_f2,IC_f2_test_label);
bb = [ACC,SN,SP,PPV,NPV,F1,MCC];
[ACC,SN,SP,PPV,NPV,F1,MCC] = roc1(predictions_f3,IC_f3_test_label);
cc = [ACC,SN,SP,PPV,NPV,F1,MCC];
[ACC,SN,SP,PPV,NPV,F1,MCC] = roc1(predictions_f4,IC_f4_test_label);
dd = [ACC,SN,SP,PPV,NPV,F1,MCC];
[ACC,SN,SP,PPV,NPV,F1,MCC] = roc1(predictions_f5,IC_f5_test_label);
ee = [ACC,SN,SP,PPV,NPV,F1,MCC];
R=[];
R=[aa;bb;cc;dd;ee];  