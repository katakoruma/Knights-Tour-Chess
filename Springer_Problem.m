clear

length = 5    % length of chessboard
width  = 5     % width of chessboard

px = 1        % starting coordinates
py = 1

x = 2 + px;
y = 2 + py; 


Field = zeros(width + 4, length + 4);

Field(1:2,1:length+4) = NaN;
Field(width+3:width+4, 1:length+4) = NaN;

Field(1:width+4, 1:2) = NaN;
Field(1:width+4, length+3:length+4) = NaN;

Field(x(1),y(1)) = 1;

kmin(1) = 1;

j = 1;
p = 1;

while j <= (length*width)-1


    [Field,moves(j),status] = Zug(Field,x(j),y(j),kmin(j));

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

end

disp(Field(3:2+width, 3:2+length))

function [Field,k,status] = Zug(Field,x,y,kmin)

    status = 1;

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
