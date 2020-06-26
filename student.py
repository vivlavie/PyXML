from xml.etree.ElementTree import parse

tree = parse('data.xml')
root = tree.getroot()

student = root.findall("student")

name = [x.findtext("name") for x in student]
age = [x.findtext("age") for x in student]
score = [x.find("score").attrib for x in student]

print(name)
print(age)
print(score)