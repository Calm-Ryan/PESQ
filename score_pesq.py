from scipy.io import wavfile
from pesq import pesq
import glob
import sys

ref_path = sys.argv[1]
deg_path = sys.argv[2]
ref_path_list = glob.glob(f"{ref_path}*")
deg_path_list = glob.glob(f"{deg_path}*")

ref_path_list.sort()
deg_path_list.sort()
score = []
for i in range(len(ref_path_list)):
    rate, ref = wavfile.read(ref_path_list[i])
    rate, deg = wavfile.read(deg_path_list[i])

    score.append(pesq(rate, ref, deg, 'wb'))

print("=====================================")
print("PESQ Avarage :", sum(score)/len(score))
print("=====================================")