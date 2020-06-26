from xml.etree.ElementTree import parse

tree = parse('ruby_ps_00_shk_02.xml')
root = tree.getroot()
sce = root.findall("Element")
# subele = [x.find("SubElements") for x in sce]
for x in sce:    
    scename = x.get('Name')
    scegoal = x.get('Goal')
    sceid = x.get('sceid')

    print("<H1> {:s} </H1>".format(scename))

    print(sceid,scename, scegoal)

    ses = x.find('SubElements').getchildren()
    for se in ses:
        sename = se.get('Name')
        print(sename)

    print("<H2> {:s} </H2>".format("Functionality"))
    fs = x.find('Functionality').getchildren()
    for f in fs:                
        ffunction = f.get('Function')
        fcriteria = f.get('Criteria')
        fref = f.get('Ref')        
        print(fref, ffunction, fcriteria)
    
    print("<H2> {:s} </H2>".format("Availability"))
    avs = x.find('Availability').getchildren()
    for f in avs:                
        ael = f.get('SubElement')
        aa = f.get('AvailabilityAssurance')
        ac = f.get('AvailabilityCriterion')
        aref = f.get('AvID')        
        print(aref, ael,aa, ac)
    
    # s = x.find('Survivability')
    print("<H2> {:s} </H2>".format("Survivability"))
    svs = x.find('Survivability').getchildren()
    for f in svs:                
        smah = f.get('MAH')
        sel = f.get('SubElement')
        sa = f.get('SurvAssurance')
        sc = f.get('SurvCriterion')
        sref = f.get('SurvID')        
        print(sref, smah, sel, sa, sc)
    # i = x.find('Dependencies')

refs = root.findall("ReferenceList")
# subele = [x.find("SubElements") for x in sce]
rr = refs[0].getchildren()
for r in rr:    
    rauthor = r.get('AUTHOR')
    rdocno = r.get('DOCNO')
    rdocrev = r.get('REV')
    rdocttl = r.get('TITLE')
    print(rauthor, rdocno, rdocrev, rdocttl)

dd = refs[1].getchildren()
for r in dd:    
    rauthor = r.get('AUTHOR')
    rdocno = r.get('DOCNO')
    rdocrev = r.get('REV')
    rdocttl = r.get('TITLE')
    print(rauthor, rdocno, rdocrev, rdocttl)
