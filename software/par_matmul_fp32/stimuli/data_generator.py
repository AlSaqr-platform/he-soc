
#!/bin/python3

# Run it by:
# ./data_generator.py --M=m --N=n --P=p --float_type=fmt --MAC_flag=true
# The script will generate three floating-point matrices fo format fmt (FP32/FP16/FP16ALT):
#


import os
import argparse
import sys

import torch
from torch import nn


def relative_absolute_error(true, pred):
    true_mean = torch.mean(true)
    squared_error_num = torch.sum(torch.abs(true - pred))
    squared_error_den = torch.sum(torch.abs(true - true_mean))
    rae_loss = squared_error_num / squared_error_den
    return rae_loss


def mean_squared_error(true, pred):
    squared_error = torch.square(true - pred)
    sum_squared_error = torch.sum(squared_error)
    size = true.size(dim=0) * true.size(dim=1)
    mse_loss = sum_squared_error / size
    return mse_loss


def matrix_init(IN, dt):
    temp = torch.zeros((IN.shape[0], IN.shape[1]), dtype=dt)
    # iterate through rows of IN
    for i in range(IN.shape[0]):
        # iterate through columns of IN
        for j in range(IN.shape[1]):
            temp[i][j] = IN[i][j]
    return temp


def error_metric(ref, res):

    # calculate manually because metrics doesn't supprt bfloat16
    d = ref - res
    mse_f = torch.mean(d**2)
    mae_f = torch.mean(abs(d))
    rmse_f = torch.sqrt(mse_f)
    r2_f = 1-(torch.sum(d**2)/torch.sum((ref-torch.mean(ref))**2))
    print("Results of metrics:")
    print("MAE:",mae_f.item())
    print("MSE:", mse_f.item())
    print("RMSE:", rmse_f.item())
    print("R-Squared:", r2_f.item())
    rae = relative_absolute_error(ref, res)
    print("RAE is", rae.item())


def matrix_mult(Xs, Ys, dt, mac_flag, cast_flag, cast_to):
    Rs = torch.zeros((Xs.shape[0], Ys.shape[1]), dtype=dt)
    # iterate through rows of X
    for i in range(Xs.shape[0]):
        # iterate through columns of Y
        for j in range(Ys.shape[1]):
            temp = torch.tensor([0], dtype=dt)
            # iterate through rows of Y
            for k in range(Ys.shape[0]):
                a = Xs[i][k]
                b = Ys[k][j]
                if cast_flag == "true":
                    if cast_to == "FP16":
                        a = a.type(torch.float16)
                        b = b.type(torch.float16)
                    elif cast_to == "FP16ALT":
                        a = a.type(torch.bfloat16)
                        b = b.type(torch.bfloat16)
                if mac_flag == "true":
                    a = a.type(torch.float32)
                    b = b.type(torch.float32)
                    temp = temp.type(torch.float32)
                temp += a * b
                if mac_flag == "true":
                    temp = temp.type(dt)

            Rs[i][j] = temp
    return Rs


def write_matrix(matrix_to_write, name, file_pointer, float_type):
    matrix_string = ''
    sz0 = matrix_to_write.size()[0]
    sz1 = matrix_to_write.size()[1]
    if 'ref' in name:
        file_pointer.write("PI_L2 OUT_TYPE %s[] = {" % name)
    elif 'A_mat' in name:
        file_pointer.write("PI_L2 MA_TYPE %s[] = {" % name)
    else:
        file_pointer.write("PI_L2 MB_TYPE %s[] = {" % name)
    if float_type == torch.float32:
        name = ")"
    elif float_type == torch.float16:
        name = ", dtype=torch.float16)"
    elif float_type == torch.bfloat16:
        name = ", dtype=torch.bfloat16)"
    for i in range(sz0):
        for j in range(sz1):
            matrix_string += str(matrix_to_write[i][j].item()).replace('tensor(', '').replace(name, '')
            matrix_string += ', '
    file_pointer.write("%s" % matrix_string)
    file_pointer.write("};\n")


def get_inital_config():
    # get arguments  and data format
    parser = argparse.ArgumentParser()
    parser.add_argument('--M')
    parser.add_argument('--N')
    parser.add_argument('--P')

    parser.add_argument('--MAC_flag', default="true")
    parser.add_argument('--float_type', default='FP32')
    args = parser.parse_args()

    M = int(args.M)
    N = int(args.N)
    P = int(args.P)
    mac_flag = str(args.MAC_flag)
    bits = args.float_type.split(",")
    return M, N, P, bits, mac_flag


def select_dtypes(user_dtypes, num_param):
    types_dict = {
        "FP32": torch.float32,
        "FP16": torch.float16,
        "FP16ALT": torch.bfloat16
    }
    dtypes = []
    if len(user_dtypes) == 1:
        for i in range(num_param):
            dtypes.append(types_dict[user_dtypes[0]])
    elif len(user_dtypes) == num_param:
        for i in range(num_param):
            dtypes.append(types_dict[user_dtypes[i]])
    else:
        for i in range(len(user_dtypes)):
            dtypes.append(types_dict[user_dtypes[i]])
        if 'FP32' in user_dtypes:
            for i in range(len(user_dtypes), num_param):
                dtypes.append(types_dict["FP32"])
        elif 'FP16' in user_dtypes:
            for i in range(len(user_dtypes), num_param):
                dtypes.append(types_dict["FP16"])
        else:
            for i in range(len(user_dtypes), num_param):
                dtypes.append(types_dict["FP16ALT"])
    return dtypes

def check_cast(datatypes):
    result = len(set(datatypes)) == 1
    if result : #All Elements in List are Equal
        return "false"
    else: #All Elements in List are Not Equal
        if torch.float32 in datatypes:
            return "false"
        else:
            return "true"

def save_data_into_hfile(M, N, P, A_mat, B_mat, res):
    # Generate header file
    f = open('data.h', 'w')
    f.write('\
#define M %s\n\
#define N %s\n\
#define P %s\n\n' % (M, N, P))
    write_matrix(A_mat, 'A_mat', f, A_mat.dtype)
    write_matrix(B_mat, 'B_mat', f, B_mat.dtype)
    write_matrix(res, 'ref', f, res.dtype)

    f.close()


def main():
    M, N, P, bits, mac_flag = get_inital_config()

    # Create reference matrices
    A_ref = torch.randn((M, N), dtype=torch.float32)
    B_ref = torch.randn((N, P), dtype=torch.float32)

    # calculate reference output
    ref = matrix_mult(Xs=A_ref, Ys=B_ref, dt=torch.float32, mac_flag=mac_flag, cast_flag="false",cast_to="false")

    # set the data types based on the parser input
    datatypes = select_dtypes(bits, 3)

    cast_flag = check_cast(datatypes[0:2])
    cast_to = "FP16ALT"
    A_mat = matrix_init(A_ref, dt=datatypes[0])
    B_mat = matrix_init(B_ref, dt=datatypes[1])

    res = matrix_mult(Xs=A_mat, Ys=B_mat, dt=datatypes[2], mac_flag=mac_flag, cast_flag=cast_flag, cast_to = cast_to)

    error_metric(ref, res)
    save_data_into_hfile(M, N, P, A_mat, B_mat, res)
    print("############################## Done! ###################################")
    return None


if __name__ == "__main__":
    main()
    pass
