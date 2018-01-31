from mpi4py import MPI
import numpy as np
from netCDF4 import Dataset
rank = MPI.COMM_WORLD.rank
nc = Dataset('parallel_tst.nc','w',parallel=True)
d = nc.createDimension('dim',MPI.COMM_WORLD.Get_size())
v = nc.createVariable('var', np.int, 'dim')
v[rank] = rank
nc.close()
