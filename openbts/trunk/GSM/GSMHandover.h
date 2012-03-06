/*
* Copyright 2008, 2010 Free Software Foundation, Inc.
* Copyright 2012 Handover Action Group Inc.
*
* This software is distributed under the terms of the GNU Affero Public License.
* See the COPYING file in the main directory for details.
*
* This use of this software may be subject to additional restrictions.
* See the LEGAL file in the main directory for details.

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#ifndef GSMHANDOVER_H
#define GSMHANDOVER_H

#include "GSML3RRElements.h"
#include "GSMLogicalChannel.h"
#include <map>

namespace GSM {

class GSMHOActiveCalls {
  private:
	unsigned int count;
	SACCHLogicalChannel cSACCH;
	L3MeasurementResults measRes;
  public:
	GSMHOActiveCalls(SACCHLogicalChannel const&, L3MeasurementResults const&);
	void addMeasRes(L3MeasurementResults const&);
	bool decideHandover(void);
	TCHFACCHLogicalChannel* allocNewTCH(void);
	void performHandover(TCHFACCHLogicalChannel &);
};

class GSMHandover {
  private:
	typedef std::map<unsigned int, GSMHOActiveCalls> ixCallStorage;
	ixCallStorage ixCallSlots;
  public:
    void storeMeasRes(SACCHLogicalChannel const& , L3MeasurementResults const&);
};
}
extern GSM::GSMHandover gHandover;

#endif // GSMHANDOVER_H
