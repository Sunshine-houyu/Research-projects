%% 淘个代码 %%
% 2023/09/15 %
%微信公众号搜索：淘个代码
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fMin , bestX,bestidx,Convergence_curve ]= OCSSA(pop, M,c,d,dim,fobj,da)

P_percent = 0.2;    % The population size of producers accounts for "P_percent" percent of the total population size
pNum = round( pop *  P_percent );    % The population size of the producers
lb= c.*ones( 1,dim );    % Lower limit/bounds/     a vector
ub= d.*ones( 1,dim );    % Upper limit/bounds/     a vector
%Initialization
numm = 2;% 10种混沌映射类型选择，1-10分别为，tent、Logistic、Cubic、chebyshev、Piecewise、sinusoidal、Sine,ICMIC, Circle,Bernoulli

x = repmat(lb,pop,1)+chaos(numm,pop,dim).* repmat((ub-lb),pop,1);%这里选择2，为Logistic混沌映射

for i = 1 : pop
    
     [fit( i ),idx(i)]= fobj( x( i, : ),da) ;
end
pFit = fit;
pX = x;                            % The individual's best position corresponding to the pFit
[ fMin, bestI ] = min( fit );      % fMin denotes the global optimum fitness value
bestX = x( bestI, : );             % bestX denotes the global optimum position corresponding to fMin
bestidx = idx(bestI);
% Start updating the solutions.
for t = 1 : M
    [ ans, sortIndex ] = sort( pFit );% Sort.
    [fmax,B]=max( pFit );
    worse= x(B,:);
    % 由于要加入鱼鹰算法，所以要先将鱼鹰算法需要的参数准备好
    FP = pFit(sortIndex(1:pNum));
    XP = x(sortIndex(1:pNum));
    r2=rand(1);
    if(r2<0.8)
        for i = 1 : pNum                                                   % Equation (3)
            %             这里就是挑一个比较好的鱼鹰，selected_fish就是挑好的
            fish_position=find(FP<FP(i));% Eq(4)
            if size(fish_position,2)==0
                selected_fish=FP(1);
            else
                if rand <0.5
                    selected_fish=FP(1);
                else
                    k=randperm(size(fish_position,2),1);
                    selected_fish=XP(fish_position(k));
                end
            end
            %
            I=round(1+rand);
            x( sortIndex(i),:)=x(sortIndex(i),:)+rand(1,1).*(selected_fish-I.*x(sortIndex(i),:));%Eq(5)
            x( sortIndex( i ), : ) = Bounds( x( sortIndex( i ), : ), lb, ub );
            
             [fit(sortIndex(i)),idx(sortIndex(i)) ]= fobj( x( sortIndex( i ), : ),da);
        end
    else
        for i = 1 : pNum
            x( sortIndex( i ), : ) = pX( sortIndex( i ), : )+randn(1)*ones(1,dim);
            x( sortIndex( i ), : ) = Bounds( x( sortIndex( i ), : ), lb, ub );
            
             [fit(sortIndex(i)),idx(sortIndex(i)) ]= fobj( x( sortIndex( i ), : ),da);
        end
    end
    
    
    [ fMMin, bestII ] = min( fit );
    bestXX = x( bestII, : );
    % Transformed into standard Cauchy distribution distribution
    pd = makedist('tLocationScale','mu',0,'sigma',1,'nu',1);
    rr = random(pd,length(( pNum + 1 ) : pop),1);    %Generate 1 Cauchy random number
    for i = ( pNum + 1 ) : pop                     % Equation (4)
        x( sortIndex(i ), : )=   bestXX+ rr(i-pNum)*bestXX;
        x( sortIndex( i ), : ) = Bounds( x( sortIndex( i ), : ), lb, ub );
       
         [fit(sortIndex(i)),idx(sortIndex(i)) ]= fobj( x( sortIndex( i ), : ),da);
    end
    
    
    c=randperm(numel(sortIndex));
    b=sortIndex(c(1:20));
    
    for j =  1  : length(b)      % Equation (5)
        if( pFit( sortIndex( b(j) ) )>(fMin) )
            x( sortIndex( b(j) ), : )=bestX+(randn(1,dim)).*(abs(( pX( sortIndex( b(j) ), : ) -bestX)));
        else
            x( sortIndex( b(j) ), : ) =pX( sortIndex( b(j) ), : )+(2*rand(1)-1)*(abs(pX( sortIndex( b(j) ), : )-worse))/ ( pFit( sortIndex( b(j) ) )-fmax+1e-50);
        end
        x( sortIndex(b(j) ), : ) = Bounds( x( sortIndex(b(j) ), : ), lb, ub );
        
        [fit(sortIndex( b(j) )),idx(sortIndex( b(j) )) ]= fobj( x( sortIndex( b(j) ), : ),da);
    end
    for i = 1 : pop
        if ( fit( i ) < pFit( i ) )
            pFit( i ) = fit( i );
            pX( i, : ) = x( i, : );
        end
        if( pFit( i ) < fMin )
            fMin= pFit( i );
            bestX = pX( i, : );
            bestidx = idx(i);
        end
    end
    Convergence_curve(t)=fMin;
    disp(['   第',num2str(t),'次适应度值为：',num2str(fMin),',最优值alpha：',num2str(fix(bestX(1))),',K：',num2str(fix(bestX(2))),',最佳IMF分量对应索引值：',num2str(bestidx)])
end


% Application of simple limits/bounds
function s = Bounds( s, Lb, Ub)
% Apply the lower bound vector
temp = s;
I = temp < Lb;
temp(I) = Lb(I);

% Apply the upper bound vector
J = temp > Ub;
temp(J) = Ub(J);
% Update this new move
s = temp;

%---------------------------------------------------------------------------------------------------------------------------
