PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE CONFIG ( KEYSTRING TEXT UNIQUE NOT NULL, VALUESTRING TEXT, STATIC INTEGER DEFAULT 0, OPTIONAL INTEGER DEFAULT 0, COMMENTS TEXT DEFAULT '');
INSERT INTO "CONFIG" VALUES('CLI.Prompt','OpenBTS> ',0,0,'Prompt for the OpenBTS command line interface.');
INSERT INTO "CONFIG" VALUES('Control.Reporting.PhysStatusTable','/var/run/OpenBTSChannelTable.db',1,0,'File path for channel status reporting database.  Static.');
INSERT INTO "CONFIG" VALUES('Control.Reporting.TMSITable','/var/run/OpenBTSTMSITable.db',1,0,'File path for TMSITable database.  Static.');
INSERT INTO "CONFIG" VALUES('Control.Call.QueryRRLP.Early',NULL,0,1,'If not NULL, query every MS for its location via RRLP during the setup of a call.');
INSERT INTO "CONFIG" VALUES('Control.Call.QueryRRLP.Late',NULL,0,1,'If not NULL, query every MS for its location via RRLP during the teardown of a call.');
INSERT INTO "CONFIG" VALUES('Control.GSMTAP.TargetIP',NULL,0,1,'Target IP address for GSMTAP packets; the IP address of Wireshark, if you use it for GSM.');
INSERT INTO "CONFIG" VALUES('Control.LUR.AttachDetach',1,0,0,'Attach/detach flag.  Set to 1 to use attach/detach procedure, 0 otherwise.  This will make initial LUR more prompt.  It will also cause an un-regstration if the handset powers off and really heavy LUR loads in areas with spotty coverage.');
INSERT INTO "CONFIG" VALUES('Control.LUR.FailedRegistration.Message','Your handset is not provisioned for this network. ',0,1,'If defined, send this text message, followed by the IMSI, to unprovisioned handsets that are denied  registration.');
INSERT INTO "CONFIG" VALUES('Control.LUR.FailedRegistration.ShortCode','1000',0,1,'The return address for the failed registration message.  If the message is defined, this must also be defined.');
INSERT INTO "CONFIG" VALUES('Control.LUR.NormalRegistration.Message',NULL,0,1,'If defined, send this text message, followed by the IMSI, to provisioned handsets when they attach on Um.');
INSERT INTO "CONFIG" VALUES('Control.LUR.NormalRegistration.ShortCode','0000',0,1,'The return address for the normal registration message.  If the message is defined, this must also be defined.');
INSERT INTO "CONFIG" VALUES('Control.LUR.OpenRegistration',NULL,0,1,'If not NULL, allow unprovisioned handsets to attach in Um.');
INSERT INTO "CONFIG" VALUES('Control.LUR.OpenRegistration.Message','Welcome to the GSM test network.  Your IMSI is ',0,1,'If defined, send this text message, followed by the IMSI, to unprovisioned handsets when they attach on Um due to open registration.');
INSERT INTO "CONFIG" VALUES('Control.LUR.OpenRegistration.ShortCode','101',0,1,'The return address for the open registration message.  If the message is defined, this must also be defined.');
INSERT INTO "CONFIG" VALUES('Control.LUR.QueryClassmark',NULL,0,1,'If not NULL, query every MS for classmark during LUR.');
INSERT INTO "CONFIG" VALUES('Control.LUR.QueryIMEI',NULL,0,1,'If not NULL, query every MS for IMSI during LUR.');
INSERT INTO "CONFIG" VALUES('Control.LUR.QueryRRLP',NULL,0,1,'If not NULL, query every MS for its location via RRLP during LUR.');
INSERT INTO "CONFIG" VALUES('Control.LUR.SendTMSIs',NULL,0,1,'If not NULL, send new TMSI assignments to handsets that are allowed to attach.');
INSERT INTO "CONFIG" VALUES('Control.LUR.UnprovisionedRejectCause','0x04',0,0,'Reject cause for location updating failures for unprovisioned phones.  Reject causes come from GSM 04.08 10.5.3.6.  Reject cause 0x04, IMSI not in VLR, is usually the right one.');
INSERT INTO "CONFIG" VALUES('Control.NumSQLTries','3',0,0,'Number of times to retry SQL queries before declaring a database access failure.');
INSERT INTO "CONFIG" VALUES('Control.SMS.QueryRRLP',NULL,0,1,'If not NULL, query every MS for its location via RRLP during an SMS.');
INSERT INTO "CONFIG" VALUES('Control.TMSITable.MaxAge','72',0,0,'Maximum allowed age for a TMSI in hours.');
INSERT INTO "CONFIG" VALUES('Control.TMSITable.MaxSize','100000',0,0,'Maximum size of TMSI table before oldest TMSIs are discarded.');
INSERT INTO "CONFIG" VALUES('Control.VEA',1,0,1,'If not NULL, user very early assignment for speech call establishment.  See GSM 04.08 Section 7.3.2 for a detailed explanation of assignment types. If VEA is selected, GSM.CellSelection.NECI should be set to 1.  See GSM 04.08 Sections 9.1.8 and 10.5.2.4 for an explanation of the NECI bit.');
INSERT INTO "CONFIG" VALUES('GSM.CCCH.AGCH.QMax','5',0,0,'Maximum number of access grants to be queued for transmission on AGCH before declaring congrestion.');
INSERT INTO "CONFIG" VALUES('GSM.CCCH.CCCH-CONF','1',0,0,'CCCH configuration type.  See GSM 10.5.2.11 for encoding.  Value of 1 means we are using a C-V beacon.  Any other value selects a C-IV beacon.');
INSERT INTO "CONFIG" VALUES('GSM.CCCH.PCH.Reserve','0',0,0,'Number of CCCH subchannels to reserve for paging.');
INSERT INTO "CONFIG" VALUES('GSM.CellSelection.CELL-RESELECT-HYSTERESIS','3',0,0,'Cell Reselection Hysteresis.  See GSM 04.08 10.5.2.4, Table 10.5.23 for encoding.  Encoding is $2N$ dB, values of $N$ are 0...7 for 0...14 dB.');
INSERT INTO "CONFIG" VALUES('GSM.CellSelection.MS-TXPWR-MAX-CCH','0',0,0,'Cell selection parameters.  See GSM 04.08 10.5.2.4.');
INSERT INTO "CONFIG" VALUES('GSM.CellSelection.NCCsPermitted','1',0,0,'NCCs Permitted.  An 8-bit mask of allowed NCCs.  Unless you are coordinating with another carrier, this should probably just select your own NCC.');
INSERT INTO "CONFIG" VALUES('GSM.CellSelection.NECI','1',0,0,'NECI, New Establishment Causes.  This must be set to "1" if you want to support very early assignment (VEA).  It can be set to "1" even if you do not use VEA, so you might as well leave it as "1".  See GSM 04.08 10.5.2.4, Table 10.5.23 and 04.08 9.1.8, Table 9.9 and the Control.VEA parameter.');
INSERT INTO "CONFIG" VALUES('GSM.CellSelection.Neighbors','39 41 43',0,0,'ARFCNs of neighboring cells.');
INSERT INTO "CONFIG" VALUES('GSM.CellSelection.RXLEV-ACCESS-MIN','0',0,0,'Cell selection parameters.  See GSM 04.08 10.5.2.4.');
INSERT INTO "CONFIG" VALUES('GSM.Channels.C1sFirst',NULL,1,0,'If not NULL, allocate C-I slots first, starting at C0T1.  Otherwise, allocate C-VII slots first.  Static.');
INSERT INTO "CONFIG" VALUES('GSM.Channels.NumC1s','7',1,0,'Number of Combination-I timeslots to configure.  The C-I slot carries a single full-rate TCH, used for speech calling.  Static.');
INSERT INTO "CONFIG" VALUES('GSM.Channels.NumC7s','0',1,0,'Number of Combination-VII timeslots to configure.  The C-VII slot carries 8 SDCCHs, useful to handle high registration loads or SMS.  If C0T0 is C-IV, you must have at least one C-VII also.  Static.');
INSERT INTO "CONFIG" VALUES('GSM.Identity.BSIC.BCC','2',0,0,'GSM basestation color code; lower 3 bits of the BSIC.  BCC values in a multi-BTS network should be assigned so that BTS units with overlapping coverage do not share a BCC.  This value will also select the training sequence used for all slots on this unit.');
INSERT INTO "CONFIG" VALUES('GSM.Identity.BSIC.NCC','0',0,0,'GSM network color code; upper 3 bits of the BSIC.  Assigned by your national regulator.  Must be distinct from NCCs of other GSM operators in your area.');
INSERT INTO "CONFIG" VALUES('GSM.Identity.CI','10',0,0,'Cell ID, 16 bits.  Should be unique.');
INSERT INTO "CONFIG" VALUES('GSM.Identity.LAC','1000',0,0,'Location area code, 16 bits, values 0xFFxx are reserved.  For multi-BTS networks, assign a unique LAC to each BTS unit.  (That is not the normal procedure in conventional GSM networks, but is the correct procedure in OpenBTS networks.)');
INSERT INTO "CONFIG" VALUES('GSM.Identity.MCC','001',0,0,'Mobile country code, 2 or 3 digits.  Defined in ITU-T E.212.');
INSERT INTO "CONFIG" VALUES('GSM.Identity.MNC','01',0,0,'Mobile network code; Must be 3 dgits.  Assigned by your national regulator.');
INSERT INTO "CONFIG" VALUES('GSM.Identity.ShortName','Range',0,1,'Network short name, displayed on some phones.  Optional but must be defined if you also want the network to send time-of-day.');
INSERT INTO "CONFIG" VALUES('GSM.Identity.ShowCountry',1,0,0,'If not NULL, tell the phone to show the country name based on the MCC.');
INSERT INTO "CONFIG" VALUES('GSM.MS.Power.Damping','50',0,0,'Damping value for MS power control loop.');
INSERT INTO "CONFIG" VALUES('GSM.MS.Power.Max','33',0,0,'Maximum commanded MS power level in dBm.');
INSERT INTO "CONFIG" VALUES('GSM.MS.Power.Min','5',0,0,'Minimum commanded MS power level in dBm.');
INSERT INTO "CONFIG" VALUES('GSM.MS.TA.Damping','50',0,0,'Damping value for timing advance control loop.');
INSERT INTO "CONFIG" VALUES('GSM.MS.TA.Max','5',0,0,'Maximum allowed timing advance in symbol periods.  Ignore RACH bursts with delays greater than this.  Can be used to limit service range.');
INSERT INTO "CONFIG" VALUES('GSM.MaxSpeechLatency','2',0,0,'Maximum allowed speech buffering latency, in 20 ms frames.  If the jitter is larger than this delay, frames will be lost.');
INSERT INTO "CONFIG" VALUES('GSM.RACH.AC','1024',0,0,'Access class flags.  This is the raw parameter sent on the BCCH.  See GSM 04.08 10.5.2.29 for encoding.  Set to 0 to allow full access.  If you do not have proper PSAP integration, set to 0x0400 to indicate no support for emergency calls.');
INSERT INTO "CONFIG" VALUES('GSM.RACH.MaxRetrans','1',0,0,'Maximum RACH retransmission attempts.  This is the raw parameter sent on the BCCH.  See GSM 04.08 10.5.2.29 for encoding.');
INSERT INTO "CONFIG" VALUES('GSM.RACH.TxInteger','14',0,0,'Parameter to spread RACH busts over time.  This is the raw parameter sent on the BCCH.  See GSM 04.08 10.5.2.29 for encoding.');
INSERT INTO "CONFIG" VALUES('GSM.RADIO-LINK-TIMEOUT','15',0,0,' L1 radio link timeout.  This is the raw parameter sent on the BCCH; see GSM 10.5.2.3 for encoding. Should be coordinated with T3109.');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.ACCURACY','40',0,0,'Requested accuracy of location request. K in 10(1.1**K-1). See 3GPP 03.32, sect 6.2');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.ALMANAC.REFRESH.TIME','24.0',0,0,'How often the almanac is refreshed, in hours');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.ALMANAC.URL','http://www.navcen.uscg.gov/?pageName=currentAlmanac&format=yuma',0,0,'URL of almanac source.');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.EPHEMERIS.REFRESH.TIME','1.0',0,0,'How often the ephemeris is refreshed, in hours.');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.EPHEMERIS.URL','ftp://ftp.trimble.com/pub/eph/CurRnxN.nav',0,0,'URL of ephemeris source.');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.RESPONSETIME','4',0,0,'Mobile timeout. (OpenBTS timeout is 130 sec = max response time + 2.) N in 2**N. See 3GPP 04.31 sect A.2.2.1');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.SEED.ALTITUDE','0',0,0,'Seed altitude in meters wrt geoidal surface.');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.SEED.LATITUDE','37.8720708',0,0,'Seed latitude in degrees.  -90 (south pole) .. +90 (north pole)');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.SEED.LONGITUDE','-122.2578337',0,0,'Seed longitude in degrees.  -180 (west of greenwich) .. 180 (east)');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.SERVER.URL','http://localhost/cgi-bin/rrlpserver.cgi',0,0,'URL of RRLP server.');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.ALMANAC.ASSIST.PRESENT','0',0,0,'1=send almanac info to mobile; 0=do not');
INSERT INTO "CONFIG" VALUES('GSM.RRLP.EPHEMERIS.ASSIST.COUNT','9',0,0,'number of satellites to include in navigation model');
INSERT INTO "CONFIG" VALUES('GSM.Radio.Band','900',1,0,'The GSM operating band.  Valid values are 850 (GSM850), 900 (PGSM900), 1800 (DCS1800) and 1900 (PCS1900).  For most Range models, this value is dictated by the hardware and should not be changed.  Static.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.C0','51 ',1,0,'The C0 ARFCN.  Also the base ARFCN for a multi-ARFCN configuration.  Static.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.MaxExpectedDelaySpread','1 ',0,0,'Expected worst-case delay spread in symbol periods, roughly 3.7 us or 1.1 km per unit.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.PowerManager.MaxAttenDB','10',0,0,'Maximum transmitter attenuation level, in dB wrt full scale on the D/A output.  This sets the minimum power output level in the output power control loop.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.PowerManager.MinAttenDB','0',0,0,'Minimum transmitter attenuation level, in dB wrt full scale on the D/A output.  This sets the maximum power output level in the output power control loop.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.PowerManager.NumSamples','10',0,0,'Number of samples averaged by the output power control loop.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.PowerManager.Period','6000',0,0,'');
INSERT INTO "CONFIG" VALUES('GSM.Radio.PowerManager.SamplePeriod','2000',0,0,'Sample period for the output power control loop.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.PowerManager.TargetT3122','5000',0,0,'Target value for T3122, the random access hold-off timer, for the power control loop.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.RxGain','47',1,0,'Receiver gain setting in dB.  Ideal value is dictacted by the hardware.  This database parameter is static but the receiver gain can be modified in real time with the CLI rxgain command.  Static.');
INSERT INTO "CONFIG" VALUES('GSM.Radio.RSSITarget','-50',0,0,'Target uplink RSSI for MS power control loop, in dB wrt to A/D full scale.  Should be 6-10 dB above the noise floor.');
INSERT INTO "CONFIG" VALUES('GSM.Timer.T3113','10000',0,0,'Paging timer T3113 in ms.  This is the timeout for a handset to respond to a paging request.  This should usually be the same as SIP.Timer.B in your VoIP network.');
INSERT INTO "CONFIG" VALUES('GSM.Timer.T3122Max','255000',0,0,'Maximum allowed value for T3122, the RACH holdoff timer, in milliseconds.');
INSERT INTO "CONFIG" VALUES('GSM.Timer.T3122Min','2000',0,0,'Minimum allowed value for T3122, the RACH holdoff timer, in milliseconds.');
INSERT INTO "CONFIG" VALUES('GSM.Timer.T3212','30',0,0,'Registration timer T3212 period in minutes.  Should be a factor of 6.  Set to 0 to disable periodic registration.  Should be smaller than SIP registration period.');
INSERT INTO "CONFIG" VALUES('Log.Alarms.Max','20',0,0,'Maximum number of alarms to remember inside the application.');
INSERT INTO "CONFIG" VALUES('Log.Level','WARNING',0,0,'Default logging level when no other level is defined for a file.');
INSERT INTO "CONFIG" VALUES('Log.Level.CallControl.cpp','INFO',0,1,'Default configuration logs a trace at L3.');
INSERT INTO "CONFIG" VALUES('Log.Level.MobilityManagement.cpp','INFO',0,1,'Default configuration logs a trace at L3.');
INSERT INTO "CONFIG" VALUES('Log.Level.RadioResource.cpp','INFO',0,1,'Default configuration logs a trace at L3.');
INSERT INTO "CONFIG" VALUES('Log.Level.SMSControl.cpp','INFO',0,1,'Default configuration logs a trace at L3.');
INSERT INTO "CONFIG" VALUES('NTP.Server','pool.ntp.org',0,1,'NTP server(s) for time-of-day clock syncing.  For multiple servers, use a space-delimited list.  If left undefined, NTP will not be used, but it is strongly recommended.');
INSERT INTO "CONFIG" VALUES('RTP.Range','98',1,0,'Range of RTP port pool.  Pool is RTP.Start to RTP.Range-1.  Static.');
INSERT INTO "CONFIG" VALUES('RTP.Start','16484',1,0,'Base of RTP port pool.  Pool is RTP.Start to RTP.Range-1.  Static.');
INSERT INTO "CONFIG" VALUES('SIP.DTMF.RFC2833','1',0,1,'If not NULL, use RFC-2833 (RTP event signalling) for in-call DTMF.');
INSERT INTO "CONFIG" VALUES('SIP.DTMF.RFC2833.PayloadType','101',0,1,'Payload type to use for RFC-2833 telephone event packets.  If SIP.DTMF.2833 is defined, this must also be defined.');
INSERT INTO "CONFIG" VALUES('SIP.DTMF.RFC2967',NULL,0,1,'If not NULL, use RFC-2967 (SIP INFO method) for in-call DTMF.');
INSERT INTO "CONFIG" VALUES('SIP.Local.IP','127.0.0.1',1,0,'IP address of the OpenBTS machine as seen by its proxies.  If these are all local, this can be localhost.  Static.');
INSERT INTO "CONFIG" VALUES('SIP.Local.Port','5062',1,0,'IP port that OpenBTS uses for its SIP interface.  Static.');
INSERT INTO "CONFIG" VALUES('SIP.MaxForwards','5',0,0,'Maximum allowed number of referrals.');
INSERT INTO "CONFIG" VALUES('SIP.Proxy.Registration','127.0.0.1:5064',0,0,'The IP host and port of the proxy to be used for registration and authentication.  This should normally be the subscriber registry SIP interface, not Asterisk.');
INSERT INTO "CONFIG" VALUES('SIP.Proxy.SMS','127.0.0.1:5063',0,0,'The IP host and port of the proxy to be used for text messaging.  This is smqueue, for example.');
INSERT INTO "CONFIG" VALUES('SIP.Proxy.Speech','127.0.0.1:5060',0,0,'The IP host and port of the proxy to be used for normal speech calls.  This is Asterisk, for example.');
INSERT INTO "CONFIG" VALUES('SIP.RegistrationPeriod','90',0,0,'Registration period in minutes for MS SIP users.  Should be longer than GSM T3212.');
INSERT INTO "CONFIG" VALUES('SIP.SMSC','smsc',0,1,'The SMSC handler in smqueue.  This is the entity that handles full 3GPP MIME-encapsulted TPDUs.  If not defined, use direct numeric addressing.  Normally the value is NULL if SMS.MIMIEType is "text/plain" or "smsc" if SMS.MIMEType is "application/vnd.3gpp".');
INSERT INTO "CONFIG" VALUES('SIP.Timer.A','500',0,0,'INVITE retransmit period in ms.');
INSERT INTO "CONFIG" VALUES('SIP.Timer.B','10000',0,0,'INVITE transaction timeout in ms.  This value should usually match GSM.Timer.T3113.');
INSERT INTO "CONFIG" VALUES('SIP.Timer.E','500',0,0,'Non-INVITE initial request retransmit period in ms.');
INSERT INTO "CONFIG" VALUES('SIP.Timer.F','5000',0,0,'Non-INVITE initial request timeout in ms.');
INSERT INTO "CONFIG" VALUES('SIP.Timer.J','500',0,0,'Non-INVITE non-initial request retransmit period in ms.');
INSERT INTO "CONFIG" VALUES('SIP.Timer.H','5000',0,0,'ACK timeout period in ms.');
INSERT INTO "CONFIG" VALUES('SIP.Timer.I','500',0,0,'ACK retransmit period in ms.');
INSERT INTO "CONFIG" VALUES('SMS.DefaultDestSMSC','0000',0,0,'Use this to fill in L4 SMSC address in SMS submission.');
INSERT INTO "CONFIG" VALUES('SMS.FakeSrcSMSC','0000',0,0,'Use this to fill in L4 SMSC address in SMS delivery.');
INSERT INTO "CONFIG" VALUES('SMS.MIMEType','application/vnd.3gpp.sms',0,0,'This is the MIME Type that OpenBTS will use for RFC-3428 SIP MESSAGE payloads.  Valid values are "application/vnd.3gpp.sms" and "text/plain".');
INSERT INTO "CONFIG" VALUES('SubscriberRegistry.Manager.Title','Subscriber Registry',0,0,'Title of subscriber registry database manager web page.');
INSERT INTO "CONFIG" VALUES('SubscriberRegistry.Manager.Url','http://127.0.0.1/cgi/srmanager.cgi',0,0,'URL of the subscriber registry database manager.');
INSERT INTO "CONFIG" VALUES('SubscriberRegistry.Manager.VisibleColumns','name username type context host',0,0,'Field names in subscriber registry visible in the database manager.');
INSERT INTO "CONFIG" VALUES('SubscriberRegistry.db','/var/lib/asterisk/sqlite3dir/sqlite3.db',0,0,'The location of the sqlite3 database holding the subscriber registry.');
INSERT INTO "CONFIG" VALUES('SubscriberRegistry.Port','5064',0,0,'Port used by the SIP Authentication Server. NOTE: In some older releases (pre-2.8.1) this is called SIP.myPort.');
INSERT INTO "CONFIG" VALUES('TRX.IP','127.0.0.1',1,0,'IP address of the transceiver application.  Static.');
INSERT INTO "CONFIG" VALUES('TRX.Port','5700',1,0,'IP port of the transceiver application.  Static.');
INSERT INTO "CONFIG" VALUES('TRX.RadioFrequencyOffset','128',1,0,'Fine-tuning adjustment for the transceiver master clock.  Roughly 170 Hz/step.  Set at the factory.  Do not adjust without proper calibration.  Static.');
INSERT INTO "CONFIG" VALUES('TRX.TxAttenOffset','2',1,0,'Hardware-specific gain adjustment for transmitter, matched to the power amplifier, expessed as an attenuationi in dB.  Set at the factory.  Do not adjust without proper calibration.  Static.');
COMMIT;
