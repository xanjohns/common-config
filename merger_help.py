#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier:	ISC
import sys;
import json;
import os;
json_arr = json.load(sys.stdin)
for val in json_arr:
    url = val['clone_url']
    os.system("gh repo fork {} --clone".format(url))
