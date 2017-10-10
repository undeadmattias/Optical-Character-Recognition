function [hitrate,confmat,allres,alljs,alljfg,allX,allY]=benchmark_inl3(mysystem,datadir,mode);

%% modes
% mode = 0 means no debug plots. This is fastest.
% mode = 1 means debug plot of the union of the segmentations
% mode = 2 means debug plots of each individual segmentation.
if nargin<3,
    mode = 2;
end

%keyboard;
thispath = pwd;
nbr_correct = 0;
nbr_char = 0;
alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
alen = length(alfabet);
confmat = zeros(alen,alen);
if mode>0,
    figure(1);
    clf;
end
alljs = [];
alljfg = [];
allres = [];
allX = [];
allY = [];
jj = 0;

a = dir(datadir);
for ii=1:length(a);
    [path,name,ext] = fileparts([datadir filesep a(ii).name]);
    if strcmp(ext,'.jpg'),
        % Found an image
        fname = name;
        
        % Read ground truth
        fid = fopen([datadir filesep fname '.txt'],'r');
        facit = fgetl(fid);
        fclose(fid);
        % Read ground truth segmentation
        gtdata = load([datadir filesep fname '.mat']);
        % Read image
        im = double((imread([datadir filesep fname ext])));
        
        %keyboard;
        % segment image and check that the segmentation function exist
        try
            S = feval(mysystem.segmenter,im);
        catch
            disp(['There was an error when I tried to run ' mysystem.segmenter]);
            blubb = exist(mysystem.segmenter);
            if blubb == 2,
                disp('The function seems to exist');
            elseif blubb == 0
                disp('The function does not exist');
            else
                disp('This is strange. There is no such function, but there is something else with this name');
            end
            error(['There was an error when I tried to run ' mysystem.segmenter]);
        end
        nrofsegments = length(S);
        
        % Calculate total foreground of system
        FG_system = zeros(size(im));
        for kk = 1:nrofsegments
            if all(size(S{kk}) == size(im)),
                FG_system = FG_system | S{kk};
            else
                disp('There is something wrong with the size of the output');
                disp('Each segment S{k} should have the same size as the original image.');
                break
            end
        end
        
        % Calculate total foreground of ground truth
        FG_gt = zeros(size(im));
        for kk = 1:length(gtdata.S)
            FG_gt = FG_gt | gtdata.S{kk};
        end
        
        % Total segmentation error
        % Use Jaccard index
        jfg = sum(sum(FG_gt & FG_system)) / sum(sum(FG_gt | FG_system));
        
        % Individual segmentation error
        % Use Jaccard index
        js = zeros(1,length(facit));
        for k = 1:min(length(S),length(gtdata.S)),
            js(k)= sum(sum(S{k} & gtdata.S{k} )) / sum(sum(S{k} | gtdata.S{k}));
        end
        
        %% Extract features from the ground truth segments
        alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        ialfabet = zeros(1,255);
        for kk = 1:length(alfabet);
            ialfabet(abs(alfabet(kk)))=kk;
        end
        for kk = 1:length(gtdata.S);
            jj = jj+1;
            %[ii kk jj]
            %keyboard;
            allY(1,jj)=ialfabet(gtdata.facit(kk));
            try
                XX = feval(mysystem.features,gtdata.S{kk});
            catch
                blubb = exist(mysystem.segmenter,'kind'),
                if blubb == 2,
                    disp('The function seems to exist');
                elseif blubb == 0
                    disp('The function does not exist');
                else
                    disp('This is strange. There is no such function, but there is something else with this name');
                end
                error(['There was an error when I tried to run ' mysystem.features]);
            end
            allX(:,jj)=XX;
        end
        
        clear f;
        for kk = 1:nrofsegments;
            f(:,kk)=feval(mysystem.features,S{kk});
        end

        %%
        % classify
        for kk = 1:nrofsegments;
            y(1,kk) = feval(mysystem.classifier,f(:,kk),mysystem.classification_data);
            guess(1,kk)=alfabet(y(1,kk));
        end
        
        if length(guess)<length(facit);
            guess = [guess 'A'*ones(1,length(facit)-length(guess))];
        end;
        
        %Individual interpretation error
        thisres = guess(1:length(facit))==facit;
        
        
        %% Plot the result
        if mode>=2,
            NN = min(length(gtdata.S),length(S));
            figure(1); clf
            %subplot(2,NN,1);
            %colormap(gray);
            %imagesc(im);
            for kk = 1:NN,
                subplot(3,1,1);
                colormap(gray);
                imagesc(im);
                title(['Original Image: ' name ]);
                subplot(3,1,2);
                tmp = S{kk};
                ii = find(sum(tmp));
                %xmin = min(ii)-4;
                %xmax = max(ii)+4;
                %imagesc(tmp(1:(min(40,size(tmp,1))),xmin:xmax))
                imagesc(tmp);
                title(['System Segmentation. Score: ' num2str(js(kk))]);
                subplot(3,1,3);
                tmp = gtdata.S{kk};
                ii = find(sum(tmp));
                %xmin = min(ii)-4;
                %xmax = max(ii)+4;
                %imagesc(tmp(1:(min(40,size(tmp,1))),xmin:xmax))
                imagesc(tmp);
                title(['Ground truth. Image: ' name ' Segment nr: ' num2str(kk) ' Classifed as 'guess(kk) ]);
                pause;
            end
        end;
        
        %% Also plot for whole foreground
        if mode >=1
            subplot(3,1,1);
            colormap(gray);
            imagesc(im);
            title(['Original Image: ' name ]);
            subplot(3,1,2);
            imagesc(FG_system);
            title(['System Segmentation. Score: ' num2str(jfg)]);
            subplot(3,1,3);
            imagesc(FG_gt);
            title(['Ground truth. Image: ' name ' Union of all segments. Classifed as ' guess]);
            pause(0.2);
        end;
        
        %%
        % Build up the confusion matrix
        for kkk = 1:length(facit);
            fi = find(alfabet==facit(kkk));
            gi = find(alfabet==guess(kkk));
            confmat(fi,gi)=confmat(fi,gi)+1;
        end;
        nbr_correct = nbr_correct+sum(thisres);
        nbr_char = nbr_char + length(facit);
        alljs = [alljs;js];
        alljfg = [alljfg;jfg];
        allres = [allres;thisres];
        
        
        %%
        alljs = [alljs;js];
        alljfg = [alljfg;jfg];
        pause(0.2);
    end,
end,

hitrate = nbr_correct/nbr_char;

cd(thispath);
