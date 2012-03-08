/* OpenBTS Handover */

#include "GSMHandover.h"
#include "GSMConfig.h"

#include <iostream>

using namespace std;

namespace GSM {

/* Identify the measurement results by the SACCH and store them */
void GSMHandover::storeMeasRes(SACCHLogicalChannel const& cSACCH, L3MeasurementResults const& measRes) {
  unsigned int tSlot = cSACCH.TN();
  ixCallStorage::iterator it = ixCallSlots.find(tSlot);
  if(it == ixCallSlots.end())
  {
	  ixCallSlots.insert(make_pair(tSlot,GSMHOActiveCalls(cSACCH, measRes)));
    return;
  }
  it->second.addMeasRes(measRes);
}

GSMHOActiveCalls::GSMHOActiveCalls(SACCHLogicalChannel const&  cSACCH, L3MeasurementResults const& measRes)
  : count()
  , cSACCH(cSACCH)
  , measRes(measRes)
{}

void GSMHOActiveCalls::addMeasRes(L3MeasurementResults const& measRes) {
/* Info output */
  if(count++%1000) {
	  cout
           << "MEAS VALID: " << measRes.MEAS_VALID()
           << ", RXLEVEL_dBm: " << measRes.RXLEV_FULL_SERVING_CELL_dBm()
           << ", RXLEVEL_SUB_dBm" << measRes.RXLEV_SUB_SERVING_CELL_dBm()
           << ", RXQUAL_BER: " << measRes.RXQUAL_FULL_SERVING_CELL_BER()
           << ", RXQUAL_SUB_BER: " << measRes.RXQUAL_SUB_SERVING_CELL_BER();
	  if(measRes.NO_NCELL() == 1)
		  cout << ", RXLEV_NCELL_dBm: " << measRes.RXLEV_NCELL((unsigned int) 0)
			   << ", BCCH_FREQ_NCELL: " << measRes.BCCH_FREQ_NCELL((unsigned int) 0);
	  cout << endl;

	  /* Make a decision and perform the handover */
	  if(this->decideHandover()) {
		  TCHFACCHLogicalChannel* newTCH = this->allocNewTCH();
		  this->performHandover(*newTCH);
	  }
  }
}

/* FIESER HACK */
bool GSMHOActiveCalls::decideHandover() {
	if(!system("ls | grep doit")) {
		system("rm doit");
		return true;
	}
	return false;
}

TCHFACCHLogicalChannel* GSMHOActiveCalls::allocNewTCH() {
  TCHFACCHLogicalChannel *newTCH = gBTS.getTCH();
  return newTCH;
}

void GSMHOActiveCalls::performHandover(TCHFACCHLogicalChannel & newTCH) {
/* Search for oldTCH */
  /* gBTS.TCHPool returns a vector */
  TCHList chList = gBTS.TCHPool();
  /* use channel timeslot information (TN) and TCHList to identify oldTCH */
  TCHFACCHLogicalChannel *oldTCH;
  TCHList::iterator it = chList.begin();
  while(it != chList.end()) {
    oldTCH = *it;
    if( (oldTCH->ARFCN() == this->cSACCH.ARFCN()) && (oldTCH->TN() == this->cSACCH.TN()) )
    	break;
    it++;
  }
/* switch SIP connection from oldTCH to newTCH */

/* send handover command via oldTCH (FACCH) */
  cout << "sending HandoverCommand" << endl;
  oldTCH->send(GSM::L3HandoverCommand(newTCH.channelDescription(),GSM::L3ChannelMode(GSM::L3ChannelMode::SpeechV1)));
/* release oldTCH */
  oldTCH->send(GSM::RELEASE);
}

}
