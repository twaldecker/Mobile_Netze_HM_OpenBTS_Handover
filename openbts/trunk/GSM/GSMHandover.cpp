/* OpenBTS Handover */

#include "GSMHandover.h"
#include "GSMConfig.h"

#include <iostream>

using namespace std;

namespace GSM {

/* Identify the meassurement results by SACCH and store them */
void GSMHandoverDecision::switchMeasurement(SACCHLogicalChannel const& sACCHLogicalChannel, L3MeasurementResults const& l3MeasurementResults) {
  unsigned int tslot = sACCHLogicalChannel.TN();
  indexed_storage::iterator i = measurementSlots.find(tslot);
  if(measurementSlots.end()==i)
  {
	measurementSlots.insert(make_pair(tslot,GSMMeasurementStorage(sACCHLogicalChannel, l3MeasurementResults)));
    return;
  }
  i->second.addMeasurementResult(l3MeasurementResults);
}

/* Constructor for storage class */
GSMMeasurementStorage::GSMMeasurementStorage(SACCHLogicalChannel const&  sACCHLogicalChannel, L3MeasurementResults const& l3MeasurementResults)
  : log()
  , cSACCH(sACCHLogicalChannel)
  , measurementResults(l3MeasurementResults)
{}

/* Add new result and perform handover logic */
void GSMMeasurementStorage::addMeasurementResult(L3MeasurementResults const& m) {
  /* Info output */
  if(log++%200) {
  cout
       << "MEAS VALID: " << m.MEAS_VALID()
	   << ", RXLEVEL_dBm: " << m.RXLEV_FULL_SERVING_CELL_dBm()
	   << ", RXLEVEL_SUB_dBm" << m.RXLEV_SUB_SERVING_CELL_dBm()
	   << ", RXQUAL_BER: " << m.RXQUAL_FULL_SERVING_CELL_BER()
	   << ", RXQUAL_SUB_BER: " << m.RXQUAL_SUB_SERVING_CELL_BER()
	   << ", NO_NCELL: " << m.NO_NCELL();
  if(m.NO_NCELL() == 1)
	  cout << ", RXLEV_NCELL_dBm: " << m.RXLEV_NCELL((unsigned int) 0)
		   << ", BCCH_FREQ_NCELL: " << m.BCCH_FREQ_NCELL((unsigned int) 0);
  cout << endl;
  }
  cout << "Descriptive String: " << this->cSACCH.descriptiveString() << endl;
  /* gBTS.TCHPool returns a vector */
  TCHList chList = gBTS.TCHPool();
  /* use channel information (ARFCN and TN) and TCHList to identify oldTCH */
  TCHFACCHLogicalChannel* oldTCH;
  TCHList::iterator it = chList.begin();
  while(it != chList.end()) {
	  oldTCH = *it;
	  if( (oldTCH->ARFCN() == this->cSACCH.ARFCN()) && (oldTCH->TN() == this->cSACCH.TN()) ) {
		  break;
		  cout << "oldTCH found at ARFCN: " << oldTCH->ARFCN() << "Timeslot: " << oldTCH->TN() << endl;
	  }
	  it++;
  }
  //this->performHandover(*oldTCH);
}

void GSMMeasurementStorage::performHandover(TCHFACCHLogicalChannel & oldTCH) {
  cout << "performHandover" << endl;
  /* alloc new TCH */
  //TCHFACCHLogicalChannel* newTCH = gBTS.getTCH();/* send handover command via oldTCH (FACCH) */
  /* search for connection counterpart of oldTCH and connect to newTCH */

  /* send handover command via oldTCH (FACCH) */

  /* release oldTCH */
  oldTCH.send(GSM::RELEASE);
}

}
