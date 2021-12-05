% Arnoldi process
function [Vm,Hm_bar] = Arnoldi(A,b,x0,restart_m)
% Input: restartm is the restart parameter
    
%     [size_of_A, ~] = size(A);
%     R = Inf(size_of_A,size_of_A);
%     H = zeros(size_of_A+1,size_of_A);V = zeros(size_of_A,size_of_A+1);%A*V=V*H
    
    [size_of_A, ~] = size(A);
    R = Inf(restart_m,1);
    H = zeros(restart_m+1,restart_m);V = zeros(size_of_A,restart_m+1);%A*V=V*H

    % v1 = r0./norm(r0)
    r0 = b-A*x0;
    beta = norm(r0);
    V(:,1) = r0./beta;
    for j = 1:restart_m
        R = A*V(:,j);
        for i = 1:j
            H(i,j) = R'*V(:,i);
            R = R - H(i,j)*V(:,i);
        end
        H(j+1,j) = norm(R);
        if abs(H(j+1,j)) < 1e-10
            sprintf('done without residual');%Real m is the real m generated by H(j+1,j) = 0. 
            break;
        else
            V(:,j+1) = R./H(j+1,j);
        end
    end
    % resize H to Hm_bar and V to Vm.
    Hm_bar = H(1:j+1,1:j);
    Vm = V(:,1:j);
end

