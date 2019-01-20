// Copyright (c) 2012-2017, The CryptoNote developers, The Bytecoin developers
//
// This file is part of Bytecoin.
//
// Bytecoin is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Bytecoin is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with Bytecoin.  If not, see <http://www.gnu.org/licenses/>.

#pragma once

#include <cstddef>
#include <initializer_list>

namespace CryptoNote {
struct CheckpointData {
  uint32_t index;
  const char* blockId;
};
  
const std::initializer_list<CheckpointData> CHECKPOINTS = {
{          0, "22fba2b21c776e6171e1045834cc2187d75901d1983c7a9d6a37f296d1b3830e"},	
{       2500, "67d1e8569e2f40692882032c28c76c94a073ba9822ad09603940ca91d9ac21c3"},
{       5000, "c9c02f4950a39d5bc0197adacf2dbb2bb5130442f00d0e3fb30cbe17e50bfe8a"},
{       7500, "bc819dfcbf84ed330af14bb6bf2975f30752fb3ea159a69b56cbe22056e301fa"},
{      10000, "f2b6469dcaadb7e45964dae43029c24a0fcf6d350abcaad157f7a93b72caaa70"},
{      15000, "7f5ef57a562b7548b43c1d2d6ea91f07ebc603ed99c41708c82175ee92199dd2"},
{      20000, "0dce615cf72be169ade296a7207c4b3134e8764fe086e3b8f6d11a8fa4542735"},
{     203823, "7ecaebd8f78ed303d093a2039db4e9e0249f003239b869508cc17380dd95891f"},
{     430124, "017d600ac6ed3111621e1387a0d02e8052a29905c5ae263607911bbf30ee0fd1"}
};
}
