clear
delete(gcp('nocreate'))

length = 5    % length of chessboard
width  = 6     % width of chessboard

px = 1        % starting coordinates
py = 1

w = 6         % number of parpool workers


x = 2 + px;
y = 2 + py;

Field2 = zeros(width, length);

Field = zeros(width + 4, length + 4,w);

Field(1:2,1:length+4,:) = NaN;
Field(width+3:width+4, 1:length+4,:) = NaN;

Field(1:width+4, 1:2,:) = NaN;
Field(1:width+4, length+3:length+4,:) = NaN;

Field(x(1),y(1),:) = 1;

posmoves = zeros(1,w);

for j = 1:2

    posmoves(j+1,:) = zeros(1,w);
    posmoves2 = [];

    kx = 0;

    for k = 1:w

        if w == size(unique(posmoves2.', 'rows').',2) , break, end

        kx = ind2sub(size(posmoves), find(posmoves(j,:) == posmoves(j,k)));

        kx = max(kx(kx-k<0));

        %kx = max(ind2sub(size(kx), find(kx-k<0)))


        [posmoves(j+1,k)] = Zugtest(Field(:,:,k),posmoves(j+1,kx));

        if isnan(posmoves(j+1,k))
            f = errordlg('Not solvable with these boundary conditions','Error');
            error('Not solvable with these boundary conditions')
        end

        [Field(:,:,k)] = Zugaus(Field(:,:,k),posmoves(j+1,k));

        posmoves2(:,k) = posmoves(:,k) ;

    end

    if w == size(unique(posmoves2.', 'rows').',2) , break, end

end

Field3 = Field
posmoves


parpool(w)

parfor c = 1:w 

    Field = Field3(:,:,c)
    j = max(max(Field));
    p = 1;
    
    kmin = ones(1,j);
    moves = zeros(1,j);
    x = 1, y = 1
    
    for i = 1:j
        [x(i),y(i)] = ind2sub(size(Field), find(Field==i))
    end
    
    
    while j <= (length*width)-1
    
    
        [Field,moves(j),status] = Zug(Field,kmin(j));
    
        if status == 0
    
            p = p+1;
            Field(x(j),y(j)) = 0;
            j = j-1;
    
            if j == 0
                f = errordlg('Not solvable with these boundary conditions','Error');
                error('Not solvable with these boundary conditions')
                break
            end
    
            kmin(j) = moves(j)+1;
    
        else
    
            [x(j+1),y(j+1)] = ind2sub(size(Field), find(Field==j+1));
            kmin(j+1) = 1;
            j = j+1;
    
        end
    
        if p > 10^7, break, end
    
    end
    
    Field2(:,:,c) = Field(3:2+width, 3:2+length);

end

for k = 1:w, if min(min(Field2(:,:,k))) ~= 0 , disp(Field2(:,:,k)), end ,end


delete(gcp('nocreate'))

function [Field,k,status] = Zug(Field,kmin)

    status = 1;
    [x,y] = ind2sub(size(Field), find(Field==max(max(Field))));

    for k = kmin:9

        switch k

            case 1
                if Field(x+1,y+2) == 0
                    Field(x+1,y+2) = Field(x,y)+1;
                    break

                end

            case 2
                if Field(x+2,y+1) == 0
                    Field(x+2,y+1) = Field(x,y)+1;
                    break

                end

            case 3
                if Field(x+2,y-1) == 0
                    Field(x+2,y-1) = Field(x,y)+1;
                    break

                end

            case 4
                if Field(x+1,y-2) == 0
                    Field(x+1,y-2) = Field(x,y)+1;
                    break

                end

            case 5
                if Field(x-1,y-2) == 0
                    Field(x-1,y-2) = Field(x,y)+1;
                    break

                end

            case 6
                if Field(x-2,y-1) == 0
                    Field(x-2,y-1) = Field(x,y)+1;
                    break

                end

            case 7
                if Field(x-2,y+1) == 0
                    Field(x-2,y+1) = Field(x,y)+1;
                    break

                end

            case 8
                if Field(x-1,y+2) == 0
                    Field(x-1,y+2) = Field(x,y)+1;
                    break

                end

            case 9
                status = 0;
        end
    end

end

function [k] = Zugtest(Field,kx)

    if size(kx) == [1,0] , kx=0 ; end

    [x,y] = ind2sub(size(Field), find(Field==max(max(Field))));

    for k = circshift(1:9,-kx)

        switch k

            case 1
                if Field(x+1,y+2) == 0
                   return
                end

            case 2
                if Field(x+2,y+1) == 0
                   return
                end

            case 3
                if Field(x+2,y-1) == 0
                   return
                end

            case 4
                if Field(x+1,y-2) == 0
                   return
                end

            case 5
                if Field(x-1,y-2) == 0
                   return
                end

            case 6
                if Field(x-2,y-1) == 0
                   return
                end

            case 7
                if Field(x-2,y+1) == 0
                   return
                end

            case 8
                if Field(x-1,y+2) == 0
                   return
                end

        end
    end

    k = NaN ;

end

function [Field] = Zugaus(Field,k)

    [x,y] = ind2sub(size(Field), find(Field==max(max(Field))));

        switch k

            case 1
                if Field(x+1,y+2) == 0
                    Field(x+1,y+2) = Field(x,y)+1;

                end

            case 2
                if Field(x+2,y+1) == 0
                    Field(x+2,y+1) = Field(x,y)+1;

                end

            case 3
                if Field(x+2,y-1) == 0
                    Field(x+2,y-1) = Field(x,y)+1;

                end

            case 4
                if Field(x+1,y-2) == 0
                    Field(x+1,y-2) = Field(x,y)+1;

                end

            case 5
                if Field(x-1,y-2) == 0
                    Field(x-1,y-2) = Field(x,y)+1;

                end

            case 6
                if Field(x-2,y-1) == 0
                    Field(x-2,y-1) = Field(x,y)+1;

                end

            case 7
                if Field(x-2,y+1) == 0
                    Field(x-2,y+1) = Field(x,y)+1;

                end

            case 8
                if Field(x-1,y+2) == 0
                    Field(x-1,y+2) = Field(x,y)+1;

                end

        end
    end
