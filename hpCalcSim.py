import random
from pyswip import Prolog as pl
import itertools as it

print("Consulting")
pl.consult("main.pl")

HPog = [1,2,3,5]
APog = [2,3,4,5]

HPmult = 2
APmult = 2

simRes = ""

print("AP:HP:HPnew\n")

for i in range(0,4):
	HP = HPog
	AP = HPog
	match i:
		case 0:
			caseString = "## Calculating without Multipliers ##"
			print(caseString)
			simRes += caseString

		case 1:
			caseString = "\n## Calculating with Attack Multipliers ##"
			print(caseString)
			simRes += caseString
			AP = [point * 2 for point in AP]

		case 2:
			caseString = "\n## Calculating with Defense Multipliers ##"
			print(caseString)
			simRes += caseString
			HP = [point * 2 for point in HP]
			

		case 3:
			caseString = "\n## Calculating with Attack and Defense Multipliers ##"
			print(caseString)
			simRes += caseString
			AP = [point * 2 for point in AP]
			HP = [point * 2 for point in HP]

	itString = "\n-First Iteration-\n"
	print(itString)
	simRes += itString

	liste = [AP, HP]
	combinations = [p for p in it.product(*liste)]

	newcombs = []

	for comb in combinations:
		for soln in pl.query("einheit_alive("+str(comb[0])+","+str(comb[1])+", HPnew)"):
			tmpStr = str(comb[0]) + ":" + str(comb[1]) + ":" + str(soln["HPnew"]) + "\n"
			print(tmpStr)
			simRes += tmpStr
			newcombs.append((comb[0], soln["HPnew"]))

	itString = "\n-Second Iteration-\n"
	print(itString)
	simRes += itString
	
	for comb in newcombs:
		for soln in pl.query("einheit_alive("+str(comb[0])+","+str(comb[1])+", HPnew)"):
			tmpStr = str(comb[0]) + ":" + str(comb[1]) + ":" + str(soln["HPnew"]) + "\n"
			print(tmpStr)
			simRes += tmpStr


with open("res.txt", "w") as w:
	w.write(simRes)