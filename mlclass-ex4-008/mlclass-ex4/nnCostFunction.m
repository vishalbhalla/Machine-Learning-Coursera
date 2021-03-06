function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

a1 = [ones(m, 1) X];
z2 = a1*Theta1';
interHypoX = sigmoid(z2);
a2 = [ones(m, 1) interHypoX];
z3 = a2*Theta2';
HypoX = sigmoid(z3);

sizeY = size(y,1);  
newY = [];
for k = 1:sizeY;
    classLabel = y(k);
    vectorY = zeros(1,num_labels);
    vectorY(classLabel) = 1;
    newY = [newY ; vectorY];
end;
          
a = log(HypoX);
J1Term = -1 * newY.* a;
b = log(1 - HypoX);
J2Term = (1-newY).* b;
interJ = J1Term - J2Term;
J = sum(sum(interJ));

J = (1/m) * J;

% Regularized Cost Function Components for Theta1 and Theta2
regJTheta1 = sum(sum(Theta1.^2)) - sum(Theta1(:,1).^2);
regJTheta2 = sum(sum(Theta2.^2)) - sum(Theta2(:,1).^2);
J = J + (lambda/(2*m)) *(regJTheta1 + regJTheta2);


% Backpropagation algorithm for (unregularized) neural network cost function
Delta3 = HypoX - newY;
Theta2Del = Theta2(:,2:end);
Delta2 = (Delta3*Theta2Del).*sigmoidGradient(z2);

% Regularized Backpropagation Components for Theta1 and Theta2
sizeT1 = size(Theta1,1);
Theta1(:,1) = zeros(sizeT1, 1);
sizeT2 = size(Theta2,1);
Theta2(:,1) = zeros(sizeT2, 1);
Theta1_grad = Delta2' * a1 + lambda * Theta1;
Theta2_grad = Delta3' * a2 + lambda * Theta2;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

% Backpropagation algorithm for (unregularized) neural network cost function
grad = grad./m;

end
