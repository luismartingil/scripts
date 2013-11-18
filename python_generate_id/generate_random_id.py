#
# This file is part of random_id.
#
# random_id is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# random_id is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with random_id.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Generates a randomized id.
# 
# Author: Luis Martin Gil
#         www.luismartingil.com
# Contact:
#         martingil.luis@gmail.com
#

from random import random
from hashlib import md5
from time import time

def generate_id():
    ret = md5(str((random() * 1000000000L) + time())).hexdigest()
    return ret

if __name__ == '__main__':
    print generate_id()
